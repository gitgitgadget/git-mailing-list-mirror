Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297090;
	b=K8pIJByvkz12xWtQWr1CnNQfkuPu72OF7ScFPXRK9PSD4VNrTaQqdn9DqIAJsZQbWvoA
	 yfiM2C4hXIDoanIX95YmHvLSfj4Z+76mMgDsH7PgnNiWcxDhUJHMQIPIF4+5RMLKCDy/Z
	 Iv8OOopfIWfBD0RRw8k+i+6Jd9S12EbJCGrvYRBllBodQpj+7Vxm+qD0mLEnOTU52btH9
	 bBE8v6nIfAxNQu17pNmiiZhlA2MY1Glzumr8jNXpZpI17YkSJCAXdB8OMYgLcCHd97G18
	 QdN6XcbhkYYtDgiXBpOHswtSB0hLZCEqwDkc9ex4c4NfdFFvQqaMg4zC1mwzS9AjjUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297090;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WawNCux7rD2Qmdl+fOi7pHlnpmxM4bZExOFfkyGGIwU=;
	b=0XzRaQevBdqaci0hg9Wt6dS/dDfvpvGIMB+qlRsQ0A4NDKj4senzwHV+PHOWxl0zA3eD
	 S1iSCspJS2YkU+H/JkACe6ATZAbuEHZilAPqn9h0baLkfzHIArWhDKHtnPtI3BIvE0hDL
	 8npXUzru8f90mlFLE4IdH7jsOzsE2zG/2fLm79nIiPrm+1noCiy8iCjDGklaxFEP9KZUU
	 cTsLtEphkK7x9X83xE3AiYOaK3lqXb5qUELs3wtFfs6Z9l44xU6NHRqrpRtLiQPpQVGgN
	 5ePd2Ro1hOwcpG+LPV2Y8S0EPHCHfXTicF8toIQco/8doLq15nDTwyhNHYa4/aFm96g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nb38x2oy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cBZOrxTZ;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0F606A320
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nb38x2oy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cBZOrxTZ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D20F7A00D9
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:04:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 14:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793297088; x=1793383488; bh=WawNCux7rD
	2Qmdl+fOi7pHlnpmxM4bZExOFfkyGGIwU=; b=nb38x2oytSZQEe8YR+GtHkP4OW
	Oh+7qozESTpTTzhbE+P7un91j7C+15ji/amnSdqw6YccB4svEHPGnbt65LsLMETg
	fhavqLKAD7NVN9DOT/tZZ3b+c5wqz6QYAWkaeKNTXAtxoujm3YXJMEyxMcAs7GP1
	k6EJytHI743UMPngzB+62FAv5olG6wJ1Yk4jrEHhRsCewz+xjjG6VhSxorCp+7Ka
	94fefcpLmzMOBzE5y7Jxy4lubJu1eVwbiYSyWfasAGb2waHGT1avs7Ndwu0H5t8m
	apOn6ynP9uCE5WZV9lMBF+/l9esVE4J+LBynaTaMf4txxRztqC2JxvqEAUsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793297088; x=1793383488; bh=WawNCux7rD2Qmdl+fOi7pHlnpmxM4bZExOF
	fkyGGIwU=; b=cBZOrxTZNLF0boxb/RL6sxNR1bqANjAZz/FG3KDOgyIGm+4Qvy+
	6rdBqj8clUDu82hVrHCiFzxfprvdKRql8u3bmvjMmkGDea+qV0S0rJLqc5WczOLw
	ub0wXh7z1jub8TRYgD1qtenZktYiEq2JubFWwQIBGUWnkmsDnx3409qsU/QZ6s91
	bedInMbDx8GTsoplROWWqPMOFUoizKs4jC5e2jdLmNEqG1GL2Sxx5WrzQC5UdYz8
	mhzHGT23mhxdJvyRdAvaWxHBxg7KItSFvRJe7uYzEbEadHkcv2PjSz3gXpmnCBV4
	yKkzUpkdm81VQb+v19yeBmWz+CABGNxPcQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793297088; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:X1HSCiW8yHP0uMfO7Okd6RhoJ7ZaUWWfVXVMFjSys1GgdoE
	69mJykW2uwL5hAjxZgIP+TRyJaGB8Wwa4WVVOoQh+og07QdSRdmWCQ0enyybZlSr
	HYws9YCwFudmQJDQvP8U8WGUZbjeL8jpvrmGaq77S/AJfonYEcxnbcaDmPYxiVKe
	NMQBbuCd3i7c6PlywvPkK7j2KfC3uj/vP4TOh0h21fPlQVA79QCCTTlNiiBJ50zr
	kYWiNu6uEoFPBGV0Z4ZFfQO+qV7qAAqhGfBxpAd7dXyWWk8bfF6MhuAfn8hMag3t
	efrah0EM/FtyupLn/8DCGWROBEePI+IjNQEd0DQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nUwSbYvmDFz3D5NMGz2nde5TFnXSPH6jvM4n0gAzRT8=:Nzz7r/kDJktgFInWPgwqoF4QPEVpEVpjKVDryb8wx6Y=;
