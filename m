Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD619C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 09:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99D12312D
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 09:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgLMJql (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 04:46:41 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:56837 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgLMJql (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 04:46:41 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Cv05M0vrDz5tl9;
        Sun, 13 Dec 2020 10:45:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 671EB20C5;
        Sun, 13 Dec 2020 10:45:58 +0100 (CET)
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
From:   Johannes Sixt <j6t@kdbg.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
 <2cc4925f-3661-1dfb-2668-5f56edcb8455@kdbg.org>
Message-ID: <b297b843-99e1-152d-aed1-20371af42d42@kdbg.org>
Date:   Sun, 13 Dec 2020 10:45:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2cc4925f-3661-1dfb-2668-5f56edcb8455@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.20 um 10:34 schrieb Johannes Sixt:
> I don't understand the concept. A mailmap entry of the form
> 
>    A <a@b> <x@y>
> 
> tells that the former address <x@y>, which is recorded in old project
> history, should be replaced by A <a@b> when a commit is displayed. I am
> assuming that the idea is that old <x@y> should be the "banned" address.
> How does a hashed entry help when the hashed value appears at the right
> side of a mailmap entry and that literal string never appears anywhere
> in the history?

Never mind, I got it: A wants to be disassociated from <x@y>, but not
from their contributions whose authorship was recorded as <x@y>.
Therefore, Git must always compute the hash of all of <x@y>, <a@b>, etc,
just in case that the hashed form appears anywhere in the mailmap file.

-- Hannes
