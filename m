Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043FA1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 00:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeHPDOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 23:14:17 -0400
Received: from pug.qqx.org ([50.116.43.67]:52180 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeHPDOR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 23:14:17 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 16BAD2AB68; Wed, 15 Aug 2018 20:19:39 -0400 (EDT)
Date:   Wed, 15 Aug 2018 20:19:39 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180816001939.GA31703@pug.qqx.org>
Mail-Followup-To: Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180808223323.79989-3-bmwill@google.com>
User-Agent: Mutt/1.10.1+70 (7f47a5ece) (2018-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 15:33 -0700 08 Aug 2018, Brandon Williams <bmwill@google.com> wrote:
>Teach "submodule_name_to_gitdir()" to munge a submodule's name (by url
>encoding it) before using it to build a path to the submodule's gitdir.

Seems like this will be a problem if it results in names that exceed 
NAME_MAX? On common systems that's 255, so it's probably not going to be 
common; but it certainly could for some repositories.
