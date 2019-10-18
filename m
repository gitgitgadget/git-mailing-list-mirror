Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E1B1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfJRWpI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:45:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44417 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJRWpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:45:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so7771231wrl.11
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fZB0t9mWV/7l/VZz4+lYZPf33yS1rNyXY9Add0uut+o=;
        b=PXGRT0ojpT4lm8E4AoL8UsEuviSx2cf818xfTdius0cAFsH5ZfANKi/lMJDcuUPWon
         wlRy/tFLKKFYB4ovtQ0yiww4CxzHZcwRKbnGieMjHyAatH8QiviS4zo5UYLdpDc50J1C
         MkGYWyzbnslE2g5IZFP69Q6RBgLGMeN6COL82jyqdY6CFwz4NQdE300rE7zh/KKyF+ya
         lF5uySJEbMLLXgbwFZt5lRpS9xnOBo59omFOYSFrU8jZNWYM0DNNXx/iko7neDQH3JAg
         AXAQvNG5IMfdKo/g33/ritJK97jNWckoUYixcrFWc7Mp9RzJVInVcjSUBAGa8LfmAbMG
         /N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZB0t9mWV/7l/VZz4+lYZPf33yS1rNyXY9Add0uut+o=;
        b=TNx3iE64RzWAHfkINz71OdnsAJEQ94DzUe9pIeE05WxPjQO8LrnanyjM1ccIpCxSii
         twIfs7DJpgGBX3BLubzC3tbjyUjBWeaIGxGwDaquAr7vzBZgFOIshYTgjNJbc0PvBLd2
         PzsaJPEWCq1InT8WjpgqYnG2URfr61X+HIpai1Rf9bHhGNha7kl6aNpWALuGM1CwxjQX
         7gsvnng0XgncLFydm9azrykAJeEl3xG1Z2yeu3YC3YkqIao6iP8r63MIX+KBOOENAAk2
         MIdh/Cw4eSS59GIpXQIy21C0B4PuzUWU6Ma15/EHlIUX2VJr8Vz3kOkdihCwmaPas8OW
         3eTQ==
X-Gm-Message-State: APjAAAVtpo5t5vqaIZ5E3UppmB9ERsBUOQqHMx8KUYE2+7DvHHSKNs3V
        hudgyUwOmPTFipklaGxBWNs=
X-Google-Smtp-Source: APXvYqySMUlMqjBfbqX2FLLH142iM+qLHf+EMZDPIVHJB5QwV7vHdhKtHj86+SjW7yAOxJKOTeQ7uQ==
X-Received: by 2002:adf:ff8b:: with SMTP id j11mr8691536wrr.299.1571438705684;
        Fri, 18 Oct 2019 15:45:05 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id v6sm9110494wma.24.2019.10.18.15.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 15:45:05 -0700 (PDT)
Date:   Sat, 19 Oct 2019 00:45:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/15] t: teach test_cmp_rev to accept ! for not-equals
Message-ID: <20191018224502.GL29845@szeder.dev>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
 <417e808466ee3e61a1719faa319fe0e796d5d271.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <417e808466ee3e61a1719faa319fe0e796d5d271.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 03:10:21PM -0700, Denton Liu wrote:
> Currently, in the case where we are using test_cmp_rev() to report
> not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
> contains
> 
> 	r1=$(git rev-parse --verify "$1") &&
> 	r2=$(git rev-parse --verify "$2") &&
> 
> In the case where `git rev-parse` segfaults and dies unexpectedly, the
> failure will be ignored.
> 
> Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
> do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
> in all tests to take advantage of this new functionality.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>


> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b299ecc326..76dce5f8ee 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1012,8 +1012,17 @@ test_must_be_empty () {
>  	fi
>  }
>  
> -# Tests that its two parameters refer to the same revision
> +# Tests that its two parameters refer to the same revision, or if '!' is
> +# provided first, that its other two parameters refer to different
> +# revisions.
>  test_cmp_rev () {
> +	local inverted_op
> +	inverted_op='!='
> +	if test $# -ge 1 && test "x$1" = 'x!'
> +	then
> +	    inverted_op='='
> +	    shift
> +	fi
>  	if test $# != 2
>  	then
>  		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
> @@ -1021,7 +1030,7 @@ test_cmp_rev () {
>  		local r1 r2
>  		r1=$(git rev-parse --verify "$1") &&
>  		r2=$(git rev-parse --verify "$2") &&
> -		if test "$r1" != "$r2"
> +		if test "$r1" "$inverted_op" "$r2"
>  		then
>  			cat >&4 <<-EOF
>  			error: two revisions point to different objects:

A semi-rhetorical question: how will the output of 'test_cmp_rev ! HEAD
HEAD' look like? :)

