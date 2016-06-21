Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DA21FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbcFUSEa (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:04:30 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35257 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbcFUSEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 14:04:12 -0400
Received: by mail-lb0-f195.google.com with SMTP id td3so2691355lbb.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 11:03:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2qwxCc/EAXd/XC3kwwtyRiaZfXC6Sthzx0RKVSR5jiI=;
        b=kcB/GhFMB5dRBca6MWKYDTMFow0k9ffrs6wEXy0TCpv0G9Ah5Gd9kisn4X3jJS3SVJ
         /edqcrcztk2Ye8CqehKqfyUObbDNTh8taYedasDy52ivrIVe/s+Cl4bz+RUdYztLaQUS
         h8rGDToxpD0IPIJZYFcXEWgYiKRVFaRhoJNHa+64vMwBZV2kbxViSiwOnoUrLwNcSznN
         wyiueS4/+WP7V94wSuX1uvPtmZf/LLmwakkCm9beV8X7Py39JoVesvrrBuIAeiTDRX6+
         8FRB3YT/GiCe4iWLIAvAzZSx/SyYuXLdMInJ/CT95nwmcJASRTA8S6h0zYUt2WbX9BCA
         QmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2qwxCc/EAXd/XC3kwwtyRiaZfXC6Sthzx0RKVSR5jiI=;
        b=f653cVem9gniD/5oUWuLWx/w2HjcL++6xChniQVoqh9eI56qEM3cFzu6Ll9F5d+hKP
         JlNMTE/Oyhtqnf50zNiM7h4J2Nrd07h7hEz3ksShq7RpI/FsqbECzzhbYyeKozERLu3L
         xTE1y7el8R/vCrvTjymy7MNZHPTavtufvOV3Qd7mLBiE2scQg874hv8DHK6vSVRGl837
         tbO2LeLQwLFsQGQIomDP1uiQKUX/xxmlurHpQrbUuHU195pOpGbzN1mId2jZmdEb/OTn
         bWQk0rLWtyc0yAjWSHCztgTbcef2ta8wrw9XgKz3aXHdVPehYtxHIjaHwexEAF2B0Q7k
         ZZ9w==
X-Gm-Message-State: ALyK8tJKxQ8ukTGl68g6Eu62JuGtp5op/v3O5Jw1QktsMs4asXpm7XIsglc2UrTn41Tzjg==
X-Received: by 10.194.85.161 with SMTP id i1mr22098631wjz.95.1466532192496;
        Tue, 21 Jun 2016 11:03:12 -0700 (PDT)
Received: from par3bztk12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 12sm4036484wmj.19.2016.06.21.11.03.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 11:03:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] perf: accommodate for MacOSX
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <fa788ff09727fc37d8e799dbf1a92e4bba4152c9.1466517188.git.johannes.schindelin@gmx.de>
Date:	Tue, 21 Jun 2016 20:03:10 +0200
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DA5551A9-E3F0-4A59-9B91-206AA74FEAD4@gmail.com>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <fa788ff09727fc37d8e799dbf1a92e4bba4152c9.1466517188.git.johannes.schindelin@gmx.de>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 21 Jun 2016, at 15:53, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> As this developer has no access to MacOSX developer setups anymore,
> Travis becomes the best bet to run performance tests on that OS.
> 
> However, on MacOSX /usr/bin/time is that good old BSD executable that
> no Linux user cares about, as demonstrated by the perf-lib.sh's use
> of GNU-ish extensions. And by the hard-coded path.
> 
> Let's just work around this issue by using gtime on MacOSX, the
> Homebrew-provided GNU implementation onto which pretty much every
> MacOSX power user falls back anyway.
> 
> To help other developers use Travis to run performance tests on
> MacOSX, the .travis.yml file now sports a commented-out line that
> installs GNU time via Homebrew.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/perf-macosx-v2
> .travis.yml        | 2 ++
> t/perf/perf-lib.sh | 6 +++++-
> 2 files changed, 7 insertions(+), 1 deletion(-)
> Interdiff vs v1:
> 
> diff --git a/.travis.yml b/.travis.yml
> index 0e569bc..c2b76f9 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -82,7 +82,9 @@ before_install:
>        brew tap homebrew/binary --quiet
>        brew_force_set_latest_binary_hash perforce
>        brew_force_set_latest_binary_hash perforce-server
> -      brew install git-lfs perforce-server perforce gettext gnu-time
> +      # Uncomment this if you want to run perf tests:
> +      # brew install gnu-time
> +      brew install git-lfs perforce-server perforce gettext
>        brew link --force gettext
>        ;;
>      esac;
> 
> 
> diff --git a/.travis.yml b/.travis.yml
> index c20ec54..c2b76f9 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -82,6 +82,8 @@ before_install:
>       brew tap homebrew/binary --quiet
>       brew_force_set_latest_binary_hash perforce
>       brew_force_set_latest_binary_hash perforce-server
> +      # Uncomment this if you want to run perf tests:
> +      # brew install gnu-time
>       brew install git-lfs perforce-server perforce gettext
>       brew link --force gettext
>       ;;
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 18c363e..773f955 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -127,11 +127,15 @@ test_checkout_worktree () {
> # Performance tests should never fail.  If they do, stop immediately
> immediate=t
> 
> +# Perf tests require GNU time
> +case "$(uname -s)" in Darwin) GTIME="${GTIME:-gtime}";; esac
> +GTIME="${GTIME:-/usr/bin/time}"
> +
> test_run_perf_ () {
> 	test_cleanup=:
> 	test_export_="test_cleanup"
> 	export test_cleanup test_export_
> -	/usr/bin/time -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> +	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> . '"$TEST_DIRECTORY"/test-lib-functions.sh'
> test_export () {
> 	[ $# != 0 ] || return 0
> -- 
> 2.9.0.118.g0e1a633
> 
> base-commit: ab7797dbe95fff38d9265869ea367020046db118

Looks good to me.

- Lars

