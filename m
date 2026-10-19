Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447214;
	b=eaHnXqNW0fD4pvYHRN+xgoRr1qK/SxlacgkF2zxzXAgOQR+fyZCvAwqS/J6SGnfw5cA7
	 aol+lnjEhc9d1WMFeIyh5Vaa9yzGKXAyTF+7JXta4evBOQxYTP/5s0cZftfErzI/ZvrKt
	 qdc6usFT+QGJYk0MghqEf9OS0fWVf16KIwFJYjkbUnPrVkjEgof8neEYcN0+Tl3RVud+Z
	 MDx0JVwP5ov5KGiDkdu/nwBzxGAMBjJ9OoOlmKBc6sHBlrULcNOTNQAdoL1WtKDf0WaHM
	 8aAuyookT5gp/3QAk2sitQfkB3zWWAw0jxpuqL+KINrJprg1f4RR3ulAerJ7YTGC5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447214;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IJDllP42AgS1G5fjKWI8KuWxhlzRe/LkELccvjLl9aU=;
	b=iZdMO1dfKNBVISPp3QQQp3o2UEpNtmUfi956zQ/ImjwjFbXvWtu6SFrh76Km/HSoIJ3d
	 pNjKZlPdB1OA9Jk08r8VZAvyOpyYbAYqOcbfNAVfx+QsUiASd7DoLW9C3Sgud8T2kbhB7
	 9q92rremPKp0UQtfgZIn5r7MZ1nlWfFtTIpk1KBExfkikMNU2M6zgdkY5KKQIpVE5F2lH
	 ijPgJb8Rn6OREph6oiGu20DVnULHdtgjfxYllP5VO+LtXWRSOvCrAWM7Y1CDd+MMolRVC
	 OLmn/Ty5cWzAbRJ47jOFIKmb07pSC+lupnSBMQFozJaYoVIXd1YAYno6LCDmPt0J7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QLtpqswM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jez7V4Wu;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C2606A31E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 22:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4C2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QLtpqswM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jez7V4Wu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A132EC0192
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:00:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 18:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792447213; x=1792533613; bh=IJDllP42Ag
	S1G5fjKWI8KuWxhlzRe/LkELccvjLl9aU=; b=QLtpqswMo6AzTwYR70gYSh6MVj
	nMggJNBrrJUWWHX4aCrUhZHQ/0jGsBbvMZeVaLmNgf/euxosmIj1Ile2UWKERC4c
	8hTe5NOJ2RlU40x8TL5LeNUzRqUznLKaisIhe3pfn6oeqBHUNgyCdrci+IMny59A
	jZ0PJt9p+El+n5PFxPNXrkzvlkt0CIgEsbL02ll4HciP/yCuWbpYn7Qx/Qzltx03
	TcoBra13fQN28ZY1B6RvBezkMXSOcfWPpeUwQl8TRVaxJF+v3zcLkYYnZTxIdg9N
	ZsGx0lfJZ9ba6xJIfgqO++6VSPCnroZp91mGfbnXjFfptPk0xM8ly9AkgjAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792447213; x=1792533613; bh=IJDllP42AgS1G5fjKWI8KuWxhlzRe/LkELc
	cvjLl9aU=; b=jez7V4Wuj4CXpwl8ASINHWVMau2ta6+C/2DXBRyl8UtT6wdloxu
	4EvTvuxPZHZD89o4EPEzCnqk4TqmANxkaGddTSDDoUvdgerNBz8nu4OTo97Jrsvv
	xHDNc8LybmNl364r/9fXSgIQGsVQMyTTKFC+g72cdMZmqD6MjadPlMZ1jV/SuSOu
	e48Lwm63CYuTCdv/bbRk8J08H2DBJDujiRVOBiScS4NhQn3RFhir/9mEz+MxHJjh
	Kr6IX4wCL5XRVLk6YcKQsy/d0D5ZDOFsmblxghZsh5GoCi3tajC/HttqyhcIVgwe
	SVHNS+I0UJI9WMg/jNNa1J8gjotTR7q8NOg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792447213; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ifeUJJxxkpKI59gkWzXpl7Q5SbhCGixyMxbDzz6mh4IIupv
	JpEpggTIWRHbxJU7/wLbBJuk25GLXLzVFj4hnlNzHbkNuBRdZ/uXCiCkB7qLCYPu
	sgJ7lEygt92F4xEOrnCMJWMJV6SjsaVtYI5wzEcsKRXojaPhrrrRiDz+Zfvu30fY
	XYLjLug0WB+nkd18HHaamUU3rf8D+tcav3vhrWV2ynO0ZOrd/jFRwvF4SAhz0d7G
	m7L1Hc2zknigQkIC8Zhlr/gXkvxVYyKH9pcHaK1rXdfu+h+VgcLNSUvbTKP/pYMi
	cwcYaKmmTNpNS/Xr1kd9lmfZpzwP/k+Qm1eho4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HVC28idGP0x0PUUgzNzp2RoUcmtZGKEIHMiYwRsi9Vs=:NfKSxCuI/xVVna9UtrfXsmksv7IJ56KyxTBj6EdOupU=;
