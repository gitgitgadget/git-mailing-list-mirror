Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012904;
	b=Z+lJ6hrd1Haop7QlYPj14Mb/xt6MPvTiCOPlX/RW+v2k7BK96uOX3gTi/nWPtTVjgAs8
	 F5ZacK7qzO0JPLYoxHgALF5emtn5P7PKI/wMErEyECUt8eAXRDISvIiT/4aZD8viCA5Oe
	 zwC6EQA7j0M/kNJQ21/C2EIpx01Z+Q2nLLBt9DL2nqegkPDIQFdQhh+/xi/CLqIWACGRQ
	 lwObjzvY/jJOpscNww/K7xoyTe9r9lnS0GoLfIMwjKvHov4EpwL3phbiJ9kAH6HKuUw3N
	 pg8aq5V93duO/eRTZFlPoVbjO1XDCTdlNSy1yME/TZc19M3HlS6bTowiXcoHpyElhaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012904;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IWJTQzrf8h3ohbx4meCxkUbdAJg/aqrd5ZDvINVtzyk=;
	b=xu5qVn6mXGrtCWv8ofywO/i26eYoal6MuW4tLtD35+Nlyc3NFlEkMKpAa7D47MkmiZkZ
	 kR4x/gHfdk/vEqVWCRvi89l4MzdlByCJNYGWfO/kF5pq6v+UCS8ji/Qckjk6RX8MyGwag
	 jKH1D8q/3PjF+mqtiUa98q3lwkFT2CsK6waNMZ2IIWen6xasEMWZ18yXsfgZcjMJg6+95
	 +xyrH06ABXlfOzdZUqurnARAojG6umq9oDnAdGiLhrLiux7i4bSu6E4pgZrhhuVWzqFV6
	 cWogEULyuqDXJTSPpI7x1lMfqpyzJGSwQupfx2IUHBeNAr3rkSQvUQaiax5zaf33Y8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YlWG3QR0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XbCihppw;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263A606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F263A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=YlWG3QR0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XbCihppw
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 430E11D000A8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:08:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 07:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793012902; x=1793099302; bh=IWJTQzrf8h
	3ohbx4meCxkUbdAJg/aqrd5ZDvINVtzyk=; b=YlWG3QR0kpHLgTZDKSL224ahgm
	TjcOckNojEYz1E7euVbix/d8SE6fPb0N2K4zMZGKLzgf2b1p9qPdEt/Hyp6qFpFd
	ReWUfy1qWyn0T3plhC5CxWhKAcWkinEDewUZye0Y1Dbn/Q41D/S/6e7oSj4sXQb0
	OrM7CkjfWTaKEl3NvQpgjxY4bgL7RNpnXIcMoeGoXmGX+HjSb3aLsRZIUpwlopxN
	2Uw8kEdT5XSRBvlsbFucukbZiOTFay55+Du9YTaUjBEu3fB9ZvfN+ivUj5YLfggL
	fBryXfxQ9Zi63WZN+3n3CHipc2wlIT5x8bP9SgMPTl8MhS6FrsuUhmZ/h4wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793012902; x=1793099302; bh=IWJTQzrf8h3ohbx4meCxkUbdAJg/aqrd5ZD
	vINVtzyk=; b=XbCihppwX+0bNeurLgD1IuCdeZZTaU9zijeBhtXeWdChVtsHlKc
	t1R1PFoXPg/+xXFkCMMMYxB7hUdiheY5J2JVGX133cAYlIz5kQ/7pUGXxhyKY91N
	4v7E+Us8/yENBVhfEqWUw+QhSkqMpGAzakQjmU/ScZvWoboe49jjqt8Z+Efj4TXH
	zmGqRqG3mFrakf3zzfWHcBcV2rZddwWl7TqGWzmX/SYxnP9yavda1+ujfmqSwKNn
	q5DrHKODMM8NuA0qSLrp9y8S6x2lecZ9WCjnWIC6al8zaVCR7FJGOSUg8MvWu9CQ
	Of7T0ICH8EL8SmPHAmDnLLDI6J6/a1dUDeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793012902; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mfChQjTlwbK3P4NsAAIzFWLL49rWnZLcmE3U5SsBbcd51Hl
	+33scVXsISA07pyzTjc7eBy3GPYkAUT72A2yfvopvbWGUN3c+2WsFGCcyTtNrLMF
	3CzfCXrNwUPDp/hGBATPSPzd972Xx8QQRrsK5SzuRXqNq84vuLcnaQDD7Nje6Ls7
	RLL0anaojOSo1slg/3io66C94R8zRKz5I+9khbljAAaN3+6CyGFKpwBoaRo6liNa
	zdejmj4iqIi7R5UZGwmmBLSAZjsFYYGv8Cbdczx6XjdrGDBMctb5iNFf5O83ZLwb
	f+TYzqt8jJH4aDYmh9sknlziJnN+1odtAkoIQqQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rY6T0TNh/G68oNVSpnlBP8qWC7UOWOgINMEDFde9xW0=:Hp85SphKAXRXIu0do6r2mF532qRm86yfY73hFJCQVM8=;
