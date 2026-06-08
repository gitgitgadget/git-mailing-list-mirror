Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD43B14AF
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957067; cv=none; b=iLbYPyRpWvmQniW3EBw22Y3CxTjerCwRPZheoJkGI/qp0KxcC+IN1FVDU50Zn1pMlDbIzjC8iJapg2wpcvhLW31RSA5epzZd73g4rZ8ZrkB+e5FA6DOiSXlgGvOCd47MA6Ol55tQ7ZcMnWaiHU1mI3IrvULtTP1GJZGIPiFwJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957067; c=relaxed/simple;
	bh=ku8+0cNNfTwo3npL6F6onFc3HyIHqE35BLfFLH4OSgY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aiP3l9HorWC3FYogGGw5cTlrPc/GeuxgWEyKuB42x9QaUto55TboPpDmjlzMdtdy4lz7L1+FtL00QhdVzf/dXGexwziy65nwGBCHNtMfvB94Cwm3iRPCGZINlWv1l17jZkGRn/G2cuJbWbTJ81Em/7/cQAuVBpHHcJYygmgkMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy/M/uSH; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy/M/uSH"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59be89d310aso3652673e0c.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780957065; x=1781561865; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxqi1DokBG7WcEpszWQwSUe/2B7YIxV5CnQoZWH27fI=;
        b=Sy/M/uSH6WyRP6ZrGqg62KfnEWZX3G+UOX/iGGOs/1jOYpoeLMjZ5AeWHQbgbHPuJt
         mMyPEAsGJcDxFhjbB4SbUlbyNzIEoBszgf6tiH51uYUrQY9KR/e9a31O4mKlUemPwlv4
         rHfSd9PYSyWl9RXsPd/GKmXrLZb+v14fq0pwB5Yx2HCsvi8eLCmAbeX1yvDng3UqAF+y
         687uB8vYgP81IUOQTXDe6/64poLZezLP4sPSBWODjgzFGE3Q3YOkY7nOXp5/p10ojr3L
         NVIrV7uap/BO7uJIx5RqhH+OhiSG21mumqaMvTpreeUb9YNmTv0RgxScDOP1yPwlW2sL
         Br4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780957065; x=1781561865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxqi1DokBG7WcEpszWQwSUe/2B7YIxV5CnQoZWH27fI=;
        b=mef2bw9zOBSJai5/08GpW92fDmqT6TSh+35JkVX34fotURDvs1GWoy86hQntD09MF8
         ws3nHbdkNiFaoILmC2KiC8Jq2cWGONy/aXzTQwR3PZUFuMeNKtEg7pcN8n7cJtJrfDul
         4po8wjwtXS+iBTmc6F3/skw5DTIDt85UbLJWaBz1Eihqw5B8hwm7v0kKchBOnb7pn9CA
         S1hjKMqRuHuzMnXHwDRudgqmsmSdLrT2V7HzC0SKUMSWmNdRBqiwGNNJdJXBERyus8/0
         HztDfQTNu3wW8/CeXgvToZJaAtp86AR6cDcsrffnUeO6Dwro8siSE1ADB32+nI3jimy2
         eGQw==
X-Gm-Message-State: AOJu0YxVIkIQcvr0cU6oqwYKlQVdwPNs3cW8n1BGelK6dTFO6j3Tlg5z
	Vn3gvwJ1KnJ3R5jMMyCeFciS0qottrezw1sVQhElDUdNQgqV7N5B56tk
