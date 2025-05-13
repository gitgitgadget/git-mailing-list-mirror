Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2B1EF375
	for <git@vger.kernel.org>; Tue, 13 May 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119328; cv=none; b=cWKEbvrpoIzwAT6g3oQm61hGY65gVSFdMxOQnr2KQCp73o+AnTV4czv7zP+LiUptmEj++w41KAHz5nVv01qKrVXjN6cE/P1Q8tZuUQn/LSFdaOAz4m5NKf/ReGsAgogVA8CrngobH9bX9RGUD+7iu1eVVAHR+50GHlHjPbJMzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119328; c=relaxed/simple;
	bh=0DbTo9I4O+q9QDYheOnPxq/My4/h8ZVCKRT4AX8SlTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVSzjQJ0g09gbgoT1sfbfG6w4kv2NQel9kBEhfo8RlWSjaNROAb82/KJMxND5PRIWy/X8xfRDkSlKYp+VF4ipIP3975mVYwlrSgmpbl313lgSVHW6qNWuysiW3cuEo1MmCqZ1zJKaAtgwUKyXkh2FB3BWeOjp9VlvNRMRK07Kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb0R1jfL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb0R1jfL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2317d94c9cdso4590465ad.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747119327; x=1747724127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7JSSpbgXOZxGAfW/cVUER6QbTluS8kQVXGxB/vAE2g=;
        b=nb0R1jfL8119iaUkJKPAjF2bCYdWfqsC0gHhovwa1y+98ceRSTaeJNXH5q+XrfZfQy
         4Ntwy5SJuo988zPAiigv6SDmyATXIltcyhRIuqQ+vPbTWzIZpwzw7gntegX82kdCWKn9
         yajIuyOO7688cYlsnPsDXetfaoc4hBEHC4YQ+404FszFek4sLaQg4B4lOWl1dIE1JJiY
         v2yiy8+ZN3qirt48z3JCqG67v5QiyeW3sHsW8g9JvfMd2WdAdcHqEcJ7m1kISopQ1Z0y
         6x4j0HTWf1cGZb95cacmBUYt8i9DfRM1nPxQZY1XNWkBNrIT4RnfsQufy6lPHCYAruej
         uzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747119327; x=1747724127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7JSSpbgXOZxGAfW/cVUER6QbTluS8kQVXGxB/vAE2g=;
        b=v//lcjG7Mbnru01DMeEIkoANpN4WMKrs0JtfCDw+xXOIEmkpreX4uHbvZb+gUdu/9r
         R2akKXL0eRt2i2ZKL7tsynQMwx8/0cZfHLJjqSb7RQrhkJCWEycac1Vr1iFJRSR0L6ZA
         aQFSRngqew/MkaeR0GRQmkrsu7VxCAtJuoQr6ND1XbOFZR+Si4Kr2N06WjeRq2AQwpgI
         2+mpI8v22NCURejVM7wP3cvTM/AEWgFm+kgXiB/jD9Gv0g5MeR+dslZlNxPR5EwjOawt
         g08ufJOsnzNegPMJc63OrCtpWDODLc/iHUKI+e9OT/NoAP7jma7TYJIfLXq03heu4Ie0
         qCFQ==
X-Gm-Message-State: AOJu0YwxXjKZT9OU8UywLiNwrMSGg/qmjUwiCoGiXTriXGIq4kGoF48C
	mx5sZi1esQv7jus11A7vF4nkRXPb/nPLTT/dOSB2B1UAhSrJzCPDM+XDmA==
X-Gm-Gg: ASbGncuGtcngCSNcG7cuSodFwkbbmC7Be4w9zdhgB2FNCxCzu+ljdETT5C034uNUzRY
	xsWghFb9moVMIBPoG/g8sqZCIKH1i7KoP90nrBLgfr/OWBIvf2SxQU98OcEvLSnl8DKjEj3K70z
	9XFIBUVRs/5/+VvsqCMSJ3EGequeonObR3HQ3A07SRo4QQxa4r00+vwdG7UI6pFyJAWDnyLuZtV
	FUosG8qmz4F6jtdcsQjPANo04+KNEmzWsU1tA3YPgkTHp1nVxgCquPb/XhXjkTf5IJe696dVTql
	cIWjUG2DIK3gn2OY5EJKeeiaSrdONaJICmFVgQzuSeooPyI=
X-Google-Smtp-Source: AGHT+IGc4fGj16g1myxve8JhdwuMUZjGqJ8U1ojohksAWgWYM2Y9qbkWId/tDozYJwMy6dwog+KeDw==
X-Received: by 2002:a17:902:dacd:b0:22c:35c5:e30e with SMTP id d9443c01a7336-22fc8b519c5mr195156375ad.13.1747119326573;
        Mon, 12 May 2025 23:55:26 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc82a2e4fsm73951175ad.232.2025.05.12.23.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 23:55:25 -0700 (PDT)
Date: Tue, 13 May 2025 14:55:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCLs_A1DV7ZQSm-O@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtzm2bDRSTgEO-@ArchLinux>
 <20250512130619.GB1191360@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512130619.GB1191360@coredump.intra.peff.net>

On Mon, May 12, 2025 at 09:06:19AM -0400, Jeff King wrote:
> On Sun, May 11, 2025 at 10:01:50PM +0800, shejialuo wrote:
> 
> > "load_contents" would choose which way to load the content of the
> > "packed-refs". However, we cannot directly use this function when
> > checking the consistency due to we don't want to open the file. And we
> > also need to reuse the logic to avoid causing repetition.
> > 
> > Let's create a new helper function "allocate_snapshot_buffer" to extract
> > the snapshot allocation logic in "load_contents" and update the
> > "load_contents" to align with the behavior.
> 
> This looks good to me. One thing that did give me a slight pause while
> reviewing:
> 
> >  static int load_contents(struct snapshot *snapshot)
> >  {
> > -	int fd;
> >  	struct stat st;
> > -	size_t size;
> > -	ssize_t bytes_read;
> > +	int ret = 1;
> > [...]
> > +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
> > +		ret = 0;
> >  
> > -	return 1;
> > +	close(fd);
> > +	return ret;
> >  }
> 
> I wanted to see what the semantics of "ret" were, but there aren't any
> other assignments. So I think this is equivalent to:
> 
>   int ret;
>   ...
>   ret = allocate_snapshot_buffer(snapshot, fd, &st);
> 
> that function.
> 

That's right, it would be more clear. I will update in the next version.

> Probably not worth re-rolling for that, though.
> 
> -Peff