X-ME-Sender: <xms:pjTfao72WkowSAW1ZCzyDIT_IVzRwJ6RN-Sw5YbHza9ZGmhwy5tVoQ>
    <xme:pjTfahWG-IKBqsqiIHjPWdohr2fn0UHj3jCst4EC-NjqI_8diu6StLWueQyXKtO_U
    7qePwvlHOPMBY5z24Jl80WAQe_ATL4Q073S8ZMhcrpIO20eCBJpOsI>
X-ME-Received: <xmr:pjTfak39IRJTq7laqe8ke6gPRXiASjrQVvDmvUopO-gpkyWS0J1xdg>
X-ME-Proxy-Cause: dmFkZTE7yTumNkBDihnAFge8ViisjJahQSsThRsRSvukn05baNn3q0oKGr8dfJ/j3c8y0I
    iifaJcBkaLutVgMKfDfTEc6V31JmLMV7eQTvaKtycmc/zbW3jWFcSNoTEHAuUfrxIuhMrb
    dvpGrakrDQSZ2tnUp4uq+Mal4HbBZUe7Sr9ia9kaVnZsZeSxkiinlBgeIa7jbWN2b1rHPb
    lNmNudw+NnfASDu1EneeFZZI8Qn5ypveF6Wv8ZYkaslE2iv6j+hIjEoRsL8wchdemzMMOA
    7q4BWgWkmgz6+D8ukGKi8nL5oNuxvw5HFRujkbJ2TXcgHfD9fcnhlpKQNK2aaaEdm9PBjX
    cLRBi8bcnY45EuUxAc/QAbfJZH+nMh9ofZM+F3j71pVHuNAZv+s3ktWHHxLa1/Z7gznYN1
    7KKZFvDjK6REpxBAZ4fdvGXc25RyoT8m8cfcoQlJ900yJdReY9t1lXB5K+uhawQIoV6eJB
    /6N6ptCFtYPgMpGHEFLs9Skp3V/yRaEW8aueyg8e4mXzPmMgftIYvGoDZh6J75TMk8kRKo
    Uc21hqD57VbfYqrWlrS6wsFfCUzDuoa9zmFzhg+pMCeLrk5WVkVZKn0Nxt17GFZZX8Ayby
    2BapG//OKD56DLNWFnQeYsWFTMAjd9BM+DJg/VOSammnu/KN06eT5n3vB9Lg
X-ME-Proxy: <xmx:pjTfam2L0nMJEpejyJvuLLRmh69KKvmZYDew_bHdqyH9pDTg2nMeNw>
    <xmx:pjTfav_GxvIKpgnCVtdBdboR689JKGne-pmKK396ak3oUMKAVtNkEg>
    <xmx:pjTfar1VEZXlvm527IpjlhcLII_dy8FfcXdY2ckw2QOTjYB0zc2Lyw>
    <xmx:pjTfak9ZeGnKeQ3xS5aW1sYs8Zb04JY2b_QKv_okzOj5b5zHjTfHLw>
    <xmx:pjTfaqz3z4KWzgxPT3tPLYWcO7pbMyVMFHy_Xx5RIWXg_q5NpVcKRTcB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:08:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba65d13c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:08:20 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:08:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 2/2] ci: fail the build if perforce, git-lfs, or JGit
 fail to install
Message-ID: <at80okuHpoUjUYpQ@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
 <a57cfbb2a5c0f34e44595c3b688b18c760258685.1793008465.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57cfbb2a5c0f34e44595c3b688b18c760258685.1793008465.git.gitgitgadget@gmail.com>

On Mon, Oct 26, 2026 at 09:54:25AM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 203e8401cf..7c3c6ad434 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -94,22 +94,25 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  		wget --quiet --directory-prefix="$CUSTOM_PATH" \
>  			"$P4WHENCE/bin.linux26x86_64/p4d" \
>  			"$P4WHENCE/bin.linux26x86_64/p4" &&
> -		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
> -			rm -f "$CUSTOM_PATH/p4"
> -			rm -f "$CUSTOM_PATH/p4d"
> -		}
> +		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +		p4d -V
> +		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +		p4 -V

Isn't the && chain completely useless now, both here and in the other
cases? We let `set -e` do its thing, but we don't have any error
handling for the whole block anymore after we dropped the error message.

Patrick
