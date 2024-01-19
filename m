Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF1AD54
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647900; cv=none; b=g5ogmJQFm6Dhvp3rDUwqlC+Iwb1RMislFvdcUyB5Tj3bohyPzt5oycIZ5POlmR68ICQ7twt1Tt9hbzYvGPiJ2eNm8RWY9eI12QyQEo18xeEafEe7oaz7WeHII7rgRjTyyq2jy+1mduoofQxqw66IXB2+Lvfqi178JpDRnDTOCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647900; c=relaxed/simple;
	bh=EV0wBl5g9OZzWDD9mfDj91cxz2zxP7zIHx4bIVDPWzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b24BXCE2LxkiRpz/AWyM7VS6D3HWi7QZbKTitgA8P7E2qnrtvIEVeomSY3K6RI4FTqwTEe0VUm7L/+rnHIhT+KcMVBjFfw3kniFE7p4vHZUne8CLlU1vC0azqCU71cEtWaKGaaq1MrRWOQ9Jkt6iW2FFlEqdbyvjkqmznPGwFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPLvv/B1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tJch/OZ9; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPLvv/B1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJch/OZ9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 00D423200A5B;
	Fri, 19 Jan 2024 02:04:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Jan 2024 02:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647897; x=1705734297; bh=AUknOe51dR
	gBLEjv0nEWB2Qij3meFlu4l9fDcwDz6ag=; b=HPLvv/B1gnXtV9JVBGUpeDYr/i
	6S57ZOPMpSd7UNWK8RlMxsrNsfFpJgVIa+/oVDoqSg5jNsZZ10XOpEr2wrGfIfVT
	w94NBEcwbtbda36Mq9U0KKs6XJFiNZ3t+d3gx31WFJdatbftnEHxn8M1bhq+4wXw
	I9fhmhqoQKC7nXNhdtIFZpDWq/tn0N/QaLlKqS/LxQVwl2Mf3hzxq8HR2wL2dqhY
	h1HqkPuA+8RzcIpfZIR7kI7hasekUxi6NeQDmO92FLyeQZ8Yh6SuVL0coJzBJ7UY
	33ubVngDwBcvq6FlzzPMskaGnOwpwMIorBmzG70H0KdOiNVDvlWW4AQLi/5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647897; x=1705734297; bh=AUknOe51dRgBLEjv0nEWB2Qij3me
	Flu4l9fDcwDz6ag=; b=tJch/OZ9F+LFEuKiykl1pAv94+0hDITi/CMSBdLWKLs0
	ygqgMnTsXw4Ks8+GQx1Q9HKr1be3q6DwH8snA+DcYBo5tPVom0saL2OVGs3eQsv7
	2I+aG9BVUIUXg30MJmjNxKlWGrzx1HygfGJekNICsTYHM/nuoWfja8cXzv5PfMeH
	d9iDMaurxuPZHvjpMtXhcu2ZAWKOAVNb3LX0dZe2U2OV3Eyppdn4fRK2riTGaEDC
	5c6e3U6Zq5STukds4Gy6nmAbQ4YoGLJN/efEdXXB5ynIXM0A/MyCh7fQBWrKFW7a
	3oHmgItIZdvUkA/IoviW+Euo2/BU0d6OQ/nR2B+ufA==
X-ME-Sender: <xms:GR-qZTUIcipDMNe3nThUQV3vhHSauOzKtY97KrndXZZlTzpBpaYEzQ>
    <xme:GR-qZbk4v1TTFFyoTf_WtyLm0aT-3zsQiZ9EJtPzwXRDkvnubVpAiYLFVBSXfOcSB
    gzLxhSp4sIZsEUTJQ>
X-ME-Received: <xmr:GR-qZfa0TZJ_kepZEZt1QFTB1pkKon4O-fJH3esDYC0N2PPb8byZwKoIzKneWeFiji20M02LGLTNHmJfhMUmXida4qbHyTo_hXLghHk0dPtE5w9anA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:GR-qZeV8Voeaxd41tgkDLXYXHwqN_de_PN3Y0zc46-g0DUL82qfLHA>
    <xmx:GR-qZdmvaEmqC11jYpDPDei3O9BkBbXByiosAWl2uFB5WP2IW0YZSg>
    <xmx:GR-qZbdxghpTwAiAo4qwvDRMKJzfk01pszJCTAuV9_aoHZbDA24rkQ>
    <xmx:GR-qZdtfKI192T-yV7kKe1ZLNLzHN3yAL2P3P6JuStoHqYmVxpnIhQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:04:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cfb223d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:02:00 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:04:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] completion: move to maintain define-before-use
