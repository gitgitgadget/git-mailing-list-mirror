Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795112834;
	b=salr5gXNJ4iD78Cd9u/XhdnhPQL9w3QGB+j90ft5KhZAoAdB2RQpoRbvDxMHXDPKCNP/
	 Dl40pcQrKygyXfj44DGzfKn1MFhOdFK6H/BFbqF9Eb98foP3El3IFDcbMVxXYaCYIxGYP
	 PpwfMPPasdrAyQyiK9ptvQAArZCDVx0TwypszIQcQ2aWUCymaNbvF3qNn+O4yvG7r4tiW
	 5e6l9bLmWvLGtL80G8qxLkF7GjvgGlKF6zBZK/Q9ZIGWYSGY4tqdN1EQaSxGEsUvCPANM
	 KTv+CeYRpETBXBI5540seaNO2STtYshpo7gfXAojNyrmPpVwRYkClYV3D7aGNeQEGWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795112834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VAsa4lta98+3tissfpMDUdT1YfRaLFW8L92UB+M2cSI=;
	b=EsKoB2DYwKQUAjICvAfXXBh7vvoWqjUPEdVPDlP2FlWSaabOB7VDY+o+lkm2ed1gWptX
	 ZU+IyV1oc/YKgvXsnXlX9r577G8Skg+QWskmA89ShJxfZ345HSG92iF0jg5G068hI7iov
	 JYijaOz2olQ/t1Ez4zFcJMyvtCiewQbQ7HGNl+YmHd3Z521VPo4+5VekW/sUTGu9T7QMX
	 KsaaKL+4NCN5KAS9XZs3hTyC57wFw2fWVmQToV+Rd8uQ2tItYYxQmrK7GOGb3BSw4ylxK
	 asfLhcHU/X8zkCHUAB9fsyrHchNkEr5U4kAE/OSQ8akRw2jkHLhCpUGbavioK1+OxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6D5azaC;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E768606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 18:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E768606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6D5azaC
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2530a12.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795112833; x=1795717633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAsa4lta98+3tissfpMDUdT1YfRaLFW8L92UB+M2cSI=;
        b=l6D5azaC8AA5u6uczy6cpfRagYR2Emo5izw0PH7Y8pl9sAcYuavGRSYBTQZEmOF+wi
         ufdX89RiALpLgIAfqVtvoDklBOxbV0QHC1VYqmlUpShQ1dCVSEss3NlpYq3ph6N37TpD
         cipIWUm3zatTdmogKC1PhiyisVYy5IF6gZWFsBFZsK2iqtlqcpiTf1p3OG/IvU/0dsSP
         Dt+9/PoP4cnlIRQ4PXCgtk+gp/ih67GcHJm1xL31LtBBosIYdhRJ3w0U3N5/BUlGGJYl
         n7un2ecNcxe3xSUEZSs31eEuFvtMARrMRE+K8QCedcyvDT6mD4PpoGfHtMJ9RTkmOF0X
         TIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795112833; x=1795717633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAsa4lta98+3tissfpMDUdT1YfRaLFW8L92UB+M2cSI=;
        b=vaW10vyyZonNQmAWhzCagCB57/4BDrYBfTH9POBE3FPzfteixmKsZ0OWgne9geWP6s
         ZvB/Es8o+oyi+8DOYS2HrpQgif9daox/GfMIBnhJyJt9z4ZmWkO0Cg8UeGzAMKemhnj3
         tf4/VaqnDNZ7RU2A5v8dQLOl0MvSUus68jC5T+YUiaNJJXsVzWg6od/3xuKdT51o3xlk
         FbHofRFTAkD0oeqMy6W5s5iMtCR4Euyi0POxvzri9ebw55nfiOnSheAEfOYgeRXA/ODN
         CDpV2V3KHgzl1nWG32JAaIZBUGCawdPBua2SzoiBDNgdAQMuR1Z55hTB9M2KZDNs3HOE
         dpzA==
