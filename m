Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DCDC04FEE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 19:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjITTUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjITTUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 15:20:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28054CA
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:20:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so291152276.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695237647; x=1695842447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNhMtZq7OPQAW9USlzWmSDmFKCwIKTdvsudxNDrnf3Y=;
        b=LEFD/QGagyxf9qvyYaCGrOQvhvlGoz97Q9/dV1uRMITZJBZUP4eRIrJSLmLMvAKiZU
         KyyaDEXslsxJiDexKe7H80TWX9xCpRduz9F7txE3lv7qOBvVEnbcabTPA9LkQyEDLevN
         vdEJzYs/qq8RT/lNY0+XWAIuOtcA6+A/gcnLGa+CVRGl+ob8beGFO6hYIL0dL5Bb+otY
         q0/Cl0I+ni3aAqyH07sf9FhJ4XIA6/RrhncQM94j3CZbGLsrTdlR+Z4O9Lv3sXhh64v1
         cmgreHWSfgJuDeJecZf8kB7SlsgtPwhXtsvLbOV7X0g0XKDYnjmayXQNGs5uckzJAlXV
         sNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237647; x=1695842447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNhMtZq7OPQAW9USlzWmSDmFKCwIKTdvsudxNDrnf3Y=;
        b=AEXOBSaYSC0Wx5yRF/VI4881iX4keoHW5OCm0XPFqvTtvvuCYZtKlkME/rCRVWOAbv
         IBRGGeTEUylgSZJ/tB8vMI27G2WHx48ei3rC3zBnM1j14L98MD5yfv0HEZTaYQ5QJr/i
         fBV2ozxn0yUBHuinQRuLIeExuCVKXA7k+kAWBMBzBlnd7T702WVuVAxX5lFgFxKgbtP+
         ftpWSdG1jMHjinjZE86IdqfMH4A2KpjOuTdeyfpGHZzT2I48G3MIJX7glF9/KUH6KnVO
         Rcwi+PUSNxeYYwsg+C3AUkZHgostFg8PW4q2iWlGWV/giuVbzanMkrAR2WMDE60f0UWF
         i46g==
X-Gm-Message-State: AOJu0YwFRSOu65WTdCWL27WxzwQ01q/65XMcZD3cQkRbBpeP/Kz2Pnp8
        KuqNqO5DdM3Zeeof7/ApfJaaL6jcklk=
X-Google-Smtp-Source: AGHT+IHHIBOqaEyBuSFMD7BsL5o5no7/nznvuk99z+Vb9zHrdFS2eJzVxjQLBH4w5VwNL4dx9+/6b/Cj4kQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:6894:0:b0:d81:7d48:a459 with SMTP id
 d142-20020a256894000000b00d817d48a459mr49831ybc.8.1695237647300; Wed, 20 Sep
 2023 12:20:47 -0700 (PDT)
Date:   Wed, 20 Sep 2023 12:20:45 -0700
In-Reply-To: <xmqqjzskdh9t.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqmsxmdhdw.fsf@gitster.g> <owly7comj5ll.fsf@fine.c.googlers.com>
 <xmqq34z9g8jz.fsf@gitster.g> <owly1qetjqo1.fsf@fine.c.googlers.com> <xmqqjzskdh9t.fsf@gitster.g>
Message-ID: <owlyv8c4irci.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> Whatever improvements you have in mind, if they are
>>> minor, letting the above graduate (they have been in 'next' for a
>>> week without anybody complaining) and doing them as a follow-up
>>> series would be sensible, I would think.
>>>
>>> Thanks.
>>
>> Hmm, I don't think they are minor? See
>> https://github.com/listx/git/tree/trailer-libification-prep for the
>> current state of things.
>
> They do not look like "oops the patches I sent to the list was
> totally bogus and they need replacing"; aren't they rather "these
> are not yet complete and there are some of the follow-on work on top
> of them"?

Yes, precisely.

>> I need to still follow up to your last comment on "trailer: rename
>> *_DEFAULT enums to *_UNSPECIFIED" [2] (I was going to see if we needed
>> the "obvious solution" as you described).
>>
>> If it's too painful to move this out of 'next' now, I'm OK with it
>> graduating as is and doing a separate follow-up (I expect several more
>> of these to happen anyway). Up to you.
>
> Let's mark the topic as "waiting for follow-up updates" and keep it
> in 'next' until the follow-up patches become ready, then.

Sounds good.

>> Sorry for not noticing that this was in 'next' sooner and communicating
>> accordingly.
>
> Gotchas happen.  Let's try to communicate better the next time.
>
> Thanks.

Thanks!