Message-ID: <ZaofFwDaNrjmbxk_@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240118204323.1113859-4-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qC1EftNcHV//voZC"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-4-britton.kerin@gmail.com>


--qC1EftNcHV//voZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:21AM -0900, Britton Leo Kerin wrote:

Same here: please explain what the problem is that this patch is trying
to solve in the commit message.

Also, as far as I can see, this patch is actually a prerequisite for the
preceding patch where we already call `__git_complete_log_opts ()`. So a
better way to structure this would be to introduce and move
`__git_complete_log_opts ()` in a preparatory patch, and only then start
calling the function for "visualize" in a subsequent patch.

Patrick

> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 269 ++++++++++++-------------
>  1 file changed, 134 insertions(+), 135 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c16aded36c..63ca8082a4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1445,6 +1445,140 @@ _git_archive ()
>  	__git_complete_file
>  }
> =20
> +# Options that go well for log, shortlog and gitk
> +__git_log_common_options=3D"
> +	--not --all
> +	--branches --tags --remotes
> +	--first-parent --merges --no-merges
> +	--max-count=3D
> +	--max-age=3D --since=3D --after=3D
> +	--min-age=3D --until=3D --before=3D
> +	--min-parents=3D --max-parents=3D
> +	--no-min-parents --no-max-parents
> +"
> +# Options that go well for log and gitk (not shortlog)
> +__git_log_gitk_options=3D"
> +	--dense --sparse --full-history
> +	--simplify-merges --simplify-by-decoration
> +	--left-right --notes --no-notes
> +"
> +# Options that go well for log and shortlog (not gitk)
> +__git_log_shortlog_options=3D"
> +	--author=3D --committer=3D --grep=3D
> +	--all-match --invert-grep
> +"
> +# Options accepted by log and show
> +__git_log_show_options=3D"
> +	--diff-merges --diff-merges=3D --no-diff-merges --dd --remerge-diff
> +"
> +
> +__git_diff_merges_opts=3D"off none on first-parent 1 separate m combined=
 c dense-combined cc remerge r"