X-ME-Sender: <xms:7ZLWavxnlLGl-wWwjXOaT4TLyITaEzDgNFpwHEmnFyzVuitsjMUmcQ>
    <xme:7ZLWauRuG7m2kDoOu1Ypwp0Rlbj9aRAx7t5Ii9_CEWawkoZ7Ymdan1gf061ljeFcH
    N4ez9RoCSNizfp7kc-EvqyaEeavOv1P4i2Aw3QTXwRBUd6QhGFrGw>
X-ME-Received: <xmr:7ZLWauUcadZoQPFK1szLiRCTn-RytLQZMsQnorxBFsDXgCLpI3FCgN6xz7P6_xd0JUqlde6b0qh7pY_3QdXCy0J7k36JQSX-feL9>
X-ME-Proxy-Cause: dmFkZTGFlMwLpo5s28ptJGyjo854krfW7z6vz8f9lZl29Siz7iyoNGUaOPoapz5+ME7hGH
    npuHMuFcv2sz3FxVt5OYUKAWE5UUQ/RjcxJ5QCNW3ECLomxSqB87P3FlGgXkm8iWHZro8+
    MTjUu+lUPv22Df4Jq/s4SefjnEfyT2mobvw8CRUILgJZADPpKo63fBLal4UB/bhd3zkwMJ
    X5fF2FVLiz4mCu2yMNwmLJp0lOH25g9yl4/rdQYN+TpyBCZgRtT1RC2uPFKQvX+ELEzdzA
    HWqyJMQO2Oe2SPhnQjY6Hp7qpd1PNSSVTDZiOv5wlnBGPiUU5Q0qtV2vbYmoy42V1FDxXY
    iEsszL44VxK3mHN9Tzlvte+yyXr8bojmAhBJnEnvKL2MvWGwPgC8IRN60mJ5capsYBsGjl
    VHLsl2tkIsib7ItjgBr1c9M/o84VfiYin0uRssQGCv3cipbKi7LxQh6cU/FoGx7Ajnboo+
    exmhSxe1/gad2OVmcBKX/xEbpjqQUOdD0pQeawxIFNPzlqQG6jYkue4yTCuayGpSNvPVvh
    JC5BCuTn1UGre16uS8lhwCPODdq/sCmILQciDknMTH0KmJQ6WwwKqaZvB6vUa2KipOrDeD
    8dSshTt6rnhgfQvqAf8OpbmbusIv8B+UfvMRie53fqJCFftg7ZkjULlODC6A
X-ME-Proxy: <xmx:7ZLWaoYZ88x2PW7EM3bEaqWMiqSNjeGEpjjqmcVdWXjTsP3gJKrOAQ>
    <xmx:7ZLWas13ORXwT4QhEbE-ucx3gVWO5Dkls4Wbg_PyBAZ0bRSB2A9xHg>
    <xmx:7ZLWaih-rDCPM_g_k_pngJba9DfDOZIDfmPznszztOuR1CrDfyGeDw>
    <xmx:7ZLWaoa6lDcSTojTJNYMGwgI0baxcS4ae7hpjcthZhJW2bg_8OxXAg>
    <xmx:7ZLWal1ztg4SxYwh3ZIAYzEJQbjQL34LMgKPI3SbGudaFi8Kp7UyY-sP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 18:00:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] imap-send: accept messages with Subject before Date
