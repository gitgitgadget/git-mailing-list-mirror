Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAB1BF50
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737660; cv=none; b=Vtwp4yrhT60QRxE/0eul6qgj/ARmbToDArfTq7ecNAlWgvz7PfmeaZlwQV1YWeDLO68oeEth9YLEaLdkdWOdoq/Jtz5WyrxiPJxxzloNXgyQIkZFxIPS3RWdt1bx23wBU548lBpv8SEkIz84JHTg3uyLOxSQ6EQShO017GwJ0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737660; c=relaxed/simple;
	bh=zgVhCGC5AXxinUEJt9X35aiXqMVOaI89EWj10tgpWIk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O1IV7vFwrt90lPfwd1/hrP9kmKJ4URo61ef2ofKLzkXPHCuBCluM0L6DL7JE2DIDwUnYGqGssT7KY1+YjfBm32rXtzjhdxA8IXicyVM7oQU8CWa4pmnvGZmUNwilFd1YziJZshkpGKGIAhf1tN8wAL27EmGZaaf0sxVaLRcGBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQlUvTae; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQlUvTae"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c819f6146so7702603e87.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718737656; x=1719342456; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P625zsGCOD9NCOEcBp7BgdNy7ig/qHdbX0sOH7VzWvE=;
        b=CQlUvTaeM3lss8fGfgf2d4PhpMXXgt8cat7zs2KcUrL4C+UODwtIT9luiUEe0sZJmT
         GTt8uPp0gA6f1AMQE0lbq0Jswf0Ks3e9ZMieMGsl6Slj4UdcmOlYMNGAnMjb1VRSPgNu
         /QnsBwDnMSaa9h3e4Yp1K/h0S3yiqvs5naX/w4kATuDiSvy/+AZzylu2VvDX/De7COjX
         pioYhwzsYUKdEgx6OBIySZkOe/F4wKXyR+AMzmHaUuGjzCTlUB11VIMWb1mDkQ7lRG/D
         oDzYXeDLbuVt9f0UHkZEaa1Iso5KGUPhHmFnbNDC5S0SIz+HBiw9WjL/BmEV9hJR4tf8
         twpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737656; x=1719342456;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P625zsGCOD9NCOEcBp7BgdNy7ig/qHdbX0sOH7VzWvE=;
        b=NeuCrYyJJzm1a7HFf0uYlJKAlogSjqZD2ZGiF8WLWBKhnQQyCKHyFXU+kz45IYxjcU
         l1R0RwmiXIxTQrb7piYyo7XXUWW3nf5o/tEaJNaQmwgEiB1zDXdNmCRRRChOoEx5tPkc
         uFvcSFoX0Tim+c3C2iOLFtFvox+EZnTEKxgBSFP2nSjcLzMEqC0bh2e5G1X6m8jX8AcU
         SHLrOQlP8W5OIR1UoYPgqhhhrh7qmNWioLSsxYJzydluwni+8E8f6fSAePmmO7H26JcD
         o9DhLD5WDCReMmR1s/TWjrqiu9B+u4Ld58WrEHf/bVTH9MggvhCCl+ynjVgB8RsfSb8B
         eMdg==
X-Forwarded-Encrypted: i=1; AJvYcCU0s7bSArv2tMM77uBEPZb4YdybrUQ5cbxrRpCSw4a8E4oj8qYhmwYk+0VWnjxVSwLJXdvPoPMjG/BYEycHJViQiJP6
X-Gm-Message-State: AOJu0YwVO6L5VDHSSyOoJ2fL3piHzSH1IOq88T3XhnvHWJPNjW1/jLwy
	i3Z1qH6Ee/y8gWOjAYScFQXJPwnFqLG/qIM14CLkSbZ0JNSfLrTQ
X-Google-Smtp-Source: AGHT+IFRTkOolKtdoJxK3VRqEhDl+d3JgjlaOtCjR7L91viVlr6tYZD7wfdq1QwmOGi/pWoMcdyg6g==
X-Received: by 2002:a05:6512:1c8:b0:52c:39eb:40d2 with SMTP id 2adb3069b0e04-52ccaa5e026mr278812e87.20.1718737655800;
        Tue, 18 Jun 2024 12:07:35 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:565:11e0:94ec:6f6c:b5bd:ddee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362907048b0sm1400831f8f.24.2024.06.18.12.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:07:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Non-blob .gitmodules and .gitattributes
