Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433539;
	b=csBcm8liMtzdGzSrHiECZVOpFW76QUzmdU7HsyUVo4JAIGPwLPG63vkQ7tkq59NxmHDC
	 P+9SmvG8MMgybdB8xYF/VrR8rIYW/vJhDJIGrHur0rSK2ZM054700EhXuHJOd9KX95Xw2
	 jD0703I3X5iFLG/nJzMrY0RIoqBfUyscGcGahXWXwUAJaFpoqkvzI/I8lGRxfQa1AkqnF
	 SA0SUgW7aJ08SGgAcJag/ixExmVG6qpOz1UkZCveLFMn9/o/yP7hktGfJieS2Nt7dmWOd
	 mhs24HSIAHSVfc3A9pygWCGdn3+Lv0QuLOflqaLi619HlDFsQvd1dtW+GbVXybKjFDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=7dhaSy3OrxV4yiUaZyds5jHq2H3fLJgYLzowVKa/nDA=;
	b=cwm3A4M36gfkt17C2lNN/74qvJWheuOnbzBFzVQU6Vwa50xhvTOqU5WXuKEge4CHKUYf
	 eWKyNdVbi1ZrjPWyanrBfOu7V5ZHLpTej8+6oFMvABYppt+BFUjwZwTvpKYWYqp49ToBW
	 zEep66MqPlCdvvsMA21zyL+j0QvoXnl8bXzoGMb6+r70mh+/Lya8fU68jZMeTkAyfY1cI
	 2ZZxpx83SIv5bFlxCCwXBIlWQPHFDVxgCTSR79klgYJLLDORnOsi8blpT/Dudpo/NAIec
	 BKG+AvCF1sR2MMIydmRwrAq7Trpn16BZip8djJnwAd1x1NYmwk73+rmNbzLNUs9+Vug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKUSZIdo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE30606A320
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 07:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKUSZIdo
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2473614a12.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 00:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793433538; cv=none;
        d=google.com; s=arc-20260327;
        b=JOCRLpCqy0H7942cguYfJw+pd+DPAussgsY7Wy2HIzHKFZrSmxViy7nM1qZ9AOGxSd
         Qi+Mf4mkWCXoMHkdA4dgGnD1xsVDOCuVae7gDKTclHt7r4rSeIB0ExDkotrHDPYy0nRW
         rt6Y1Xfkneu/uIl9QubYmVhFB6fCoDDVrgROEkwsLsnxTanUSB0hEtS2zGIgewYTwwNZ
         rONZoMqd9a/oEqsJ4NjJhKKxFkBHnrbY9cGmYERqTIQd1mezAtsofRsD8L0nU7plEZ70
         Dl0BQY5znFcAzvCfm/hhWs84lg5cVDouQ7erqTbVo3uohiuBsvilbgMDHmZ6kLwhcxul
         gNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7dhaSy3OrxV4yiUaZyds5jHq2H3fLJgYLzowVKa/nDA=;
        fh=xa0Ijta1yFPKEUCNbZI8BAOhkLrh+CczpEHacmTg6rc=;
        b=nVJU5Wtlc0GkfBG07puzxDjN1rrMn0+6Hi44MEJ0i+M+nzm4rIJpjaT341E9qqI5Ng
         i+se1iPlRuyRPdIk9H5dcIl/O0Dw0LkKpxuvG1py4kNEmVQeq8UFCiBCkAvmsQd18FCc
         ezncnMMA5btyusP2ufuirDPH2TDBEgfpUjQaE0Fbh1Ql9MkEA4DC4xNJLNM3LTq8kciN
         JUrUOB1cQBsbSk+3sjS2CEBX1h+qSF4yoArnw1uv37fF3BZOx4HfhaULTfb1QGCTpZS0
         kNcpqLYawLMIJmjhhlUU49gUa+iAKtkacynRtZSn2di7uKZQ9vf9hAyzhZMeZDlJLQ/k
         rs+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433538; x=1794038338; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dhaSy3OrxV4yiUaZyds5jHq2H3fLJgYLzowVKa/nDA=;
        b=iKUSZIdoNIc02Nrch9LBpi/oxUP4BSmxtjUDI9E8HqKzXoc+d27ZwiKcojVlXHHDX/
         iyr/7esUNGZuVBIoEBDS6/jFusGpl/qee6dF6QfLlS2PuYBe3rizjfkm8QIs2s8kERBr
         +zZ05NbsmoG41mRowEeR+dDMulHfrDHLawcodKa6D3F/3H2kp2XCSIKhgDWklt4oQxTv
         tS01sJ+nCSmEbYy6VtVLCPAe85XibG0Vb9+k2tqX58dIObg5bbgFeyw5d/JhefPhit6v
         Qe1W+qBawajGUejDQo8h9fJFWNaOdVlfK1t5ioBGZd24DD7zKKsizDpfG94aT/FmiGoU
         31Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433538; x=1794038338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7dhaSy3OrxV4yiUaZyds5jHq2H3fLJgYLzowVKa/nDA=;
        b=U78IXR6gRj+5Ax6hntSG7XJzlBnDI0HUQ2/nOCyC1yHeQ9DpBl720PUlJdhQIks/IO
         CtjxouiUE+dl1XHmLjhr5U1XSMRm+Aqny04PTPR1GdIVwdSa8LAPUx5gPXH+OjK0wB0m
         hc58SPgVzh+b3ReMWxWMdaS1mDDAyuLRwGX/vQ6Ltw+UlnjimyOm85GZCnBUB4z/kyzo
         axFt7IEWbqesR63ZFLLtcVofRZakNRwJrh7gQnIg9HxeTBC8uk86SUQIH7fH6q1BxpwF
         RHQen1EhBUiryhN52250oTwVlLTcbmIPLRlJ57tQAOosIYRiL5kd6O9VKUDhPxpx12wi
         ABwA==
