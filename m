Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30881F462
	for <e@80x24.org>; Mon, 29 Jul 2019 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfG2PLj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 11:11:39 -0400
Received: from mout.web.de ([212.227.17.11]:47167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbfG2PLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564413083;
        bh=8s0RbiYP2oTBAvbqy4BbaqhuzLnkV/yXhQO7BzPeYyg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WrPI1w79EgBBGlphDysgbzYPtdQU6tE1PibyrFbN0IKbKst5YDIJPD0wm8n1E+mNr
         puNUoJ7H0XzFDstDKsenzrykPmWaI1k4I/c2doqknUtlWsdoFnS+DEme1zFXtgJ7M8
         A+Na2K8OQBHh+O/0lBqZvBV/cCWcGRWmwDREQdr0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyRS-1iXb9N1Yl8-012VFW; Mon, 29
 Jul 2019 17:11:23 +0200
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     avarab@gmail.com, sandals@crustytoothpaste.net, gitster@pobox.com,
        dev+git@drbeat.li, Johannes.Schindelin@gmx.de
References: <20190728235427.41425-1-carenas@gmail.com>
 <20190729105955.44390-1-carenas@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de>
Date:   Mon, 29 Jul 2019 17:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729105955.44390-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5aU6eC77m9e+U2BUGRe/DVWxuKUmvREWdfdhbfbHD/3lTTfoR54
 39O55EnXgd9w/H71FUHAeghLCSETA10NySYzGBwfiLC2FNyVVsoz/yuzc+q6XfUryHa+/S2
 9UkDXtyjQmVufYa934otqtOVTEaECyl+2nfJZAds8rca+kfZ7DCc4QTL1JPQ+hSQs8iwvZj
 v2WzPgFKsWM/aB2GXHqlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+0W4Po8UvZA=:lOThSWkHYlQLW5RtY+Ilkz
 TmpX+7eH7eaIUXyMyZt7O8Wyp7QqTimoGvKKfGAAPWnJdRYWOsRwzmzXzPZCrF6Q5RdKO/KJe
 JKhJFwvPSfVCKQd/YCbarjE7g24saisruWGp6xzyI4UUnRL8klEEBUyZwK9hODNAgFddF9enR
 erZl7EViKvRWmtUY+QhlpIF0bEdG4Z5MbGjqw26ebaNzbV0ORqM5Uf73QUZWC5ImWx5boJyp+
 mYCrJnJ3ERXRG8LIE8E8389nUZba26WoTFrGOv/BFC4NBUhkUMhf7Wen0Id75UvkUY9aHanON
 UMUsNWn3PXtQ842Au5WoffIqkd+5g1ypQfrF2HsBDUYUKPvWFTZPXKO5U2QbnAe6k/Slz3mch
 JmvzbybFAnsg9L3gljI6L/W6ozjeguAgbZe2kO8wSXT1t+ii3SxGt1wXwhrHHetekhMRU2VPq
 HMg40clmjqZSD2HYFt9rZ0o85kezm7dbaywryJoa5I354giioqoRpFfcaUHhnhvIhI2mOqI6b
 Rmstqs0BUJRrEXZ6IYYX37QcmqaqUs1dOcKVSmZfjHVb1otTNTa8iEqDmzySX3CqOA2nK9Rpm
 9cWrw3D94g4VadOLv+Dd4m3LhtlX3Ei1wyQu30I0PffvoAplUgPOOB/+r11G35u3PnddAhMtP
 lzcXVi+ryeoOAg6NciiuWGgwR5+gl1aO6e5P6SmfWJmwdwzir9Dc2Ir6MfE3YxnQbvuGn4OJW
 QuZDmZ5S546eDO8YIWLMf3oX/oEXVGPz3krq0ZmQrLHODHwnBOUE4chaxtP1yG/FD43dPmyPN
 g7nxkJ5j7BIZFVR70Y+nUbOLRPM97Ixxam6gqv0oB7YlTjcOcbhZwp/9A6zVf9TfXP5uOdCkW
 sVffFAOSI/GM650NsnsLduTJoAE8p0Eca3bxRJxMLNyWKviMVRTBmgW8U9N6B6J0ogxu7ldCm
 c7uF2eqX4fSGI+OXC/6ajomiZmkzYvONOLUwh05eznQrjKfc4oTqC3/C+0Zac+hC2JcziqMSg
 6vUiksltO09IpHUH4n3KyW1YhSrqOELhNxCsiURfMdeLF55Pg960IjWmA/SjpCd2kS8OWWHgM
 83ab6oBWdqMOzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.07.19 um 12:59 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
> had one, forcing the use of JIT if -P was requested.
>
> After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> the PCRE2 engine will be used more broadly and therefore adding this
> knob will allow users a escape from situations where JIT might be
> problematic.
>
> JIT will be used by default but it can be disabled with the --no-pcre-ji=
t
> option in `git grep` or by setting 0/false into the pcre.jit config.
>
> If a value of -1 is used instead then the following error is prevented b=
y
> using the interpreter when a JIT failure consistent with known security
> restrictions is found at regex compilation time.
>
>   $ git grep 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> V2: add command line to grep as suggested by Junio
>
>  Documentation/git-grep.txt | 11 +++++++++++
>  builtin/grep.c             |  4 ++++
>  grep.c                     | 30 ++++++++++++++++++++++++++----
>  grep.h                     |  1 +
>  4 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index c89fb569e3..895c6b34ec 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	   [-v | --invert-match] [-h|-H] [--full-name]
>  	   [-E | --extended-regexp] [-G | --basic-regexp]
>  	   [-P | --perl-regexp]
> +	   [-j | --[no]-pcre-jit]

Do users care?  Enough so to add a short option for this?

>  	   [-F | --fixed-strings] [-n | --line-number] [--column]
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [(-O | --open-files-in-pager) [<pager>]]
> @@ -69,6 +70,12 @@ grep.fallbackToNoIndex::
>  	If set to true, fall back to git grep --no-index if git grep
>  	is executed outside of a git repository.  Defaults to false.
>
> +pcre.jit::
> +	If set to false, disable JIT when using PCRE.  Defaults to
> +	true.
> +	if set to -1 will try first to use JIT and fallback to the
> +	interpreter instead of returning an error.

Why not implement only -1, without adding this config setting?

> +
>
>  OPTIONS
>  -------
> @@ -175,6 +182,10 @@ providing this option will cause it to die.
>  	Use fixed strings for patterns (don't interpret pattern
>  	as a regex).
>
> +-j::
> +--[no-]pcre-jit::
> +	Diable JIT in PCRE with --no-pcre-jit.

"Disable".

Ren=C3=A9
