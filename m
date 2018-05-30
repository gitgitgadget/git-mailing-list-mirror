Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC2D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 03:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935523AbeE3DFF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 23:05:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33725 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933740AbeE3DFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 23:05:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so108665wmc.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mtap1asaszxq5HSVEvcJWEgveeH7AAjDBM0Ss9a1rXA=;
        b=TMWIloLP3ZaQJcFuIU0d5IUYVsMmxAkOxP0n+u/ooehXrPSV0LlVOJQ9LyFOBh80zW
         DRL9emOrW5SgbCXc//bnIrNgYx7bjv+L7rautaskeoQB/oqCCI4c0jrwH3eV60kMe4JJ
         tMeU7msGbZNe/ZtwqKm8CAFa0sNKDkXA3x1DhRPJfxD+9EKwu66shR6jevbGr5qt35wF
         WtZsSFU1h97sMkBzjtTa3xqOeeRm6cPWF0am0ibtIKJ6PhPt8i0Nz++cMIVZEoibmbvg
         zpy9FOblxUQln4d39f/epuhSDTzXavPMZCabE9iMUAejmQHmpKAJ/39YUDw7aFDrunoK
         lZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mtap1asaszxq5HSVEvcJWEgveeH7AAjDBM0Ss9a1rXA=;
        b=AuO9cbQeXQmRM85K59X5eek9DQJiPPuFShjK7qvuO47eaHMxFxzsZr3aErN5XpL1e9
         i9qp091OKe8KMgWPLy7cDw/iQ2qJcc+pNZovOL2w/T9j8CTsa9ZUiAWkC4Lx7i6vdX+p
         SoCF9v+wF/2HxhcArznYySafvqq2reZIg7VZan5bkwbXSd8yY0JZYGSDwsNfKFqGpoa6
         5F3O3a565BZoPlE0T2XyO4aV6Du5Mcbxny9q+1yFdIJrGeULyqnwQ9hcvU1gh80DkMCx
         bAB4Fs2cPzN5x3mre3j1PAFydKIN1dbvimVExffe+/s5Bldbis4zS+ndDnYJGy8aUBcP
         Rbag==
X-Gm-Message-State: ALKqPwckwxTSwABW8Qd8WW9J3W5zejLbJqww3u9ETHmPHiQCtzwLv1JF
        6z/naw8/UpXHid+mIcKs0bY=
X-Google-Smtp-Source: ADUXVKK1DtxwNr8i52CHbE1Pho4KbYtSWQIM5fxmBVW1GdjJTmUWCltpahAm1T6lP5jXrWQK9Uo7Tg==
X-Received: by 2002:a1c:d810:: with SMTP id p16-v6mr75503wmg.133.1527649502620;
        Tue, 29 May 2018 20:05:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z63-v6sm50127437wrb.34.2018.05.29.20.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 20:05:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180525192811.25680-1-avarab@gmail.com>
        <20180525192811.25680-3-avarab@gmail.com>
        <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
        <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
        <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com>
Date:   Wed, 30 May 2018 12:05:01 +0900
In-Reply-To: <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 28 May
 2018 18:44:25
        +0200")
Message-ID: <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, May 28, 2018 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> If the project has some tool constraints and have to accept new
>> "broken" objects on ongoing basis, then fsck.<msg-id> facility may
>> make sense, but that is probably a very narrow special use case.
>
> That makes sense. I'll reword this bit.
> ...
> I'll try to clarify this, but I think we really should have some bit
> there about historical tools. Realistically no new git tools produce
> these, so the user needs to be made aware of what the trade-off of
> turning these on is.
>
> The reality of that is that these objects are exceedingly rare, and
> mostly found in various old repositories. Something like that need to
> be mentioned so the user can weigh the trade-off of turning this on.

Rare or not, once we say "avoid fsck.<msg-id> unless you have a good
reason not to", wouldn't that be sufficient?  

Between "fsck.<msg-id> makes sense only when you use these rare and
you-probably-never-heard-of tools ongoing basis" and "when you
already have (slightly)broken objects, naming each of them in
skiplist, rather than covering the class, is better because you want
*new* instances of the same breakage", I'd imagine the latter would be
more helpful.

In any case, let's see if there are more input to this topic and
then wrap it up in v3 ;-)

Thanks.
