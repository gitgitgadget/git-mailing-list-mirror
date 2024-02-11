Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6955B66F
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671852; cv=none; b=jN6N2Vd5zNtmgAsS9UWiLxMP28zWL2ENsXYUwsRrj+JebVVQLGJWFGx4SRgkEMaCQREijgUuC03WZS+ggbX9l6j9p3twx3xwEII2qrawT17zRLT42fEYfq3zTErwCXEtK3vAy15ERwDRWSXJm4TFZeIKSuAe9YSvY419s37+g30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671852; c=relaxed/simple;
	bh=W+RG9e3CK5hsbQ1SkkHGjpoP6+kojEcTxA9+ZtYvGq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pibzLpOX1YFmlfEiDxd7xG7s43sE0xCMk7If/rT/Wk1tYhkBAcb0GO8M6lIuS7oOCzfgK0SIi24+d03WOgL1uRs/yi+mFavtmzUxlQCbrrBEHgw7ebr8picO02tF78Z42G4LOK1qslBvz0590OfDaKNBy9Uh/Mfn//NiTQ2Lzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PBp3h4q2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PBp3h4q2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D275A28BBF;
	Sun, 11 Feb 2024 12:17:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W+RG9e3CK5hs
	bQ1SkkHGjpoP6+kojEcTxA9+ZtYvGq4=; b=PBp3h4q2WZ4q+/SHLw7GutiVnz16
	bsQOYwcPInFFfjhe1QrV6i8bR7XTB+p6nyMG4PwhHh5Ql4oafnMJo8G1JUuqApSy
	u2uvuqIYZkn0YGDv5mZopHX8jLhFpYXiOfygxkJNFWEyIQReqfLrHTUOPaEFXmPd
	7dTsAzL14F/cTsc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CAFAD28BBE;
	Sun, 11 Feb 2024 12:17:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74E6628BBD;
	Sun, 11 Feb 2024 12:17:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: bump remaining outdated Actions versions
In-Reply-To: <pull.1660.git.1707652357696.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sun, 11 Feb 2024 11:52:37
	+0000")
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 09:17:25 -0800
Message-ID: <xmqqplx29aze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6E220000-C901-11EE-B5EB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> This avoids "Node.js 16 Actions" deprecation messages by bumping the
> following Actions' versions:
>
> - actions/upload-artifact from 3 to 4
> - actions/download-artifact from 3 to 4
> - actions/cache from 3 to 4
>
> Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> Original-commits-by: dependabot[bot] <support@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D '' && matrix.vec=
tor.jobname =3D=3D 'linux32'
> -      uses: actions/upload-artifact@v1
> +      uses: actions/upload-artifact@v4
>        with:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}

Curious that, among all other uses of actions/upload-artifact@v3,
only this one has been using @v1, which may deserve explanation.
The proposed commit log message pretends that this never existed.

Please drop a non-standard "Original-commits-by:"  trailer, and
instead mention what you wrote under three-dash line about the
dependabot in the log message.  Perhaps something like...

	After activating automatic Dependabot updates in the
	git-for-windows/git repository, Dependabot noticed a couple
	of yet-unaddressed updates.  They avoid "Node.js 16 Actions"
	deprecation messages by bumping the following Actions'
	versions:

        - actions/upload-artifact from 1 or 3 to 4
        - actions/download-artifact from 3 to 4
        - actions/cache from 3 to 4

	Note that one actions/upload-artifact@v1 was used in one of
	the rules because ...

        Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
        Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>


Thanks.
