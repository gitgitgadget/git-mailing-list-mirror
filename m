Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305037;
	b=D+13qCryJEXiLwrYlITXBF8Bp08Sos3/w1VCt39WHIC2C+6+vPFz2gbikhrVctoA6IoU
	 WQi6zIZ4oz8qCDol/Mj0Mp7M2aPe2MnIWt8f90HACswPXcMMm4iOFdWU99EdRe9WtQqsO
	 TxRV6A/YtujTIzLtXsMsx0sYg8bJhN6aKeJy6CubuTDkkWZEZr9rqs4quBNv8jVZTBjaf
	 5N+vnYeXkIItwNhHB9tPuvdx8D45FexXNkorlDY0KhZjNYl0cZaruHCNgjYjtFMETEc0u
	 c0P11tG6H4htT4QzizCncB0vYejuRNzq1nxJsVDAUGj88mdIY+sA939/Hk6dVz8HBTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305037;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=BMsXRXqPvXyyVDDi538ZQJDuK0MGOmlp7SI17o9BIEI=;
	b=Ti1BgfUX65jkXDz0wBpxa3UWEiMN3l3RTBQXrGjHBTdXqxAOqPFSlCPwFUcgyDA0kwud
	 lMNKJ6TiIW9HZVdzYFEdO4wPeIWUSINSOISeuks/1NfvdthbQyx+0ZLbTSvvFXBRKnZfs
	 fvLFbu6pOa52hTGdPW6rQvHQ+P84RdsWBi6Ww36agnA21eQ1TUuFTpAWuL9Ub/oSTXwCM
	 1bOnzykSJvxkTi8yjCMHTH9BcLlxfDwVJ8mRcuYRHn00xl58wybP463/SenmKmRK6y9eY
	 hcOPm9oDgLD3ycLirkwBz8ioKWjMBVWYSH3yS0TMjToSrR6GcoES1ctJbcSsKQIynYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=NN7z019c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dr7uUtv6;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C169606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C169606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=NN7z019c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dr7uUtv6
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F3087A0132
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:17:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 16:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793305036;
	 x=1793391436; bh=BMsXRXqPvXyyVDDi538ZQJDuK0MGOmlp7SI17o9BIEI=; b=
	NN7z019c9BmGDhRQWxoRT98Q+B116Q1blsm5aVUaNWnJIyswLQaLl4hUL9Cj0zbv
	1oannt1EGYt5nXq+vqEBGmQH36botkPeUbV5sRddVvUrot5g5KK+BKBADnAmHsfj
	VPEXEt0e5BHm3pa7o/Qs8P6iFRBrNuT6js4IT8D5+HRTafklGrHRPem34Pde72V3
	Ljg9WPXQXMVmyDLDPAFk1MKNUIAA4AjocAXm5ggjLHMX6TmAq2qEdnwYC7cQa99q
	RvPGQKW0GKywtwaXBEdXC9sMBAqhGFatTXt85y6Z9xJGeMYtMJN2qgeOnSftgnuA
	7GWHaw0KAneaaiY2vRWE5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793305036; x=1793391436; bh=B
	MsXRXqPvXyyVDDi538ZQJDuK0MGOmlp7SI17o9BIEI=; b=dr7uUtv6koBZtafS5
	BMo+g3iB9R3evkgJAk4xXs8A9eAIfn2oxh91ZMj8TTwrwUlV0PAoJHLF14FX1JdH
	xOvjRlmrrCCPgSzKq0NjxyLkUi6XnfoGK39TFsNlfRhI+3ccamCYBbZdy6J4Tg1V
	4xpvJUlGQZaminIqVBYqFYRiFlR+qFvPcI3d6JpWDE8/YvHHYacBPbnnBb0/vwIY
	sfaE1jeMndD8ahCaG1HPqN1T7VLdXBMj0XkEYRCAYtEeU7pEMmM3/CniSZNVK526
	3ZaQMd5oegwc1OJ+uzQuR2Gvj1hcd6A3z9x2cSZIQqV0cGY9+OPkVaNn9MV1N490
	dZ0Xg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793305036; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Kwkr/uhVxzgdv0Gh5q19TCjja0J4oPV6dVju1nbn5H9Ngi0
	6cbnbAEJVwcdGZCdX2Ye7h2mW9Kc5P6FoZ1kK7sbG2O0aDaqqRe0XyahgMSMUMoY
	knB63bAwA67OTRCbtPbjjZzkpEoqMq5sbWRK2YUoCMnNM8SVZ3OI6YBmWywxNUPa
	GTgmktKnk4AULw4Us71HRyMmvq6K2EUKeNofLwrJ5ocn7koc9KqxRwdSUr2sfRKe
	rcfc7+3TC96gmcWqxulmKY5hqpmxU1kcF3aT4rW0N9R+Kqc4EOvHYRv9TEbsvw4c
	jtW9Y4Z5YB2EENZWE7sc9lSL9XCAAfSPEq6A7QA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AV4rxfpco+qSFK85A9oCH77Pem/wQRtoDQm9DQrdKu4=:BKTJVIrw7aYN0BJhIPC5Nk7mrjfRqxQDuz4HOI1Xq+w=;
