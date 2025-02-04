Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B421B90B
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709589; cv=none; b=sq3PnZg87DwC48OLFRxqtdDEglfj7swXGHuUaQl1YZsfRQGLkY/+E93/wZy7ILwbsiADKk25A7YuC5APK6XAHPRDl0D+4Zsvl8UaIXmKobRseT04oHOSLW524NNYNHSWgmuM+/kGPYJ393oVC8B5fNG1rknV62jL/nFe9bLEtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709589; c=relaxed/simple;
	bh=dGWt3iDpEH7E23p9eXuJ3kbweymFVwu0jnCWABT5v+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0URojAMGvhFOCEub9UetpSIU+m+GcnziMvJoSlheb3jmG93B0dnRpDYYLNwrizcu58CBtQlxXYh0PloOt4QLhY/7dGTl6fCbnmPpMI6P25Jp5LAxmoyaqhc4w2qeYXCgon9J/1Tdq9gEBGJVOa+KoN6CLc/fZ7IxPdMpgh1uY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHo9k6sp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHo9k6sp"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e2766994bso3189578a34.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738709583; x=1739314383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIvuRWwUV7MjoX8CdeeorA6uNY11+RbECM1Vsr1MEOs=;
        b=CHo9k6spFDsDiObrVux0CQKloByrUE+RXk7CnqFTyNsELONw0BmgczSHmMRzoVUpL4
         BBZW7T5Q/2KLLLD3kZJ2MvGKtL7aiwJIlvAsV4s27KguSGMDn5qim8s7pERr+XG30Eda
         NanHLFlUzTbXIETQKF5qxMWDg/0D/XNjZqmeOMC6reayLI7koF7GuKTAFSiAFkMhYil6
         haK/E+5Nm6TibtZ2h1QGHHGE0oc49VCBI46joFIOiirF8vfhfFmxXRrSOF1fcw+1zTws
         p1XReGgID84ETZX0vhRJtScbjFyIqM9ZVultfET8RFAtJabyDYLEZPedCL3yXdgsPeKr
         i+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709583; x=1739314383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIvuRWwUV7MjoX8CdeeorA6uNY11+RbECM1Vsr1MEOs=;
        b=JvzNT2tYiImvQKFEMwfVm/GOd3gBjl4/7sGLF9tZkuK4SNioYgnjmOYHV0ZaDTDcdA
         gAjBwZfKP/lzJgcQATzj8T8J6K3yG4802UlHJGT5NK2K4KOqa9zZI1dsys+xC7PWcNLM
         LGX4Vq5DkFPFF3+1RaqfuTO+Aac3kfzdY0lwnJ01Y2/SZDHeIjpWDkei1RATd4Q898wo
         ff5jVoBYbEdZ81z48XY0wQ/5OK4Z0LWCLSwVHPDNN4wWR0PRD7ZrkkCblmic2KKGig/W
         rNNut4FvJRm7OVBY5LgB7Qh7b/mtfzemGsANgWIthPZhHv7BuQ5HD4OYEuyC4bxDq9KT
         foWA==
X-Gm-Message-State: AOJu0YyeGG4RjSsFvyE6iKrAZtjFRnY1a7iCOKvlWyPc/y0lsF3iipQz
	40jbkzoDVA/oIqY58MXQEYS6IcNB1Y+Omlja8ugqC/8+oguKJAo/
X-Gm-Gg: ASbGnctl96Kgv3vO5r383ZCE1Uyi342jbSt9wBGzAf3N3aA/LdIIv1SbYQ/RISaX5EH
	K5STgMt4O/nNy1hJ1hycYxqcQz4vqUZBvMtOCr2KbIdWBwN+AGy2qVEkLbETUaKnFdcRiRYf38X
	WL4n+C8kT4eQqu2QUxb2JglUXkJNkZWufDF8lhB30fmjYnddr5zepqMRpfGgpKjQ1laD7j8w4U8
	8d+DmWGAqm5YJF0pVt5NgAl8VHMBbBk33/inQxwOVQFwJF62N+LEtvThF7I7otRzZft+tSd73Tt
	w1anaV3t
X-Google-Smtp-Source: AGHT+IFGeSYz4aGXX0K3rZoyrfQPe29hX0vfYR/eITCoR7x61qyMPpt1EMb4+zrmGjVAeXwTEop2wA==
X-Received: by 2002:a05:6830:6288:b0:71e:240a:4803 with SMTP id 46e09a7af769-726a4286783mr486910a34.23.1738709583577;
        Tue, 04 Feb 2025 14:53:03 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-726617bad32sm3608561a34.3.2025.02.04.14.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:53:03 -0800 (PST)
Date: Tue, 4 Feb 2025 16:50:06 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
Message-ID: <i4nwrzqjhuvo26kt45aykazut7rgvhh5w474dkqay3fhmnuvtx@czemalalwuwm>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-2-jltobler@gmail.com>
 <xmqq4j1a1wvr.fsf@gitster.g>
 <xmqqikppvf2t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikppvf2t.fsf@gitster.g>

On 25/02/04 08:40AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So regardless of what the future default value of core.quotePath
> > would be, I am not convinced that it is a good idea to octal quote
> > any and all bytes outside the ASCII range in the rev-list output.
> >
> > After all, "git rev-list --objects" would show such a path without
> > quoting, no [*]?
> >
> >     Side note: the path in the output from "git rev-list --objects"
> >     is a hack to allow receiving end to compute a path hash, and
> >     does not have to be strictly reversible, so it emits verbatim
> >     bytes but truncates the output at LF to preserve the one-line
> >     one-object output format.
> >
> > We do need to quote certain bytes (e.g., LF cannot be allowed
> > verbatim, when the output is line-oriented, and we use C-quote,
> > which means literal double-quote needs to be also quoted), so we
> > cannot mimic paths emitted by "git rev-list --objects", but I do not
> > think it buys us much to quote non-ASCII bytes these days.
> 
> Rereading this I realize that I was not quite making sense.
> 
> A short version of what I wanted to say is:
> 
>  - The output format need to do some quoting anyway because it is
>    inevitable to make the string stuffed as "value" in a space
>    separated list of var=value on a single line.
> 
>  - It does not really matter if core.quotePath allows us to pass
>    bytes with 8-bit set (e.g. UTF-8 outside ASCII) unquoted or
>    require quoting.  The receiving end must be prepared to unquote,
>    so it is dubious that a new feature to ignore core.quotePath is
>    needed.

I agree, thinking about this some more, forcing the value quoting
behavior to act as if core.quotePath is always enabled is a step in the
wrong direction. If anything, we could force it disabled to be more
friendly to non-ASCII characters, but that is probably not worth it
either.

>  - We do need to quote SP that cquote does not require quoting, so
>    some wrapping around quote_c_style() like quote_path() does is
>    needed.

I think using quote_path() as-is should be sufficient. I'll drop the
first two patches from this series in the next version I send and adapt
accordingly.

Thanks
-Justin