> +
> +__git_log_pretty_formats=3D"oneline short medium full fuller reference e=
mail raw format: tformat: mboxrd"
> +__git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short =
local default human raw unix auto: format:"
> +
> +# Check for only porcelain (i.e. not git-rev-list) option (not argument)
> +# and selected option argument completions for git-log options and if any
> +# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
> +# and will be empty on return if no candidates are found.
> +__git_complete_log_opts ()
> +{
> +	[ -z "$COMPREPLY" ] || return 1   # Precondition
> +
> +	local merge=3D""
> +	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> +		merge=3D"--merge"
> +	fi
> +	case "$prev,$cur" in
> +	-L,:*:*)
> +		return	# fall back to Bash filename completion
> +		;;
> +	-L,:*)
> +		__git_complete_symbol --cur=3D"${cur#:}" --sfx=3D":"
> +		return
> +		;;
> +	-G,*|-S,*)
> +		__git_complete_symbol
> +		return
> +		;;
> +	esac
> +	case "$cur" in
> +	--pretty=3D*|--format=3D*)
> +		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
> +			" "" "${cur#*=3D}"
> +		return
> +		;;
> +	--date=3D*)
> +		__gitcomp "$__git_log_date_formats" "" "${cur##--date=3D}"
> +		return
> +		;;
> +	--decorate=3D*)
> +		__gitcomp "full short no" "" "${cur##--decorate=3D}"
> +		return
> +		;;
> +	--diff-algorithm=3D*)
> +		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=3D}"
> +		return
> +		;;
> +	--submodule=3D*)
> +		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=3D}"
> +		return
> +		;;
> +	--ws-error-highlight=3D*)
> +		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highl=
ight=3D}"
> +		return
> +		;;
> +	--no-walk=3D*)
> +		__gitcomp "sorted unsorted" "" "${cur##--no-walk=3D}"
> +		return
> +		;;
> +	--diff-merges=3D*)
> +                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-me=
rges=3D}"
> +                return
> +                ;;
> +	--*)
> +		__gitcomp "
> +			$__git_log_common_options
> +			$__git_log_shortlog_options
> +			$__git_log_gitk_options
> +			$__git_log_show_options
> +			--root --topo-order --date-order --reverse
> +			--follow --full-diff
> +			--abbrev-commit --no-abbrev-commit --abbrev=3D
> +			--relative-date --date=3D
> +			--pretty=3D --format=3D --oneline
> +			--show-signature
> +			--cherry-mark
> +			--cherry-pick
> +			--graph
> +			--decorate --decorate=3D --no-decorate
> +			--walk-reflogs
> +			--no-walk --no-walk=3D --do-walk
> +			--parents --children
> +			--expand-tabs --expand-tabs=3D --no-expand-tabs
> +			$merge
> +			$__git_diff_common_options
> +			"
> +		return
> +		;;
> +	-L:*:*)
> +		return	# fall back to Bash filename completion
> +		;;
> +	-L:*)
> +		__git_complete_symbol --cur=3D"${cur#-L:}" --sfx=3D":"
> +		return
> +		;;
> +	-G*)
> +		__git_complete_symbol --pfx=3D"-G" --cur=3D"${cur#-G}"
> +		return
> +		;;
> +	-S*)
> +		__git_complete_symbol --pfx=3D"-S" --cur=3D"${cur#-S}"
> +		return
> +		;;
> +	esac
> +}
> +
>  _git_bisect ()
>  {
>  	__git_has_doubledash && return
> @@ -2052,141 +2186,6 @@ _git_ls_tree ()
>  	__git_complete_file
>  }
> =20
> -# Options that go well for log, shortlog and gitk
> -__git_log_common_options=3D"
> -	--not --all
> -	--branches --tags --remotes
> -	--first-parent --merges --no-merges
> -	--max-count=3D
> -	--max-age=3D --since=3D --after=3D
> -	--min-age=3D --until=3D --before=3D
> -	--min-parents=3D --max-parents=3D
> -	--no-min-parents --no-max-parents
> -"
> -# Options that go well for log and gitk (not shortlog)
> -__git_log_gitk_options=3D"
> -	--dense --sparse --full-history
> -	--simplify-merges --simplify-by-decoration
> -	--left-right --notes --no-notes
> -"
> -# Options that go well for log and shortlog (not gitk)
> -__git_log_shortlog_options=3D"
> -	--author=3D --committer=3D --grep=3D
> -	--all-match --invert-grep
> -"
> -# Options accepted by log and show
> -__git_log_show_options=3D"
> -	--diff-merges --diff-merges=3D --no-diff-merges --dd --remerge-diff
> -"
> -
> -__git_diff_merges_opts=3D"off none on first-parent 1 separate m combined=
 c dense-combined cc remerge r"
