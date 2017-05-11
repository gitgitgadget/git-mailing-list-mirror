Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205D8201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbdEKUVm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:21:42 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34848 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756205AbdEKUVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:21:39 -0400
Received: by mail-pg0-f42.google.com with SMTP id q125so332164pgq.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DQON0OOeSmyV3Pust5fG8i3IRnOEr9X4jCyj83bVjnI=;
        b=aBs91q7xJxISYrtX6BLpofod0KRQizVqRN83sNKBNSZi0OiieVqUXp4a9llJQFZ0uX
         s/HcGFO2Iq5E+ael4gu6lXwPQoAtbWpWlM4338jgBPMJSj/d/uENRWobRPyL2O4w2tEP
         7NEzPkDy3aWEVzeLOeKZF222Y7rceyN1SJ0+MrbGtU50at7xHTSqwxYPgvwFgqbMOHbT
         XF1mzQHAzx99/U+VnLBZSlpnDqr0rKWIhwVZB95rT8ivZ8l8QDXtrlwim93UenvIVlPD
         cjvPeu+u2/+XrIFcHWa+UGBRe6gHp66IYmBkk3RNWmLQVgvNWyy/r4AvrYwCjaO6XS+T
         d2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DQON0OOeSmyV3Pust5fG8i3IRnOEr9X4jCyj83bVjnI=;
        b=PjuKPG2FL/E6KckD6fjrUUl1lguqlh0IrJ5DRkOv2xN3A8o/muWYweMaT2uRjAr1u8
         K5FziOTBKHK0kW3ynL+9fiV5M8Uy7TEkh04SR3KoNW1s7Ulc/5SFcggxgjwa3DgmIfTL
         OEa3NduXDjfO4Crc01lTULA5t15zAMwja05ZidSZ++qL3w2Kw28e0OpAZcmvBt3Gvn6z
         dGPWmQBqRMj/GBB7o4EZEFiCnfslEUUUH05J+EFcp0mwR4rDJC1F7n2dtS2pFUCtf0B0
         ppkw83dmam5IwKDnaDb9UTwHKyw7Rc05EIAuKfwwFF6e9ja6aAajkEa8Wqj10mMnPIrv
         xzjQ==
X-Gm-Message-State: AODbwcDuYrAWr5Y/LUyPzUFwrCrNfcbvuI5cOGzOPUluno3SuTEEdaok
        4XA8rjh5kZhKwb0d
X-Received: by 10.84.216.10 with SMTP id m10mr477979pli.4.1494534093615;
        Thu, 11 May 2017 13:21:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id n65sm2148010pga.8.2017.05.11.13.21.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:21:32 -0700 (PDT)
Date:   Thu, 11 May 2017 13:21:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 28/29] grep: given --threads with NO_PTHREADS=YesPlease,
 warn
Message-ID: <20170511202131.GK83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-29-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-29-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Add a warning about missing thread support when grep.threads or
> --threads is set to a non 0 (default) or 1 (no parallelism) value
> under NO_PTHREADS=YesPlease.
> 
> This is for consistency with the index-pack & pack-objects commands,
> which also take a --threads option & are configurable via
> pack.threads, and have long warned about the same under
> NO_PTHREADS=YesPlease.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c  | 11 +++++++++++
>  t/t7810-grep.sh | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 1c0adb30f3..f4e08dd2b6 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -289,6 +289,15 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
>  		if (num_threads < 0)
>  			die(_("invalid number of threads specified (%d) for %s"),
>  			    num_threads, var);
> +#ifdef NO_PTHREADS
> +		else if (num_threads && num_threads != 1) {
> +			/* TRANSLATORS: %s is the configuration
> +			   variable for tweaking threads, currently
> +			   grep.threads */

nit: this comment isn't formatted properly:
  /*
   * ... comment ...
   */

> +			warning(_("no threads support, ignoring %s"), var);
> +			num_threads = 0;
> +		}
> +#endif
>  	}
>  
>  	return st;
> @@ -1233,6 +1242,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	else if (num_threads < 0)
>  		die(_("invalid number of threads specified (%d)"), num_threads);
>  #else
> +	if (num_threads)
> +		warning(_("no threads support, ignoring --threads"));
>  	num_threads = 0;
>  #endif
>  
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 561709ef6a..f106387820 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -791,6 +791,24 @@ do
>  	"
>  done
>  
> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=N or pack.threads=N warns when no pthreads' '
> +	git grep --threads=2 Hello hello_world 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 1 warnings &&
> +	grep -F "no threads support, ignoring --threads" err &&
> +	git -c grep.threads=2 grep Hello hello_world 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 1 warnings &&
> +	grep -F "no threads support, ignoring grep.threads" err &&
> +	git -c grep.threads=2 grep --threads=4 Hello hello_world 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 2 warnings &&
> +	grep -F "no threads support, ignoring --threads" err &&
> +	grep -F "no threads support, ignoring grep.threads" err &&
> +	git -c grep.threads=0 grep --threads=0 Hello hello_world 2>err &&
> +	test_line_count = 0 err
> +'
> +

Same bit about doing the correct checks on the error strings to account
for translation.

>  test_expect_success 'grep from a subdirectory to search wider area (1)' '
>  	mkdir -p s &&
>  	(
> -- 
> 2.11.0
> 

-- 
Brandon Williams
