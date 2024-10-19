Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78421373
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729343291; cv=none; b=G4MQBsmIAYdRGRXlmzt3fC8xwRNAgAVsRpdObgMXW/LWCFFNqtBxxIm/KhiqS934jDAXY5D6q4O3EFMtG3jqki3MkAf0ZlWQX0n+BtOEeyt6+n24quqRqQwJFr5N02ghTP3gp3VkZzqs1SuADWdy3Yi9/KAwrRJ0/I0QAS3T/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729343291; c=relaxed/simple;
	bh=GwCkkJptz8/0wRQMdpDN3t1zcV6X0rl7MBqSDP2Cw6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSIX/dKMijueX+As7MFzku47G4AvzOYvWXp23kSsSlvNvSWOiFf7jao1EK0DFeDp8dx+Y3ZWEHBGzyMvVo8utiWfwOa9RqDZcpZaRKKW/8bn1jPgWMyemJBylrCiPCyzZlmP2CPDy7uu2jLEbFt41IS8cUNEsJo0LzcBK9kWyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG7U8aa0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG7U8aa0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so3602154a12.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729343288; x=1729948088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwCkkJptz8/0wRQMdpDN3t1zcV6X0rl7MBqSDP2Cw6o=;
        b=ZG7U8aa0dSbxhrynHshlmWG6dbgUKsP+pxBhQ66a++TQdfnerBFbIEwP8nfZoahcZL
         GwObQeijuGY8U5ET4SoHScS9LdIzL6HvbyFbCTKQKA/4TcYLSpT4v+LAqxp+omC3wGfV
         HPft3xqhUe/bETg5rsFV5rsZlTNaqPCl5vYvFiB2i1v7AzCL44EbEwOnJTt7APJ2ffMT
         8tU1+1E4ApgyO7PASk74fFnbF61EcL3mr5WDlK0HeVpSj/VFD2/241WKzdvVRERo4GmB
         mwEqPdNkp7VhnONOIm8IyLvZwfeYHJauF3FgREax61vtw7z9Ue+LXJLV0UGClqcw8Gel
         +HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729343288; x=1729948088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwCkkJptz8/0wRQMdpDN3t1zcV6X0rl7MBqSDP2Cw6o=;
        b=GnlOmya4i9zPPC8oVMounP8u0TiAcZ9GAIoR09oKi2iuz/YDlOSfVBzpZ7rPbPyl7j
         NGCTNG5mjN+BdjgMjn4CfOEiIrqmECO3L82eBXDFpdXyZbEXq+lJANp8qP+ZqfaWvBDy
         HxElvguZR61bP29xHsD9bGsOAMFfzNyKITCAgqUkyAuaKCU/2wHqgB1nYL0kw9SB8TaH
         /Q5rvF4WEqbb953QyzBbGbA5vfAhLlwQsF1uLNkhvZDBA8vIHUDN3DwcpJi/p5B+/bvl
         Df/x6y67bs5SFlr41rFKXrGYCNVana1WI3YKcmnF8nyPgpy5D+6FPQWbKutzWANFSuAe
         r4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEnEvdYwWDp0qwyZsSZNdriNh2VLsyUyy/9/eUdjKnqoa7QWRWTB+XG2ocn8pLV1jtz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CD38H7Bnso8sNEO5EGIPGHWy6iBKHpEoYq1E55qkmVloNvKh
	iVi397OZrRE3/tcKDYZBXbGkfGfZOwSZBeNKuzrEKamyn4lroL9a
X-Google-Smtp-Source: AGHT+IEHyxdTcpdkHpIsGNM2K6OX/4eI8tUf1QMZ8Fi7S9c9t4BXGHhB81GMwu7zBzQw0IhMXhDtVg==
X-Received: by 2002:a05:6402:2794:b0:5c9:a588:9dc1 with SMTP id 4fb4d7f45d1cf-5ca0ac6251amr3796915a12.13.1729343287333;
        Sat, 19 Oct 2024 06:08:07 -0700 (PDT)
Received: from void.void ([141.226.12.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0e8d31sm1828670a12.69.2024.10.19.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:08:07 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:08:04 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxOvNNz6qGGGES8F@void.void>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
 <ZxKSFBl_pV2r99dY@void.void>
 <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
 <ZxKi7qn6tEWyBXsd@void.void>
 <ZxLNj59mKfZubiY/@nand.local>
 <ZxLN0u5r88hQsY+c@nand.local>
 <ZxLWAmXJORyVldip@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLWAmXJORyVldip@nand.local>

On Fri, Oct 18, 2024 at 05:41:22PM -0400, Taylor Blau wrote:
> Since this topic is already on 'next', please submit any new patches in
> a separate topic so I can queue them independently. Thanks.

On it.
