Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955AF207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 05:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953988AbdDZF3E (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 01:29:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35462 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953985AbdDZF3C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 01:29:02 -0400
Received: by mail-pg0-f67.google.com with SMTP id 68so1088444pgj.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KoC4pK2zhDeSHuFIff4Qdt29hxdu5FC/8z90IbvKi1c=;
        b=rb9UF3QeUykZYEDvMjxlfIkrXjnawsQMFg3jtni8Jhz/2WBfZCtcX0fgBi8TcyKr+b
         9uaoPtgkqoqv07bDAjLVNHw+bYZnVrVdweX1DlbFrnWglEDjxykmTd597bc1D3RSEKvq
         Pw/Bgj96F5nqU9BZ5oWZRtQHgw7YBerMYwYA+0ZlOVPZLzPOA3fzWx2iuE8f9bBLtpFm
         YXBbQycZOkFrvw6QUTrDx4Nhm9UvGkJ5T9EiSbqmb17i8LomgMH6U4bdpz7YD7CFpy8S
         xD1SUNG+EUVs8orJ+eaZT8hNnmxoTNauaw2Bl/NtOnHKK7Wz7VPhTGMQg+wzg0sSK/3x
         0BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KoC4pK2zhDeSHuFIff4Qdt29hxdu5FC/8z90IbvKi1c=;
        b=CtXGsDoiI2xBnvUdHzkx5lpKRQpTj2GLFOErn9hlbksTv+/6e/K29HTfZT0A69JJS9
         wp6lJnB7TltOY7CDjOfa30o9AEpdDiQ4Y2UT9VWZNJNXV1Z41XoK6tb03YLs6Gch5/ik
         QMcTli+NTRnmgVEMaqQugZxfXn9xX+ggbzYdoiE7y3naZfsYePomN+GN6uAC5GxQzwOk
         nj5zmGYmn80vFk+GLiFalQkcEleAc1g1SeUlgTYsaOSeIAJI4rcl0i4ai4EMsONoOGlc
         6chud9qYmVP93MgyUFbrhl1YrWeehJO+gYecssLhhDoUmQItJpJ9uVkvkpnbH7dXjPSc
         8OKw==
X-Gm-Message-State: AN3rC/4x5NCsdHFqv1s1Sv1FTykjl9b0Rl5a86iYTeHdXkBPdKAdd4VR
        3MksFD7I8at1UA==
X-Received: by 10.99.60.3 with SMTP id j3mr30342047pga.61.1493184541851;
        Tue, 25 Apr 2017 22:29:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id v62sm16430745pfv.44.2017.04.25.22.29.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 22:29:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?utf-8?Q?Zol?= =?utf-8?Q?t=C3=A1n?= Herczeg 
        <hzmester@freemail.hu>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v4 05/19] grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
References: <20170425210548.24612-1-avarab@gmail.com>
        <20170425210548.24612-6-avarab@gmail.com>
Date:   Tue, 25 Apr 2017 22:29:00 -0700
In-Reply-To: <20170425210548.24612-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 25 Apr 2017 21:05:34 +0000")
Message-ID: <xmqqvaprrb37.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -417,7 +415,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
>  	int regflags;
>  
>  	basic_regex_quote_buf(&sb, p->pattern);
> -	regflags = opt->regflags & ~REG_EXTENDED;
>  	if (opt->ignore_case)
>  		regflags |= REG_ICASE;
>  	err = regcomp(&p->regexp, sb.buf, regflags);

This hunk is wrong.  Now the use of regflags we see in the post
context is mixing ICASE bit into an uninitialized garbage on the
stack.
