Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90B7201A4
	for <e@80x24.org>; Mon, 15 May 2017 06:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759481AbdEOGY3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 02:24:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36353 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759463AbdEOGY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 02:24:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id h64so10966586pge.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 23:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1SpqwxeuLhz2w7McZIwmYzpcEwv7jw/ZrNM192fgCpQ=;
        b=Q0/z2jhHiboQz2wc+rqUt0Pu9V1WB10/6qEbaXkuqPHxsZHt+xq9Baj77vr3Hf5jsj
         wS2jJKWIjOXyWK/y9BrlbsOmakTQfUh+tm5oyj7VRaS/XRDooeOeH1sAAKmpoopxF7md
         PYp6Y7+f0ujCpJUkK0+5gLYzc/iZ1bag/wz0PzyxDmybTfWdoZkocao0yP5330TU7eW7
         Ehnj7pcjw2ebQ6BmxWL9LYpcuTTsgNWxiw+zSYGCww7/XJex4AMvrTex3DZYXE5H/V23
         +SgJqPhUuLeBGhHMTwFehWy/DIPO7FXCOaPHUeUkxp/f+qn6GC9UzJyy0bFC7EijPV7b
         OTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1SpqwxeuLhz2w7McZIwmYzpcEwv7jw/ZrNM192fgCpQ=;
        b=Lz4VtuSCDQV16VIqHneHr2Bhvz+dr4PQtDMlSfDzgcXhGhJChExtwqynp+Mmo32u3q
         VDgjwK8/UBqh0byN4lOH72p54S1QB7Kol9DyfPR0tPc3ZtG9lRpfaUnb3m4vhaOKjdvn
         OZgrPk/TTDtlrxLd9tEPyZSAe+28wdaOpuGPIic1y/MjcyQlNdqkEPjVfHeF9rf1HvFs
         bj//8u2y7AMckb8DFMPQR2nvvOwjvfKd32xvP9iPRScSHQ5MM0VZY+cq/1T8Vmn/axZg
         1hNYKet5pwO4e/ROiCMZRRc3mIDJPes99Sp3l5A249HenEwixPJS4Quch9P9HVEm55f4
         gTJg==
X-Gm-Message-State: AODbwcCM5bQsHQ2BekNvC6O+ULWKoa6z0w5YGdTrgEeKQulxFJeCTotq
        hCL8VTSNyskNNA==
X-Received: by 10.98.88.4 with SMTP id m4mr4606885pfb.41.1494829467412;
        Sun, 14 May 2017 23:24:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id k86sm883688pfk.125.2017.05.14.23.24.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 23:24:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 21/29] grep: factor test for \0 in grep patterns into a function
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-22-avarab@gmail.com>
Date:   Mon, 15 May 2017 15:24:25 +0900
In-Reply-To: <20170513231509.7834-22-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:15:01 +0000")
Message-ID: <xmqqo9uuvdra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Factor the test for \0 in grep patterns into a function. Since commit
> 9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
> \0 is considered fixed as regcomp() can't handle it.
>
> This limitation was never documented, and other some regular
> expression engines are capable of compiling a pattern containing a
> \0. Factoring this out makes a subsequent change which does that
> smaller.

The latter half of the first sentence of this paragraph does not
parse well, around "and other some".  "never documented" makes
readers expect "... so let's document it", but I think you are
driving in a different direction, something like...

        Since some other regular expression engines are capable of a
        pattern to match a string with NUL in it, it would be nice
        if we can use such an engine and match against NUL; as this
        "patterns with NUL always use --fixed match" is not documented,
	let's hope that nobody depend on that current behaviour.
        This step does not yet change the behaviour yet, but it
        makes it easier to do so in later steps.

perhaps?  I tend to agree that it is OK to break users who depended
on that "patterns with NULL match with --fixed" (partly because it
is so unintuitive and not useful behaviour, and partly because it is
easy for them to explicitly say -F), but let's make sure we clearly
say that we will be knowingly breaking them.

Thanks.
