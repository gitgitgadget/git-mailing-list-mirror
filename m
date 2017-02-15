Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057AF2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbdBONGv (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 08:06:51 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34691 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBONGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 08:06:48 -0500
Received: by mail-ua0-f193.google.com with SMTP id t17so236702uae.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7NlvWDgVhLYAc84bdUz6a91Wbs8JbbSBsNBBG36FF7o=;
        b=P0s9O3s+jgV5LeotcYbewc0UqnjU8Wsj9K0iem2JmQ2jMaacRKPt36VG8i/qJ2TzQw
         kKpYT3c+9hP9e2k5xriftwGHUXOvXLODmT4IDeQ9JjbVddiq5UqipjAi+aeUd95EjUcS
         vq+YQZLPMl6kTlDRK6mDv3yRjaq0BsYvKpky0qUHkCL0b5xAqKuKINc0ChBu9sAlvEOY
         aLLl3HjWWFChRLXhioSmt7FQW4WVoiQwbJiXM2sU/bwzG2EgaoqJRHchD/ZyvhIImcFW
         jmGmFP50tXCOG14tQHeFi5u2hRDGXDHj43G+K3EY7WBZvan+KbPfYxmx/verAPygRMaJ
         8Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7NlvWDgVhLYAc84bdUz6a91Wbs8JbbSBsNBBG36FF7o=;
        b=X/G03Nk5VuhKHOK0zoo+sAn+uhNE+RdfA8zIifr3/0G9Ku8YcXUu6VqgdY4mt8YMOo
         ny2JZNxXrd04BagiGmvv0kBCnvwNRHJhaAQuF0nl+f8+LZIjR8RC+APuIplGtVjAZsro
         9g0esRB7hCSzoicp/JarsMEyqKLQcsKRXnm37pWEu8s5y+9M8/V6vtUklebYapztoyP1
         X7tX14ZiUOqodGLouCrV8EbUrPh4zqOLE7Lt8Ea0qO8rbdk0mHA/QbivIhdIGplj0Sel
         c+YxP41WeJe0LNo+y0Ct9t5mf8CsDAuiFsNJxpHgEb130BxlSOivbgmVYHWMSf77GmYK
         xOzw==
X-Gm-Message-State: AMke39mNLCU/UNfsnnem4Yvq+scr8WoOPbLDtICRgLjuyCBDuWc6bPTtZoLT58AaK1uCO+aqo/yomupatfmq3g==
X-Received: by 10.176.68.100 with SMTP id m91mr18517414uam.119.1487164007802;
 Wed, 15 Feb 2017 05:06:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Wed, 15 Feb 2017 05:06:47 -0800 (PST)
In-Reply-To: <xmqqtw7w41m5.fsf@gitster.mtv.corp.google.com>
References: <20170213192036.10671-1-szeder.dev@gmail.com> <xmqqfujhddl2.fsf@gitster.mtv.corp.google.com>
 <CAM0VKjmU57saSfyRuoWfC+UZFNypH1Wp9X33VgzPq9fatD=qtg@mail.gmail.com> <xmqqtw7w41m5.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 15 Feb 2017 14:06:47 +0100
Message-ID: <CAM0VKjk4YxX_+QzRw3HmnABV9AbkyzFjKau4Q=z4dPQpLzd--g@mail.gmail.com>
Subject: Re: [PATCH] completion: restore removed line continuating backslash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 3:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> If you feel uncomfortable and want these to cook longer, please tell
>>> me so.
>>
>> Well, it was mainly my surprise that a 20+ patch series arriving so
>> late that it gets queued on top of -rc0 would still make it into the
>> release.
>
> It all depends on what area the changes are about ;-)

Sure.  I actually wanted to end that email with something like "and
it's in contrib anyway :)", but by the time I got there I forgot about
it.
