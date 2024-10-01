Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F41BAEF8
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758711; cv=none; b=cmUiOQjMkJCh90LLfbja4Y/4Vv1ilt5Npq1Q8U/Fy9I3gsn1ul5B8gI9DwoJYk/hUogaMIWCiiAH/+oSi3aU/HyLzw0KmtDDW9Oy/3Xk72ZSB/ArgTCAWgh34W1Aj6g9KavQGkXPMcR7HdoLOfm6fVR+jX71Nxab4H7RYn+mP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758711; c=relaxed/simple;
	bh=iAo79yj5KPJxcjCdPGc2HCusU7xwWUeaFJSAyeYRlyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv1OmHqQQCzCk8S5jJ8A0hkIn6Z2YENOBGAR2qXji55fRBUGl3rOlcRWYXymcAQ/qkoiL1T3jEF1EUoro/vu3N3a3G4+W5sgn9Uw/sBjsc2gZduSaT+ZK8s1c/wuHhnqOjBgGXK1xnz+E2DBNuBkbqnBTAPjekpzvoaGA+byZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/eec3SI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/eec3SI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db54269325so3860881a12.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727758709; x=1728363509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PqChDf0lV9l6Ory90w8OBCtXErr2rFQXCL7fjKDaak=;
        b=C/eec3SIwBg0Y6UUQrpPI6H5kq1+rjiWouRcFhMJ4iD2mPJFYUSQeuf9/70hZQObiL
         PonU4Rjj7sjvDZnYPY6dNNGpgHv619qDM3Y3QFOxGI0brfIhbsmvVUYLd10ewrF/Sscg
         WG9ApHOV69G+5CXQr0arAakwiGi31hWpc+BgUgMSyQMn7HM1iHTodwjRAh6x7xUO05op
         fClP4EnWfichYhSRwNHgiGVlxP+DpUp/59YNzu+cDziccU50aB+y9i8hPxBRzmtuYB3v
         CwzsjyTSgKeQpQfwkLlX8LDFnra9dRgYODQR8gk+vK+HGjUL3clPr4v2NNE5DfOs157i
         DEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727758709; x=1728363509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqChDf0lV9l6Ory90w8OBCtXErr2rFQXCL7fjKDaak=;
        b=U18nr1AXzH/aHrb+G3xhFCEKr/asK3g3uT7+V3i05kJoD2l/WLHsbeDH9tCayAMuJJ
         9HZX+1h0Dx9s56rtf/vKXxvsQKixRx1sSO7uOTXx/Y25BIDgdtZP9G4htVS2NTdCh+5D
         5oh/XATivBJgk6w6gKbHMV2DA/H3QZkK0xpQKRXF7VRWvyduVxiI0K2cBvO1Zi+S4wxo
         w6D3KAIspPqHQroXfl5WvgMPoZwgiPNjLLxLQcv1AGY5hMU91DjarzGluVGgZdZjGeS+
         cIh57xZvBA0H/DtJvDWKflRNOUQE/LTFJnNM4xZ2DP1neLDIOfmvcUd6RYeSoLMxi6V6
         Amcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0/63uedL3jSVngqNcQwxuCmkfzE/g9fPejgkEAdWMDBfNmDuP4XEi+nOOGmNyLBiYB2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuKR9eYbP0/NdOuCqUpGbRVTK+4qT0BLsvmrmABpzBOB7gtteT
	zSSULg4T5ErLwa7vL5spmbSuxdT4VahZYXyo6/wqVJGtDNcehFy/
X-Google-Smtp-Source: AGHT+IFYv8t9+lgezje+vyiBObNJGAGnjrsFSkstZ5K0NOE8+vkqRd+G1/aoCh+ts4erAlXFylrr4Q==
X-Received: by 2002:a05:6a20:438e:b0:1d5:119b:3b2 with SMTP id adf61e73a8af0-1d5119b0b82mr11526430637.33.1727758709330;
        Mon, 30 Sep 2024 21:58:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2963dasm7427584a12.2.2024.09.30.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 21:58:28 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:58:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
Message-ID: <ZvuBduVg9TJeULpl@ArchLinux>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
 <xmqqy13852jk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy13852jk.fsf@gitster.g>

On Mon, Sep 30, 2024 at 01:06:55PM -0700, Junio C Hamano wrote:
> >  	/*
> > @@ -28,8 +27,8 @@ int cmd_apply(int argc,
> >  	 * is worth the effort.
> >  	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
> >  	 */
> > -	if (!the_hash_algo)
> > -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> > +	if (!repo->hash_algo)
> > +		repo_set_hash_algo(repo, GIT_HASH_SHA1);
> 
> ... is this use of "repo" still valid?  We now pass NULL, not
> the_repository, when a command with SETUP_GENTLY is asked to run
> outside a repository, no?  Shouldn't it detecting the case, and
> passing the pointer to a fallback object (perhaps the_repository)
> instead of repo?
> 

This is a bad usage. Although the "t1517: apply a patch outside
repository" should check the code, the uninitialized variable
"repo_exists" will cause "repo_exists ? repo : NULL" to always be
"repo" which hides the wrong usage of the "repo_exists".

By fetching the tree, I initialize the "repo_exists = 0" for the [PATCH
v2 1/4]. And there are many tests failed. Many builtins with
"RUN_SETUP_GENTLY" property or which could be converted to
"RUN_SETUP_GENTLY" property by ONLY "-h" parameter will fail
(segmentation fault). It's obvious that we use NULL pointer for "repo".

In my opinion, we should first think about how we handle the situation
where we run builtins outside of the repository. The most easiest way is
to pass the fallback object (aka "the_repository").

However, this seems a little strange. We are truly outside of the
repository but we really rely on the "struct repository *" to do many
operations. It's unrealistic to change so many interfaces which use the
"struct repository *". So, we should just use the fallback idea at
current.

Thanks,
Jialuo
