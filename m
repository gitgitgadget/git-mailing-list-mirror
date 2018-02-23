Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1811F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeBWKVR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:21:17 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36190 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeBWKVP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:21:15 -0500
Received: by mail-ot0-f193.google.com with SMTP id 108so1176218otv.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DBhqhypR0wP1/6OpocAQxey6UJcKdL/iPgq38voV0tA=;
        b=h11kRk/FhG+4PpH8y7p2FWUMiYmz6KizacPVt0ZK67g+OXwZlYRge9TLSDEXc3mMfP
         PdI/8UnnPlNGYHSiKBhbQl9nYNIo1Lup30aLu2VCBbH7dbSjdVsRRrHypnFBr5coXzsX
         YfmDi194ToSa5I7zzJtq7WUOIAI32N7mf7V4AYb34fge/14Wcm/FXPoIjMhgNdA13Wyj
         aVkPyqVebZn9PgBbb4zuYNAUqy1KNMt9oX4/aZ01zONeVoFdQVKmiOaKJDbbJtifwwsk
         xzivWdUBbCaYOp6McqMyFrLLL79GP3PHtqsQIfs2L0lvc8cyhnysmyM1HdJ6pOq4blrj
         i4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DBhqhypR0wP1/6OpocAQxey6UJcKdL/iPgq38voV0tA=;
        b=e0iDkpjWcU/cBPlKNlr+BE93ya6c/oDnNPUjhKERuaf60d9bls8m+UJwGKp2t7Bik/
         DalJzEQ+1ya1XmMSYQRmuE9am769SCeOCZDzSaG/4CJntCNQenbDmigvDOyFQE0lxJBl
         iokSJhsFivoewwKoAD5KFkDFIK2l7TW6BsV123LiMaf96u7g31bcAR0zeqOiVkRUD8a6
         Wa9LYRqeGt7hSX3PbBw5a/FGhWTWK4FQWz4s5afORA7aoHRYiV3/imn5vYDkT/udn97H
         093CJGwzUd6EDdvOvZ5p61ASXFOg8yf2+GVbhBOuZEq4+lvT0bujQ4c/U0131PCXSLbP
         bpQA==
X-Gm-Message-State: APf1xPCqjOtHwvDV4HpS9jwOeFzqLYjsyixoc17rNzETVBkije/Hi/Hh
        CaLjcH1AlSCmF3HeOE2Uv8CYuGFgE9fHe3LN5kQ=
X-Google-Smtp-Source: AG47ELsPcrLmWqisg+9dW3wV/Wf0o8r1iHGZhS9yBbPxtH9z77Rb7rGAOyWACMsnrOKFbK7NQJfC7wo0W9R3IQelvtk=
X-Received: by 10.157.54.204 with SMTP id s12mr722754otd.304.1519381275067;
 Fri, 23 Feb 2018 02:21:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:20:44 -0800 (PST)
In-Reply-To: <87h8q97sim.fsf@passepartout.tim-landscheidt.de>
References: <20180131093051.15525-1-pclouds@gmail.com> <20180211094328.6157-1-pclouds@gmail.com>
 <xmqqa7w1yiuj.fsf@gitster-ct.c.googlers.com> <87h8q97sim.fsf@passepartout.tim-landscheidt.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:20:44 +0700
Message-ID: <CACsJy8DefOL=JS-24GBucGfUx5q3A=JoLVq2N6ykdtz4yQ-dmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add "git rebase --show-current-patch"
To:     Tim Landscheidt <tim@tim-landscheidt.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 7:54 AM, Tim Landscheidt <tim@tim-landscheidt.de> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Compared to v2:
>
>>> - the potential loss of errno before it's printed out in builtin/am.c
>>>   is fixed.
>>> - keep update_ref() in sequencer.c non-fatal like this rest
>>> - rename ORIG_COMMIT to REBASE_HEAD
>
>>> Interdiff:
>
>> This round hasn't seen any comments.  Is everybody happy with it?
>
>> I personally do not have strong opinion for the feature but didn't
>> spot anything against the execution, either, so...
>
> Sorry for the late reply: I dislike REBASE_/HEAD/ because
> ORIG_/HEAD/ refers to the tip of the original branch, and
> /ORIG/_HEAD refers to the original branch, so
> /REBASE/_/HEAD/ is doubly confusing IMHO.  I consider
> ORIG_COMMIT easier to understand because ORIG_HEAD refers to
> the tip of the original branch, and ORIG_COMMIT would refer
> to one of the commits making up that original branch, but as
> I suggested it myself I might not be very objective in that
> regard :-).

I wonder if you could make a ref symlink named ORIG_COMMIT pointing to
REBASE_HEAD. A bit more setup for you, but that'll make everybody
happy.
-- 
Duy