In-Reply-To: <94129fb718c0fd961df78550f6633752d474f825.1792437558.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 19 Oct 2026
	19:19:18 +0000")
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<94129fb718c0fd961df78550f6633752d474f825.1792437558.git.gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 15:00:11 -0700
Message-ID: <xmqqse211hck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> which fails with "no messages found to send". imap-send only counts a
> message when its From, Date and Subject headers come in that order,
> and git send-email writes Subject before Date.

Nicely analysed.

> +static bool has_required_headers(const char *line)
> +{
> +	bool from = false, date = false, subject = false;
> +
> +	while ((line = strchr(line, '\n')) && *++line != '\n') {
> +		if (starts_with(line, "From: "))
> +			from = true;
> +		else if (starts_with(line, "Date: "))
> +			date = true;
> +		else if (starts_with(line, "Subject: "))
> +			subject = true;
> +	}
> +	return from && date && subject;
> +}

So the caller is responsible for placing the cursor at the beginning
of a message (e.g., a "From " line) and this one inspects the lines
starting at the point looking for the headers we want to see.  The
cursor is local so our incrementing will not break the caller.

RFC 822/2822/5322 specifies these headers as case insensitive, so
you'd want to use istarts_with() instead, though.  I can see that
the original did not get it right, but we are making the wrongs in
the original right, so ...

>  static int count_messages(struct strbuf *all_msgs)
>  {
>  	int count = 0;
>  	char *p = all_msgs->buf;
>  
>  	while (1) {
> -		if (starts_with(p, "From ")) {
> -			if (starts_with(p, "From git-send-email")) {
> -				p = strstr(p+5, "\nFrom: ");
> -				if (!p) break;
> -				p += 7;
> -				p = strstr(p, "\nTo: ");
> -				if (!p) break;
> -				p += 5;
> -				count++;
> -			} else {
> -				p = strstr(p+5, "\nFrom: ");
> -				if (!p) break;
> -				p = strstr(p+7, "\nDate: ");
> -				if (!p) break;
> -				p = strstr(p+7, "\nSubject: ");
> -				if (!p) break;
> -				p += 10;
> -				count++;
> -			}
> -		}
> +		if (starts_with(p, "From ") && has_required_headers(p))
> +			count++;
>  		p = strstr(p+5, "\nFrom ");
>  		if (!p)
>  			break;
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index d1393ef197..1f77c14315 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2863,4 +2863,39 @@ test_expect_success $PREREQ '--compose handles to headers' '
>  	test_cmp expect msgtxt2.to
>  '
>  
> +test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archive' '
> +	write_script fake-imap-server <<-\EOF &&
> +	printf "* PREAUTH [CAPABILITY IMAP4rev1 LITERAL+] ready\r\n"
> +	printf "1 OK\r\n2 OK\r\n3 OK\r\n"
> +	cat >/dev/null
> +	EOF
> +	test_config imap.tunnel ./fake-imap-server &&
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--from="Example <from@example.com>" \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		HEAD^ &&
> +	{
> +		echo "From mboxrd@z Thu Jan  1 00:00:00 1970" &&
> +		cat msgtxt1
> +	} >archive.mbox &&
> +	git imap-send --folder=INBOX <archive.mbox 2>err &&
> +	test_grep "^Sending 1 message to INBOX folder" err &&
> +	test_grep "(1/1) done" err
> +'
> +
> +test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch' '
> +	test_config imap.tunnel ./fake-imap-server &&
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--from="Example <from@example.com>" \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		--imap-sent-folder=Sent \
> +		HEAD^ 2>err &&
> +	test_grep "^Sending 1 message to Sent folder" err &&
> +	test_grep "(1/1) done" err
> +'
> +
>  test_done
