Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1214AD2B
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708956; cv=none; b=gzxMU9XOxquZJzYfJEskMojfONL8x35u/AF7jEXiPMtqckNxR2fJ4zqkiRshufSQow84FhrSSczEvwphM20CFUJ20WW9O6vE+o61ImAEOKgZQ2QR/P0c23mzD3xMTC3RkSDgwBo1QeT0yo2N1xoWDR8IreS7zkEpmTwVg3/O0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708956; c=relaxed/simple;
	bh=xRZLya7dgkNmD9IiVE6+/G4dNJ7k31iqs99cwB60BIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIoo4UpAMHFZsQPgoOtXnoBVAtNImU6uHGuVWgq8fRRJlXTVNRlHLbHCXdX0J/MakcCGoE8LOqOq3Y7eCvi/RHEbY9ywNGQTpV6dn0xh6g643TIgsFGBfoaueOeH/MSj0aw4ZMGtpzneIa6+GAXWGibpEuAVhLWL0xzzU7C5/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhovTm4c; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhovTm4c"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71ded02b779so3380917a34.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 14:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738708954; x=1739313754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xo5oBMyePI5VOIqSzpKoonlKLLxNXkZs9Oedr0Dri8=;
        b=fhovTm4cF1jVP3QZ+e1nUTcRt04y4MeneBpyn2aUeUDq4CZP4iuE1ZQV+M4pES2weh
         aWKlFA46rX/NY29ASvIAhzWOEJzT7uMnrB3ie4gLwRpkTr938SV9JubxsY88ylM9ZdLG
         vFv3XVN31bnSygSSpEiUFWCJmv5HsWfb3kGQXFD/liAZQu3GeDkoJJwRkvGPpAKGMXGm
         zXADYV00gDys/Vzm1+vlwhCjv6m03kSUj8DEidVt/qVlPqkLvCR0scS2Z0OepNRrUms6
         6SRB4gelfm/zkLaPdKfatAKfLtwkjTPbbaFuVPJOHCEDQCV1EXEh9xCap+fBBTKwwZqc
         Giqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738708954; x=1739313754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xo5oBMyePI5VOIqSzpKoonlKLLxNXkZs9Oedr0Dri8=;
        b=VrNzZHqpRSZqlybjT5dDYZ9SKruuPdfKnQwYBLOFejukrfnUWYbf9zuUsBKn2FkYBK
         ucPNluNJ/x8/1HceLlkDVWFYKr5wPnYD+qnb/xq7y8NQZ00RZcOn6yufpCR80ptd6itR
         zD7WhwkcNwb/yJuFANOp814wPpOmVSabTO+QrWGVYYnVFK9ZL0anAe8RTlY3yQYr0jBr
         p6uBz9aYxSL6O0kpr5XV8R86KBykOr9nLUPyJBJ9mGe6rICX/UTgEU3Sa7eVjSOgzhYG
         sohbqRMOozGmyQ+zCaUBqij6V7GZEO00MfZtcqMabvvgUBgotpasm0jB2+shsIYdWqRd
         Nb5g==
X-Gm-Message-State: AOJu0YzRcH5ljmTg+Yl4XNXqezQT621lba9q1VDepv7IIF6bkD2USKY/
	b/sFTwhgsaagnAFfZ+5devp2VtPUGGM1ZrRQ+6iTBtJUhTQ3sRWt
X-Gm-Gg: ASbGncvpq+3is6DPxJyoVfluNOCdFSQs9H6aFWrz+9OWexbsZtitNgK+6kAiY/DudKC
	J+NPK59zbeDaex550q26VC3wgBkeX+jsFrizcajlDUYMDX21CCK7bfkaB2wYZAvokqOf4RqmeHg
	JK88ZctpBMBduGYk5xJ2cSoIzKumgpfbp+OwgsxvRTqB8OY1T/3azbBeaDGtytSlG9IghW1K6Ko
	qh4y7Vnbt/3nKi2HkkVSCLqOimJhR/Y6apXw+ihmBuDOk96u6kPvcEmX3TSXl1N4XqsEVx36AAV
	dTRQv8Ub
X-Google-Smtp-Source: AGHT+IE55vI/A9VbPixu8YLWsAroCY1UbrGTGiUCkIzjpJu6n7KpBPJJQjfC+v8Akk9sk528RdagVw==
X-Received: by 2002:a05:6830:6682:b0:71e:946:80c4 with SMTP id 46e09a7af769-726a41cd4afmr647581a34.12.1738708954252;
        Tue, 04 Feb 2025 14:42:34 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f333540bb6sm3236264b6e.11.2025.02.04.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:42:33 -0800 (PST)
Date: Tue, 4 Feb 2025 16:39:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
Message-ID: <ksta3edbxwkl62u36xif63q4ebux5hdaxkbme6v6li5v3sgndb@nuu5yyp5clbk>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-3-jltobler@gmail.com>
 <76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com>

On 25/02/02 10:52AM, Phillip Wood wrote:
> Hi Justin
> 
> On 01/02/2025 20:16, Justin Tobler wrote:
> > The `quote_path()` function invokes `quote_c_style_counted()` to handle
> > quoting. This means the output `quote_path()` is ultimately affected by
> > `core.quotePath` configuration. In a subsequent commit, `quote_path()`
> > will be used in a scenario where the output should remain consistent
> > regardless of the current configuration.
> > 
> > Introduce the `QUOTE_PATH_IGNORE_CONFIG` flag for `quote_path()`which
> > when set instructs the underlying `quote_c_style_counted()` to also
> > ignore the `core.quotePath` configuration when executed.
> 
> I'm confused as to why this is necessary. All of our existing plumbing
> commands that print paths respect core.quotePath so why is rev-list
> different? The config setting only affects the representation used for bytes
> 0x80 and above, control characters, backslash and double-quote are always
> quoted.

You are correct that it isn't neccesary. From a previous discussion, I
initally thought it would preferrable to have consistent output for this
plumbing operation, but as you pointed out other plumbing commands
respect core.quotePath. I'll drop these first two patches in the next
version.

Thanks for the feedback!
-Justin
