Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6304206B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262624; cv=none; b=NRSGhhkKU84MZXUQtmRNC1cxpF/pcHrgES8CSIfmLdwQYcGv7WCEd2xey6lftwJjCn3B+R9upqsWhdZ43wTncNhty3CYGjdbL/sRmY3u22Emtv6p/mKz8TJ5kxOzvFOytsd7qhltZFDAE8uV+0gHzBjYCYvQFkl42yKI4z5vDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262624; c=relaxed/simple;
	bh=LFqL9B88zrX/jUpETRGYM4itZxv3wP5YpBjGFwYOIy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK/Uf0WuSdIJZtJ80SYTeSDSwmApDXLo4VMMOfKAnrWwM6HKPtWsOkA3xzYx+q0ib48XOjj8i0jjtBW4OKO6yFOVRmMLBtQId0QVMTQ52AzesQ/EfKBYQXlPLNP7rCeuhJATtTWkf5obj6JCfmSLXGvrimbVe+bu/F1u1brz3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLoJ2ExB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLoJ2ExB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fed75b38so13625ad.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724262622; x=1724867422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfDcH/l4eaIcG3+xPuGAaB2F3q0tguWDtT4lCvvNQxw=;
        b=OLoJ2ExBE9HVJBXmOptiqQT8qUNDw4XuCdQvKUF4CmoDxrvaG9HHVgUMz78LWaXyCj
         HkYi2T9aRjsd8hYfBXCm1flQf4i2lVuQvRlZLmUeDhMWGFSQF+c7fb+8nl+3w5bMcnZf
         TnBX3tojGZ6KNoCQDga8VYwLmvfZg0MFmCmR3AYT5sceuSERuK6QKbokcGsMfsLZ4bzr
         b73pwWnWtjQTD/6KVYAsVKj2pAbsVLjO1SuLZn0HtUcQ+vISo3a0w/ggoLoURByeoRM/
         eHTYQq4Sl8f0lDu8CYCC5skImXttsR5hOXgCNh/jE+5b80waa4CDenYLw7ILTqNUBqhE
         kR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262622; x=1724867422;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfDcH/l4eaIcG3+xPuGAaB2F3q0tguWDtT4lCvvNQxw=;
        b=bOCuJcofeDqnXyGNJ1Wb16tvUnMYqy9JQi+DFZADqug5kGw2X+alFuwe7qaSlCGsHo
         PxcP5zEGU+qMirV6hWS+9d/CosOOm3Srnby/3DlGUXTwDpL0rGHgNYVw8Y3Avo0K5kNG
         s4rvef3MToBINF/UDFIMIrkQsYW1QwZGEjiYNqeGrGC0onHxIBfr7U2/aeNKJWVTaoi+
         ERCwl2Z14qohT5Pz+pEy3GQIhQMqeqb7jLL6PRj1MnwPM0NcCzEC1ZQTY6JO4dIphnE9
         kLUBYrWqSi08Tm6Ktlg4cGVfUItR+DKsubmyUFg/U21hal6xueFDheMNKkIcgOVnT5ec
         6mgg==
X-Forwarded-Encrypted: i=1; AJvYcCVQdRWLOVkEjkOcOYEDewnKGhfIoaaE6pcS5YK/HxzX6hGGoDvCRBtocp8u2ZNfk1k7Jtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRP9gdA2mr6hyFcF2OnWNIMh/Pg6c7L2EyMYOf5Wt7UDIOi+6F
	dpqh1MUwg0W7CFpz1YPil0b0cHIWeWWKY61IM2gW4DTu0O/f+m4e0CtaCC2LwQ==
X-Google-Smtp-Source: AGHT+IF7bZrTs9OrEEd+849tYFb2N+r9sVbvSrT3D//+OrRLJOgxF3AA5H0OZai8yIRD3wz2jW3N5w==
X-Received: by 2002:a17:902:ecca:b0:1f6:8836:e43f with SMTP id d9443c01a7336-203834bd0f2mr415ad.17.1724262621032;
        Wed, 21 Aug 2024 10:50:21 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:b433:fc59:16ec:53b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714323e8331sm62955b3a.116.2024.08.21.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:50:20 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:50:14 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
Message-ID: <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
 <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com>

