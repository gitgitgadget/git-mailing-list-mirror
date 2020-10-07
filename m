Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D75C47095
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F66215A4
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VJPqO9OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgJGQGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:06:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:57899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbgJGQGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602086788;
        bh=osZJEGiCZhLuQX85PQn0UpxdD8Jel/6XbNrUr4It21Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VJPqO9OLxkeaqWRZlzHn084KBK10st4Q6yXoBNkbQ7DEYVhsSF8Bs3ZxvMeslv32H
         aJghnf8QjLFuiREa29FyFx8r+Y9ng7XttC0M+FIIzPj6EQRzV51D7KL80GXythZMBu
         pC4WJJ2DbtxExR+a8mBEnMUiTiXDTcRIpclE+TWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1kzWVj1smJ-00aBHl; Wed, 07
 Oct 2020 18:06:28 +0200
Date:   Wed, 7 Oct 2020 18:06:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 3/7] subtree: persist cache between split runs
In-Reply-To: <8eec18388c86071db47512b84118e3b9111bd34d.1602021913.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010071750310.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <8eec18388c86071db47512b84118e3b9111bd34d.1602021913.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xkj0QhUKe7ouL8mdlqGxmMKkKUxSjlkrmQMNukXZy6QStXfs1h2
 g/roTpzZn1KiZ8nWFmO5t/uW7/5cQK7OsvpukZShFQhxCDHCxTPvYGKF5YOvCPI3pcIjrgV
 XSBguSM0yi16WEkI1sd6kJPVPuvN+lTMql2bpe7UTmnSYuag8qoi7nctAHod8oajlm4JXLR
 n1IbCika97FC5p0sk+YuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ZLAbLJ3Rkc=:DmHOLZDR9HqSgG3R0Ussx2
 jHcIuNTp7WhAAvWB0Szc9A/QLhDlgaE9DI5Glt9vJOJZvIS3y93HDNH/DUbPTKUGihZoEss4t
 ZJqYa18+ojMFkfBafldbiz57EwxkqRo6su95R+LbweIruxoZoy8Oy/wIPZ5uL8uf/7uuZnxmZ
 DqyFWW7idfbquU5XrKU4Fg25n7NucefYl0BgBZGynBrtniiN57GMJ3Pc33J6OtHzGr7GGL7NC
 RhQQBdqInkd/sJjuQHsYzonKYbv73ttO2W5Cnb12gwglNDjX8RfCTs872OM+6iRDEs0MmpKWz
 2NuDrr2XtmUJY4f8n3riorqfoBO9JV09kLcMqP3skIdlTrxmc1wV6ej9oXhMD7XsZMc01vtYa
 H5XCaCCQi+1eIG4JV505KvReurO3bpFXUG6DXp1Yz1N5Ea8u7FrropSmboJQKBAlIlowd6A4k
 oVYzGSPFs8Zo0MEQQJ37ObvMhZm7xfev7DWykGA4f0wZ3LPtUZV1nRfN3p9UDPCiNVJJxmto8
 xfYqOuXzpaYIT0cLB2T/g/sS0tLwyJWYHYg3UIuZnCQdQ+Phym/G20ZDJnpOmz7bfELO42Ed4
 hlFsMsBO7ggSD5Aaj5RQq9gPBAKsXxzwo0TpYT4dSV6gnxhDMsEcx8oe4qTtoH/hCcvmtepAD
 VFVmGeO/tPPycheiEhX9+p9KrF2dYfBePBPExjvKmm7Sb1FRXSjSr38L7acqFz6HFUtalsV75
 Pu9aCyb9ZTRtzFmLChtdO1gZBlPqMUwBFErzcdc+Wtzpbut5U+0jh7zP17nxGrCx5hfbsgUbZ
 /J0JBPcYNQj/ZNKWXPi/arAbzJxlVMsINS6yjV0thf9tShudnmd6bNk5u11qep1TRfn7ZX2XR
 ef/Lggvvyep4kyeGnNtvBxsDAVIe0mLjKoXzsFcBjw9bgbdStRJXDb4LbAyE5Y5Iasg+bH7+6
 dGxfJEzWDJpXxDJ9eZN5vWg2H1vp8AS7VUGoPLNeTBV/5EfSnEIHZ3hDJCl3ybTCpjN+Hhs00
 XaRBxW1P5iXx3Vuj7POQYS+feQj8c7+XpCjEo7Z62Yar3rJ6KniL6DPE7iKw46rvyyMR8FP9H
 EFncet+1AJyCbjkNBEq1ns6K+08OwaClOqr+I5BkuQyEWfI+hblcDXFtDqInzOqKdPrt//cF1
 7l1WFFFgsC/QQgiE3LvqX9OFtEuFwv9olfSVg7DSAzKHDhGVzwQtll1CdcH8K0TTc0GBDDGeJ
 vSsNMP2nKD5hzVvQP1WS+vvTKmSAsgI4x70MwLw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> @@ -48,6 +49,7 @@ annotate=3D
