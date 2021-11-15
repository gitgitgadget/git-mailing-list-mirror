Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969ACC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7670361AFF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKOK7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:59:01 -0500
Received: from mout01.posteo.de ([185.67.36.65]:44195 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhKOK66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 05:58:58 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9A25824002B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:56:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1636973761; bh=08L3wamiFf1XdfqVlYt1yDWmgyUeCBtdV9y/lqqoDyg=;
        h=Date:From:To:Subject:From;
        b=kY6I7RGPAKuHgMeUOtnaHsy33L8rmczqIWYemvFjI5qg2BYgxKbNZtE0goLh7j/uc
         YF759j7PWlPS54XMtH0EHtfdqDJuufT+Owy/qmj58waGCnWVgWbqtrgC9GwdZ6Gztj
         gWwlgAJLelcH7bWre63+ThojoP9nc7g4mS4KBZHrXWC4aD+w0QbsCC/K7hc0ZdWhVK
         Rr/KdR6yKpto/XiuSltFymjr4+jHA6qz34LsyW5RtQejcShc3PFkkYWqsNxI71COd2
         hgUbLXA2FHvP65kPBwoghK4Tzagek0zYnK5oJlDDEwfFp30ldc3dzmihexlW7rfNKC
         OocRb6FRgS2PA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ht5hc63cgz6tqB;
        Mon, 15 Nov 2021 11:56:00 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Nov 2021 10:56:00 +0000
From:   andre_pohlmann@posteo.de
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        andre_pohlmann@posteo.de,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
In-Reply-To: <YY2MXSZXIRSDLQCu@camp.crustytoothpaste.net>
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
 <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
 <3dd24fb6153cf8d67b74c6cea1a4a734@posteo.de>
 <YY2MXSZXIRSDLQCu@camp.crustytoothpaste.net>
Message-ID: <468f30fbff6f1fcf708c484c19c287b7@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Starting from the relevant branch

git branch TEST_1
git checkout TEST_1
git status

then

git checkout BBV ---- that is the original Branch
git branch TEST_2 ff2c8952 ---- the commit to check out from
git checkout TEST_2
git status

git branch --contains 48c8756e ---- the commit with the specific code

the result is that only TEST_1 is shown, not TEST_2.
It looks to me like the commit is missing.
When I look at the code, the lines in question are also missing.


Am 11.11.2021 22:34 schrieb brian m. carlson:
> On 2021-11-10 at 18:27:56, andre_pohlmann@posteo.de wrote:
>> Hello Johannes,
>> 
>> Thanks for your ideas.
>> 
>> I have checked out the respective new branch and switched between the
>> original and the new, multiple times.
>> Otherwise I would not have noticed the lack of commits.
>> 
>> I have also set up a virtual machine, free of any IDE or GIT. There I 
>> only
>> installed Git for Windows and repeated the process via cmd. The result 
>> is
>> the same, there are missing commits in the history compared to the 
>> original
>> branch.
> 
> Could you give us a set of commands you've run (in Git Bash) to create 
> a
> new test repository (or clone an existing public repository) and
> reproduce this problem?  Right now, we don't know exactly what you've
> done, so we can only speculate about what you're seeing.