On 2024.08.19 17:07, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> git check-mailmap splits each provided contact using split_ident_line.
> This function requires that the contact either be of the form "Name
> <user@host>" or of the form "<user@host>". In particular, if the mail
> portion of the contact is not surrounded by angle brackets,
> split_ident_line will reject it.
> 
> This results in git check-mailmap rejecting attempts to translate simple
> email addresses:
> 
>   $ git check-mailmap user@host
>   fatal: unable to parse contact: user@host
> 
> This limits the usability of check-mailmap as it requires placing angle
> brackets around plain email addresses.
> 
> In particular, attempting to use git check-mailmap to support mapping
> addresses in git send-email is not straight forward. The sanitization
> and validation functions in git send-email strip angle brackets from
> plain email addresses. It is not trivial to add brackets prior to
> invoking git check-mailmap.
> 
> Instead, modify check_mailmap() to allow such strings as contacts. In
> particular, treat any line which cannot be split by split_ident_line as
> a simple email address.
> 
> No attempt is made to actually parse the address line to validate that
> it is actually an address. Doing so is non-trivial, and provides little
> value. Either the provided input will correctly map via the map_user
> call, or it will fail and be printed out, surrounded by angle brackets:
> 
>   $ git check-mailmap user@host
>   <user@host>
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/check-mailmap.c             | 18 +++++++++++-------
>  Documentation/git-check-mailmap.txt |  8 ++++----
>  t/t4203-mailmap.sh                  | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
> index b8a05b8e07b5..6b7fb53494f0 100644
> --- a/builtin/check-mailmap.c
> +++ b/builtin/check-mailmap.c
> @@ -25,13 +25,17 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
>  	size_t namelen, maillen;
>  	struct ident_split ident;
>  
> -	if (split_ident_line(&ident, contact, strlen(contact)))
> -		die(_("unable to parse contact: %s"), contact);
> -
> -	name = ident.name_begin;
> -	namelen = ident.name_end - ident.name_begin;
> -	mail = ident.mail_begin;
> -	maillen = ident.mail_end - ident.mail_begin;
> +	if (!split_ident_line(&ident, contact, strlen(contact))) {
> +		name = ident.name_begin;
> +		namelen = ident.name_end - ident.name_begin;
> +		mail = ident.mail_begin;
> +		maillen = ident.mail_end - ident.mail_begin;
> +	} else {
> +		name = NULL;
> +		namelen = 0;
> +		mail = contact;
> +		maillen = strlen(contact);
> +	}
>  
>  	map_user(mailmap, &mail, &maillen, &name, &namelen);
>  
> diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
> index 02f441832321..7747e38e25e3 100644
> --- a/Documentation/git-check-mailmap.txt
> +++ b/Documentation/git-check-mailmap.txt
> @@ -15,10 +15,10 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> -For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the command-line
> -or standard input (when using `--stdin`), look up the person's canonical name
> -and email address (see "Mapping Authors" below). If found, print them;
> -otherwise print the input as-is.
> +For each ``Name $$<user@host>$$'', ``$$<user@host>$$'', or ``$$user@host$$''
> +from the command-line or standard input (when using `--stdin`), look up the
> +person's canonical name and email address (see "Mapping Authors" below). If
> +found, print them; otherwise print the input as-is.
>  
>  
>  OPTIONS
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 79e5f42760d9..0c1efe0b2e17 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -73,11 +73,40 @@ test_expect_success 'check-mailmap --stdin arguments: mapping' '
>  '
>  
>  test_expect_success 'check-mailmap bogus contact' '
> -	test_must_fail git check-mailmap bogus
> +	cat >expect <<-EOF &&
> +	<bogus>
> +	EOF
> +	git check-mailmap bogus >actual &&
> +	test_cmp expect actual
>  '

I think I'd just remove this test case altogether, IIUC it' doesn't
provide any additional value vs. the "check-mailmap simple address: no
mapping" test below.


>  test_expect_success 'check-mailmap bogus contact --stdin' '
> -	test_must_fail git check-mailmap --stdin bogus </dev/null
> +	cat >expect <<-EOF &&
> +	<bogus>
> +	EOF
> +	cat >stdin <<-EOF &&
> +	bogus
> +	EOF
> +	git check-mailmap --stdin <stdin >actual &&
> +	test_cmp expect actual
> +'

Similarly, I might change this to use a real address instead of "bogus",
as we're no longer checking for invalid input.


> +test_expect_success 'check-mailmap simple address: mapping' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-EOF &&
> +	New Name <$GIT_AUTHOR_EMAIL>
> +	EOF
> +	cat .mailmap >expect &&
> +	git check-mailmap "$GIT_AUTHOR_EMAIL" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check-mailmap simple address: no mapping' '
> +	cat >expect <<-EOF &&
> +	<bugs@company.xx>
> +	EOF
> +	git check-mailmap "bugs@company.xx" >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'No mailmap' '
> 
> -- 
> 2.46.0.124.g2dc1a81c8933
> 
