Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F0C4742C
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F382622228
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Afjh/ygX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKFCjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:39:14 -0500
Received: from avasout02.plus.net ([212.159.14.17]:33088 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgKFCjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 21:39:13 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id aregkOZSF0K1Oarehke9E1; Fri, 06 Nov 2020 02:39:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604630352; bh=tjX5r3e2iSFgrvOBuyHZiTae4KTNtMTcKdxX1kPikkI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Afjh/ygXePbZgdkDH066VK26vr96lWsgP4E5lBoFBltROuAxnN702Kl42xGoKW15c
         I67Ka4kbfdMCfv2+TD9rLW51KD7C8aszqfCjbRyiGfy22Fy901xFyKFd8xUswSPHio
         ieQ/XMIbAGoPQBd8mFRaJ3Ctdw4wXDnbeuo8fHlPOBpjjnjWZnihcDNfJY9OOMyPGX
         nxxgruorxH8JQrQ/t/1ta+wfh7cqGJFfDMrlSd5XT1UWQ/Qcj/n8+ZfASj8h7+s75O
         2EbI8vFEPCiv7zxZ0GD8U9j0emQQ7vbbBDrvurnzT5J1+ZleDklvEojmoqm8OwQjit
         meTFuhnjj/BTQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=l6qMoqZhj8SvL2nTlFsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
 <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
 <xmqqeel7h0aj.fsf@gitster.c.googlers.com>
 <0cbe821b-092d-a5f9-e2ab-13a3c01e9a02@ramsayjones.plus.com>
 <xmqqa6vvgs9y.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ec59a5d8-26fc-988e-4458-fd2cd421f9d5@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 02:39:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6vvgs9y.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNICWKFCFK0P7ku9Q3yvAd6SgJo4NDTKYCoCl9NQF3MNrUWaJfk7IYa7E8SsGPhb23OOtLKcUhYDGSASlFQVMww6ucMs1SGP7iddOCIKckqInv+0Kxz7
 Jjab2MkUfiMAlYW8caF33QmUBQ08Oa5YZmALdQAXzf+dkAaal5rmnxUEhPYAF9zZUbmQP3A8zXXRlQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/11/2020 01:58, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> I did have a patch #9 that moved the removal of the tarballs from
>> the 'clean' target to the 'distclean' target (that is move the new
>> 'iterate over the dist-tars file' code). However, I wasn't convinced
>> that it was a better place for it.
> 
> I am not either, other than "things created by 'make distX' cleaned
> by 'make distclean'---that sounds consistent" ;-).

:-D

> 
>> Also, just moving the new removal code would not alter the concerns
>> about it that you express above. So, we need to address that either
>> way.
> 
> "make distclean" can still depend on GIT-VERSION-FILE and your daily
> cleaning needs can use "make clean" that cleans only the files that
> can be cleaned without knowing what GIT_VERSION is, no?  That way,
> we do not have to use dist-tars file at all, no?

Hmm, so rather than dropping the last two patches, you are suggesting
replacing this patch with a patch that moves:

	$(RM) $(GIT_TARNAME).tar.gz
	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz

to the 'distclean' target?

Well, that would address your concerns, but I was hoping to fix the
'your current branch has to be the same as the one you created the
tarballs on' for the '(dist)clean' target to actually remove those
files issue.

As I said in the commit message, my preferred solution was to simply
put them in a 'dist-tars/' directory. Then you would only delete the
files actually generated by the 'dist' and 'dist-doc' targets, and
you could easily remove that directory (be it in 'clean' or 'distclean'
or 'clean-dist-tars', ...).

Hmm, I wonder if my concerns about that solution are overblown? dunno.

ATB,
Ramsay Jones

