Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B09C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355086AbhKYNRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:17:08 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:45557 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351677AbhKYNPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 08:15:07 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mqEXa-000AxO-3T; Thu, 25 Nov 2021 13:11:54 +0000
Message-ID: <3e7af5d3-58fd-3a92-371f-3fa26cfe05a0@iee.email>
Date:   Thu, 25 Nov 2021 13:11:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: What's cooking in git.git (Nov 2021, #06; Wed, 24)
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlf1caica.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqlf1caica.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25/11/2021 05:56, Junio C Hamano wrote:
> * rs/mergesort (2021-11-18) 1 commit
>  - mergesort: avoid left shift overflow
>
>  Bitop fix for 32-bit boxes.
From my Win64 perspective, this also covers LLP64 boxes.
Maybe   s/32-bit boxes/32-bit and LLP64 boxes/.
 
I'm still resolving an unexpected rebase problem with my short series
that fixes the other Visual Studio C4334 "was 64-bit shift intended"
size mismatch warnings.

My rebase problem appears to be because sha1-file was renamed
object-file.c, where one of my fixes is applied, and the rebase onto
this rs/mergesort series decided that my one line change should include
3 extra lines (see https://github.com/PhilipOakley/git/tree/oneU_t-v2;
03203b1679).

I'll probably just rebase my patches onto the latest master. Two of the
patches could be retrospectively applied to maint, but the object-file.c
patch is probably best on master.

Philip
