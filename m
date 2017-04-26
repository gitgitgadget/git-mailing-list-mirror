Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B6A207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 04:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947968AbdDZEuo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 00:50:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35772 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947694AbdDZEun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 00:50:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id a188so13962600pfa.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 21:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J3lW2MFRwXUdV05cRJqW+9h8CemxCkVCCDsSgSbKUHU=;
        b=lQtW/C4df5x3bYOZ0y+yAqruA3VBJS1ACjp1WOJ+6+E1k2gO373eZNGUzLwodAaUpH
         ggfsF0i/K4VCTv0UJizXAEMeiqcFTXOezGOe2i8SlsH04fYDnYn73zJkZS7hb28AIDJ/
         QCfnwYRFZ1n73DLi7CvT/+lzxc9mKKxGSi3OETs2HmSW6LDEXD5wrxafqFsFm2kzCR0m
         V9+OhEFK3COiRmEy65Fxs6e+uZC/EuHpgDfvBi1EXMvr4cTRlIqNGiaiE3fr/5nZeFTJ
         +bahISoKDuX78bqUyziz5HvxX7x9cJEuOSRdytin5IXhARhDHwDEE5bZ9xeL2gDGDfUC
         mbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=J3lW2MFRwXUdV05cRJqW+9h8CemxCkVCCDsSgSbKUHU=;
        b=NJsDbpCP0avM3bVy93AGDjowcnaFOAVOsUeRMo625Z6d5YYnw/qvMIPmb8qDpo8GMR
         UaKzOPlpl2NdcsrP3kPBDAmDiPJXQLMxuZEQ1jsHnMFklf41VdBzt+tnXa+guWB0WLol
         W05sBWbjeXSzRa0LEsl1JrJ+n5vbVkn209obn2y+kh71ganVFOEJZIE1IS05I6IoxeLT
         GqJKbXEBjA34HDZYSXcl0pfqFf+8IPFZqaGVS1bxRNeWq0QT6Dr0YXWJ7jWCgNFI9Bph
         CE/0xggTrGfoRI/TiWQIPQlHzfU0NMii0/sUzKcw6MPO0PECcdoupoHXmtxumuwnGD8p
         ihow==
X-Gm-Message-State: AN3rC/45MGMWdt23dwrmMORe7xBEwsvBZL4s0idRPYFERVF4l5iBnMv9
        rSKhCN2RlqGPsQ==
X-Received: by 10.99.146.30 with SMTP id o30mr30350085pgd.183.1493182242390;
        Tue, 25 Apr 2017 21:50:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id x21sm39167750pfa.71.2017.04.25.21.50.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 21:50:41 -0700 (PDT)
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
Date:   Tue, 25 Apr 2017 21:50:40 -0700
In-Reply-To: <20170425210548.24612-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 25 Apr 2017 21:05:34 +0000")
Message-ID: <xmqq4lxbsrfj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove redundant assignments to the "regflags" variable. There are no
> code paths that have previously set the regflags to anything, and
> certainly not to `|= REG_EXTENDED`.
>
> This code gave the impression that it had to reset its environment,
> but it doesn't. This dates back to the initial introduction of
> git-grep in commit 5010cb5fcc ("built-in "git grep"", 2006-04-30).

As long as nobody calls grep_commit_pattern_type() more than once
while interpreting something like "grep -E -G -P -F -G" (i.e. "I
cannot quite decide which pattern type I want to give..."), this
change should be safe.

This made me wonder if we should be doing "opt->regflags =
REG_EXTENDED" for ERE from the same "this is only called once"
reasoning, but regflags is a collection of bits, and presumably bits
other than REG_EXTENDED can be set before the control reaches
grep_commit_pattern_type(), so that one must stay as-is, i.e.
"opt->regflags |= REG_EXTENDED".

Thanks.