X-ME-Sender: <xms:zKnjakg9Ge9ATxyxhKM3tbpwo5oeF28xIuv-YgHvJ_Ux6G2_drFvHA>
    <xme:zKnjajBnwUG_7D07yofLXxsJENZiqZildDinCXIJIlXCFUQjakru2VEAn0fXOq6yZ
    kj7JxCkT3LELqLcVvm0r3vwoEiy7EIiMrik_QrhEEz-ax4tdlX-tg>
X-ME-Received: <xmr:zKnjapsFl7bDj25YsYtufcvn86M5TUCJVCc0foMXjmd9IKaBkw0OO9ICa3U>
X-ME-Proxy-Cause: dmFkZTFkxOhLUuQePbeazO/6SH8gGRhrno3vPGMtvom+VyNjfpBtDck08eZN93aP24nkiT
    q6oreIc3Gs2zqrJqN1vSu+7RA5tbf2Pa1Pj7QaXR0xgGYK808G4ItVUmzvWIsS0BGMatcM
    2Lwqyii+Z3g6U+19HjKhUKsaFzCZ72mZR/BLTsScF7fmZYtBnU1HIGTPpHPewob3f5Rvr7
    BqeT6cK1qFiBlkORD6iC40UH/mfn+ogWqVrQu9GxX2wPA27LyedFHuOWsf13agVENMkuZF
    0HG+aA1VzNvD1QT+UTBXJBjtwofpbE1XEwOlCuQbPXg6XOMCymYvDGD63HufMxwzfXmPsA
    zm3Nx1mPBUQQsAqBvAOL7mLutiz6i6Hn5kmcpvgrcXiDSPjyiyTy0HXkeUqSyibPfZlRl5
    hXocx2yWc4pmhudJiqP9YK/xTZevA/RwyEcHD98ffeUqzNCuI9zqEFbmHaaWju3bzf48tX
    shrWfvVipzmg2GlIZ6M8AFM1w0UImR0Dn8wtH8mrzLdVryPmuo0HNv6PURUXVtgYdBlKwW
    TiIlqwSGsEwNUzTl1Rgy3sloIr21nyFjyWYuJxqD53Lp4/oYU5+xZYHY2hS/I9U8CHAF3c
    sqnfMwk+Gi9Xcs6ejiH+HftdFlyJEjEuMo9iJi2np4HsaPuvOyOzSdDMc+Cw
X-ME-Proxy: <xmx:zKnjagbuFCpgqVr0AfhUAA-eXt56dChAAT4pD6k_hCcZtqO4lMfGtQ>
    <xmx:zKnjakU6EUROUXZBqMo_hJHDNrGuUcJh_QpjPCqg42srluAleWWSew>
    <xmx:zKnjas6446DMtNQAFMXlPg6ezdW354_1nCrWDJj25ZVy_chGEwcD2A>
    <xmx:zKnjanh2e_ZQNEbCQOj-9XME2CAUK9o_y2wpSplZ9-Xu7sJiTD2Htg>
    <xmx:zKnjasTMFCffRQPkhQ9m9iGdPw1TIXV_SNYMpVFwfYaSj8xwFjHNdAXI>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 16:17:15 -0400 (EDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 16:17:13 -0400
Message-Id: <DMHLKVCPT29F.1JXB7BAOXBPYT@fastmail.com>
Subject: Re: [GSoC PATCH] t5402: use test_path_* helpers instead of test -e
 and test -f
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Tilak Kumar" <raaztilak07@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261029200024.32206-1-raaztilak07@gmail.com>
In-Reply-To: <20261029200024.32206-1-raaztilak07@gmail.com>

On Thu Oct 29, 2026 at 4:00 PM EDT, Tilak Kumar wrote:
> Use test_path_exists and test_path_is_missing instead of "test -e"
> and "! test -f" in the post-merge hook tests, so that a failure
> reports which path was unexpectedly missing or present instead of
> failing silently.
>
> Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
> ---
>  t/t5402-post-merge-hook.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
> index c77aa56421..1e222ac28f 100755
> --- a/t/t5402-post-merge-hook.sh
> +++ b/t/t5402-post-merge-hook.sh
> @@ -37,12 +37,12 @@ test_expect_success 'setup clone hooks' '
> =20
>  test_expect_success 'post-merge does not run for up-to-date ' '
>  	GIT_DIR=3Dclone1/.git git merge $commit0 &&
> -	! test -f clone1/.git/post-merge.args
> +	test_path_is_missing clone1/.git/post-merge.args
>  '
> =20
>  test_expect_success 'post-merge runs as expected ' '
>  	GIT_DIR=3Dclone1/.git git merge $commit1 &&
> -	test -e clone1/.git/post-merge.args
> +	test_path_exists clone1/.git/post-merge.args
>  '
> =20
>  test_expect_success 'post-merge from normal merge receives the right arg=
ument ' '
> @@ -51,7 +51,7 @@ test_expect_success 'post-merge from normal merge recei=
ves the right argument '
> =20
>  test_expect_success 'post-merge from squash merge runs as expected ' '
>  	GIT_DIR=3Dclone2/.git git merge --squash $commit1 &&
> -	test -e clone2/.git/post-merge.args
> +	test_path_exists clone2/.git/post-merge.args
>  '
> =20
>  test_expect_success 'post-merge from squash merge receives the right arg=
ument ' '

looks correct to me.



--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