X-Gm-Gg: Acq92OGbdytdMUVC3I89vtItfMqtRX0OEZ0t+IsMpZhm22D+7AdHIcGuxD27EJTpyOe
	QJI6To5giMFldEs21CcNqUbdzIk2C+C7BSApynD8CX0fepkYp5Xrt1s3nXQWEE6cbjsIrJYEwUH
	/TiTi4xArGSlWigI3IIJZdk/sE0stJXzVWEbzaTn3Fr3SFmFIAHlwktWCaFNPv5EBa2sPc7OMpe
	/MDwno4aU2b9vitj6yJbZ+P3DvOpoVfvJyosqlXt75MJw/V6ZP6pE976EE6wcw6qeWVVnuD0n8h
	cuiFLEiEEGsWnUuDGcQY9DP1xRLnXloyjk34q/npV4lgRa//pS5iL6WWp6BkyC8jisL/Kff1Va1
	+DaupcemXc91RyjVf7kOXaLPuxb5xV62sAjJ3IzpKIjb7VA5hLc7oEcnCRvZj12xAcHqx9mGkHK
	DIBVR+zj4LacS8fim6kOlv0nwi+iyvAtNqnbDJVkdiHmMM6JgIIZtAwiPTyYSFGWg=
X-Received: by 2002:a05:6122:46a0:b0:5a0:90e0:a4c5 with SMTP id 71dfb90a1353d-5acd9e24d05mr5856424e0c.8.1780957065500;
        Mon, 08 Jun 2026 15:17:45 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44da2fsm15752825e0c.9.2026.06.08.15.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:17:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 8 Jun 2026 19:17:30 -0300
Cc: git@vger.kernel.org,
 a3205153416@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <D14CA105-3690-4BB1-932D-7081B1A1DBFA@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> +test_repo_info_path () {
> + field_name=3D$1
> + expect_absolute_eval=3D$2
> + expect_relative=3D$3
> + env_prefix=3D$4

This helper function needs a documentation.

> + test_expect_success "query individual key: =
path.$field_name.absolute${env_prefix:+ ($env_prefix)}" '

This makes the output polluted. What about changing it by something =
like:

	test_expect_success "absolute: $label' '...'
	test_expect_success "relative: $label' '...'

with a custom label?

> +
> +test_expect_success 'setup test repository layout for path fields' '
> + git init test-repo &&
> + mkdir -p test-repo/sub
> +'

The helper function `test_repo_info_path` is relying too much on the
existence of the `test-repo`. I think it would be better to add a new
parameter `repo_name` (or similar) because:

1. You could move this creation to the helper function and
   you won't need to place the test after that creation

2. You could use different for each (test_repo_info_path call, path =
format)
   pair. Currently, if more than one test fails, its result is =
overwritten
   and the `expect` and `actual` files from the trash directory will be
   the last of the broken tests.

3. You won't need to use the hacky 'echo "$(cd .. && pwd)'=20

This applies my suggestions (feel free to use, adapt or discard it):

test_repo_info_path () {
        label=3D$1
	field_name=3D$2
	repo_name=3D$3
	expect_absolute=3D$4
	expect_relative=3D$5
	init_command=3D$6

	absolute_root=3D"$repo_name"-absolute
	relative_root=3D"$repo_name"-relative

	expect_absolute=3D"$PWD"/"$absolute_root"/"$expect_absolute"

	test_expect_success 'setup test repository layout for path =
fields' '
		git init "$absolute_root" &&
		git init "$relative_root" &&
	       	mkdir -p "$absolute_root"/sub "$relative_root"/sub
	'

	test_expect_success "absolute: $label" '
		(
			export ROOT=3D"$PWD"/"$absolute_root" &&
			cd "$absolute_root"/sub &&
			eval "$init_command" &&
			echo =
"path.$field_name.absolute=3D$expect_absolute" >expect &&
			git repo info path.$field_name.absolute >actual =
&&
			test_cmp expect actual
		)
	'

	test_expect_success "relative: $label" '
		(
			export ROOT=3D"$PWD"/"$relative_root" &&
			cd "$relative_root"/sub &&
			eval "$init_command" &&
			echo =
"path.$field_name.relative=3D$expect_relative" >expect &&
			git repo info path.$field_name.relative >actual =
&&
			test_cmp expect actual
		)
	'
}

test_repo_info_path 'gitdir' 'gitdir' 'gitdir' '.git' '../.git'