>  squash=3D
>  message=3D
>  prefix=3D
> +clearcache=3D

It might be more consistent to call it `clear_cache` (i.e. with an
underscore), just like `ignore_joins`.

>
>  debug () {
>  	if test -n "$debug"
> @@ -131,6 +133,9 @@ do
>  	--no-rejoin)
>  		rejoin=3D
>  		;;
> +	--clear-cache)
> +		clearcache=3D1
> +		;;
>  	--ignore-joins)
>  		ignore_joins=3D1
>  		;;
> @@ -206,9 +211,13 @@ debug "opts: {$*}"
>  debug
>
>  cache_setup () {
> -	cachedir=3D"$GIT_DIR/subtree-cache/$$"
> -	rm -rf "$cachedir" ||
> -		die "Can't delete old cachedir: $cachedir"
> +	cachedir=3D"$GIT_DIR/subtree-cache/$prefix"

Excellent, the `prefix` should be "unique enough".

> +	if test -n "$clearcache"
> +	then
> +		debug "Clearing cache"
> +		rm -rf "$cachedir" ||
> +			die "Can't delete old cachedir: $cachedir"
> +	fi
>  	mkdir -p "$cachedir" ||
>  		die "Can't create new cachedir: $cachedir"
>  	mkdir -p "$cachedir/notree" ||
> @@ -266,6 +275,16 @@ cache_set () {
>  	echo "$newrev" >"$cachedir/$oldrev"
>  }
>
> +cache_set_if_unset () {
> +	oldrev=3D"$1"
> +	newrev=3D"$2"

`local`? ;-)

> +	if test -e "$cachedir/$oldrev"
> +	then
> +		return
> +	fi
> +	echo "$newrev" >"$cachedir/$oldrev"

So that directory contains commit mappings, a file for each mapped
revision.

Thinking back to patch 2/11, I am now no longer that sure that it makes
sense to fill it up with every commit in that commit range: performance
suffers when directories contain too many files.

For example, I had a case in the past where it took a minute just to
enumerate a directory, and even looking whether a file existed in that
directory was not exactly fun.

In any case, I would write it slightly shorter:

	test -e "$cachedir/$oldrev" ||
	echo "$newrev" >"$cachedir/$oldrev"

> +}
> +
>  rev_exists () {
>  	if git rev-parse "$1" >/dev/null 2>&1
>  	then
> @@ -375,13 +394,13 @@ find_existing_splits () {
>  			then
>  				# squash commits refer to a subtree
>  				debug "  Squash: $sq from $sub"
> -				cache_set "$sq" "$sub"
> +				cache_set_if_unset "$sq" "$sub"
>  			fi
>  			if test -n "$main" -a -n "$sub"
>  			then
>  				debug "  Prior: $main -> $sub"
> -				cache_set $main $sub
> -				cache_set $sub $sub
> +				cache_set_if_unset $main $sub
> +				cache_set_if_unset $sub $sub
>  				try_remove_previous "$main"
>  				try_remove_previous "$sub"
>  			fi
> @@ -688,6 +707,8 @@ process_split_commit () {
>  		if test -n "$newparents"
>  		then
>  			cache_set "$rev" "$rev"
> +		else
> +			cache_set "$rev" ""

Was this hunk intended to be snuck in here? I can understand the
s/cache_set/cache_set_if_unset/ changes, of course, but not this hunk.

>  		fi
>  		return
>  	fi
> @@ -785,7 +806,7 @@ cmd_split () {
>  			# the 'onto' history is already just the subdir, so
>  			# any parent we find there can be used verbatim
>  			debug "  cache: $rev"
> -			cache_set "$rev" "$rev"
> +			cache_set_if_unset "$rev" "$rev"
>  		done
>  	fi
>
> @@ -798,7 +819,7 @@ cmd_split () {
>  		git rev-list --topo-order --skip=3D1 $mainline |
>  		while read rev
>  		do
> -			cache_set "$rev" ""
> +			cache_set_if_unset "$rev" ""

Okay. A quite interesting question now would be: are there any callers of
`cache_set` left? If so, why?

Thanks,
Dscho

>  		done || exit $?
>  	fi
>
> --
> gitgitgadget
>
>
