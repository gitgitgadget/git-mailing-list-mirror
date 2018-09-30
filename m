Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6851F453
	for <e@80x24.org>; Sun, 30 Sep 2018 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeI3TEM (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 15:04:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeI3TEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 15:04:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id n23-v6so6044957wmc.1
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DW1h5m4QOH/qv6J0TrUI02snYW/ygPKFvN8mlexw2/w=;
        b=Q1EJ/2wx7ES1XcsckKLc4YQSusrNmAofoNN4OAwK08ei6+ZPr9ff7dxUYkb6eZ09Qi
         bDNmsyktXJl0Q1QmCgXkb6RkUMM72DIhiHq5LVXUDZIBaoPABMLSdLqlWZnv0m+1ThQ5
         86iiqOYbiTGNpmy2g/N6AT++2aNW4uzVGXtesl7TGUPAO5Bwj5tUUOCPXee1eCSu9syo
         pmNNfA6nfgi+IpDUU1NeFS0oCHF3QQcddeRcih/2HLG1pPHbA6uPWUvCRD1JyM/5J/PM
         SjquL2DYadQy4a08KCkDSmgdyWbKovGgXQmY5eqoKvmzHebavn/GIWOlJt+JxHBwO5vA
         0hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DW1h5m4QOH/qv6J0TrUI02snYW/ygPKFvN8mlexw2/w=;
        b=J3QTm3IrAdQlecdXJeY+HbOWKSw+9wwMBXoFzlAxA06RzCgwg7/d2H8E9GD8i0xDOw
         /7bLZ3Gp/YJ8J91Cmi7GAYvIYTzoBHiTj5rdMUoGThNTWJO1n8Mn0bXKkAGMKiONk9x3
         F00DIzjh1f7GADtsELIodp3u5QLlD2R+9byTIK1+i/+v/ENQK8sePrUqtVs3gvOzWoaW
         88nH9T3vOTL8x4+kdNxJxnBNgdHxjiK/0pzk4JLrja/+8tPNCsIe5DzR+bsG4DCu1/Vk
         FAMyRKSFr9lnY1Ti1kdXhYNFgJwtGE9FKAi45G1Or+V2mwI7oWBv5PiPAea/xVck0cWv
         p+fw==
X-Gm-Message-State: ABuFfohhGrERynJZVrbzxq3nH+6hR48lnv0EkQKhDBkObkO1u/Ww0rsp
        MZqkSEpSsOv7atv03qVhTPk=
X-Google-Smtp-Source: ACcGV62WFSuohPyTL/RdvVzEXnUDM2MZOClzcwVQkdD+8z5/oQ+V/OqlXB3/SvtR9UCGIQAr72Nxnw==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr6729758wmh.108.1538310679556;
        Sun, 30 Sep 2018 05:31:19 -0700 (PDT)
Received: from localhost (x4dbe4c7d.dyn.telefonica.de. [77.190.76.125])
        by smtp.gmail.com with ESMTPSA id 62-v6sm14879159wra.48.2018.09.30.05.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 05:31:18 -0700 (PDT)
Date:   Sun, 30 Sep 2018 14:31:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] t1300: extract and use test_cmp_config()
Message-ID: <20180930123116.GI23446@localhost>
References: <20180923170438.23610-1-pclouds@gmail.com>
 <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929153005.10599-2-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 05:30:04PM +0200, Nguyễn Thái Ngọc Duy wrote:
> In many config-related tests it's common to check if a config variable
> has expected value and we want to print the differences when the test
> fails. Doing it the normal way is three lines of shell code. Let's add
> a function do to all this (and a little more).
> 
> This function has uses outside t1300 as well but I'm not going to
> convert them all. And it will be used in the next commit where
> per-worktree config feature is introduced.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t1300-config.sh       | 79 ++++++++++-------------------------------
>  t/test-lib-functions.sh | 24 +++++++++++++
>  2 files changed, 43 insertions(+), 60 deletions(-)
> 
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index cdf1fed5d1..00c2b0f0eb 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -76,15 +76,11 @@ EOF

>  test_expect_success 'unset type specifiers may be reset to conflicting ones' '
> -	echo 1048576 >expect &&
> -	git config --type=bool --no-type --type=int core.big >actual &&
> -	test_cmp expect actual
> +	test_cmp_config 1048576 --type=bool --no-type --type=int core.big
>  '
>  
>  test_expect_success '--type rejects unknown specifiers' '
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index d82fac9d79..4cd7fb8fdf 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -747,6 +747,30 @@ test_cmp() {
>  	$GIT_TEST_CMP "$@"
>  }
>  
> +# similar to test_cmp but $2 is a config key instead of actual value

This doesn't describe very well the function's parameters: $1
specifies the expected value (as opposed to the file containing the
expected value), and the rest can be all kinds of 'git config'
options, not just a second argument with the config key; e.g. see call
in the above hunk.

Perheps only a brief description and a usage string like this would
sufficiently cover everything?

  # Check that the given config key has the expected value.
  #
  #   test_cmp_config [-C <dir>] <expected-value>
  #                   [<git-config-options>...] <config-key>

> +# it can also accept -C to read from a different repo, e.g.
> +#
> +#     test_cmp_config -C xyz foo core.bar
> +#
> +# is sort of equivalent of

I think this comment should outright say that "is a better alternative
to", because it provides useful output on failure, and because it
doesn't hide 'git config's exit code.

Note that this second point does make a bit of a difference:

  test_cmp_config "" nonexisting.variable

would fail, because

  $ git config nonexisting.variable ; echo $?
  1

and the &&-chain.  However,

  test "" = "$(git config nonexisting.variable)"

would still succeed, because the non-zero exit code is ignored.

I consider this a benefit, as it will protect us from a typo in the
name of a set but empty variable, even though we won't get any error
message.

> +#
> +#     test "foo" = "$(git -C xyz core.bar)"
> +

Nit: unnecessary empty line.

> +test_cmp_config() {
> +	if [ "$1" = "-C" ]
> +	then
> +		shift &&
> +		GD="-C $1" &&
> +		shift
> +	else
> +		GD=
> +	fi &&

I think you could now safely declare GD as local.  The test balloon
01d3a526ad (t0000: check whether the shell supports the "local"
keyword, 2017-10-26) has been out there for 4 releases / almost a
year, and we haven't heard about any issues, and the upcoming hash
translation test helpers use 'local' as well.

> +	echo "$1" >expected &&
> +	shift &&
> +	git $GD config "$@" >actual &&
> +	test_cmp expected actual
> +}
> +
>  # test_cmp_bin - helper to compare binary files
>  
>  test_cmp_bin() {
> -- 
> 2.19.0.341.g3acb95d729
>
