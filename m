Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51363185B52
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609061; cv=none; b=d+1x87Qz8uumkMW6jlRvRGwaAgjn6fZLYahXTBFEe9c3e/oszdZZCb/0DDQ/or3oZcPN6+I4IJQtLOpG834BSG05KNBxejaPAWe8ROmX/gxxbTG5+af/cHPoav2H/SRcgS3A2tu9HgL5qec5hySMecxgjBlCeN5Sl4f9kxoakWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609061; c=relaxed/simple;
	bh=Gr8e0FBLkEsAnYaJrdachtuoUpbhVs/mFN6zf2zsw5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUyHOnTrVzwY9D8u2yd9U9Bu3GXiTGoyagGJDyb9nP/4hZhQ8RVjC42zZYiahrgVulYeoD9zJIInuDyXNNfFB/iWL3IWTwFFdn/ZigODtIymvvX8Zv+DptMTyWIeBSK4Uk1e87XIUMQTZaRxmvntfoS7Q+S+LSfY3o7TX4n+vFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYkxvc4q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYkxvc4q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2077b48cb09so66065ad.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726609058; x=1727213858; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MHHR01ohroGZSGBSLoBNtsemdFrkJoSxp91nxePwD0=;
        b=pYkxvc4qmlLL/MHGAzA7NEW8VHVy7BtV8vB5dxaSz44RVooT243K2L0Zzl1s4/fweG
         4m6ssAI6d2NWmQrdYOUoff2iGpJKtocioIz2hboF14t8xVvPCc9b0AWWMyJz76huIMSW
         OIh0Ot/Xv2EQwh3vy19RfhPeSTmAItfC+R1Mc4Xdn1ebFQBx/socFWc50iB+fxFIS5qo
         KNpvKnXLd/NTpg5fOBbdVFlHoVTfA6GwfVMpPGkQXiu8mrIxkRc7HbUk+UJr8Zj2rJyK
         4upDiHSPNfWP8i5UbOsMJ94quK8VmU6WEK2ZlZ5lGqme2zOa91TPxLCxbMjgmYRX9c/9
         KKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726609058; x=1727213858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MHHR01ohroGZSGBSLoBNtsemdFrkJoSxp91nxePwD0=;
        b=w1oaoShI7bom2UGy/ylOsv4O+bYfzRznJ2A7QOznjQ+N1RC/9rP1+ih4EUcA5hAYj5
         OFz1bfaJDx/vd+T+/EwEXNoDt+gbCNvzoyDhYJFOlfR2fjWO56XvqoIdZT7RUXiRi/qb
         v2NFif2W7rXelsOz4w/WfA0Q0E/bQxS76q5HseVmRRZcjhpjUXINVXFDP2Qs39vS5Yfv
         tD396TOjdCnvOfJBimDoFl4BgPVJGBe9dzJijCzGse75OObxdppqpErwhgCQk2snmg4m
         VwKZ1irkhpM3YoP8CjCAem29zdmRG7uhSmwjtfmUkmc2KrFMl9oo47HO+rG16ZDSk0Xk
         a9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUvjV+RnhuZx0ja3Zjl38G1FjF5d4lAurEAOQ7MBH1vD7tf762RH3oDqS2FPLGMETIvOMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmd+/GN7UnxrFCzxKuwg7cZgslUrx+SYIXcsOCRpf6LHhEDw9
	cCVtTegMa24EJY4Gvf7ggJvZFKqqv492pVYWqxx1FYvFkLV46dfZaaEhdWyGMQ==
X-Google-Smtp-Source: AGHT+IHTLxNjT3hkg2XCcrIA6Pg/9WMwt8K2ai/K34c47TKEuDDqoJ51MQH/3Jn5Awi3JjOrrq46qw==
X-Received: by 2002:a17:903:2447:b0:205:7b04:ddf0 with SMTP id d9443c01a7336-208c3bd7aa1mr269145ad.13.1726609058295;
        Tue, 17 Sep 2024 14:37:38 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c551:a3ba:4741:7226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c87952sm10047341a91.21.2024.09.17.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 14:37:37 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:37:32 -0700
From: Josh Steadmon <steadmon@google.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
Message-ID: <xlmgclzqydsyubjegobrjwhiqkb5b4fxnxciqz3ys4yyu3a3od@kkc77fobimkm>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-5-calvinwan@google.com>
 <xmqqv7z8tjd7.fsf@gitster.g>
 <xmqqcylcpnah.fsf@gitster.g>
 <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>

On 2024.09.10 12:04, Calvin Wan wrote:
> On Mon, Sep 9, 2024 at 1:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > >> +struct libgit_config_set *libgit_configset_alloc(void)
> > >> +{
> > >> +    return git_configset_alloc();
> > >> +}
> > >
> > > git_configset_alloc() returns "struct config_set *" while this thing
> > > returns an incompatible pointer.
> > >
> > > Sent out an outdated version or something?  This wouldn't have
> > > passed even a compile test, I suspect.
> >
> > The "shim" layer should hide the details of interfacing to the git
> > proper from callers, as well as it should hide the callers' from the
> > git proper.  So if you really want to hide "struct config_set" from
> > your library callers, you may need to do something like the
> > attached, perhaps?  At least this does pass compilation test.
> 
> You're correct that this is supposed to be the shim layer, where
> callers aren't supposed to be able to directly interface with the
> config_set struct. From Rust's perspective, all pointers that come
> back from C code are effectively void* so the naming doesn't make a
> functional difference for our use case (and consequently these
> warnings did not show up from the build.rs script nor did the tests
> fail). However, I agree that the public interface should pass the
> compilation test and your approach does that -- will reroll with those
> changes and I believe that we should also fix the build.rs so that
> warnings also show up during cargo build.

Yeah, cargo will complain if DEVELOPER=1 is set. We should probably
enforce that in build.rs.
