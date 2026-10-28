Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793159003;
	b=gkf0JvPlUU3aUijlpojScv7WawV6o4CK2kSuHPyzKBfeDZkc5u8Qy7NVHQtNvHnO7PYG
	 UzyQkRpd3sznfDF5rWllJAMfCIDstLLQ3svL0isyCoFOfRBDvzKLarV/utTXvj8pKngsx
	 Pi9mW+xp4FtprrYE8TY7BoUc89rsckXWb9LdnaTVAVYCrXQcaBWD9IQt8RNWUp3mrDIJg
	 KLHtXBYL/n1CZuqEqTE5lXCe4LfwBjwIYetR579l9iScJn/PKxC3ptVYnuuOnTlkcq1DU
	 cWnYHCs98coM92yV9V+zel7Jfmm+HukwY4vPYLSPPMTT7JzQcpYTRtQgGe7MgDTh6cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793159003;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oftkx14mRDg0I9xSHW/souiwCdUoQ61hHPLqWTm+uz4=;
	b=Y+KDHgOMK41OCTA1QY5pNK+tfMPQ3LZsVcmnEkryizdjL5yNQWCyJx68EF0+q0bUywgC
	 +HBLtdS9k6VIkk89n31SMD3h/KVlmHGNCrrlfBvBpgBv/mOljUAlIe2ualOzgxTWw/1c5
	 /1RJeCNjI0TORg747/9NxdEaAO3xy2nEQsjyTKuqEr6EPZUA5th7W03UDZFQavjR9/51V
	 FEzhbXhIfhduQeupc4CHIKVPBPszwSfEUoJ7R9WUN1y1+cGyg3KRsAN7Zbb2Iclyw3YWX
	 T058mXnlwxXkEEBZmbxF2nZLF+E2pxvZ66KZ+6MdXv0MbqNHCo8HLcwtETQo0ZY6aVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=S6IF9631;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SpPf9FMN;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AD606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=S6IF9631;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SpPf9FMN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29DD97A01AA
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 23:43:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 23:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793159001; x=1793245401; bh=oftkx14mRD
	g0I9xSHW/souiwCdUoQ61hHPLqWTm+uz4=; b=S6IF9631K5buMjW98L8hr7qZpg
	RRPmTbK0SitKloCXuwFkvSTs4Sty4lh+rdw2fsr50bw+cVBJPFcVOaT0IcACX3e0
	bOe5/EzMOeZumfjPzoNFIOkNWCmcLSX+0WaDXLHUA+VDKg5GXtLb3Z+9P7cetWCs
	YaeAlNPUv1AaOJGHuJGKD9+D/hBZOc+RFAauhCU0Az8YfF8RGpQW1c5OU1UOVCOr
	O+im3/pAOCF+Cqcpz/i6CMyzZLDsWbU9aKR+J37neMtubQ4t9PzTWWH+SQGq794j
	PuTFOYTRjIQQXcV1J6K7YxtOzrSKedNJ6zqWmzVgyTUqGu8qaPsXkhcbI5uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793159001; x=1793245401; bh=oftkx14mRDg0I9xSHW/souiwCdUoQ61hHPL
	qWTm+uz4=; b=SpPf9FMNN6eNmQgIG3IrjzZ+MRflLMHI26TKxyTz3kn9k02CIT3
	WwUeDbDtvMoYbhKo82RLktp/lWK/Kz4CZ0D+lK9F1GgnoE8/kFAKWnnXzJMUkkb7
	26oAM26dp5OjSHRDbn/+DeTLvFoRqBpcc9xJyeu02mXOAugklp5F257n+fVszfkA
	A3v1g/k5Wk8PnNuIUvp1g2p/qbOO++1muVJVqgf5IDqVC6qxhRWIccv9xzfd9D7O
	6PkFywCG0iIrK2gDuMlyvEwTPzlZVN8dyCR/yRGwioN3McvgnCBdS1E6Rq9lXThd
	Lxt9MNAx9DJmEaNjcJ+pPi/1MCykK/6MUmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793159001; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LiNlOD4Vgne5Sf4kphstNPvOeqxXsbyxw2CMGMOBgjSIA6b
	jwi6ZbUS480x6CQSMPVbFRSJaupGIvTYW4XdQZWDTzl0jwNVwsjFhD8T2IgAVelh
	+MxjG64tD7yNZezraKB5pJOgGCKPmt1QgvGSZjeiv87pk1wnMU3gGE7ni6cPKfjG
	1PrksT1Tk9eiOBLb64IzvxDwTJvEDcjLjMfAKHwC8SzVl+mKivF3nf49beFUtPjz
	E30ohFI5+U3WD2bPPjEc63XiE6HLyrcuHVrJDxAzDHs1dKQ9irf3g13qPmzTYbIr
	+5o4CxuFcfZglgsZ7mo8mUzQfQ01kFpCzRsBUJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ijRDS37jt6x0w8n7IkF1URros6JYhkkFD5Tfo0oPc8s=:3sLVneE5h3ythlO9rPSz83h3b7HzuCVJ5BFk+4e0t4o=;
X-ME-Sender: <xms:WW_haqQIuh9NrC2P6UZWAekpPwT2zLLHYWIQetxy7bfP_Qjsr7ARUg>
    <xme:WW_hamzGVzjIIdF_auMt9nFIHDkFG3IR4TcYBhy0yFo40kn0s1VyrkWciqBPxu7BV
    d0KPvyQyeE3wiOo1LsSnJ5AFHVSV9EPfbEFH_CDB0ABcqODSRJ0Pw0>
