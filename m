Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A76207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S977631AbdDXVe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:34:59 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35250 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977736AbdDXVeb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:34:31 -0400
Received: by mail-io0-f174.google.com with SMTP id r16so197561413ioi.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5dH22WkhpWDDiIp2zl5hKAYDLPUnHuE51sss0HJF4RI=;
        b=vxHzVBQW8264VpQYQkNznVXq7TWlqAZIzdWw9lGoumiKul2qdqN7sGiI4hgQA5JIK1
         LQl/WiLoJeLmlm2ZUknZWQPBR5aH6fuIg/oOFdWCUCaFt1r22bl1y9JvCcLfjBxNHSaS
         274SVamcqqw50FpwD4p+pLYkmg41GITcLXLZTUD445gfoYwJTMFjNczHQFRLYQmb/KTn
         tgo2fq/5A3+psx5OWXLzvHljOlPNbKY1LWGIWKdYK7iKwXXkNLQ/Ix0Vv/WxFz6pAoF+
         y9dGUZFgw//8UoNI7IJNdN9yz8Jpda9qCIaryNipQHj4jmBPd1JnqYscDNgVl+BITliJ
         NPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5dH22WkhpWDDiIp2zl5hKAYDLPUnHuE51sss0HJF4RI=;
        b=KhDPTmoc29ZPE/ZqoirFas+NA82e6Nev974VDUo85onBN+09CypZ0VpthhxmvIYtB+
         X6Mfv6vYHG5cU3nbTcmPuWWhF49aeRO9sqcW25NGGKZQQJezBUZND6uudxvpFqlc25Fb
         Uh7u8f0lkZb2isuPRzMCd9N0gBXEqOfJi5xJ4bk6xmT2iOXuhobyQZ01y6cBhJEinzkI
         Bw9gDFLL5kwbsTThBrhsKwPdGc3FkElSnLvYbuvpU/9n3I+ZeAPESMpD+iWEn9cmPaHj
         b0tvQR9OVGBB5cPKgK6lAgs70UWLRNj897+hgIVSI+w9ARm0hW9UGVLcJSTXQeUMJikk
         A2Wg==
X-Gm-Message-State: AN3rC/7vnLaJL0hP57sZuNEsn9xFiVaU7zm0kpMdnn984nDib0x8h/zS
        wSIOZHeHP+GSW4bv
X-Received: by 10.107.187.199 with SMTP id l190mr9332330iof.86.1493069670569;
        Mon, 24 Apr 2017 14:34:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3165:1f91:2c02:1f0c])
        by smtp.gmail.com with ESMTPSA id k101sm8453284iod.39.2017.04.24.14.34.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 14:34:29 -0700 (PDT)
Date:   Mon, 24 Apr 2017 14:34:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] perf: show that wildmatch() regressed for
 pathological cases in v2.0
Message-ID: <20170424213428.GA105623@google.com>
References: <20170424211249.28553-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170424211249.28553-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/24, Ævar Arnfjörð Bjarmason wrote:
> Russ Cox just published an article about how various glob()
> implementations suffer from pathological performance when fed certain
> pathological patterns like "a*a*a*a*b" given a file like "aaaaaaa...":
> https://research.swtch.com/glob
> 
> I was curious to see if this impacted git. It turns out it does. This
> used to be a per-platform issue with git, since globbing was
> implemented via fnmatch() by default before v1.8.4, and support for
> using the OS fnmatch() was removed entirely in v2.0.0.
> 
> This performance test shows the regression:
> 
>     $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_OPTS="[...]NO_WILDMATCH=YesPlease[...]" ./run v1.9.5 v2.0.0 v2.12.0 p0100-globbing.sh
>     [...]
>     Test                                                       v1.9.5            v2.0.0                    v2.12.0
>     ------------------------------------------------------------------------------------------------------------------------------
>     [...]
>     0100.7: fileglob((a*)^nb) against file (a^100).t; n = 1    0.01(0.00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
>     0100.8: fileglob((a*)^nb) against file (a^100).t; n = 2    0.01(0.00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
>     0100.9: fileglob((a*)^nb) against file (a^100).t; n = 3    0.00(0.00+0.00)   0.00(0.00+0.00) =         0.01(0.00+0.00) +inf
>     0100.10: fileglob((a*)^nb) against file (a^100).t; n = 4   0.00(0.00+0.00)   0.01(0.01+0.00) +inf      0.02(0.02+0.00) +inf
>     0100.11: fileglob((a*)^nb) against file (a^100).t; n = 5   0.00(0.00+0.00)   0.20(0.19+0.00) +inf      0.24(0.23+0.00) +inf
>     0100.12: fileglob((a*)^nb) against file (a^100).t; n = 6   0.00(0.00+0.00)   3.03(3.00+0.00) +inf      3.08(3.05+0.00) +inf
> 
> And here's a one-liner to do the same:
> 
>     $ time (rm -rf test; git init -q test && (cd test && touch $(perl -e 'print "a" x 100').t && git add a* && git commit -q -m"test" && git ls-files 'a*a*a*a*a*a*a*b'))
> 
> Add or remove "a*"'s to adjust the runtime. With 6 that executes in 3
> seconds on my system, 40 seconds with 7 etc.
> 
> I don't think this is something we need to worry much about, if you
> have a file like this and feed Git insane patterns you probably
> deserve what you get.
> 
> The real concern is if we have behavior like this and ever e.g. expose
> globbing over the network, e.g. in some future upload-pack protocol.
> 
> There are probably some web-based programs built on top of git that
> are vulnerable to DoS attacks as a result of this, e.g. if they take
> user-supplied globs and feed them to ls-files.

I was taking a look at wildmatch a few months ago and have an unfinished
patch to do some cleanup there.  I noticed this was inefficient but
didn't expect those kinds of numbers.  I wonder how difficult it would
be to rewrite it so that we don't have this issue.

-- 
Brandon Williams
