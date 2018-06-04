Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384791F403
	for <e@80x24.org>; Mon,  4 Jun 2018 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeFDTmn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 15:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeFDTmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 15:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29332300309E;
        Mon,  4 Jun 2018 19:42:43 +0000 (UTC)
Received: from localhost (ovpn-116-19.gru2.redhat.com [10.97.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB96600C0;
        Mon,  4 Jun 2018 19:42:42 +0000 (UTC)
Date:   Mon, 4 Jun 2018 16:42:41 -0300
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Xiaolong Ye <xiaolong.ye@intel.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: clear UNINTERESTING flag before
 prepare_bases
Message-ID: <20180604194241.GV7451@localhost.localdomain>
References: <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com>
 <20180604150543.7304-1-xiaolong.ye@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604150543.7304-1-xiaolong.ye@intel.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 04 Jun 2018 19:42:43 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 11:05:43PM +0800, Xiaolong Ye wrote:
> When users specify the commit range with 'Z..C' pattern for format-patch, all
> the parents of Z (including Z) would be marked as UNINTERESTING which would
> prevent revision walk in prepare_bases from getting the prerequisite commits,
> thus `git format-patch --base <base_commit_sha> Z..C` won't be able to generate
> the list of prerequisite patch ids. Clear UNINTERESTING flag with
> clear_object_flags solves this issue.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>

Thanks!  The fix works for me.

Tested-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