From: Alexey Pelykh <alexey.pelykh@gmail.com>
In-Reply-To: <20240618183156.GB178291@coredump.intra.peff.net>
Date: Tue, 18 Jun 2024 21:07:24 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <14349714-F8D1-4F7B-BB13-4FA39C6819DE@gmail.com>
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
 <xmqqbk43ilk3.fsf@gitster.g>
 <20240618183156.GB178291@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Jeff,

> But I'd also suspect that other non-POSIX platforms would see the error
> at open(), and _would_ actually produce an error message. I seem to
> recall running into this before with Windows, maybe?

Is there an easy way to verify "what on Windows" part? I'd be happy to
help, yet I'm not sure I got it right what to look for.

> So even if we loosened fsck, I'm not sure if it's something we want to
> support. And of course my bigger question is: why? These are reserved
> names that have special meaning to Git. Sticking stuff that Git doesn't
> understand and may produce errors for seems odd.

Surely, reserved names are reserved for some reason. If there's a legit
reason alike cost-to-support, having an objection would be dumb. Yet
if supporting would turn out to be of an effort alike dropping the check
then it would seem having that check brings no value.

With that said, if those are reserved names, why .gitignore is not reserved?
For consistency at least.

Cheers,
Alexey

> On 18 Jun 2024, at 20:31, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Jun 14, 2024 at 08:35:56AM -0700, Junio C Hamano wrote:
> 
>> My knee-jerk reaction is that we probably can safely loosen by
>> ignoring non-blob .gitWHATEVER files, but security-minded folks may
>> be able to come up with some plausible attack scenarios if we did
>> so.
>> 
>> Comments from those who have worked on transfer time and runtime
>> checks on these are highly appreciated.
> 
> I can't think of an immediate problem security-wise, since we know that
> Git won't actually read the trees. In fact, I was a little surprised
> that normal Git commands outside of fsck did not run into problems with
> a .gitattributes directory. What happens on Linux, at least, is that we
> try to fopen() the directory, which works, and then read() returns
> EISDIR. But because we do so through strbuf_getline(), it just looks
> like EOF and we don't complain.  Arguably that code (and all the other
> loops like it) should check ferror() and complain.
> 
> But I'd also suspect that other non-POSIX platforms would see the error
> at open(), and _would_ actually produce an error message. I seem to
> recall running into this before with Windows, maybe?
> 
> So even if we loosened fsck, I'm not sure if it's something we want to
> support. And of course my bigger question is: why? These are reserved
> names that have special meaning to Git. Sticking stuff that Git doesn't
> understand and may produce errors for seems odd.
> 
>> Having said that, the checks for .gitmodules and .gitattributes in
>> fsck.c first collect objects that tree entries with these names
>> point at into oidsets (this all happens in fsck.c:fsck_tree()), but
>> the actual check for these found objects are done only when they are
>> blobs.  Only when we encounter a blob object, these oidsets are
>> looked at in fsck.c:fsck_blob(), and if it is .gitmodules its
>> contents inspected (and may result in a warning or an error).  So
>> the "checks" Alexey reports may not be in the runtime or transfer
>> time checks done in fsck but something else.  I dunno.
> 
> The fsck checks will kick in. When we fsck the containing tree, we learn
> that some oid X is a .gitmodules file, and queue that. The hope is that
> later we're fsck-ing X anyway, and we get to validate for free-ish. But
> if we _don't_ see it (either we checked the blob before the tree, or
> perhaps the blob is not even part of the set of objects we're checking),
> then at the end we validate any queued items that are left.
> 
> We have to do it this way to catch the case of somebody pushing up blob
> X in one push (perhaps with the name "foo"), and then doing a second
> push that references it with a new name (i.e., renaming "foo" to
> ".gitmodules").
> 
> -Peff

