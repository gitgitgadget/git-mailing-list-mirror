Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2E1F2BA4
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526160; cv=none; b=myFKre4EvuLUEiEcgpGahhive5oQYsjq1xEvOPfVuOJqHWC1xgeSpb1fHbxjpm82tXgLwDB7SJm6pDC3qPX1RaNCkJO0W3jpPzfKBNEDzqT4Npt0TSP+prj4d4rqEKUJ17GgWaT9j87sAThNkurW/m+rgtbRquN3t8X5oYIFl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526160; c=relaxed/simple;
	bh=DL/QfRzrsnwDsxgC8NpjAbumHMky9KUGTMLt//VxrOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e96j72gARMACiqff+ZKIMLj4mc3WpjKZzKpCzm5st3+gtZgb4v3km30hISHX4svL0BQQwkzvPGUIdQ0v405pv5vk7CNdXnZt9hm2/RosfO5R47Gng/IfaYeUM9To5WCTzFJCAeZ15nKeBF5yCOzUbRzVpEl1OBCc5OdsGbGlCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtA2mC6G; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtA2mC6G"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3feaedb531dso387485b6e.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745526157; x=1746130957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvY1Wca8274Nb8ZAEszBzA0Sw9PfoAf5n/rpvn2y+Ig=;
        b=dtA2mC6Gl6T3TGXTuoWDE9auEklxa9xv+l5cme40SpUU/KNZFuSVnoAFVUuSpQRa2B
         KtYHOYyKAp+mGTXWNLJDgR63UdzggJTxXhUNWvlhjOAzKV7pHHt/G0IlP8hGaddTPm/S
         oJBfEosuwDhd1NauLbyolrahqvCqVKSXTxypDkSxuEA+kq95AahV6wcZzlESFBN3IJs5
         adgjJgCGHVy1DyGdefVdZoBGUlCHb85n5y7sBc32mYK09yoS2cs6twR4RZdnRAHJHEMT
         BewJcLngghIqA9x14wKon27ewLCrOG5RqE/aPstfmFGe+YfqEbqAITCJsjCq+YmZnGvq
         wTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526157; x=1746130957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvY1Wca8274Nb8ZAEszBzA0Sw9PfoAf5n/rpvn2y+Ig=;
        b=L9kzTePKbN6afkhVy3Zjmv0Fus6+qw8nP40t07p6s+7ySQaK/r4snQwSvib/UW/vEs
         paGljZsD2iIcEccZGN4pekk3zWJXTe9UTYCWnhC0VIQsglFaenplp81MA84KXPIlErOS
         L3RX6+mrJgN4Pitfn07u67Zbux9poF3bf2R8r2nfVzOYS51BhBRbEfrWj1iYPbE5cLnK
         g0VdSpB68LpWh0z67p0nkIIxCaZbY9EQ+Bt3MNMcvMe0T4k528TkXOON9Rkl8UBr7y/t
         /q/GT+P5C8EOkDaqVNVlq5H/6Uu8xsqTWaOMjWGpZvKszogxQAVe9JXe3wE6QwhNX4Vr
         MuVg==
X-Gm-Message-State: AOJu0YzObr50JVfQpdTe7wxRFulK10uO/pm/wZixsr4uh5q81e7BZ3xJ
	Z/0CcxrKVmVwFve/1HTRS727uXPL1Nz8jfT3eus6LQMhe0XwthxR
X-Gm-Gg: ASbGncvUFRDPJKDNbTkvaJdcHcXOLX3uLM37QgKHzyMtcsiHvpfEwD0lI8US6c7AjFa
	zq7Dwz+KncmjItpeRuRR1f+gVuRxjzIWURT1m5GKZcan+L6izCMmDZMOyfXN0RXrBWBXGqtQMzW
	fLlXFTxH0kX615NoZNDOZP8MCcISHHEHKQl5L1fMUi///Purs4FXORzacpat/43r0CLpg8qlGP8
	ZUg6pJOzQ2BVEexDFkI37Z4QFqrpy1b4n98S+Qh0ytzDT+aRrDfa31wgulvA+4dX4HiA8PJE1QG
	yzQcNtR4YtmoOYSAiEESef+YA40uBtlDHg==
X-Google-Smtp-Source: AGHT+IG0Dp1Z4VuYDUXDYeOUA/lUzMfLz+JdnM89atUfzJokHKVbgXNy1TkOmFzGzecZNoaMmMR48g==
X-Received: by 2002:a05:6808:6b96:b0:3fb:e9f1:8620 with SMTP id 5614622812f47-401f11726b0mr534120b6e.2.1745526157299;
        Thu, 24 Apr 2025 13:22:37 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-60646862ee9sm398839eaf.4.2025.04.24.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:22:36 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:18:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 2/2] meson: prefer POSIX-specified shell path
Message-ID: <m2egcx4i2nezlwlyioofnz4srjgbyhb4dkyrpi5crnt5uwuvy3@a7tbji5lrnvn>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250424-pks-meson-posix-shell-v1-2-45e06ee4b6ad@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-pks-meson-posix-shell-v1-2-45e06ee4b6ad@pks.im>

On 25/04/24 03:38PM, Patrick Steinhardt wrote:
> Meson detects the path of the target shell via `find_program("sh")`,
> which essentially does a lookup via `PATH`. This may easily lead to a
> subtly-broken Git distribution when the build host has its shell in a
> non-standard location that the target host doesn't know about.

Ok, so we run into this issue if the shell path picked up from the build
host's $PATH doesn't exist on the target host. Makes sense.

> Fix the issue by appending "/bin" to the custom program path, which
> causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
> specified by POSIX this should make us pick a better default shell path
> on all POSIX-compliant systems.

So if the build host has "/bin/sh", but the target host doesn't we would
still have an issue, but that is still probably a better default. I
guess now $PATH would only be used as the fallback if the build host is
even most non-standard.

> Note that we intentionally append, not prepend, to the custom program
> path. This is because the program path can be configured by the user via
> the `-Dsane_tool_path=` build option, which should take precedence over
> any defaults we pick for the user.

IIUC, then the order precedence is "program_path", "/bin", and finally
$PATH. That makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 8f04534c7ff..1db768380bd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -236,7 +236,7 @@ sed = find_program('sed', dirs: program_path, native: true)
>  shell = find_program('sh', dirs: program_path, native: true)
>  tar = find_program('tar', dirs: program_path, native: true)
>  
> -target_shell = find_program('sh', dirs: program_path, native: false)
> +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)

It might be nice to leave a comment explaining the ordering intent.

>  # Sanity-check that programs required for the build exist.
>  foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']

-Justin