X-Forwarded-Encrypted: i=1; AKwUvBy4OPFZpxPuJW9G0I+CX+7vGyRVnV5v7AOhOX2tgQ4wSecXks+rkEfZgxp8PyFLTkabA88=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2KLY00fNR21sfM7IEVQs+0Bealdk4sh1S5Ke592CTivR9YVPc
	xVjqokvFaEvXxikX/8/Wyn5NawfW2JgxaSrKWho9Ppb+Wt2Gf/avwHHkMNrq3p2dKyljgUxKB4Y
	sLRw3c60gJGBDMo8lGXnqbBlrnuIYt1E=
X-Gm-Gg: AYBFou1M7FuJuJ2WfsinEbsic+zxXoiKng+OlqwBFg94lu3hLiRMuEP/GPJAYmGR8Hp
	qvpUP+JfpphzPv9cqb/urZPoMhkGYb3ysLF0ZYNTmoBam6De+0ucCJBUMZjdqCOAHAtTtJ2eyxq
	WJm4usu/lQsJ5GBcFC+GTBn6vyCTDLvxPIdzElkygP4aGPyHdFWV5nUGoO4KYAXh+FpoVYFn2ui
	D2fedQadqXg+hN2iGvl5tqH5pprpPcYy5J12f452jgTyWETqHWRr9UatvUc/KV2LexZ9u1tTORJ
	JZpSG+5BxrLxazLEsvphNyN+2kT89ZRFoBR72V/x/C7nFVBuXXa1E4JaiSLy5TV/VUK8Pt1AJRa
	oXhA7GZY9qm6iAfk4VF4r+PXzebjE+aMXx4Y=
X-Received: by 2002:a05:6402:a510:10b0:6b1:c2d3:6a79 with SMTP id
 4fb4d7f45d1cf-6b4d4384eb5mr2329564a12.12.1793433537491; Sat, 31 Oct 2026
 00:58:57 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com> <ad3158b3367d00fb78d2fa5a55b82d5f634c3d61.1793089879.git.gitgitgadget@gmail.com>
 <xmqqqzh6u7i3.fsf@gitster.g>
In-Reply-To: <xmqqqzh6u7i3.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 31 Oct 2026 09:58:20 +0200
X-Gm-Features: AclHuK8Hch6_BGLOM2Znj8NtMZsmab06avPcWZig-a2m62zo0DqfuHE_2548mjo
Message-ID: <CAHwyqnWM_GDhN_OSCrrwsuxuqwnc+mxi17H6Gut4mA=hAPPNFA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] imap-send: accept messages with Subject before Date
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

> > +static bool has_required_headers(const char *line)
> > +{
> > +     bool from = false, date = false, subject = false;
> > +
> > +     while ((line = strchr(line, '\n')) && *++line != '\n') {
> > +             if (starts_with(line, "From: "))
> > +                     from = true;
> > +             else if (starts_with(line, "Date: "))
> > +                     date = true;
> > +             else if (starts_with(line, "Subject: "))
> > +                     subject = true;
> > +     }
> > +     return from && date && subject;
> > +}
>
> The above assumes that an empty line that denotes the end of the
> header can be detected by looking for '\n\n' in the line[].  So this
> may be scanning thru to the end of the message including the body,
> because each and every line ends with CRLF and there is no two
> consecutive LF appearing in the line.
>
> I admit that it was eons ago I read RFCs on IMAP (like RFC 2060),
> but I recall that its definition explicitly called for CRLF line
> endings, and existing code in imap-send.c before these patches seems
> to expect that it is reading CRLF delimited lines.

Thanks for pointing this out, I'll take a look.


Harald
