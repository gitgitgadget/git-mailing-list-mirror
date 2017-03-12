Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CF31FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 09:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933828AbdCLJP0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 05:15:26 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37618 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933310AbdCLJPY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 05:15:24 -0400
Received: by mail-it0-f53.google.com with SMTP id g138so17569993itb.0
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JLXcITP9HtgSc7uub2o5001y2snfr1Yc52F2+VuzgVM=;
        b=QkInvceGHJkcQi46v4DLFffNnKC0h0N+Fz008J46hmtW1/I4/nKWkTKwGUKade7x6h
         +NMqMKm2JcrixrJVY/ks85z6GTdSMCuVxGt8wZncns5cE5FfPnYI3ene0ZEBpZ2siL5N
         iAWlXyQEK9oPzNrG3HEp2gfA0GOXpE6l8IKDOM9vIXZMxW5ajAPIsjrtRuijQ0pfh+P5
         v68nrlpaxNoBGK37xr060SkjH3qP6A3j4fqRtnGq+RUmqVrnvUnuB6K4rU55RJaqspSv
         dW8k86k/0WjJaVzJxLzKkSXhraX4Mg57Y16X/g03c4nI0lGBmxMfJhTtMG+/MjekLxPG
         fKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JLXcITP9HtgSc7uub2o5001y2snfr1Yc52F2+VuzgVM=;
        b=qjJUQJU4LcF2RAaXoZeqGso90elfPckaYhO/8Jdc0jWVWmHFNDQnZtLDl3K2JQgpsZ
         LfOqY43WWGhkw6yFLkhRFk0JRSYPZMxZkLzXB/+EnLon4ikduIfXINJLj1PUc/WCz6lC
         pI7Zm3BOHbZLNVRyvF0BFmWD7HRoeeHPuqZLCBGV8D1kqwboPMwYNgxKBpVU/tAxOyj5
         eSmxYkHes3APYae0myfQLSnHny27gUStg6VwRgorC7j5Rot57lGoFpkANSpo9FsYVato
         Zi8r1HMBXbQOW4kW0Ou9bkn+8pHEDdOtvoPUDLdb+gpaR+/Ukmmg9a69+ZVLndySaAJ0
         6T1Q==
X-Gm-Message-State: AFeK/H2BrmNTiMN0iUXyoPrngrnLTULmh4OLAeHlCzfBtggQocQ3/zA4eXr25eKrw+JleIUZswH7FYZbskcuKA==
X-Received: by 10.36.103.9 with SMTP id u9mr5803033itc.91.1489310123086; Sun,
 12 Mar 2017 01:15:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 12 Mar 2017 01:15:02 -0800 (PST)
In-Reply-To: <xmqqefy3w6k0.fsf@gitster.mtv.corp.google.com>
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
 <20170311120855.16756-1-avarab@gmail.com> <CACBZZX4AJqvtZQdZZFU8+1So5G9F11_SN4=za+8p=KYim9SFSQ@mail.gmail.com>
 <xmqqefy3w6k0.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 12 Mar 2017 10:15:02 +0100
Message-ID: <CACBZZX52UYdGa1--wAz+beHNCMST4NoopJvFg68hLDaeaq=DNQ@mail.gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 3:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Junio: This will merge conflict with my in-flight --no-contains
>>> patch. I can re-send either one depending on which you want to accept
>>> first, this patch will need an additional test for --no-contains. I
>>> just wanted to get this on the ML for review before the --no-contains
>>> patch hit "master".
>
> I haven't looked at the patch text of this one closely yet, but I
> think the goals of both make sense, so we would eventually want to
> have them both.
>
> I also think that "if you said --contains, --merged, etc. you are
> already asking to give you a list and cannot be creating a new one",
> which is the topic of this patch, makes sense even if nobody were
> interested in asking "--no-contains".
>
> So perhaps you would want this applied first, so that existing three
> can already benefit from "implicit --list" before waiting for the
> other one?

Yes, let's do this one first. I'll address the comments that have come
up & just make this all part of one series on top of JK's patches.