X-Forwarded-Encrypted: i=1; AL+hErGt7vjl2nb3X0PKM0nybrFeXDZiVcCU5/ABOiHQ4UBmolqRXXRHrk9tzUmdfDwLzmmrktE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kjdgLvS6eqqubzCyofR8lHeffzN0SOy4107YjHj3s3Pl+2NNG
	Mc+t1oRw6+KjIK8CkNqXOHx4v57O6l3g6uMhmhea/VcEfA5VzRx7DXW0
X-Gm-Gg: AZFdTZcA60IE1a5UaHQniEvlql9islTVV8DNo7uYaThVMGJ2aOLSirZm2B71OodLrvF
	bntRkfim8ZZT37Sa6D1GgHShJ3P7rNzV6YnF3VPHlA8oKv5WftNcdu4ozwnuc5oHMc/EhtqmAL1
	pGMyPFwD8I+lfwLJbn+GOSQZD5lTUrSfAkaAGGcEExkwGHrDWL2C5JFMLKOLP/Ks9N6DQDE+8jk
	a+T8FKDa4Hm4oya1Y14WFp4ndRR678UWXDSJ1sEWiZoKq1n2YEsbZ6gqNbD+aBVBRj912PhdSDG
	Gc6LAG/xRALAHO5ry9XDsmWVEMad3Xg47Kd+bKrcyEqog3qn3ybvawuTjsNvqjv1CP8WS2Xer6U
	X+Rgh0GnGiEiR1C511lS/js/lRG0xtQpVPoFLVj/SlMB2umXjbdChilwpmIkAsTA3PJ7cCfxe+a
	sPz/eTvBY1cryX9K+JjyCshGD+B3nR5h8sJFFULg6qJpaxVFDkpMjjSYx95z+BEXhDrIvJKFNW4
	D9g3RksKheR+i6GpVJFneB0DUVx6ybR8HheHV+oXmNJobFT6YozbhFH1KPuVUNKITfz553LHNww
	0rwNLWLUCvAoxfrlYLTv5ctjGkwdi/8H0+5SiPx4
X-Received: by 2002:a17:90b:3cc7:b0:3b3:c6b1:2277 with SMTP id 98e67ed59e1d1-3b41c93cdc8mr126198a91.32.1795112833373;
        Thu, 19 Nov 2026 10:27:13 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm469084a91.4.2026.11.19.10.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 10:27:13 -0800 (PST)
Message-ID: <a9916667-f53b-4611-892a-047728c22f53@gmail.com>
Date: Thu, 19 Nov 2026 23:57:10 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] t9300: make the series S tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-4-b8c3a0ab27e8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-4-b8c3a0ab27e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 23:04, Karthik Nayak wrote:
> Similar to the previous commits, modify the tests in 'series S' to make
> them independent of state from previous tests.
> 
> Replace the 'S: initialize for S tests' test with a
> 'setup_marks_repo()' function, so each test can invoke it to setup its
> own repo and tear it down when the test completes.
> 
> 'S: from with garbage after mark must fail' used to create the 'S2'
> commit which 'S: merge with garbage after mark must fail' needs. Create
> that commit in the merge test instead.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   t/t9300-fast-import.sh | 332 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 198 insertions(+), 134 deletions(-)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index a0e322b866..f9359bbaf3 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3100,10 +3100,12 @@ test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
>   #
>   #   invalid dataref ..
>   #
> -test_expect_success 'S: initialize for S tests' '
> +setup_marks_repo () {
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
>   	test_tick &&
>   
> -	cat >input <<-INPUT_END &&
> +	cat >repo/input <<-INPUT_END &&
>   	commit refs/heads/S
>   	mark :301
>   	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> @@ -3140,142 +3142,168 @@ test_expect_success 'S: initialize for S tests' '
>   	BLOB
>   	INPUT_END
>   
> -	git fast-import --export-marks=marks <input
> -'
> +	git -C repo fast-import --export-marks=marks <repo/input
> +}
>   

Ok. So, the setup needed for the 'S' series is a bit more involved and 
it was done once initially before all tests. So, turning this into a 
function and calling it from every place that needs it makes sense.

The rest of the patch looks good just as the commit describes it to be.

-- 
Sivaraam

