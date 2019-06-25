Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE92F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 07:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfFYHvz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 03:51:55 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44150 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYHvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 03:51:55 -0400
Received: by mail-wr1-f52.google.com with SMTP id r16so16625817wrl.11
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qxien4CmNnZgyK6+3q0by4WePwjsy7Y+hJFR397QIkU=;
        b=Tab7Iv665I38F580E1uK5/D4011HFDsuGCJ+eqMsxzE5Cv/i/UDzfpUmzBmkMKReuU
         bybmRqkAElLWIUiySDcEJeYLLGIpbJ/inuD9mYTTLUxeVEwWXfBu2MIIO9X0F2qIWPh4
         emPGQa7motUZRwPvTQxXoWl2bUmLHFygxUGKF19pWqcJ5FhDkMyLpxi2Ycvz+p1rs4IU
         Pl8z4DdZHFWgKzPQhcfgFIyTZBaL5Tu1jnTZfP/WZSFg7bvzxoZUG6nWGMD6+crCnuuF
         x+W9WoxRELWUvcJ0hxLZVJTnZF72UHnxapdLhmDTD3reCV728iItq3cQqVBWXM3yuYaI
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=qxien4CmNnZgyK6+3q0by4WePwjsy7Y+hJFR397QIkU=;
        b=rzHWhCR8PkqXZAssTdvMjhhcoi4X1y/qi9e9Ui41PoPztHENlhtxWeYARaE1wwy6dQ
         VDidWpOk5HLPobdf5yRx05Eu3286I7Myk8rL04FFtCKjo1eLCB0SoaFttTnnPFC1xWHg
         g0wCtP81srlQl3DOdd0c3IFJ2ourKmO47x6ILby7eJjnW2bS2MDeX46myKH7ujiY8r4R
         02MWS6T13Hm8rUZxdFV3RsxuBFSNtAerNmUvpPjK1vbvYWHB+fvUqlwTBPhfz+qyw9cl
         l+qa8VsGoU016lJ45OOxqKnMupRqDpwNavuTSNHJM/JjlCSaakZDHbIxR/eP5JCMQUT5
         zE1g==
X-Gm-Message-State: APjAAAWlX9Hp3hpXNnLPTk9SPnvB/xA/rKKNxGkCG+YFet4rA5p5+OWw
        M8VUT0kIUOgeNzMg9K47oeJaa0z4NBs=
X-Google-Smtp-Source: APXvYqzNP3SdJtgnH+QavD+8mDt/+CZjvuRhOytf+i2yCTwu+cSaOwTr6V0pTNqzjcRxXnjp7dEYfw==
X-Received: by 2002:adf:edcd:: with SMTP id v13mr34917888wro.210.1561449113020;
        Tue, 25 Jun 2019 00:51:53 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpv205.neoplus.adsl.tpnet.pl. [83.8.63.205])
        by smtp.gmail.com with ESMTPSA id q1sm1521821wmq.25.2019.06.25.00.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 00:51:52 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
        <86mujhpewj.fsf@gmail.com>
        <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
        <86ftp9p7i8.fsf@gmail.com>
Date:   Tue, 25 Jun 2019 09:51:48 +0200
In-Reply-To: <86ftp9p7i8.fsf@gmail.com> (Jakub Narebski's message of "Mon, 20
        May 2019 15:42:23 +0200")
Message-ID: <86mui63xwr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>>>
>>> Are there any blockers that prevent the switch to this
>>> "generation number v2"?
>>>=20
>>> - Is it a problem with insufficient data to choose the correct numbering
>>>   as "generation number v2' (there can be only one)?
>>> - Is it a problem with selected "generation number v2" being
>>>   incompatibile with gen v2, and Git failing when new version of
>>>   commit-graph is used instead of softly just not using commit-graph?
>>> - Or is it something else?
[...]

>>                      Using the generation number column for the corrected
>> commit-date offsets (assuming we also guarantee the offset is strictly
>> increasing from parent to child), these new values will be backwards-
>> compatible _except_ for 'git commit-graph verify'.
>
> O.K., so the "generation number v2 (legacy)" would be incremental and
> backward-compatibile in use (though not in generation and validation).
>
> Do I understand it correctly how it is calculated:
>
>   corrected_date(C) =3D max(committer_date(C),
>                           max_{P =E2=88=88 parents(C)}(corrected_date(P))=
 + 1)
>   offset(C) =3D corrected_date(C) - committer_date(C)
>   gen_v2(C) =3D max(offset(C), max_{P =E2=88=88 parents(C)}(gen_v2(P)) + =
1)=20

Do you remember who first came up with this idea for backward
compatibile corrected commit date offsets (monotonically offset
corrected date)?

> Do you have benchmark for this "monotonically offset corrected commit
> date" generation number in https://github.com/derrickstolee/git/commits/r=
each-perf
> and https://github.com/derrickstolee/gen-test ?

I guess this will have to wait...

Best,
--
Jakub Nar=C4=99bski
