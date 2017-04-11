Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BBF209FB
	for <e@80x24.org>; Tue, 11 Apr 2017 06:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbdDKG2k (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 02:28:40 -0400
Received: from 5.itsy.de ([188.40.84.14]:48892 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbdDKG2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 02:28:40 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 0836A646E6
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 08:28:36 +0200 (CEST)
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
To:     Git Mailing List <git@vger.kernel.org>
References: <20170409191117.25175-1-avarab@gmail.com>
 <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <5f6815f7-fd47-c690-9fe2-ad7077b7b670@durchholz.org>
Date:   Tue, 11 Apr 2017 08:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.04.2017 um 01:23 schrieb Ævar Arnfjörð Bjarmason:
 > * Much of it fails due to GIT_CEILING_DIRECTORIES not working with
 > dirs with ":" in the name.

Oh. That might hit me: I'm using URLs for parent directory names in a 
cache directory.

urlencode may or may not work:

 > t0021-conversion.sh = 37(%), 58(:)

Even if it works, I'll have a cache directory with pretty unreadable 
names. I had hoped I could avoid this kind of ugliness.
