Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCC3A3E84
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412910; cv=none; b=ox68/GNkn2x4KSaRHe88CLz0YwCcxse5J8WzFkm9PR0PlZPRDvZsyzZWm7CrEE+gCqRxjAoZlrlWmLgpUA5Jc/Fp16XJNYOLFXL+6Rejo8J4DWgYr4UWEygMEbqiVy2M8+Q3sEnXklyx6kFTnN9qrZif5vWlyNAYmASGAWj90ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412910; c=relaxed/simple;
	bh=GmoaPRuXSJFj8sKS23Ub7upUJPDqMS4plnWIpUe8zb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BH783/cgvGgdUpeFJtX9/1EaE1GwIFrfyxWkxr5ikVdkjdm6FrODKtdmkAq8U0Z6HBM9db4cWgg+/3xVsN9MH0GB//S1lMXg/d5dJFFZMUjbHPzUATeCJjRvDjZpH9QjlJxncjRo3EiFI9wQaR/d6vfSJyOrKEvygG07fMmrg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXOeLeNh; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXOeLeNh"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso2596671eec.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773412909; x=1774017709; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tdtrR9Nm0Yxt2lAIOAXrxJh2IpiM3T2Kmw2YL0No2k=;
        b=VXOeLeNhbNbdLA0R7BnE/9YwMjP4o7WyJTmr2ga9Ed8W1gASs4DLqsFl/gSdmmljQ2
         3X+pEugjlgeNiOttHmMjbz4kDI1YmQQ2Z6jnABuWbAT3WI9+s7VyikF16SCK82kGYL1j
         NId9kNK3Lslh1aywmTym0dIb+svSR8fCINYWTAP2dg/4LDkGeaP5Zfa7USJrkpGZcDsK
         vLcm/ABGz9uKLFDhZpyd3R3i3IEjNhwcRpVVaVupuNed9yEpWgLhi64xarkTPK39X7Dg
         kaQ4KtUjknNTBhKkx2r1acna3+sA2SnNJwCXJEMFzblE5F/Pg6rlq21bMDvwp9aLb6ol
         yR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412909; x=1774017709;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tdtrR9Nm0Yxt2lAIOAXrxJh2IpiM3T2Kmw2YL0No2k=;
        b=hwDiLvRN4go+lyjC3dlu3yyb8mij+6WtWRELWZQ4cMXMz8ck6XIHHsak7JBx+zq5LM
         ZZInj23YVd4VjPhA6CPPSMA99W1gGEw+IZGzc1q4cqBNNphqY5WIEBc1vQ7MW3EdFhKa
         0/mp6q7XfVYS0d8ai7W3MBFFSPdz7pcESwMTSlvcXH6JxHd24wfsNqdpEoKJUYN0kjUL
         7rHHnHwrKI7CqV6GyFdziwrnI52NQ1I/DJeotjdsC0HVH/6VMld40m/gfvy2EgeYlY02
         0pAEMeSLTrNPKnLOlX1zpCY4Xpf4yEg6W+0Ol5tagL5eU3W30ARZlncY9m0Rno7ZI/NS
         p0ew==
X-Gm-Message-State: AOJu0YyzYtEIMOATEbwTpkBLsfHbxo/Gk4K/9m6KXe4TglbqDNTUkQfh
	XvDRDcfUomua+o5UJTrTDCRibQFeG5tEKnKz0GN0/0qToLVbreSq7n3dz7z1/A==
X-Gm-Gg: ATEYQzw5SRVR9OYQgBHqpgW8SBnrmbJF+A5w7TmEixbsYBgTy/mec92D+zDXN4hW+w8
	mdKYCOIR7qGPtkZ5vVWLYttoKheMXpEzRIUdAPz4VPDnixsBURia4xNsWvpRXyFKYjK5SmiTkq7
	/9YFR8AwMC7Jkcq2tsA/Qy5aFGI9Y9aQ8v63+FQ28VIVd7mcFUWK6VtruFNU5qWsegiGdTB7fS8
	uvV/V/HpdQaMeYP7saQyxJ3mcPxjdbu7wkOfyulMbqVMQVL5thZHODtQKiYUzPoOAtlla/B8fjO
	3kkupTNqITj7JVNLyQ4pLRRiVaOrwjTVcLiEdsozFHi96EBGbnhkPl1/OkHXqS/LqAnF8Q3ZGpl
	DKLMHPcdSnZ8D94BWUrRiVah4SLhBGNPC/GNBpCcGFWeFt5R6TlFdUw19Wc/8VD1nsFH7EBSFU+
	p3XbYEem2OGCXrT35BDG/2Te52EWBHsRmdY2rHhi9hK3X1f7b58SKm0fsXuwyyZ3HnlmA+TAmWR
	vGGnWDrWtg=
X-Received: by 2002:a05:7300:a287:b0:2be:8216:57cb with SMTP id 5a478bee46e88-2bea55e9f0dmr1484078eec.29.1773412908367;
        Fri, 13 Mar 2026 07:41:48 -0700 (PDT)
Received: from XTHCYRY1WD-Collin-Funk (c-73-93-224-2.hsd1.ca.comcast.net. [73.93.224.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm3230347eec.19.2026.03.13.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:41:47 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: aum2357 <ahambrahmasmi2357@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
In-Reply-To: <20260313133937.562603-1-ahambrahmasmi2357@gmail.com> (aum's
	message of "Fri, 13 Mar 2026 19:09:37 +0530")
References: <20260313133937.562603-1-ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 07:41:46 -0700
Message-ID: <m1fr63zt91.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

aum2357 <ahambrahmasmi2357@gmail.com> writes:

> diff: use conventional comparison order
>
> Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
> to follow the common coding style where variables appear on the
> left side of comparisons.
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 0ee21692c2..ad0d6047af 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -432,7 +432,7 @@ int cmd_add(int argc,
>  	argc--;
>  	argv++;
>  
> -	if (0 <= addremove_explicit)
> +	if ( addremove_explicit >= 0 )
>  		addremove = addremove_explicit;
>  	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
>  		addremove = 0; /* "-u" was given but not "-A" */

See a previous thread on this topic [1].

We have a dead link in the Coreutils README-hacking that is likely to
that thread. We also generally prefer the previous ordering there.

Collin

[1] https://public-inbox.org/git/7vekbwru6x.fsf@assigned-by-dhcp.cox.net/