X-ME-Sender: <xms:v4rjappxNnfbWkDYsGlHgk56aT4K0m9_s_FfPDtsochm9Cz7C1Stzw>
    <xme:v4rjaqu1n4A_xSwhme6Lv52uWnb4DZmSNSSjtEQ2unyGEb1s0_Uyu6ldk-DeY4TtL
    5VfxWKyyoqBiq9q1VnAAA-LEPlPZXNeONqqWV-UQ_eHlrse5KniigM>
X-ME-Received: <xmr:v4rjasa5aJhq8pJrexhCUCflMfmCa3N-_NoKUi-QxEwLB2upZ0fxNmh85CBFQToefg808yX6E6odJPCWY5hk5Y_uRgiJZ8nIQhPS>
X-ME-Proxy-Cause: dmFkZTG0ySFib1honLMyjkqwncLRsK66abml6VsbsAgty4Iv8yE7+Daw8LqMJW+SWll5UX
    7xzlqfeAenBijvLJkwbiAM74cApkXnt7LRXAOhYLhaeb0/uLJ8JodD3N913C+/FnNyt3/S
    K5pEK7DGzu54xwCdIgy/7LMIgcEoUB0/PYWgGtyDflGgcHSHY6+8Jqq8x+SY7+WRDtuD0k
    HMFne4VbO+T54PsPOrjf50Im3GVHEIOempnTxB150EoJufHp9EZ5jp8rp/Lo2WvKrXdh+3
    qJEnJFB2ENAGA3oueDZDgJBOCLy0kEXWAhNJthbu+yKRBYpIDFMGL/IXHjyu/O9ZdvJ8JZ
    bOCcbZD9nZqPWJEDZ6jMuObF7CG2A2W4QxVYsuIfkjUY1tM/4YLeVr4cKzcbf5GT2hkkwm
    CR2Egz/RRvNgdKoTIxg6nC8f5vf/zWt5y0dgPkxDDHFWiFfnkRwEuazp9W55Z7msauhRp6
    Q41YBjBTiNRl6mYR+QjXbndLOcPXtSCGsuPU8aTVl69tJRNSye+HaHASehKmFgHQGX68B6
    mOr+GXOZKlJksMfNqixsw8J/Br00C287qi03AFttg1yW999YNIHuIs/JCZHwx1/77br0cF
    H5RUIZ4b6RiCsby2MUzUTmSJi6PXlTBqMDNCMUQD47qxbb7m8GjYF+9DzCwQ
X-ME-Proxy: <xmx:v4rjahYb8GavGFvXzfoeRd2DxGCOw1RcAmXXSPoVJ9bNT3nnW7V6YQ>
    <xmx:v4rjatnaF8FtzKr6tH8in6cNVj8RXvaC2mdz_ShSid4K-lLg7f2GsQ>
    <xmx:v4rjak0ii3T9wH39rK4zc01n-P0r8L_Be4Yu2IQcUKFVEiTuizn0GQ>
    <xmx:v4rjal0ZzofZ1pC83qcAyeaoJeoH3jbYhhmdxXfhhLz8TQM57GebUQ>
    <xmx:wIrjagGXA_OJwlsF0u-AM2HzlcNF7EhfrtxXV4n-5ggtGhuA7WfTU2Xb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:04:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v2 1/2] fast-import: handle
 --git-completion-helper before reading input
In-Reply-To: <20261029012616.139783-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Thu, 29 Oct 2026 04:26:15 +0300")
References: <20261024052449.95869-1-tangajoris@gmail.com>
	<20261029012616.139783-1-tangajoris@gmail.com>
Date: Thu, 29 Oct 2026 11:04:46 -0700
Message-ID: <xmqqy0bg2xj5.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 9db3f83eea..f53113d5a5 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -4204,6 +4204,10 @@ int cmd_fast_import(int argc,
>  	};
>  
>  	show_usage_with_options_if_asked(argc, argv, fast_import_usage, fast_import_options);
> +	if (argc == 2 && (!strcmp(argv[1], "--git-completion-helper") ||
> +			  !strcmp(argv[1], "--git-completion-helper-all")))
> +		parse_options(argc, argv, prefix, fast_import_options,
> +			      fast_import_usage, 0);
>  
>  	fast_import_state_init(&state, argc, argv, prefix, fast_import_options);

It is way too ugly to target this so specifically.

I wonder if we can teach show_usage_with_options_if_asked() to do
this?  With this, and the above reverted, the new test added to
t9300 in this patch seems to pass.

 parse-options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/parse-options.c w/parse-options.c
index 283a0f1dc2..f2a23b79a4 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -1536,6 +1536,12 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
 			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper")) {
+			show_gitcomp(opts, 0);
+			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
+			show_gitcomp(opts, 1);
+			exit(0);
 		}
 	}
 }
