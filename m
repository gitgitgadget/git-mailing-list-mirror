Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360A420305
	for <e@80x24.org>; Wed, 17 Apr 2019 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfDQHSP (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:18:15 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36485 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQHSO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:18:14 -0400
Received: by mail-ed1-f46.google.com with SMTP id u57so19421695edm.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Mf7hbvfdlH0FSHJk72Uu5UDW2FAgsLMEVoGVaK8kktw=;
        b=M7iPvvFofxhVlOSBIASwcSDQjl0ORHzc0Zfgb4y6+hHphhdPdFTShiBhMmaTSlcO0r
         9eaPN4WhZa2sItuvCrxO+JlWffRyXGwAAe2bMu0aGuPj9wu/1MVeDGCtMx1B+n8ShNLt
         +yBNuUnJ/jr94gtOnG3Q604ePZFjGrOGTWU1lk7WA6X9/vnuuyZnOohQXlDf0xoNSl2/
         fuDaKOLpcNBKWlTUJL2G0o+HKI4CnSEtFicqVe3g7fRteuj44ZQrsQK3Tb0FEhzUl1FI
         hZV+PU9c1pP4v/ifoMVsm5D+kN15PD84y0nQb1y4AIzLHxuUhgWaftTLR7M7UJwT4OD6
         bKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Mf7hbvfdlH0FSHJk72Uu5UDW2FAgsLMEVoGVaK8kktw=;
        b=e3vuWezFy9RnAz2TZJVLx64IYrAimL86rLrhWaMI10jLPKdPGbns/1tECB15Pje8Qi
         /pVjo8GfW76Twmn1KZmEsdP6sAVPMLQQ+03vYiDRP1AoNG1NOq4Q2g+an65Jc69OFmuX
         K3PqZgDMefeModnOtHFHmBr6F12gcelM7vFNe1ewi/JQjX2BIZ6CQuZncgjXmYBA4GKp
         mRd8Odv7hXsWwl7xeqOf3xo2Oz/hC2DM72xso+682UV5ZFT0hv0UHd2qyg8REjM3Ya6C
         C+S/SPro5ezVSM6q6LyEIQLlfy42HrBZN8ApUiopJalqb3r/zHqzXeKB5X6Xby5o88qS
         niSg==
X-Gm-Message-State: APjAAAVdYcoNBDYfOA7DC6X0GbDfdEoe+xt3pKkqQ40Wn2aK9W1yuNUI
        L+DZCqJfgHNnSFbg/harpEA=
X-Google-Smtp-Source: APXvYqwvX5rTwNbXKu6EGbiWFdGyySftqyjPYFyRlK86XSucFkz0TwmKaxBV6KNT77vlfh2DanbHUw==
X-Received: by 2002:a50:93a6:: with SMTP id o35mr55557208eda.245.1555485492904;
        Wed, 17 Apr 2019 00:18:12 -0700 (PDT)
Received: from evledraar ([5.57.21.10])
        by smtp.gmail.com with ESMTPSA id j55sm1737089ede.73.2019.04.17.00.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:18:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com> <87d0lmatr1.fsf@evledraar.gmail.com> <xmqqa7gqots5.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqa7gqots5.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 17 Apr 2019 09:18:07 +0200
Message-ID: <87bm15aymo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 16 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Apr 16 2019, Junio C Hamano wrote:
>>
>>
>>> * jc/gettext-test-fix (2019-04-15) 1 commit
>>>  - gettext tests: export the restored GIT_TEST_GETTEXT_POISON
>>>
>>>  The GETTEXT_POISON test option has been quite broken ever since it
>>>  was made runtime-tunable, which has been fixed.
>>>
>>>  Will merge to 'next'.
>>
>> LGTM, but AFAICT this patch of yours never got sent to the list,
>> oversight?
>
> I am reasonably sure that
> <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com> was sent with you on
> CC: line.

My bad, missed it.
