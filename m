Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D547320986
	for <e@80x24.org>; Fri,  7 Oct 2016 13:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756592AbcJGNIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 09:08:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33352 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756542AbcJGNI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 09:08:26 -0400
Received: by mail-it0-f67.google.com with SMTP id o21so1070083itb.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t6JYnArzqr7gwiAdYUkaYcqpDtS5/tqR5prneHBnp9c=;
        b=Ip6lDvcvWfRdauIXlJgqQGH1EN5c6tUJ6Y3E/eXnBfWpiaBfhb2RI6TbVhHLBwQBv3
         jsttApekeqB/kxlrZCTVnuiQD5ZySbqVcX5RQopLzUpUvwf8FE/1tuo5uvJpYNr0/h3Y
         56zO8+wnBxz9664q+LyavGRuO0d+9NZZdJ8k9WyyvbEG6c/LhrnZ3AL6c0h/0sGGW1xl
         JxM54+U2Zet0q6/jyte9ometJ0tHFMKo7RSmOjaIF5dxwhdngCiVjqMRjJGC4tlZ/Ija
         MC5vXOiJ39+/crTwxJKcDJ9Y6FK81+GIT2RcLa5RRvErnSNteI5w5iXoQr2CGRmlpojv
         saiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t6JYnArzqr7gwiAdYUkaYcqpDtS5/tqR5prneHBnp9c=;
        b=eF8CoOdyNriw8teNkmfPu9lhZCTNcOBji2JLAjBmZt6wuIct/BXDzRNMxMF3LAiCbU
         PNkUi3iGxWA7f18BAwUga8pDbs1p0or/NjeZjsUQ1ONWVPAjPq7ODI14oIVa6e9S0b3F
         TSthZGfgmRtwFK3yDF6wpPK6SA+qJUc0BNBCFnNglteEIenVQLPkkSGeyW1KkinZyf8b
         RPlXOP+FUHtzZ+itupLl4kDRepXCE9puX2Q3erahp1Uob37ZnewEv7Vx5JFIAuxbjU/n
         f55OhLQkXbgPr9Q9H7VcyXMuJ3wThvvc2vJ2rqIkubsO5Qd7b19BBo+YmPfHZDoEhDsA
         fVEA==
X-Gm-Message-State: AA6/9Rn1EawbD3Rq2Li8Uczl49ZhBPoTNhf7KF5CzwtZ4S4xYe+1ZxpPfvB2s8kPj/2Pl/GtSH71L54P3N1esg==
X-Received: by 10.36.67.2 with SMTP id s2mr20532325itb.50.1475845704936; Fri,
 07 Oct 2016 06:08:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Fri, 7 Oct 2016 06:07:54 -0700 (PDT)
In-Reply-To: <vpqmvig5ns6.fsf@anie.imag.fr>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <vpqmvig5ns6.fsf@anie.imag.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Oct 2016 20:07:54 +0700
Message-ID: <CACsJy8A9VBA_1aGd9R07OBfO7E0hrNVZT0ajjVAkGeg3AK91WQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 7:47 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Junio,
>>>
>>> On Thu, 6 Oct 2016, Junio C Hamano wrote:
>>>
>>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>>>
>>>> > Throwing something at the mailing list to see if anybody is
>>>> > interested.
>>>> >
>>>> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could
>>>> > make
>>>> > handling path arguments hard because they are relative to the
>>>> > original
>>>> > cwd. We set GIT_PREFIX to work around it, but I still think it's
>>>> > more
>>>> > natural to keep cwd where it is.
>>>> >
>>>> > We have a way to do that now after 441981b (git: simplify
>>>> > environment
>>>> > save/restore logic - 2016-01-26). It's just a matter of choosing
>>>> > the
>>>> > right syntax. I'm going with '!!'. I'm not very happy with it.
>>>> > But I
>>>> > do like this type of alias.
>>>>
>>>> I do not know why you are not happy with the syntax, but I
>>>> personally think it brilliant, both the idea and the preliminary
>>>> clean-up that made this possible with a simple patch like this.
>>>
>>> I guess he is not happy with it because "!!" is quite unintuitive a
>>> construct. I know that *I* would have been puzzled by it, asking
>>> "What the
>>> heck does this do?".
>>
>> Yep. And I wouldn't want to set a tradition for the next alias type
>> '!!!'. There's no good choice to represent a new alias type with a
>> leading symbol. This just occurred to me, however, what do you think
>> about a new config group for it? With can have something like
>> externalAlias.* (or some other name) that lives in parallel with
>> alias.*. Then we don't need '!' (or '!!') at all.
>
> Another possibility: !(nocd), which leaves room
> for !(keyword1,keyword2,...) if needed later. Also, it is consistent
> with the :(word) syntax of pathspecs.

This seems to solve my problem nicely.
--=20
Duy
