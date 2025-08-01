Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27482C9A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754020520; cv=none; b=inc0MhC2xiCvVwzljhFKPmTpXbZ24D49KdQw7zIHLybc65+Je/mJ7fhhkrzPkw69Z1b2+HGviwiz0f9OEz2EQwBiu0v4jkOjSGpQ02V+IGgB3S4gnEWTnIT3x9f3fqvD77y39F+ST4YctDmSndHHZil2DaGVu5DbblSnULXn/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754020520; c=relaxed/simple;
	bh=z7IUMVQMS51sR7o9NuHrDXJEcnXUiWCCN057CHMR9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5spEcl7LCS8wjxCoi9RrZ8RWdi7MJ5csF0hG6ru3olEPChpcRgjhYd6vrwfXhCqZWLXJz8f1i2c0b5af8Ikax/WPGF0QcMaCF9fMS2WHvne3bDhZODnBnFArLatdxAaBAT+ow33g9CrcgFT6Rtb9AKJKxfRMQb7IBXPGNn1fUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haUbrrru; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haUbrrru"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23fd91f2f8bso13701815ad.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754020518; x=1754625318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGAEJPyF5surbDY16jQ57AE47vvA4WM+Mxhjq1bTGsk=;
        b=haUbrrrusPZtMyfvlivnPz+U/nKG0/jcxaY0bijQzulkKW3z5LaZ249tRaZtkiqAkc
         n3Xe+O85/771qWcLo8CfO1+77c6LdxpaGBW6wAS29sl2FMfCIFVCVCfBN86VoFQLT4c1
         yf0SpqEhgT/7MsgcXjLEbPQRFhdPvv7/BhCzxvkMfPnuLijWSn2YPHmAeLAITMYAfblu
         uShjftLbnyDQCaUslCX6YxFiEzYGCpNKhQcIxI4b40xslAPNeWb4ekYAcsh6i/NMZfPe
         YhEW/derbspudaTXAfht9hP+kdcL7hs3LW3SZYQ2s6qL54jsSnDpvlMFsv4D0P0/sdWy
         xYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754020518; x=1754625318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGAEJPyF5surbDY16jQ57AE47vvA4WM+Mxhjq1bTGsk=;
        b=K02czgFkIhNPJXangxKe/QZi64yQ3pim0aaEJ7R/faUR5t+JDtBg/YCBKj76h2nwXg
         i/CjvOZD+xLBc7Y7f/PoRNgu+74ICE6Lo4b76YI7ErCo6nl8DCgB3Hg/uy0s2n8dcJ8Z
         4t+LQzppt/EAxdUPxcthU1hqu5PjxYCZ5r/SjhhnddcHj4/uooZZUuMAhmn3jKCcZIUA
         CeKb4RWqeipJ8pILxA+kZFl3747F13/XQkebLOZtdPsm0fU/q4+kkzZpUxaKH3NFR/om
         bzJARTlJvBy3Fe7Y2wsLhtD90ircK8g+791r7XeCe8tCcpXKQcaGOHAoco657tVNPsqw
         KxYw==
X-Gm-Message-State: AOJu0YwgNFiGOOd/eOJoBGXIRxFF7VlOB/6+Z0uUzP3NVd8ZOyqJZpqQ
	TvTAJiqi55Cg/tKb/oG49VFDHVuG8apxXINtWbXuSMMqq4H5RlxJ1ZNh
X-Gm-Gg: ASbGncsGGUPJAR9arMIjsPyz+0EY1WM+A4SXAhOJoNYiQtX/keK8AiqtnIF+yZzcaau
	4qeX2RIEeNtfmTWsAaZ+Ab8E9sFve2nanPDJ8BgqZZJX+nzW8t6OfZOhuIC3TVkOKgshQyk6pLn
	4+ZjjS3LTzdNXh8ETdYw209beoS6b0oL3IH6LHXrOFFBAZcyXCwIB4EFvMliNLFmPVVBpgLMLLe
	QaUkgZypQcTctv+Rt1gUgNtokbG1vbnx4T1vFihEC/+PK4xfZwxzKXYBLSXOhpuX+AyW5cLv1Vf
	/sjb+ftgJVympG71FvaDQcBTFSvYx9Z2rmRIQzvIJb1D6t3TCNoWtlxCIB2wD9x1604uH7Feppf
	sATdIEA4Q2EFEZrIIhA==
X-Google-Smtp-Source: AGHT+IGy1YKSeQurw7ULkbhhI9lItVHZR/lnz/RuwJfNrnzSiucTnUnvk12IbmuJ8D9LP2n02D1o1Q==
X-Received: by 2002:a17:902:d48e:b0:240:eea:35f2 with SMTP id d9443c01a7336-24096ae696emr171357675ad.24.1754020517992;
        Thu, 31 Jul 2025 20:55:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e8aafb34sm30855825ad.173.2025.07.31.20.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 20:55:17 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:55:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
Message-ID: <aIw6ojvvDWLPllG7@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-3-gitster@pobox.com>
 <aIwndQtEoKNXRG5z@mbp>
 <xmqqikj7ogf7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikj7ogf7.fsf@gitster.g>

On Thu, Jul 31, 2025 at 08:43:24PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Thu, Jul 31, 2025 at 03:46:01PM -0700, Junio C Hamano wrote:
> >> diff --git a/setup.c b/setup.c
> >> index 6f52dab64c..b9f5eb8b51 100644
> >> --- a/setup.c
> >> +++ b/setup.c
> >> @@ -1460,8 +1460,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
> >>  
> >>  	if (env_ceiling_dirs) {
> >>  		int empty_entry_found = 0;
> >> +		static const char path_sep[] = { PATH_SEP, '\0' };
> >>  
> >
> > I am a little confused why we need to use `static`? Would this function
> > be called many times?
> 
> I actually am confused why you would want anything other than static
> here.  Writing this way would allow the compiler to realize that the
> array can be prepared at compile time, without need to do anything
> at runtime.  If you made it non static, the runtime code would
> allocate two bytes worth of memory on stack, and stuff these two
> byte values there, each time this block is entered, which would be
> at least once.
> 

Sorry to make you confused. Because there are some other changes where
you don't use `static`. That's the main reason why I ask this question.

--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -348,6 +348,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
 		int len;
 		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
+		const char path_sep[] = { PATH_SEP, '\0' };
 		char *path = xstrdup(argv[2]);

> > And I have a design question: by using "PATH_SEP", we need to convert
> > this character to be string. Should we create a new variable named
> > "PATH_SEP_STR" or whatever to do that?
> 
> Sorry, but I do not understand the question.  You want to see
> something like
> 
> 	#define PATH_SEP_STR "/"
> 
> you mean?  I do not offhand see why anybody would want to do so.
> 

Yes, that's my question. Because I see that we would define `path_sep`
array in many place, so I wonder whether we could use such macro.
