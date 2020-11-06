Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1FBC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DCC208C7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AcCMs2fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKFUXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:23:52 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40178 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgKFUXw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 15:23:52 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id b8H0kAOUUn8O7b8H1kLrBH; Fri, 06 Nov 2020 20:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604694231; bh=3SwO/4PjS+Z565oUM3lDCjjOC7JmQzHL/MvZA0vXdOY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AcCMs2fJFSSfCCQLCND3ZE9e0DU5DwiieoN+/3ARvm3ma/l+iojYZUwg8wpiZ+tRP
         XZ6tFG+Zi34mZu+oShZTGoFNbvv5jhE+LTbYayUl6CWy8dYOIrIvgwT5QIAxaC+Wwf
         WiA9fxlDx5jZE1N7ciDHZ5XTmmXm6Edl/u5AtrCvK75Mwt4J5uGdC7/rYwAb7UJGlW
         ZOAohBOvbuMfq6TRdnvAPIeqBI1Ho9xLSE+BWcSXyOszwrl7waTUYsqw0TyPOmG16n
         E0uyaJbTKNH8E39Hl43kGyiRKwvIdc9lFw/mDKq0zwHz3ojYUqRLRyxRgNXoAZoqdS
         tYTQ+ZDqYmmGw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=TSwlB427VmZyBJlCq48A:9 a=QEXdDO2ut3YA:10
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
 <ec59a5d8-26fc-988e-4458-fd2cd421f9d5@ramsayjones.plus.com>
 <xmqqsg9mfk26.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7ad94f1a-9cc7-5ac9-2859-1d1015ea468f@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 20:23:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg9mfk26.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE09OJwNQqepkuLvJL5O+OEvoGSNgBMd8dQiplInKgekiWQZZGEJ/ClAlQLyc5BqBXLVVGh3kwNQPfVNwf8B6wH4EOKw/c5DiOjZANPygMlngStLNK7S
 MnrS4iumEYp7GG5BNp/T7MRzmaoaCCqtvWNfv8sUtPA185IDZ7SyRY8NXPaL5imyR6l+7afstfJM/g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/11/2020 17:53, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> Hmm, so rather than dropping the last two patches, you are suggesting
>> replacing this patch with a patch that moves:
>>
>> 	$(RM) $(GIT_TARNAME).tar.gz
>> 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>>
>> to the 'distclean' target?
> 
> Yup.  FWIW, I consider it a feature that
> 
>     for m in maint-2.{27,28,29}
>     do
> 	git checkout "$m" &&
>         make distclean &&
> 	make dist || break
>     do
> 
> gives me three distribution tarballs of from-scratch builds.  It
> matters when I need to push out releases from multiple maintenance
> tracks at the same time (think: coordinated security releases).

Ah, yes. I hadn't thought about that kind of usage. Hmm, but in that
case, wouldn't you rather get rid of the deletion of the tarballs in
the 'clean' target completely? Then you could either remove them by
hand (which I actually always do in practice anyway) at a time that
suits you, or maybe add a new 'clean-tarballs' target.

(That still leaves the issue of how you would identify the tarballs
in such a target, of course).

ATB,
Ramsay Jones

