Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572C2201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbdETXuj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:50:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34530 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755309AbdETXui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:50:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so13339068pfk.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=yDPufh9jeiOn2PGl1N3XZ5H3hGh86GTevP/tAOgigv8=;
        b=mPg/dSE+/2PYhm+i4bkQJvD5Ya/p9V3l5sNSIlT2GPQDvBdV84Y94NbvXkUk9Au+jo
         5g5Mht41xmNhnjvWKDJPVWrFigTyEh7v3Rkl4SOe7PNeSJ6hJYiFD3VM1LNWLtaulETM
         cN73Xu4NpEAekDd8g6dEq0aNczZ5klEDIfq+F2WeBn3gTJEkUW0QR2WdPQ1FuEOilG4D
         wSGli27oxV/ru8tuN5ABvEAZTCv2fhBADMOEme5F8O2zVF5V4QW3/3Ar0spVzBxulWay
         VZpy/u48KPLDKcT1CrD4fmIEEot0DKpP4RlUfkf5lDsb0K5pByx2F+7MoEPPVXIUD+Vx
         nu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=yDPufh9jeiOn2PGl1N3XZ5H3hGh86GTevP/tAOgigv8=;
        b=VodOMifb1k4//pdCP7dxihpjTlIeipVsT0gwX/Nw7/G7fLdShOKC0DGNcRGdW+mxyc
         AgYEoGO857vBMz2D/24G2/OwJXRR1jxYG3hhDXOdfquNj55m9EOMQm3XJEgfyOAxcwLU
         ezaVoQMjW+g23kuX5dxR4MjsozrsvC+ge8Cs+p30Cd/GoJT6AxoQ2EjO9913jC9orsY+
         /FKe78QE+AMXphx1QUyndJE46N522wGvud3EiKzvMp6iofh3q4jezXqy5RJzKmXJcKf6
         iD726ng7aCwY6a5/Hno5bsLGcZg2h2EwxjdnP4IdC0LZqZsEQSrsG8C1YHOAt+IxH1XC
         OZqQ==
X-Gm-Message-State: AODbwcAd+i0Rzfw3FDjHgZk+PRHu5TJ/FR4h79guRLcYQvGAVs3f63Gf
        VWnx89h0cLmylIulonA=
X-Received: by 10.99.124.3 with SMTP id x3mr17746462pgc.53.1495324237782;
        Sat, 20 May 2017 16:50:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a59e:fcd8:9df2:4b0f])
        by smtp.gmail.com with ESMTPSA id c19sm20374609pgk.32.2017.05.20.16.50.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 16:50:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 15/30] perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
References: <20170520214233.7183-1-avarab@gmail.com>
        <20170520214233.7183-16-avarab@gmail.com>
Date:   Sun, 21 May 2017 08:50:36 +0900
Message-ID: <xmqqefvjqe9f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/perf/README b/t/perf/README
> index 49ea4349be..b3d95042a8 100644
> --- a/t/perf/README
> +++ b/t/perf/README
> @@ -60,8 +60,23 @@ You can set the following variables (also in your config.mak):
>  
>      GIT_PERF_MAKE_OPTS
>  	Options to use when automatically building a git tree for
> -	performance testing.  E.g., -j6 would be useful.
> -
> +...
> +	any of that, that's an implementation detail that might change
> +	in the future.
> + 

I'll remove the trailing whitespace on this otherwise blank line
while queuing (no need to resend only to fix this one).

Thanks.

>      GIT_PERF_REPO
>      GIT_PERF_LARGE_REPO
>  	Repositories to copy for the performance tests.  The normal
> diff --git a/t/perf/run b/t/perf/run
> index c788d713ae..b61024a830 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -37,8 +37,15 @@ build_git_rev () {
>  			cp "../../$config" "build/$rev/"
>  		fi
>  	done
> -	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
> -	die "failed to build revision '$mydir'"
> +	(
> +		cd build/$rev &&
> +		if test -n "$GIT_PERF_MAKE_COMMAND"
> +		then
> +			sh -c "$GIT_PERF_MAKE_COMMAND"
> +		else
> +			make $GIT_PERF_MAKE_OPTS
> +		fi
> +	) || die "failed to build revision '$mydir'"
>  }
>  
>  run_dirs_helper () {
