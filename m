Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261EEC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A9223E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgLWTrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 14:47:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52249 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgLWTra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 14:47:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8AE410AEE6;
        Wed, 23 Dec 2020 14:46:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=raZefzfG8T125aM9M+qRFH09G2A=; b=OOzZM6
        TgDUa4gAL+X1te7baFPtourhx727o4ZdSNJPtOct5UPmU2Pwm9aXTl/s1wmz+V1a
        udUNtIRDbS4lkpSPd+3JBElRPti8JThSMpeKUqvu3ALm+P5SnunoSnTgVVr96LG9
        2+aHlOMecds+vPSZ+Jq8z7lvI9Oal/0p6Knv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fgf2Jjp77aVlQKeCCUMNUc+3HrGa3rUO
        d8L2lanzTXOZL04s+2eOAE6Psg/3yC2UgPFw4xztd+q+9wi86i6TcBsSKRnoB0sV
        JTKXvFatGYXtx19GUYcnSYStpVAyeYo9TLgGxwRlZ8HN7QI40JHiGNQ7BLOk6YE0
        mdNt8p1A2Y4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C13BD10AEE5;
        Wed, 23 Dec 2020 14:46:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F06010AEE2;
        Wed, 23 Dec 2020 14:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Matt Turner <mattst88@gentoo.org>,
        gentoo-portage-dev@lists.gentoo.org, git@vger.kernel.org
Subject: Re: [RFC PATCH gentoolkit] bin: Add merge-driver-ekeyword
References: <20201221034452.307153-1-mattst88@gentoo.org>
        <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
        <b2adb41b-b2d2-fecf-3a93-7eb3f1f2247d@drbeat.li>
Date:   Wed, 23 Dec 2020 11:46:44 -0800
In-Reply-To: <b2adb41b-b2d2-fecf-3a93-7eb3f1f2247d@drbeat.li> (Beat Bolli's
        message of "Wed, 23 Dec 2020 19:11:38 +0100")
Message-ID: <xmqqo8ik8fvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96E19C8E-4557-11EB-A2EB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> You can probably put each of the keywords on a separate line:
>
> KEYWORDS="
> ~alpha
> ~amd64
> ~arm
> ~arm64
> ~hppa
> ~ia64
> ~mips
> ~ppc
> ~ppc64
> ~riscv
> ~s390
> ~sparc~x86
> "
>
> The shell should handle both forms about the same.

I agree that it is a more practical approach than writing an one-off
merge driver.
