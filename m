Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62656C38A2F
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306D82054F
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JW39Y/9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDRNNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:13:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:50033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgDRNNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Apr 2020 09:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587215592;
        bh=TNGe9x31NOpTvzEfPHchQrP4elt5jxmKdriFZQn12EY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JW39Y/9da+YOxX0GedSPEJQXOvPmyPejELZfYD0TrJYwdz+OEzfX2SOhNhwNORh0h
         fCtI06T0KGweXsItTNTjEeEgL/CzUAOj8d9FgmLs6CZG4Drti30aEJTONWy8oRr2/c
         U4PlSwEx+0nQPu2FZ1ZOY2HDcdSjWsw+ZUzMhItA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.169]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgvrL-1ilCjt2Fcz-00hQ64; Sat, 18 Apr 2020 15:13:12 +0200
Date:   Sat, 18 Apr 2020 15:13:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     gitster@pobox.com, asheiduk@gmail.com, git@vger.kernel.org,
        greg@hurrell.net, l.s.r@web.de
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual
 chars
In-Reply-To: <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.2004181509350.46@tvgsbejvaqbjf.bet>
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com> <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OyVUdVfI18aHE7c/kWaCvwh2mrVhUHuQVpR6IaT9OGhp192vzzh
 a3pgJoZUnaeZyEm5ZRTTKJLCtRVVUpAiqtvN+wpPgPDcPHn6pph0/CV7JJJU4pf3RjVHZxk
 nOKpkngT75nnRuz6yTI45eoqrSUVcjv2T5ky0P3B7Hw8FpMQB2GuLD61SsGez5gWBJJkW9+
 pFGA6m54ISf//b/PIyBdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mOm9y7qQkho=:KY3qLu5Pmrw7RS42jzo0kq
 d3/Y6erK+Av9GXe2Jg/ObskKQTeBEMKIcB4mjRuxIekiKe2dfS7jxffT2ir30qyV0NR2Hgnmi
 HWpuUma93cHwi7Eih0QNeYM5059ATKnjCPYJfUzp2xfh4BGPe+I2hNWX9T8BVWCKkF3UmRFND
 9XQaaFpdGvRCmaO2UVfX/zDYWUbAmeH43OKtxRIqyKEhdX8YHw559tk4fSRh02ofzIH/CSCtz
 ISqHv4Hb9glIKbCJtiSQqWdDl/f7+xCXPrmW1YjUvpvRJ/PW1ge/ec4g7pvIUySNjzLEkhBf/
 znnfU5ubCS64G6aY/fQchFeiG6723A1zIY0aP25d7ILiMnbeJ5CJyKi8LlZ+tB/W7QbLc5R/z
 rfxgqHIx2pgE6KfXCRDldCkUphzbo/7f+vFPdjTXoEq4d8ZGLIY0ezSgF0b1iauFIcD5LVqst
 PTxntgvTDfX9aK4nawaClRlWUfYiPTgSFG9aI6BCwB01XKn+l1mN4iXWVfsNgOHMUEg72E3wG
 KcLLrE8dxNzGSUUdSIWmOzFbh4fsmByjk+D8j9kmh2X4Jc6JDJvShm/l5IJMd08hzxgWV2Kbg
 +5W58PCh7AvoBsRrYPBPStDxQZAWBKm1XvoDZjYsZmLA7iiVYO0gEtikcoflfd/NbgTj8fAhi
 VVOj+LvMpFzcdnoHNP08kBVpaST55TnWd12ZOx6r31e40j5hOAGsQG6TMDdF/C/ueo+PbJa5r
 DZmdXYtAVcitg9dfyfvp0nwCOzca2Y8W3TPufhn7i3vxrV70w1lYxvnbU4VCgjlB8zw4okFlv
 Q11W3Qp47A1/sE9cGC1s6Px3T77Uf1yMON/GIbcZw7XESUbJ7Ru5Fi6p8Xv2Aj5ymcIYIJWH7
 3LdCJav58SRJcP0sl5514lM6OJcu7V259lswD2xVz3uhFCGkibz0wsnxhiZfGVWfjjTn3hR+9
 zGsKY57taYobKT5YgP/omjHLM/Ri47PDsjnWHXmzo63biy385zN0K7eUtVbi6gMJ3k/ZAibTl
 VC5K1W+aamHa8aQ6EDAwB9Q9NbY3CgpW0446ANFFvFlRC8xWBtQ6fZFSoGdpc3J3shTTi7e7g
 03E7BYRSJiiWYV7K5vrJo9v2rvAOQYINvDJRp5qxeRNg3n586JI+lRdYcMKJQpRSiKIeKEe85
 omH6Cq7IqvBcbcDX8eDYmq+4rxyHSuXmgy+lEVm/T5MDaKa2eby4sXUcC903bpwA5xNGWhXjL
 FRE7eSJKe/H+VTyfW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Fri, 17 Apr 2020, Matheus Tavares wrote:

> grep does not follow the conventions used by other Git commands when
> printing paths that contain unusual characters (as double-quotes or
> newlines). Commands such as ls-files, commit, status and diff will:
>
> - Quote and escape unusual pathnames, by default.
> - Print names verbatim and unquoted when "-z" is used.
>
> But grep *never* quotes/escapes absolute paths with unusual chars and
> *always* quotes/escapes relative ones, even with "-z". Besides being
> inconsistent in its own output, the deviation from other Git commands
> can be confusing. So let's make it follow the two rules above and add
> some tests for this new behavior. Note that, making grep quote/escape
> all unusual paths by default, also make it fully compliant with the
> core.quotePath configuration, which is currently ignored for absolute
> paths.
>
> Reported-by: Greg Hurrell <greg@hurrell.net>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/git-grep.txt |  6 +++--
>  builtin/grep.c             | 46 ++++++++++++++++++++++++++++----------
>  t/t7810-grep.sh            | 44 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 14 deletions(-)

