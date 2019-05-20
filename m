Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E70A1F462
	for <e@80x24.org>; Mon, 20 May 2019 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfETX1v (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 19:27:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52731 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfETX1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 19:27:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so976839wmm.2
        for <git@vger.kernel.org>; Mon, 20 May 2019 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u2x95uLWCzF0zr2miSA8jpOvb3E1IZL+phTiWwzMBho=;
        b=ZI079HYjArOtwZHksYLfF+kNlz6cLsZJ+JPRe424MtYr1w00opV6rTLBcctnus0k/O
         8sUv3xqjIts4M1igwMdFDUcN1WuXNf8jNb5F5lEd4KS9GZg0YNgj1FztYRhjJ+9YuwNq
         F5QSYIPEq12cnZA8XIeh/jEMLImuROXnINLP3cIFgH4QXoVqQpBdd96y+wdqoo5ihHM9
         Rjr0b67bJVRJrKknrMy5NlbmaWPXHYkuYSxBCYsw2nNZNVbmrhmeHc6tDNfWV6z/77jf
         pQ8k5G67N6FFbqElfkZyc9p8AL2rym8hBl+wSJSSgO8aGqKU5o7Top/hWci/lCdNjF0w
         lqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=u2x95uLWCzF0zr2miSA8jpOvb3E1IZL+phTiWwzMBho=;
        b=shXNbBynzQ5pzU2ukge4+9vPebD3ovTYj2aCy2TcoGlbJdPHpyewA9gJRBMHGqJzfZ
         +mrmY5f3ZxVHYgdznzmgfECYwvN31wAdI12TIOla4Ck5GyeO11VnWhvuy9WvPdGrv8gI
         80BxAdogoEEC0EEGtlzSd6z7F9sjB+F7sKGn+Lmp8gIKNKSdiMGr7/cnrnXbjIE7EGZc
         j1NfLO68kMVzuklmc4G9mHny69e8wm/0jSPQwhL2Y4FXSkPS2ruaxG60gad4jLxg6c62
         OciF9qVlFmCD/SO5KBdaxZ1jNlSNvQn5ZNDFa9chBGFXI75HSPWVNElBWeO2kfPMczs8
         RH9Q==
X-Gm-Message-State: APjAAAUrMztNFdHKlZgRQJ7OC1ftJEYuROtFNmfAsg2ZQIJ79dbdRoZt
        cqz1VEIyXoIPSOQTlzml8fI/8AJ/Zhc=
X-Google-Smtp-Source: APXvYqx/tazkLM5tYRWmk+Ne3YJV9z8VsZGuTCnnFClXPlX3RrYv7J2sFcY0Ft/iWOhncQcoOxyFWw==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr1083855wmg.4.1558394869684;
        Mon, 20 May 2019 16:27:49 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egf151.neoplus.adsl.tpnet.pl. [83.21.69.151])
        by smtp.gmail.com with ESMTPSA id b10sm44337640wrh.59.2019.05.20.16.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 16:27:48 -0700 (PDT)
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
Date:   Tue, 21 May 2019 01:27:46 +0200
In-Reply-To: <86ftp9p7i8.fsf@gmail.com> (Jakub Narebski's message of "Mon, 20
        May 2019 15:42:23 +0200")
Message-ID: <864l5opuz1.fsf@gmail.com>
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

This should probably read

    offset_date(P) =3D committer_date(P) + gen_v2(P)
    corrected_date(C) =3D max(committer_date(C),
                            max_{P =E2=88=88 parents(C)}(offset_date(P)) + =
1)=20=20=20=20

>   offset(C) =3D corrected_date(C) - committer_date(C)
>   gen_v2(C) =3D max(offset(C), max_{P =E2=88=88 parents(C)}(gen_v2(P)) + =
1)=20
>
> Do you have benchmark for this "monotonically offset corrected commit
> date" generation number in https://github.com/derrickstolee/git/commits/r=
each-perf
> and https://github.com/derrickstolee/gen-test ?

--
Jakub Nar=C4=99bski
