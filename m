Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833612;
	b=RJWH1ajn/k6dIe9ISlkIz53xNJn9Ne25344W27joL0utPoIfWLdFo1OTpIAXmBXykicy
	 z/CwrFQHsb6wphCeDkffCYDSHj20oeeOhZSOjBoxvRjtmjsrOUPX+PHq5xwgv1miulKs/
	 LiwBeVAWW7C3dRNkrrsbjm6Rq0NB4UlMVY8SZ/dTHvNLwW7Ks7a5EenlD9FO0bKCU8arq
	 nt9joNklc0x3GdSsX8tAp6ZYs855W1WxGIQCXIa65Ux8iUwCcOtBYqCe9abZrIyhdTEpw
	 0YDumtgjEie27aD7C+aLYn6hg9859ksTcUxjucy1QgTZlkeEwwwKvfTOimY/QJdisKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mpWDozVD3KQZqgQMWf22vZ93TXf3TETFEGvaaVUsD4I=;
	b=1ZfIsFY2WecU2gaD2i6t3K2ujukFFou9q1+HQt9KnfJuF0n2pF3bw1qj4q3NIVcDOgfJ
	 1FK7iGv3eW72OantFHaXNV2/hi/bwNQt2uH9CYnKEhjoYTwQ5R2DbPhPa9/VnUvCUhdZ7
	 9dQbvIOLXDucR9ndTcN2lwd5uVYgFpyo6i9iKj1fHsjYn777G+t6xROmIcGa4mBV4BjJt
	 Knw+UMu0iNxUw1586tsopjUkiqq9Mu+EOHviYy1AKogohXmD4gN9/0Zpyz2TstfBumq0D
	 C3TeEH+j/GZ0nUIU+FP2fw7AqO9pCjYqn+OV1H2GSxegEDLBWKXLLTtWPtbyBGCvAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z8DOh1NX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FKCCIqP8;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA441606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 23:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA441606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z8DOh1NX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FKCCIqP8
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F3909EC00F4
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:06:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 04 Nov 2026 18:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793833610; x=1793920010; bh=mpWDozVD3K
	QZqgQMWf22vZ93TXf3TETFEGvaaVUsD4I=; b=Z8DOh1NXCOtwmP/yU5x0OEyiP2
	Sy4IAWgDXQfhwULE7nzPVtpdj62zH3UaWz/4vbFqCtB+ZQ8177+j6ViAmV8MHMro
	1kDANQFdfA+JSiWBadmxraxlFf8KHy/KlRb+CUB5FIT5eWUvmg1qpB1WZn4pyKuP
	oanTw3lnMYAM39Psf00tKIzezFd82upeORueGthcZ9cto2HDtg4SokJjPLYtcrd7
	1+5ap1y4oT5dXJX8M5R8rVOo5PzqtsUOLWLPCBliYcCG15jJAiwi/VraOXf0cdnh
	3zRtuhtb/9YD95GeYBcyQfwRDGhzJkpKKg1J6LqlsFIAHYn8XPDx5JWe6LxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793833610; x=1793920010; bh=mpWDozVD3KQZqgQMWf22vZ93TXf3TETFEGv
	aaVUsD4I=; b=FKCCIqP8MEoCbOHYoRUedIbUQmHSloZMazdk4zgU9nBznxmebxQ
	BdDQZddQ63tXLJmQfURnXDw0PA59le0B8t1uI1ktKaKysNVyYp9fvy/JBIyfy+cR
	lUs49+oH4N6UT7g89CKeJc4YEEftlLAtrP4nz6EXcQ6Mjhao0B+6g+o8EdSI2hGd
	qTR/EIaJShXaa9jvUfkHe8jn3SdAwTjKsNHkDQ2Zxrh5QZbOIHnod/JUbPWff4vn
	i0wE8BVl5w0Sth36v4zWDC6h0pp+2fPZYfOlSbJ5UKHkRMtvFf2/20Y2/0QJJ1UH
	bnhytlLHpbfXLgG8n5dkhDJIQkSnjsMWDog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793833610; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WuLrgVo1ed8L8T0D+pnu7CcJQsn2eyxweO0joFq8Eu4Dyd4
	v0EKjg+5wf5h29hdnO9GeLC/2hXvgQiMvOxhoTpQf//UhX6iyCfQ2DPnLln/ayOL
	d+MegZhflcPT4TfqJRGsCvp8L+sGmptoUnc6O3tRaDgPAVCOTib8SdaiIq9xJIdh
	MGX698Kil0mI9mIKaMCJwb2sSiQC6l44iWg2tL2qNq7heRYdmVEwMTHart23Fi1b
	4Eh8iZzeQM+60R5jIdhSUpjHTobWTZ6lG08UB+GudPa115kOCVLOEEFljt67hnxF
	gOGOD1Pwx2tR0fAfG5w637zrJL3GvaLoEF/IMJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sUr81nYgZUcdtGFcKWN7VUMIHVMqIOlaRoXiepOvTe8=:zHqkScW1WZnQHbLFB09Xsg3OfuNwnCYakTtjynTjQSI=;
X-ME-Sender: <xms:irrraqHIQK3zC1Ud_iDCHtKvQxGsg9IBvE9_pB9FCMWvVl7b-Sqh3Q>
    <xme:irrraiwKFD0_nUwrPzu6ZwV-Osb7GUoWXJQRUaFCIjE77l2IjtRYgjyhiY56YTKs5
    aL-hft8zQFOXE5EkvBRZHa6GVVl9Qjp06D7McS_L6UJ72Ei8gngr4wO>
