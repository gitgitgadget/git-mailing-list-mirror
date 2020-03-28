Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97062C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C06020748
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgC1RIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:08:48 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:58630 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:08:48 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jIEww-0003MR-FO; Sat, 28 Mar 2020 17:08:46 +0000
Subject: Re: See Fault when running git diff
To:     "Stewart, Tim" <Timothy.Stewart@Pearson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <771f0c5de3874158acdeb18003ac62495F73D361-1387-42DA-B582-725ADA24BB21@pearson.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <11fa2daa-b301-6128-9f25-384a5ad7dc27@iee.email>
Date:   Sat, 28 Mar 2020 17:08:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <771f0c5de3874158acdeb18003ac62495F73D361-1387-42DA-B582-725ADA24BB21@pearson.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tim,

On 15/01/2020 19:47, Stewart, Tim wrote:
> Steps to reproduce:
>
>
> Start a rebase operation that results in one or more conflicts in one or more of the repository’s sub-directories.
> List the conflicts with the following command: git diff --name-only --diff-filter=U –relative
> Identify one of the conflicts that is in a subdirectory.
> cd to that directory
> Run the same command again: git diff --name-only --diff-filter=U –relative
> Receive segmentation fault error.  I would have expected to see a list of files relative to the current directory.
> The following commands work just fine in the subdirectory you cd’ed to (I introduced spacing to make which arguments are present or absent more clear):
> git diff --name-only --diff-filter=U
> git diff                        --diff-filter=U –relative
>
>
>  
> It appears that the –diff-filter=U argument is not required to induce the seg fault making the minimal failing case: ‘git diff --name-only –relative’ when run from a subdirectory.
Is this still present in the recent V2.26.0?
--
Philip, (catching up on old emails)