Unfortunately, this causes eight test failures on Windows:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D38023&view=
=3Dms.vss-test-web.build-test-results-tab

Could you please have a look? I suspect that this has something to do with
those new tests needing the `FUNNYNAMES` prereq.

Ciao,
Dscho

>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index ddb6acc025..3109ce8fbe 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -206,8 +206,10 @@ providing this option will cause it to die.
>
>  -z::
>  --null::
> -	Output \0 instead of the character that normally follows a
> -	file name.
> +	Use \0 as the delimiter for pathnames in the output, and print
> +	them verbatim. Without this option, pathnames with "unusual"
> +	characters are quoted as explained for the configuration
> +	variable core.quotePath (see git-config(1)).
>
>  -o::
>  --only-matching::
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 99e2685090..bdf1a4bbc9 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -295,6 +295,38 @@ static int grep_cmd_config(const char *var, const c=
har *value, void *cb)
>  	return st;
>  }
>
> +static void grep_source_name(struct grep_opt *opt, const char *filename=
,
> +			     int tree_name_len, struct strbuf *out)
> +{
> +	strbuf_reset(out);
> +
> +	if (opt->null_following_name) {
> +		if (opt->relative && opt->prefix_length) {
> +			struct strbuf rel_buf =3D STRBUF_INIT;
> +			const char *rel_name =3D
> +				relative_path(filename + tree_name_len,
> +					      opt->prefix, &rel_buf);
> +
> +			if (tree_name_len)
> +				strbuf_add(out, filename, tree_name_len);
> +
> +			strbuf_addstr(out, rel_name);
> +			strbuf_release(&rel_buf);
> +		} else {
> +			strbuf_addstr(out, filename);
> +		}
> +		return;
> +	}
> +
> +	if (opt->relative && opt->prefix_length)
> +		quote_path_relative(filename + tree_name_len, opt->prefix, out);
> +	else
> +		quote_c_style(filename + tree_name_len, out, NULL, 0);
> +
> +	if (tree_name_len)
> +		strbuf_insert(out, 0, filename, tree_name_len);
> +}
> +
>  static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
>  		     const char *filename, int tree_name_len,
>  		     const char *path)
> @@ -302,13 +334,7 @@ static int grep_oid(struct grep_opt *opt, const str=
uct object_id *oid,
>  	struct strbuf pathbuf =3D STRBUF_INIT;
>  	struct grep_source gs;
>
> -	if (opt->relative && opt->prefix_length) {
> -		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
> -		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
> -	} else {
> -		strbuf_addstr(&pathbuf, filename);
> -	}
> -
> +	grep_source_name(opt, filename, tree_name_len, &pathbuf);
>  	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
>  	strbuf_release(&pathbuf);
>
> @@ -334,11 +360,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct grep_source gs;
>
> -	if (opt->relative && opt->prefix_length)
> -		quote_path_relative(filename, opt->prefix, &buf);
> -	else
> -		strbuf_addstr(&buf, filename);
> -
> +	grep_source_name(opt, filename, 0, &buf);
>  	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
>  	strbuf_release(&buf);
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 7d7b396c23..ab495dba28 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -72,6 +72,8 @@ test_expect_success setup '
>  	# Still a no-op.
>  	function dummy() {}
>  	EOF
> +	echo unusual >"\"unusual\" pathname" &&
> +	echo unusual >"t/nested \"unusual\" pathname" &&
>  	git add . &&
>  	test_tick &&
>  	git commit -m initial
> @@ -481,6 +483,48 @@ do
>  		git grep --count -h -e b $H -- ab >actual &&
>  		test_cmp expected actual
>  	'
> +
> +	test_expect_success "grep $L should quote unusual pathnames" '
> +		cat >expected <<-EOF &&
> +		${HC}"\"unusual\" pathname":unusual
> +		${HC}"t/nested \"unusual\" pathname":unusual
> +		EOF
> +		git grep unusual $H >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep $L in subdir should quote unusual relative p=
athnames" '
> +		cat >expected <<-EOF &&
> +		${HC}"nested \"unusual\" pathname":unusual
> +		EOF
> +		(
> +			cd t &&
> +			git grep unusual $H
> +		) >actual &&
> +		test_cmp expected actual
> +	'
> +
> +	test_expect_success "grep -z $L with unusual pathnames" '
> +		cat >expected <<-EOF &&
> +		${HC}"unusual" pathname:unusual
> +		${HC}t/nested "unusual" pathname:unusual
> +		EOF
> +		git grep -z unusual $H >actual &&
> +		tr "\0" ":" <actual >actual-replace-null &&
> +		test_cmp expected actual-replace-null
> +	'
> +
> +	test_expect_success "grep -z $L in subdir with unusual relative pathna=
mes" '
> +		cat >expected <<-EOF &&
> +		${HC}nested "unusual" pathname:unusual
> +		EOF
> +		(
> +			cd t &&
> +			git grep -z unusual $H
> +		) >actual &&
> +		tr "\0" ":" <actual >actual-replace-null &&
> +		test_cmp expected actual-replace-null
> +	'
>  done
>
>  cat >expected <<EOF
> --
> 2.26.0
>
>
>
