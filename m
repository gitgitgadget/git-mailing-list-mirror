Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B541F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 07:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJKPPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:15:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33416 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeJKPPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:15:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so15117111wmd.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=l+tzXO5zMBa0HCRwhwmMZaBRBx9c73mp9QQRSFUcL0Y=;
        b=T2LdzR/UOuia18APfxBxVWuGxqqjhDX24Qn0PBRWu8OZ6VsMTjAFsMfFCl6h4+ZwGT
         BffP2i+1P/LF9if7rBncrId2k1FGhY/YIihCnWIRmhOQueSZChd6O1+lvfKAM2ho8Pu8
         /s+AUcFZuyHXit6Q1bc6p6/EmD3j+CGbYzV3b4RBgMWGX4VrjZuCR8JNBNbuyWK/26eT
         3s9Jj4RKcWFuAwJkhEXmvFbrp/f6M3dGUPSJYz6z+0pyzAL5lpd8UHzoN807vfiqL2Mt
         PJh7/1RjJk37Lu+qDE8v85qdZo/uX7O7C1XikTyDHA1RoqpTE6HQJWoU7JQHNl5tqp0r
         8o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=l+tzXO5zMBa0HCRwhwmMZaBRBx9c73mp9QQRSFUcL0Y=;
        b=UMONdZdzUm+Z2ZFOlrp9owIR2UvgzuTe2vJl9OiPmFGVKnEdxS/uu5QxxTaeY2TRSP
         EohZ2QtmtNrOgZzu1vH7tF/xIKtmrd9axgN3IytV6Bj27Bn3mD1Swhl5Z60sT1iEN/VE
         gTEOksv2GevojvxZFnxKliJGhjmZTPKtp/VZAQwqKFJTKOT0KV3+soY4gm5JysIfXpO4
         ISV+419e5dMdl8UDRbSZWKzo3/ojRC+PKB5njnEqwb5q8bb9VHqJORlYSUccTpe2MIBm
         i/R32x0xMuJ6MaVG5BGa8g+LdifFRls4LikmHxBDGJnNUaWIcVVRPw9EWHVc4Kxjxbui
         9t8Q==
X-Gm-Message-State: ABuFfoh23+rmtTFoRI/90FnB77MUWIfLcLLolh/p+fV9HktNApdhaFRm
        BEqkSU8JHuQ70fivN4+25iI=
X-Google-Smtp-Source: ACcGV61L5JbJd+hWQDA3At2CXVmI+XJ8evVhF66EU7KkJVfgnbIRFsjw2xS6NkWcKoFjayBl+wE0sA==
X-Received: by 2002:a1c:f010:: with SMTP id a16-v6mr648967wmb.5.1539244167236;
        Thu, 11 Oct 2018 00:49:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id p8sm23242374wrx.9.2018.10.11.00.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 00:49:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Casey <drafnel@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] gc: remove redundant check for gc_auto_threshold
References: <20181010193235.17359-1-avarab@gmail.com> <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com> <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 11 Oct 2018 09:49:25 +0200
Message-ID: <87h8hsexdm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Junio C Hamano wrote:

> Brandon Casey <drafnel@gmail.com> writes:
>
>> ...  Again, I don't feel strongly about it, but I'm not
>> sure this change actually improves the code.
>
> Yeah, in the context of the current caller, this is a safe change
> that does not break anybody and reduces the number of instructions
> executed in this codepath.  A mistaken caller may be added in the
> future that fails to check auto-threashold beforehand, but that
> won't lead to anything bad like looping for a large number of times,
> so as long as the API contract into this helper function is clear
> that callers are responsible to check beforehand, it is still not
> too bad.
>
> So, I'd throw this into "Meh - I won't regret applying it, but it is
> not the end of the world if I forget to apply it, either" pile.
>
> I _think_ a change that actually improves the code would be to
> restructure so that there is a helper that is responsible for
> guestimating the number of loose objects, and another that uses the
> helper to see if there are too many loose objects.  The latter is
> the only one tha needs to know about auto-threashold.  But we are
> not in immdiate need for such a clean-up, I guess, unless somebody
> is actively looking into revamping how auto-gc works and doing a
> preparatory clean-up.

Yeah, that's me :) I have some WIP gc cleanup, but want to sit on it a
bit before I submit it to think about the best way to do things.

So in the meantime I was sending out a few WIP bits that I expected
could be reviewed stand-alone.

So I'd prefer to have this applied. It's easy enough to understand that
shouldn't take long to prove to be correct & trickle down to "master",
and will make those subsequent patches easier to follow.
