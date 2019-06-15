Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFCF1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFOWOx (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 18:14:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37735 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfFOWOx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 18:14:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so9321773eds.4
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 15:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M3xoD18CgWqLSnUFa7EOEH0haulZ/6AsAui1+cPWg/c=;
        b=sXGQ5wj9CqaqnmwXt3/K3sMxn1TFkcpLF63FnzOEtcuMCOfjp6TqrT76nPOgxgbZqJ
         MWFOyftrkD3DnCsabErocvpkw7zaJqmH/zOv/xlOlj45oqOVECDLSlJXFJqYjR2MR/zR
         JEk45RwU+pE0PUr1dlsSO/IWr4Melbm0buR5FnSl0lLTvzqyD5ohYFwdkPMiFE5lauI/
         9rsEMOBhLkqlhGcIBeqT4SlLMiQiETlpGZFe/37gzNUQTBSj3wx/4SVQGcljAUQOkwBV
         xvspAN8KwMhT37qg/OrH5l2M8Zju3ysd/h+vT+AhJDs7TBivmSz3iPI2P3/DbKeYpomu
         iW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=M3xoD18CgWqLSnUFa7EOEH0haulZ/6AsAui1+cPWg/c=;
        b=Fsa3t5fI8YPgmt/9XkABDCSHk6J1mVwCvsKO70DHsGvhRVr4BkML+fzfxOcMyBM21L
         wcgtHeKuy1D0+c3FruKaB9hN8LmCF5ZKYzhqBujMVqU+DNsJM3alx5fcT9g7OM7h9iYb
         QsN3PsHrA4JXEleQx6nxFnG8Dbfiu8GnAJDOax33M8GY2OF3dFIo035U6A77rpV4TTLU
         /ahuhkmZUl7T0B+wLetLPtT81ZjIf0SKiLqHLV9VlfITsVbexjg4dSZZv0CuiWJ6LWaw
         Gj8DR0QlxYSXmMDABAmLlHdZy0Erv+yIWxXIIvQV8Q13MJb2XbSWdH7LMHA97mmVZM2r
         0fdQ==
X-Gm-Message-State: APjAAAX7tk2Zcm60CwTOgumWnqanWFduD22QGf/8Lq3jDlCCrM6uRe8q
        3r6+0S8Hy/48wjvnSLn8MFA=
X-Google-Smtp-Source: APXvYqzCdD9VzQ1JaCNMe9o4/iguTI1IpQqPPdrQiTEinPlEEsbb+4HjU53ivyZwC10oe5E0/LDXAA==
X-Received: by 2002:a05:6402:14cf:: with SMTP id f15mr50334283edx.255.1560636891140;
        Sat, 15 Jun 2019 15:14:51 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id l2sm2112160edn.59.2019.06.15.15.14.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 15:14:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git-packagers@googlegroups.com
Subject: Re: Can we just get rid of kwset & obstack in favor of optimistically using PCRE v2 JIT?
References: <pull.265.git.gitgitgadget@gmail.com>
        <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
        <87v9x793qi.fsf@evledraar.gmail.com>
        <20190615191514.GD8616@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190615191514.GD8616@genre.crustytoothpaste.net>
Date:   Sun, 16 Jun 2019 00:14:49 +0200
Message-ID: <87r27u8pie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 15 2019, brian m. carlson wrote:

> On 2019-06-14 at 22:55:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> It seems most packagers build with PCRE v2 now (CC:
>> git-packagers@). I.e. we'd keep something like compile_fixed_regexp()
>> (and as an aside just use PCRE's \Q...\E instead of our own escaping).
>>
>> We'd have performance regression for platforms that use kwset() now but
>> don't build pcre2, or where pcre2 jit doesn't work. Does anyone care?
>
> I know that there are people shipping newer versions of Git using CentOS
> 6, which IIRC doesn't ship PCRE 2[0]. Since having to ship your own PCRE
> is a security maintenance nightmare, it's probably best to leave this at
> least compatible with non-PCRE 2 systems until November 2020. At that
> point, I'm happy to drop support for it.
>
> If it would work but just be slower with PCRE 1, I'm not too terribly
> concerned. Let that be an incentive to users to upgrade.

Not just PCRE, but if you don't have PCRE at all things would still work
perfectly fine.

I.e. all we're talking about is how to treat this internal
optimization. If we'd never imported kwset we'd still be perfectly
capable of searching for fixed strings with grep/pickaxe, it would have
just been slower.

So platforms that don't have PCRE at all would be slowed down by
something like what the benchmark in my
https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/
upthread shows.

Or not, maybe their C library POSIX regcomp()/regexec() is faster.

Platforms that do have PCRE would be faster than they are now, and we
could stop shipping this kwset code.

The *only* case where what I've outlined above isn't true is cases where
the pattern being matched has a \0. See my 966be95549 ("grep: add tests
to fix blind spots with \0 patterns", 2017-05-20) for how that behaves.

There our current behavior is IMNSHO insane, and is certainly
undocumented and unreliable (i.e. it behaves differently if you
e.g. have non-ASCII along with \0 in the pattern, none of this is
documented).

Having poked a bit at that I think the only sane thing there is to just
outright die unless you have PCRE v2, which is the only backend we have
that has any hope of handling that sanely.

> Also, as Carlos pointed out, not all platforms will have the JIT support
> functional, such as OpenBSD, NetBSD, and PaX Linux systems. That may be
> more of a blocker than the CentOS issue, especially since people run PaX
> kernels with standard distros.
>
> [0] I'm not certain because CentOS 6 Docker images segfault on newer
> kernels and I'm too lazy to download a live CD image for testing.