X-ME-Received: <xmr:irrrahjlub-Fn3D6tfr9enLCFgF0XGfbua8LHHzGCUXEYftNtiO7jmORLAx0kaIH6gTD1tr35ouBwNGeHhqTFo7IYIMripTEOz8P>
X-ME-Proxy-Cause: dmFkZTGFGyHYbXP15dX5S5FmvmmgNOLkTn5P0kgvKWYWhGwhs6A9IvJtXAcYakO/ONWmIF
    z+lAFClYHb7YibYfLTtrBwODoyLrfPDUs7z3xjqO4SJlyXqNvtmn5iJnT3dkxHF7vHDd2r
    W7RUVM5kH7li2tws2debyXFmIMqIPU608y1yF0ZFnywhZuXvQEfHec6IdlV37+bU95+ut2
    GKJGqejekxjifN8SLyuXUF5oJWp/aNYXTzuJ57DOaFnLN4jIHss21EPg/f/K5/XVXsxb+O
    s3nVN5kBOC85oWlrvLJK1I1WTkSZ2+5HDdix5olEpwHTXjWFcGTaQn3IGrDVF7SsSy46WV
    0rNNFVD1mwhRI2xjYWd46IoeX1JJd7bh3Outf9niYdVheW/XPndqU78/cSaNwSnVw7dTjr
    95NdlJeZYr09D8rysRACZqHr0BxZT9cLa6tjf/E+X7R7sbcjCIOMLTzK/kQ68WnQrgMJmS
    ECfTsAg4udzfveB8sEH/5l31IU688H9fpDiahE8sYPXJMVt0yH8s2Y8+jl0U0Ysx7v4j4S
    y6lJiomA+1KDCJPvbu2dNby7vVBu8Gv7OEuc6w4YrSe1DG2r63LG9gO3N+DQIv7xxccZf/
    +KYl5PHcA8iYdoLszc2Q3INQE2dV9OBVgfguOboJrcrxdGx9drDDD/T5KXgg
X-ME-Proxy: <xmx:irrratye5JDcMDd7w_EQLTvWwSExog4muXmLdMrhgxyIDOPinySTKA>
    <xmx:irrrakLHQr19jtCujiC7Qa6nIQPoPUMO4w5pJAHC_R6ld4XiK-PRHg>
    <xmx:irrrakSk3Yt7CDkWRvUSbMlHvh09W2RkzGoZsD_L4oOhmq_fmi9Rag>
    <xmx:irrrasoSd4P4gIS4LKjAIbyuURjSTGwSr-IHwDrt4cd-UujzidoutQ>
    <xmx:irrramyjN290rHLZ0DirGDa8UlO8Ctz-h6Yh4V80-qq6FjrmYcLnqIDw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:06:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
In-Reply-To: <20261103212410.1389988-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Nov 2026 15:24:10 -0600")
References: <20261103212410.1389988-1-jltobler@gmail.com>
	<20261103212410.1389988-3-jltobler@gmail.com>
Date: Wed, 04 Nov 2026 15:06:49 -0800
Message-ID: <xmqq8q38yz5i.fsf@gitster.g>
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

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/object-file.c b/object-file.c
> index a9800143bd..e04ce0bc11 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1429,8 +1429,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  	struct pack_header hdr;
>  	const char *hdr_err;
>  	int err_fd = opts->err_fd;
> -	int ret = -1;
> -	int status;
> +	int ret;
>  
>  	hdr_err = parse_pack_header(&hdr, pack_fd);
>  	if (hdr_err) {
> @@ -1462,12 +1461,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  		child.in = pack_fd;
>  		child.err = err_fd;
>  		child.git_cmd = 1;
> -		status = run_command(&child);
> -		if (status) {
> +		if (run_command(&child)) {
>  			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
>  			return -1;
>  		}

OK.  A slight simplication that does not change any behaviour.

>  	} else {
> +		int report_err;
> +
>  		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
>  		push_header_arg(&child.args, &hdr);
>  
> @@ -1487,24 +1487,24 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  		child.in = pack_fd;
>  		child.err = err_fd;
>  		child.git_cmd = 1;
> -		status = start_command(&child);
> -		if (status) {
> +		if (start_command(&child)) {
>  			strbuf_addstr(err_msg, "index-pack fork failed");
>  			return -1;
>  		}
>  
> -		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
> +		report_err = read_index_pack_report(repo, child.out, &pack_name, NULL);
>  
>  		close(child.out);
>  
> -		status = finish_command(&child);
> -		if (status) {
> +		if (finish_command(&child)) {
>  			strbuf_addstr(err_msg, "index-pack abnormal exit");
> +			ret = -1;
>  			goto out;
>  		}

OK.  A slight simplication that does not change any behaviour again.

> -		if (ret) {
> +		if (report_err) {
>  			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> +			ret = -1;
>  			goto out;
>  		}

I guess this also does not change a behaviour?  We used to relay the
error status returned by read_index_pack_report(), but now we force
the error code to an explicit -1.

Personally, I somehow find that the original "unless we positively
declare success, default to 'ret = -1', and if we may have detected
more specific error, return it back, and reset ret to 0 when we see
a success" easier to follow, but that may be subjective preference.

Will queue.  Thanks.
