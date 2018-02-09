Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0951F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBIVFT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:05:19 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33297 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIVFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:05:18 -0500
Received: by mail-wr0-f173.google.com with SMTP id s5so9560024wra.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GO/Ta6w+iSt4OCgAAf66BHtsXHUL/qml5j5kyiNoUG0=;
        b=dyzoPD1ogSvdc7aPZc/EJJbEsovtSiTUx57eH4zuI4Elk2DBwQeJQoX0pjJa2rTycm
         +uryePTM6go3U+ICAhLHubQ+HKo514+y7E20EEkEx2GuJVr1BNuWACk1zzlpX4voTie+
         Pn2lOSBMpNo/uPokvLU4SNVkVQQyV7nwsT7opDhBUI1JkAj2yZuYjuCzfaTcz5tgsMoU
         M3+5u1iUkC5yZ2rZlTagJKoin/JRp0hC/Nph+b4Qmx6+D3MLgxkHAQOP5SQdiTo4iXEX
         /U3tPX22KfwWkYGM/zfJ9w3RfS9O4DThfh75/VieshqwtiE8ku0VLkL8OuO9SA15Ry7z
         vo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GO/Ta6w+iSt4OCgAAf66BHtsXHUL/qml5j5kyiNoUG0=;
        b=Lg/AbgejwW5kgeR80kpTKdaIUQjQm+11qZ3js9bj+NC3gKfZNxyDJAhr4GKWX+ME0y
         vKeneCt/XIrYDFSDkooclfBtEX6ENNwU9A0kFt9TpiNhAnxKdvOPwTbnIBC2njbXGQxT
         KvoTrj8/Cf986J2uGJCFEO2MJncgvldvqQnd/GbD2IbdgyJei6A7w8M1Lh8OJJsO+yst
         zaAglZG4d0GCmbp7jn2z6PxWYU/pg8p/ewsheFowJ7kOKCpVZ9CcEwJ6iB4IIIuXBtCf
         rApSX40ZX0SgebvMxlSOjRA3pfy6nu53hx5mnJzSK088xLPrvQbMnF2NGveNfw1t5gce
         jrMw==
X-Gm-Message-State: APf1xPCuHj7v1APrhscFST5BfoMkQFJoSyu6Vl/6mOwBStMpyDDggS4N
        lh+pTx7hej90TM/TlXQJV4FUjCqb
X-Google-Smtp-Source: AH8x225HfdnxRkMJAmpPQQgIeYEJ27EgeD+KgH/Hu7aSpMytjCNFY2jgZWHBw5PTw1LNmsHwTHBbdw==
X-Received: by 10.223.136.225 with SMTP id g30mr3502209wrg.103.1518210316729;
        Fri, 09 Feb 2018 13:05:16 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b54sm5800259wrg.27.2018.02.09.13.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 13:05:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] update-index doc: note new caveats in 2.17
Date:   Fri,  9 Feb 2018 21:04:29 +0000
Message-Id: <20180209210431.409-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
References: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09 2018, Junio C. Hamano jotted:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>> I think you / Nguyễn may not have seen my
>> <87d11omi2o.fsf@evledraar.gmail.com>
>> (https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)
>>
>> As noted there I think it's best to proceed without the "dir.c: stop
>> ignoring opendir[...]" patch.
>>
>> It's going to be a bad regression in 2.17 if it ends up spewing pagefuls
>> of warnings in previously working repos if the UC is on.
>
> Well, I am not sure if it is a regression to diagnose problematic
> untracked cache information left by earlier version of the software
> with bugs.  After all, this is still an experimental feature, and we
> do want to see the warning to serve its purpose to diagnose possible
> remaining bugs, and new similar ones when a newer iteration of the
> feature introduces, no?

Fair enough. I just wanted to make sure it had been seen. It wasn't
obvious whether it had just been missed since there was no follow-up
there or note in WC.

We were disagreeing to the extent that some of this should be
documented in 878tcbmbqb.fsf@evledraar.gmail.com and related, and I
see you've ejected the doc patch I had in that series.

I really think we should be saying something like what this new doc
series says, it's conceptually on top of Duy's series but applies on
top of master.

I think there's room to quibble about whether to include 1/2 at all
since it's a relatively obscure edge case.

2/2 however is something I think a *lot* of users are going to hit. I
just skimmed the relevant bits of git-config and git-update-index now,
and nothing describes the UC as an experimental feature, and it's been
well-known to improve performance.

When users upgrade to 2.17 they're going to have git yelling at them
(as my users did) on existing checkouts, with no indication whatsoever
that it's due to the UC or how to fix it.

Let's at least documente it. I also wonder if the "dir.c: stop
ignoring opendir() error in open_cached_dir()" change shouldn't have
something in the warning itself about it being caused by the UC,
doesn't it only warn under that mode? I.e.:

    -"could not open directory '%s'")
    +"core.untrackedCache: could not open directory '%s'")

Ævar Arnfjörð Bjarmason (2):
  update-index doc: note a fixed bug in the untracked cache
  update-index doc: note the caveat with "could not open..."

 Documentation/git-update-index.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.15.1.424.g9478a66081

