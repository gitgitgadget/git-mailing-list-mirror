Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33482D061F
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983932; cv=none; b=F654R/SbHzCYQ6woydYKTTcu1TQylogkT9kyXvv8jyrErZuPIiOh59fK6F2V7FC7CVwjifW2TPeHNUorL9CKfyKRf98F2ONpnINfyHf1gnl665tHhEoSrSyLzDY29veF5jbq84/uzd3YNVQlV/otEK21VwT2reZrizpk1YrFstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983932; c=relaxed/simple;
	bh=yD88SnoKBHxiGmx9jZ7A80uC/MzZOnLVsHGrh1X6F3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1aIWPdvL96Mkb8lixSE/sNkfz32t/QTzf+XMtCESXX2WUUkHas8EcRAcq398dBHrSEH3kRHSH4zqp8NIP1SZctVB1unDmWaGo7xTt0kBC5tZjX3+1NTYoTacZfPKs5qEXOZow2QkJLJ5F92gmW0yOYpSZWpI8CV9jMxBUnAnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9slphen; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9slphen"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290dc630a07so22818515ad.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983928; x=1761588728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u+kUJ182U3MA4FMWe5+8TcLCd9pPI9WDKiTHxSFi6jM=;
        b=R9slphenX5hT+vpRddKZwOLrsid5zAcPVczs9mA8IRmosnNo2Fp9GGIFOtzSbvqcE6
         GPyxfuI1u9KGy6+JSSSW5ZylaNJ2wKYYya1vFKW+W79k5JS45T61dHn1q+DR0Hl6jNKN
         9+wFuPSEMMOHzptb2d4qr18u0kRYc+IuLEJpwordCZkkoNcYWdeOWiFu/EfLMT+IaLyl
         X2gqrvwIzeHAxkpCSVWAq+EFvksa6hPmrHbGBY61oyW/Co9xMSYot+lEfuw0U/UKSXtX
         BX4l9BHoKXaoQ3+gAdX9RDV2flE7dKGwsu2XYcW2f9dROPNJhGlHlQPEaUqRjrCpgtGJ
         XBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983928; x=1761588728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+kUJ182U3MA4FMWe5+8TcLCd9pPI9WDKiTHxSFi6jM=;
        b=c4S2KjTIbTU8D9J48yJlOlCNxTLk8AS/wwaCBWNtntjSwJQ4yY7XZbN5ekKsyaAN46
         ySTlN806XD041WVPJ9fa6XahzGgWjjA3tAsb1YbvQ3riyhuwgzAOeJ0YszgeO/MAglVG
         sbdQrzhglAu3axgMEeXY2/PEb+gdtgeWceBaroTxjL6kq8oKibSd734GFsEkV/LNJThP
         cMaboPsd8smJE51ZyBnWPKzwCuCqGw5Jl1PSuMV4LTBdITzj9ZGuDjiVnMqx3lI1r223
         GVaI6U4NzZw3NvZFuIoqNs8cYa7iY/scTLcWbJzA9CIkKblH3exmR+GCGISI1dtV4uJb
         /uzg==
X-Gm-Message-State: AOJu0YwSD4opJMAQ3PXFR3CpBQpaCNMZHqoqzKtTE11vprmWokISBHEG
	OSotOCvuxyaRmdOK+XuHEXGSFRKQ9Zc30JO7k/txMdyiSe3HXYyNyOA/l1dyQw/IFc55i0zknuD
	RbqJm6unj+55A2hLB/p95lHqZppht2K8=
X-Gm-Gg: ASbGnct7/juadHUCPQSfJmNZvUCvH+w6B8remGFv106UD5gMGWjOQvcSTF3RFc4h4S3
	scAH+gDqzYOuSllrXeQLZnDRZArWiZAhQ6G6zqBvmZzSMOqMDbahXhPqzqWgengc0YcyEgVVHf8
	YVCB+f8FrgbPjZmKj/E21Ngw96dZNLf7kHe+NpGwCv7EZ7ikK8S5QUmCBxG5m9vsWfeK4LLaVzz
	aAWmhNJuSdc3Pu1Jw4RlQiS6HMlfJtEgpR6GTSpRzXINCahUjTCg6B13dryKffhwsqRsB00
X-Google-Smtp-Source: AGHT+IGvwqHgIJPXf7Ju0Aa6lpwggvL/QDFtzPti/GfUjVwKYVgyTaUHtivVEA51UR4xEDMLtbBwGgllq5QDkkOEA3Y=
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-290cba4edaemr159575895ad.31.1760983927955; Mon, 20 Oct 2025
 11:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <xmqqqzuy3n3k.fsf@gitster.g> <CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
 <xmqq5xc9390j.fsf@gitster.g>
In-Reply-To: <xmqq5xc9390j.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 19:12:08 +0100
X-Gm-Features: AS18NWBOEn6-1CeSbwiNPhpSCB8MyViofwK34KrO2bU2GCpzLBp86GE2tOrf-zE
Message-ID: <CAD=f0L9u9=VAwO31qTS7GKXDrt9HjwVCHEFqDGtpv8HuWyP=nA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 16:09, Junio C Hamano <gitster@pobox.com> wrote:
>
> Bello Olamide <belkid98@gmail.com> writes:
>
> >> > -     fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
> >> > -     strbuf_list_free(fingerprint);
> >> > +     fingerprint_ret = xstrdup(split.items[1].string);
> >> > +     string_list_clear(&split, 0);
> >>
> >> OK.  This is a straight-forward rewrite that is fairly faithful to
> >> the original.
> >>
> >> But I wonder why the original was written in such a convoluted way
> >> to just extract the first part of a string that is space delimited
> >> tokens.  It is obviously not your fault that the original is written
> >> that way, bit I would have expected it to be done more like this:
> >>
> >>     char *begin = fingerprint_stdout.buf;
> >>     char *delim = strchr(begin, ' ');
> >>     if (!delim)
> >>         die_errno("Barf!");
> >>     fingerprint_ret = xmemdupz(begin, end - begin);
> >>
> >> Am I missing something?
>
> What I was missing was that we use fingerprint[1], not
> fingerprint[0].  So we need to do the strchr() twice, i.e.
>
>      char *begin = fingerprint_stdout.buf;
>      char *delim = strchr(begin, ' ');
>      if (!delim)
>          die_errno("Barf!");
>      begin = delim + 1
>      delim = strchr(begin, ' ');
>      if (!delim)
>          die_errno("Barf!");
>      fingerprint_ret = xmemdupz(begin, end - begin);

Okay thank you

>
> > Okay something like this which just finds the desired token and
> > returns a copy?
>
> >     char *begin = fingerprint_stdout.buf;
> >     char *end = begin + fingerprint_stdout.len;
> >     char *space, *start, *endtok;
> >
> >    space = memchr(begin, ' ', end-begin);
> >     if (!space)
> >         die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> >             signing_key);
> >     start = space + 1;
> >      while (start < end && (*start = ' ' || *start == '\t'))
> >             start++;
>
> The original does not seem to care and uses the whole
> fingerprint[1].buf; do we really care about tabs?  The same for
> looking at CR or LF.
>
> Even if we cared, we shouldn't have to open code strcspn() like this
> ;-)

Okay thank you very much for the guidance.

Belo
