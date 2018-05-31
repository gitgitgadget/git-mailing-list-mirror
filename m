Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853F71F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeEaHVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:21:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39045 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeEaHVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:21:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id f8-v6so52185863wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zDfjVe1CKtdBmdWwQv53LGrKVdiYMeszRmsjAXgQh64=;
        b=Z1JeROMCKQ4AuOjn1eISwjU6STBv7o+QPjhiWeISDqHhKBaGAAfZJkUya+/wRJQlP/
         Bm/9Q9ENAxLeSV1Vu6qVHGthPWBNKkX0OpcLQrX/Kjs5UKM7da5/Ci3e5IjrZePQED2A
         EqZrhFcmzoNBdeoXeGDds54yCth+UC4j18633Bins3GzmVcE+E+bGRiNmPAyrmncf/Wm
         1bVdTNaEZYBndndRRaRpFCa+8pgh8+zhn0soXKauJv5GPrZZKqMUd9OY6uYvDQcukoD0
         2/4JomwhdEMiNCs0Od9eb/DVsZOJeBI+6Zjq50K824XYREyX8wtF6Ygc9+zV5NKkGR6B
         tS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zDfjVe1CKtdBmdWwQv53LGrKVdiYMeszRmsjAXgQh64=;
        b=P14h49pyWUOCN7QLdC72Beco9dy/C76xIJzaelkZZ7+S/8n1qGAaj/KAJ+6o3ey2at
         z3Lnf+Yr47pIgrzrFp2qxUFEhghgmeayTNVuwfzUJc1YhgB7SCqx7YgcozPThNRFsjVM
         mHxihvlaEhk+JN4/9m6frXbmV+w/F6bUv7BpLfGwLqlecbniepxV135KAfakmDaCJ4KE
         360hc4VKtKwZ3wcy+2OrJ9mIjolOuSO2ciPWqylGranRvffHyhrQ8ZnVJ7OZ97covf4Q
         eMTKU7DzIkQ5hn3q+eG7xUxEC+cYcz+2FPLSjOrfyX+nwY6PkzhZVGqP0fcLEMN9LgN2
         OCCQ==
X-Gm-Message-State: ALKqPwdGprjVV8YSRHUv2kkMceLZ63FQRNeYe5EQ8Iaac9b7hSkYmjgx
        x4dCWWMWTljlmThwFMSeK5s=
X-Google-Smtp-Source: ADUXVKK7DFCjMr+Pw54bd8w2bXd5qT/dhs9sqc3K6JvMoHuk5oNV8yMibo3GVQaqW/hOl/0cQKTyXw==
X-Received: by 2002:a50:996d:: with SMTP id l42-v6mr6656011edb.179.1527751260383;
        Thu, 31 May 2018 00:21:00 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y4-v6sm19751379edr.51.2018.05.31.00.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:20:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com> <20180525192811.25680-3-avarab@gmail.com> <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com> <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com> <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com> <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:20:58 +0200
Message-ID: <87fu289tph.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, May 28, 2018 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> If the project has some tool constraints and have to accept new
>>> "broken" objects on ongoing basis, then fsck.<msg-id> facility may
>>> make sense, but that is probably a very narrow special use case.
>>
>> That makes sense. I'll reword this bit.
>> ...
>> I'll try to clarify this, but I think we really should have some bit
>> there about historical tools. Realistically no new git tools produce
>> these, so the user needs to be made aware of what the trade-off of
>> turning these on is.
>>
>> The reality of that is that these objects are exceedingly rare, and
>> mostly found in various old repositories. Something like that need to
>> be mentioned so the user can weigh the trade-off of turning this on.
>
> Rare or not, once we say "avoid fsck.<msg-id> unless you have a good
> reason not to", wouldn't that be sufficient?

It's our documentation that should be clearly stating those reasons. If
we're not saying anything about these being historical bugs, then e.g. I
(not knowing the implementation) wouldn't have turned this on globally
on my site knowing that because I have none of these now I'm *very*
unlikely to have them in the future.

That's different from something that just happens rarely, because a rare
non-historical event can be expected to happen in the future.

> Between "fsck.<msg-id> makes sense only when you use these rare and
> you-probably-never-heard-of tools ongoing basis" and "when you
> already have (slightly)broken objects, naming each of them in
> skiplist, rather than covering the class, is better because you want
> *new* instances of the same breakage", I'd imagine the latter would be
> more helpful.
>
> In any case, let's see if there are more input to this topic and
> then wrap it up in v3 ;-)
>
> Thanks.
