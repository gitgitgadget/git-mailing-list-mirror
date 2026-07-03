Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40133DEC8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055293; cv=none; b=Di1WPGNdkYY7fLnALRYMvOf1l/pneVM9/gjZwhscJB10fmGueceiw6secK87Zw9ch5lKk0l5PnI+xvvYrJF66cJcX1Ggibj43KnRuPMrALLkbtG7PY2wqaR5oJLeoLgDJTlOKqwpq4tFRzb0dwJlvuoRjgeP5kzlNjHfZJVUeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055293; c=relaxed/simple;
	bh=ij3OUyayyF6UEo2clmrSoq15Xvk/Lsx5+NDguS7uzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXbzuPM/hrOFM3G0omrTV5bYPRVDcLGihq9kX+v0DVPOc/4fQMR9cXgBUFJ2A9viJ4zK8ODsjeMS3gfyhL5noGRXbhzISR6boO5CrESiIBtXVWzaQ97X8eH3STt2Qk6UrGosZ3Usgxg8TS9mjkGxUbacIjg+WRG2REjx2o6/d2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=k+f0to5Y; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="k+f0to5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783055280; x=1783660080; i=tboegi@web.de;
	bh=sD06uYjST4N1YdxhkquUZiMXZ6vnZ12oXzRmuq4lcZ0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k+f0to5Y6ZwiZDQXdhzD9kCSJ0+r3jKPYGW55emA22SOlXrMXyUqRAbJJ7N2PUJk
	 2+ndFxdwFcWw0D5eHDvw5+qs5Fza8uRtyXJO23M/b0SOhvOnXbxZHcqJxvB9SkPN8
	 8HGL6H1G65fKgkl1Q3o9PsEytgRg1S40rNPg/F5uPgfcpsx8RQQEbh1OXmKKgkf3h
	 cLccCKBqO2gBKuqgRITzHhZNj7qBYEGU2Z5JvT/L/keXroZusPEAmPDIeHdSFPzn5
	 iBuxaov3yk44iP4J0eOl9YVHZzZzqQHOtDPg6As00FbMUt/unZViNhftYfciFb/MO
	 Yd6fdOVKT/CiSGny/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpqq-1xEIeQ2jOE-00aV70; Fri, 03
 Jul 2026 07:08:00 +0200
Date: Fri, 3 Jul 2026 07:08:00 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] precompose_utf8: use a flex array for d_name
Message-ID: <20260703050800.GA29216@tb-raspi4>
References: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:+sjlE+kQU+2g9eIut6UrM9sk51NPcT4XrN5mcb0ZlZKF9rN6FqI
 CcAvf9QMVEbvK9r2ucVmLzYRzoLMdTpPegDSzQL/JHnqGvrsVg3/ebcTnDRCniP7s/C9iXW
 5B++LlDa3Rdc+gcYNoq+UFvdn/zzT4fg7kL7vpafZJ2vtMvgOmzhoeCZn91HUBv/ymYEOx5
 U7D+pC483MK0O/UAP00dQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tGKoCBrwhgc=;NimzqbUS6nTNrQudI28ULEpjY8/
 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
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 10:35:54PM -0400, Ihar Hrachyshka wrote:
> On macOS, git status may abort while reading a directory entry
> whose UTF-8 name grows past NAME_MAX bytes:
>=20
>   __chk_fail_overflow
>   __strlcpy_chk
>   precompose_utf8_readdir
>   read_directory_recursive
>   wt_status_collect
>   cmd_status
>=20
> The precompose wrapper already reallocates dirent_prec_psx for
> long names, but d_name is declared as char[NAME_MAX + 1]. A
> fortified libc can still see that declared object size and reject a
> larger strlcpy bound, even though the allocation was grown.
>=20
> Make d_name a FLEX_ARRAY and size allocations from offsetof(). That
> matches the actual object layout with the dynamic allocation, so the
> fortified copy sees a destination whose size can grow with max_name_len.
>=20
> Add a regression test that creates a 261-byte non-ASCII basename and
> runs status with core.precomposeunicode enabled.
>=20
> Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>

Nice, thanks for the patch.
One minor nit/question:
Do we need a
test_have_prereq PERL
in t/t3910 ?

[]
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
> index 6d5918c..fda4a76 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -207,6 +207,21 @@ test_expect_success "Add long precomposed filename"=
 '
>  	git commit -m "Long filename"
>  '
> =20
> +test_expect_success "status with long non-ASCII filename" '
> +	test_when_finished "rm -rf long-utf8-status" &&
> +	git init long-utf8-status &&
> +	(
> +		cd long-utf8-status &&
> +		test "$(git config --bool core.precomposeunicode)" =3D true &&
> +		long_utf8_name=3D$(
> +			perl -e "print q(a) x 249, qq(\342\200\224) x 3, q(.md)"
> +		) &&
> +		test "$(printf "%s" "$long_utf8_name" | wc -c | tr -d " ")" =3D 261 &=
&
> +		printf "content\n" >"$long_utf8_name" &&
> +		git status --porcelain=3Dv1 >actual
> +	)
> +'
> +
>  test_expect_failure 'handle existing decomposed filenames' '
>  	echo content >"verbatim.$Adiarnfd" &&
>  	git -c core.precomposeunicode=3Dfalse add "verbatim.$Adiarnfd" &&
>=20