X-ME-Received: <xmr:WW_has2RHtsh9iVw5NCMYpiPEMOHDdA7AvZp-oJwc8sDvX_vPx9pnEPx9QAhrF2ufFpO8hzrkHVrj8tXSljqWiipjjRzY4bX0Nid>
X-ME-Proxy-Cause: dmFkZTGNaWNdLhGuL+pvuv70ctq2Of/MIk2RUEoXtg+Ca+vsSWx8y7YZ+BJRHjdzaCxLLn
    aHpw403FyyttrTLqJC7h03m1x+kj/IaRxFQvXeil1BK3yw7FK6uic2CvFfTvok/ctE9wMu
    rTgl4xdIJNska2RzHHpFc8a05d89Hg2KMKRHsKmUJKiwyGkGg8yYcgBGSydg5/rxviNY/t
    UB8K/dPhoevMgMuNbTotUarL9K1BkdcjSn+nFp298AebuXYbtxBrf+riZdtYLllWjhdpMQ
    9mNitB1Y48A3NwRkqmEaOh3x1Xx5YKALHb/eIJKkgWxJyFcEFa9v7BBdU/QqkDXjN3NqH2
    SVgIU+Km85GRXLi6IPPSIR19n91wseucOYgSeCj998ExqI6GicOe44tZFi0qUrB3iMcZ0w
    KghVgTGzu+n+8Q1cwT3gB8evTRH0OPvQS/pXtcIBoMO3WxOvwvYGCzeVSM1DtilgL0IzjA
    PKaxyeIxVTurm4SQwbQXRDAWnoeRSDHphgqzL2HHWPnacMLW8t0+hyPqsHbtk4qIbLt3D7
    YukiYqtq4fCN8SF0HEh9rWjeG6AFjhbO0dVs+UBnbKEy5GDTEiUCPN9Q43DUrrK7iI+vrn
    t3P9QhYzGJWlp9Cq3zX+RcVPXwWFrSLodrW9fDIojYQDlzmloWoUOJh7uQjw
X-ME-Proxy: <xmx:WW_hak5QHstWlKYuqQ1-W1bCqUVFTJuKQjgi1IKzc1adOSzmUJ57yQ>
    <xmx:WW_havV6NxE4W8ubUbe---pV4YN21cYjbc-TJkfFXiXOhfsZHrJTWA>
    <xmx:WW_hajDGiUt5Ezm_zX1Cchq7r_Rlf3zsTnmVfLeqMz3oePxNkNIcdQ>
    <xmx:WW_hau6V480HSCRXIp0kGGeeNcskWU_CZ-9YlB8RFq5HKbrKv7oE_g>
    <xmx:WW_hapirSZcTmCQgHYrIqKCLFQ4hGozoxWNYlgfWEgHwFNtNMV5qd-to>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 23:43:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t/t1467-refs-rename: Use test_must_fail in place of NOT
 operator
In-Reply-To: <20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com>
	(Hardik Kumar's message of "Wed, 28 Oct 2026 00:18:43 +0530")
References: <20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com>
Date: Tue, 27 Oct 2026 20:43:20 -0700
Message-ID: <xmqqld7iebhj.fsf@gitster.g>
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

Hardik Kumar <hardikxk@gmail.com> writes:

> All tests in `t/t1467-refs-rename.sh` use test_must_fail for verifying
> when a test or command is expected to fail. `test_must_fail` is used for
> all Git commands.

"all Git commands" that are expected to fail, right?

For two "git" commands that appear immediately before the line you
touched in the patch, test_must_fail is not used ;-)

> The use of the NOT operator is replaced with `test_must_fail` to ensure
> consistency in the unit tests without any functional changes to the
> tests themselves.

A more common way for our proposed commit log message phrase the
above is

	Replace the "not" (!) operator with `test_must_fail` to ...

More importantly, the use of test_must_fail is *NOT* about
consistency.  The most important reason why it is the better way to
write than "! git refs rename ..." is that test_must_fail notices
and fails loudly if the command line getting tested does not fail in
a graceful way.  If somebody tries to update the "git refs" command,
introduces a bug and makes it segfault when 

	git refs rename refs/heads/symref refs/heads/renamed

is run, the command line prefixed with '!' will happily say "ah, the
command crashed and did not succeed, and I am happy", but that is
not the kind of failing that we want to be happy with.  If you
prefix the command line with test_must_fail, however, test_must_fail
would still fail when the "git refs rename" died with segfault or
otherwise killed by a signal.

Thanks.


> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  t/t1467-refs-rename.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1467-refs-rename.sh b/t/t1467-refs-rename.sh
> index 2b28be75c8..b7d290d05b 100755
> --- a/t/t1467-refs-rename.sh
> +++ b/t/t1467-refs-rename.sh
> @@ -88,7 +88,7 @@ test_expect_success 'rename with symbolic ref fails' '
>  		A=$(git rev-parse A) &&
>  		git refs create refs/heads/target $A &&
>  		git symbolic-ref refs/heads/symref refs/heads/target &&
> -		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
> +		test_must_fail git refs rename refs/heads/symref refs/heads/renamed 2>err &&
>  		test_grep "is a symbolic ref, .* not supported" err
>  	)
>  '
>
> ---
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
> change-id: 20261028-refs-rename-test-fail-ec7a8fa74e54
