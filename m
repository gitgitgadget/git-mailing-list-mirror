Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67218F2F5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351547; cv=none; b=uz9s3fZdkPB8OO0gfInFozcI1IPWLJ5oPtkAE6au/54GlZnEFIEd5s6qoRljv01ZwqD94VmB9gczVw2/yCxNa8ot85uhDaHcYh4S5JSd9Rl1z7KSRY17hV38QIULr9jQYdCfjaz0qqtZao1fiZQNC2vEUbMX+FgBxDNRh6WAJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351547; c=relaxed/simple;
	bh=wlcxg+FqNaafUcau3bgTNjYgqVQdGnA5tPetoH13xS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsWgtXyYHdUqvHOn2gGDCC3+FFvIi8oCePsUyJcvWAoQ9XoCLsUzA5ZFmVjlGVwl2YiUfNbXRiDs4adu6pH8MUBxX/Pd6x8pqew/VAyY4mvhFWCmYsOPM7M/bk3WCYaAIMbfc4uoKzR7y8gG4RVpRSAaIBX8SOlhwGR2xQE5dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsTTdRS7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsTTdRS7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d18112b60so3304432b3a.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722351545; x=1722956345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtjIO7E61oIAV9VHKldVr8Q+Uh+Wq5eZGQP5m/i7HsA=;
        b=FsTTdRS7mSRuUVvyAnvf5espXMxjixx+V9jonIaf0yaMcOse81+TKWIMZee2TtvYjQ
         +wtTV0sbhb3RrudAU9sVmzvK9Vj2/bkYdRqav8YkB3AiK8ecnq+j3etdq4dUaegmGrVs
         mSQ8QqXLXxikDCXp96f/DqYchrM+xnOwMRZjaR8w6OYAJWlRMsGFZ/DFUF53wFySAyLF
         /etNshxFBweVFpIuXS4TJy1nhLYG42VvFqASyjeuyEGalEaj10XTqFNesRlsj+VX4fJx
         GZXXwfhgOIxcM2OUT3ijVzZuP87cBs7U6zOB0GteiCkk36hTYchfxRrnOFZriBraWWMn
         YPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351545; x=1722956345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtjIO7E61oIAV9VHKldVr8Q+Uh+Wq5eZGQP5m/i7HsA=;
        b=G25KKdTNnpyrVWh2zQo1WkPTPmOOuBQYxCAtO1XTDpgIfrZA2SAU1XPwYSNAWZA4vK
         Mxyu6pzvg4PnGs4Fz5RHCB4GLe36rAbNW1bC3qCe0eMzdkZMhx8NKvS3KvQ5d66eEPwh
         PyQKpIaVf7siFfXaClqzMaXuRsws0/LmOlozLEauDZ7NFJVVW89FEhRBWtSSokJSqa24
         zmA022OLFeU7Wr3eGB4Vri3aUAeXm9+3pfe0xyfwU1Ch4lorqJo+YgR7/1QRjQsYKW2+
         9HQHC28epwlIyQTocLpW2OphxwxHLo6LDfDkCpxCwMd+D9iPgMJ43AZKAZbPleJ4J0J/
         JLCg==
X-Gm-Message-State: AOJu0Yw+7TlVK64/mu1zCpFObVueCLXJQgyIuREIDJAHBPbiGcVNwOzE
	xSZBPZfzxNS8OpiOeM5+Sonx+6pTeQkWvHLmlvIGr7teyUJ8AJZ1
X-Google-Smtp-Source: AGHT+IHx2QnkIGCGYz7xHPqtzJGe9vukAgtIqQZb0oWLyZO31sQuGwH/ntd5KS3tl67nK9dJXpXzlw==
X-Received: by 2002:aa7:9088:0:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-70efe449177mr3464720b3a.8.1722351545019;
        Tue, 30 Jul 2024 07:59:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7133f5sm8469295b3a.54.2024.07.30.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:59:04 -0700 (PDT)
Date: Tue, 30 Jul 2024 22:59:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 03/10] fsck: rename objects-related fsck error
 functions
Message-ID: <Zqj_zITuG-gsNM2R@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYkP5YiISbMrrN@ArchLinux>
 <Zqik2RCfA6MAzzXx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik2RCfA6MAzzXx@tanuki>

On Tue, Jul 30, 2024 at 10:31:21AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:26:40PM +0800, shejialuo wrote:
> > The names of objects-related fsck error functions are general. It's OK
> 
> s/general/generic, I guess.
> 

I will improve this in the next version.

