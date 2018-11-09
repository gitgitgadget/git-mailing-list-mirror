Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0A71F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeKIRP4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:15:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40447 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIRP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:15:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so377600edx.7
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 23:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PwZRsiMYEJ3fFG6Vsyq1Ovf6m4Iz1nDaOyS7zuYUip8=;
        b=WFFtAso1wLsdddnrOOfofJG6rHAHFEtfaqoZhncyA9GpUyx6h6uYcTVSAVQ84nX0dT
         nREfjM2Fxz0de3g4cEaA5jsupOrnwXsM0pFUxYtdR7jFQH04ogAgHrK7CJxx5gElqZFs
         QbOs2DtZrIxcUZpFvcV0KAdvYOxmkhDUfwCiO3hD4y5zkvQohEAuBb9NrlGRZPrduEwQ
         G58W7ZkTbPzzGQVx95eUnY/9Foc5h5vDF35iGLY56qCzA/gA2mtHl5HGE3Np/VDR0Ltp
         7lvzVSilIZVsxvwjeV5wUO1NpYoOg3rjaoEQB1v2c4E9dbMpd9Pj9QmK0QtEMZvrZ9iB
         lwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PwZRsiMYEJ3fFG6Vsyq1Ovf6m4Iz1nDaOyS7zuYUip8=;
        b=Dyu0z59/+0lpdgA8gY0lneSQZrjcFQ5B5TSTHtnU3CjN0ZaZYFiW52amhGs+h6eAyq
         DcFAtYMUp7q9a9rzBpgXy/iUQfV8QDbn4hXNTk4JKXrHEh65eS77XCigvxBRLNyAzni6
         z/HNAF8IKYRVQWHbOSouSk9U3u6QerGzVxNInDh5bKIcj+wzaW5Pikv0tqjZth3x/Ylk
         dbR7RhfYe7hQmDq+yCMG+vmXHsBH5w/dkyyPdPYMxXOZ4lY+7VQkG1MYRXk5J8R4xOxO
         jdTVBLN4BMb8k4ZPY9aRYK4SUYdrbrNYGWoCWx2kAGx9EGyj7oXrw0MMts/HqAY92SqN
         RNgg==
X-Gm-Message-State: AGRZ1gLb6FtFcsxWri2gUT6eQB+Ag3Enz3FvTYsfwFkQzQGrxMOxolbe
        3z+uk5VrrhPOR0dftKN+u2qngyLEzXs=
X-Google-Smtp-Source: AJdET5cDhhR0bSl7+UY2U70rYWet5hwJ1qx3llncPN8GusIRQ/3NMh9Wtu91aeiF/HtA91zaDtQrqg==
X-Received: by 2002:a17:906:e211:: with SMTP id gf17-v6mr1093515ejb.46.1541748995824;
        Thu, 08 Nov 2018 23:36:35 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d24-v6sm891380ejd.77.2018.11.08.23.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:36:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] range-diff: fix regression in passing along diff options
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet> <20181107122202.1813-3-avarab@gmail.com> <CAPig+cTeNcn_raJWfEK_C_du1v1KYQFTVmWA9B4DNHAXoFHw-w@mail.gmail.com> <87k1ln5hcx.fsf@evledraar.gmail.com> <CAPig+cSJ=T_iwPOaxT9T0XK2UYZfvkE_Vx5D__ZLct+z1-p5cg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cSJ=T_iwPOaxT9T0XK2UYZfvkE_Vx5D__ZLct+z1-p5cg@mail.gmail.com>
Date:   Fri, 09 Nov 2018 08:36:34 +0100
Message-ID: <87in1666t9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 09 2018, Eric Sunshine wrote:

> On Thu, Nov 8, 2018 at 5:34 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Thu, Nov 08 2018, Eric Sunshine wrote:
>> > Looking at diff.c:parse_diff_opt() and enable_patch_output(), rather
>> > than introducing this new conditional, I'm thinking that a more
>> > correct fix would be:
>> >
>> >     opts.output_format |= DIFF_FORMAT_PATCH;
>> >
>> > (note the '|=' operator). This would result in 'opts.output_format'
>> > containing (DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT), just as it did
>> > prior to 73a834e9e2 when --no-patch was specified.
>>
>> Maybe I'm misunderstanding, but if you mean this on top:
>>
>>     -               if (!opts.output_format)
>>     -                       opts.output_format = DIFF_FORMAT_PATCH;
>>     +               opts.output_format |= DIFF_FORMAT_PATCH;
>
> That is indeed what I mean.

*Nod*

>> Then the --stat test I've added here fails, because unlike "diff" the
>> "--stat" (and others) will implicitly "--patch" and you need
>> "--no-patch" as well (again, unlike with "diff").
>
> This new --stat test also fails with Dscho's original git-range-diff
> implementation, even before 73a834e9e2 regressed the --no-patch case.
> The commit message seems to sell this patch as a pure regression-fix,
> so it feels wrong for it to be conflating a regression fix
> (--no-patch) with preparation for potential future improvements to
> other options (--stat, etc.).
>
> I could see this as a two-patch series in which patch 1/2 fixes the
> regression (with, say, "|="), and patch 2/2 generalizes setting
> 'opts.output_format' for the future. Alternately, if left as a single
> patch, perhaps the commit message could be fleshed out to better
> explain that it is doing more than merely fixing a regression (since
> it wasn't at all obvious to me, even after digging into the code
> earlier to come up with "|=", or now when trying to understand your
> response).

Yeah that makes sense. I did not see (but see now) that the --stat
behavior was different now v.s. before your 73a834e9e2.

>> Right now --stat is pretty useless, but it could be made to make sense,
>> and at that point (and earlier) I think it would be confusing if
>> "range-diff" had different semantics with no options v.s. one option
>> like "--stat" v.s. "--stat -p" compared to "diff".
>
> Perhaps this sort of rationale, along with some explanatory examples
> could be added to the commit message to help the reader more fully
> understand the situation.

*Nod*