> -
> -__git_log_pretty_formats=3D"oneline short medium full fuller reference e=
mail raw format: tformat: mboxrd"
> -__git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short =
local default human raw unix auto: format:"
> -
> -
> -# Check for only porcelain (i.e. not git-rev-list) option (not argument)
> -# and selected option argument completions for git-log options and if any
> -# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
> -# and will be empty on return if no candidates are found.
> -__git_complete_log_opts ()
> -{
> -	[ -z "$COMPREPLY" ] || return 1   # Precondition
> -
> -	local merge=3D""
> -	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> -		merge=3D"--merge"
> -	fi
> -	case "$prev,$cur" in
> -	-L,:*:*)
> -		return	# fall back to Bash filename completion
> -		;;
> -	-L,:*)
> -		__git_complete_symbol --cur=3D"${cur#:}" --sfx=3D":"
> -		return
> -		;;
> -	-G,*|-S,*)
> -		__git_complete_symbol
> -		return
> -		;;
> -	esac
> -	case "$cur" in
> -	--pretty=3D*|--format=3D*)
> -		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
> -			" "" "${cur#*=3D}"
> -		return
> -		;;
> -	--date=3D*)
> -		__gitcomp "$__git_log_date_formats" "" "${cur##--date=3D}"
> -		return
> -		;;
> -	--decorate=3D*)
> -		__gitcomp "full short no" "" "${cur##--decorate=3D}"
> -		return
> -		;;
> -	--diff-algorithm=3D*)
> -		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=3D}"
> -		return
> -		;;
> -	--submodule=3D*)
> -		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=3D}"
> -		return
> -		;;
> -	--ws-error-highlight=3D*)
> -		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highl=
ight=3D}"
> -		return
> -		;;
> -	--no-walk=3D*)
> -		__gitcomp "sorted unsorted" "" "${cur##--no-walk=3D}"
> -		return
> -		;;
> -	--diff-merges=3D*)
> -                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-me=
rges=3D}"
> -                return
> -                ;;
> -	--*)
> -		__gitcomp "
> -			$__git_log_common_options
> -			$__git_log_shortlog_options
> -			$__git_log_gitk_options
> -			$__git_log_show_options
> -			--root --topo-order --date-order --reverse
> -			--follow --full-diff
> -			--abbrev-commit --no-abbrev-commit --abbrev=3D
> -			--relative-date --date=3D
> -			--pretty=3D --format=3D --oneline
> -			--show-signature
> -			--cherry-mark
> -			--cherry-pick
> -			--graph
> -			--decorate --decorate=3D --no-decorate
> -			--walk-reflogs
> -			--no-walk --no-walk=3D --do-walk
> -			--parents --children
> -			--expand-tabs --expand-tabs=3D --no-expand-tabs
> -			$merge
> -			$__git_diff_common_options
> -			"
> -		return
> -		;;
> -	-L:*:*)
> -		return	# fall back to Bash filename completion
> -		;;
> -	-L:*)
> -		__git_complete_symbol --cur=3D"${cur#-L:}" --sfx=3D":"
> -		return
> -		;;
> -	-G*)
> -		__git_complete_symbol --pfx=3D"-G" --cur=3D"${cur#-G}"
> -		return
> -		;;
> -	-S*)
> -		__git_complete_symbol --pfx=3D"-S" --cur=3D"${cur#-S}"
> -		return
> -		;;
> -	esac
> -}
> -
>  _git_log ()
>  {
>  	__git_has_doubledash && return
> --=20
> 2.43.0
>=20

--qC1EftNcHV//voZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHxYACgkQVbJhu7ck
PpRZmA/9F31mTEdnFWdTx9B6mNh+xrMeWVeYf8LquZrYecbtQznLcA+9meVUjGQc
JZcIP2teoFcI1qZd2sjzFAsOD+Y+jh7QIvq30eKqmD2fOwEUrGrKtyPSC5Upj2rT
KqzYFlQZdkirkGlkklhKVpyAV2W/U/9CSlebP9BCINiFjxTSJuI31T4TAKOOGJWF
Ny4HEQZUaBPph6bp1uav+6iigsUlg0MUJLKnXlHXaDJSO23whf8Qfo2FAS3spRu9
wnOVYSaU51tnV94FmpkaKCcECi8vnJjw0hqjvQjnoy+A4C0tFcdXYr5nNGWCVCLe
QfutP36punsO9/JusdRX1oexT9nasZ1d59VLGGKqdU3XEtLcX6uZzl7AX0QtPTsn
ZEhfTG2vb+2rYhHlPlL2vcsnfomJIIRpZGjvkZcocg/7Rswx5HliLdq25nX2boB3
0gTjWpc3ttFT9an5Qd2axqgmbH2ShABzpxVx7CMDPQ6cy79OYjbdECL8FLi7Y6Mq
SkgVBBEac5GDCS9Ef2hdCUm1mlW4KIjBUZbd9cPuE5R5rkqY53+ticSe4yB7Xh4h
dOctkDIalAaPkJ48Ef7k/gJDAEJNUf1VxD478w3TEYIFwNFNWN05du4Sl3h/MXue
LhD4FX7a3/7iOJ8GqTghGSK4nXm9lDjhTmdxp6m6bHYz6WSi3r0=
=k6ar
-----END PGP SIGNATURE-----

--qC1EftNcHV//voZC--
