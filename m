Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B89246BDE
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456643; cv=none; b=sFPF5Sw79CM0ISCTH7zFFTyrs1K0R0Y+rjWEzG2OWp6TdQbnqUoDrKbR+knMawsi/X3GsvBNrOC7Ao/MnS+c7du6YK9ZJTUiunjn4ixbVULP2lvcI3y10sr9k9EfuGyFfxamj5XBBuUW6a00LPPvKpxRE7PWy0sZAT5RrNxECz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456643; c=relaxed/simple;
	bh=fP3kaYzlI67M2ACVgsPX+c7EiHxUdj9iplI/ZoZ2IYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qidQQe1SPIStt9FojYNoTnjKq2Vx+dbQ6FrrIUmz2Ho5yyV34Xpi5ZXkLIc+rvPFDUott647tHHLT9s+8S3zfPjRHaPzj6LTVV6pji9KnXwgjVq4z99KqkUr9hN4jFXel98voiR3v99Kao47hFSCFCsMDsV5i23lKrvtQvS79nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr37bwoE; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr37bwoE"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e32821b5bcso1486739241.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760456641; x=1761061441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP3kaYzlI67M2ACVgsPX+c7EiHxUdj9iplI/ZoZ2IYA=;
        b=nr37bwoEMQwSv2KDPilhGVci47fbQex4E8sUgtiPKnaip5loy1XV65zAkpku+D9CSu
         XQVZcAFUIdOimlO1eMH2pwaGEj2TlJj1HP/KyJRvnATymekCCUf+v3EGyEXyAvGLm6a/
         WAQAjIBeySmTJZSzVD4dY7lvgjQ5ex+TOCEF3qYvxh75tFWPeZ2G6CnauDelEZSk8/n5
         mBU+du1xC31CvQ8jna7Rhupl8IHwAe8MSuc+OEX8oJL4xdXzFQHZ9A5QugA77sIy57Yt
         X1Zpr9C9I1X6nC6QCDZl8NgCGqtHLcALz290unlTwRIeIgyM6fpT2WvJHgtY0zO/UUVJ
         lgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456641; x=1761061441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP3kaYzlI67M2ACVgsPX+c7EiHxUdj9iplI/ZoZ2IYA=;
        b=JCl3BJNyHvJvkekX9SXomLWam14Cef9x5NUfT+KCPVDbkEOGSpF1qM5cC4eao31THR
         XsdMfEgZss1vPi/150eskKgT9Suo5WkzkJsli8wqtNG3mVx4jGL0VFF6fORNA9YiR4zU
         SVmH9lBpCaUitioGjO3+0AzFbYJyNcw5sPp1k9+ziYdBzY3JGo8wC24XCaar8g2BHPwy
         ACvFRBRgFUZXvEw7Rhz2IuRK1LeoXZBwaV+gbjVleNkSxEzo8WV1fQxIVIOYafu4CwuH
         mKJiEkGCsbRPN+Z3N9ORaRjc0ekxvDWqDAkZLM10+c9xcBrTytetVlDLQx1mbLs4SHtq
         h4oA==
X-Gm-Message-State: AOJu0Yx4tno7/IgwToJ4HDsvi/64AFtDFFkm7XVyohI1SDpgPelSgn/X
	y1WvUlyXnmvfbcY6ji5SrqFb64geJAI5fSp+zaE5G3jxdta6oEjC1A6u84IunMir4UjS61372Kv
	eWAcOob64811xsUhHLzi476vNBpG2nQbTE+VoJkQ=
X-Gm-Gg: ASbGncvm4qV/dmoq5NPTApky9tPT/22vBoz88E1v9a9KhtrPRNhd9wT7aSWtbz1fVe1
	shCpiFOeknTGSdUuhjIjHYKEk5CIW+p/txV3GF376OGbT3ausM7TDMq21WXzrl1mXXZcdu8wp40
	VjW5ZdCtlRIpqTlCgiCF9hcpiEsyPioYHFzVXO55C10t05/HiIuzRHq05ZJ4ndn2FuyJKZfswgs
	d1zPFOcffluSj96IYrILnY/7drvvER7QcQDP4yf1klxwsJtxnIyqKDhCg==
X-Google-Smtp-Source: AGHT+IEVEGGsLcJy7brsv4TGO++O39S+cE+1I6mSzLinMVTIHww4sENr5mj7Ch+LoH30RYzuKPZjZuWXmFLCet06BBA=
X-Received: by 2002:a05:6102:2928:b0:520:3f1a:c520 with SMTP id
 ada2fe7eead31-5d5e2215305mr9380281137.7.1760456640698; Tue, 14 Oct 2025
 08:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013122824.15216-1-solobarine@gmail.com>
In-Reply-To: <20251013122824.15216-1-solobarine@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 14 Oct 2025 21:13:48 +0530
X-Gm-Features: AS18NWBTeYBlrQgCTXW0IDfuB67oHNHS5pbXk9vUqUqGbre_DPvOPjMlggpgDnk
Message-ID: <CAPSxiM8fJamoTq1sJ6U8GSE8nAeDv5QhNQdThz-8D19_Maz2dw@mail.gmail.com>
Subject: Re: [PATCH 0/1] *** Update test file path checks ***
To: Solly <solobarine@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:58=E2=80=AFPM Solly <solobarine@gmail.com> wrote:
>
Hello Solomon,

I noticed the second patch in this thread did not get to the mailing list,
you might want to resend it.
> *** Update old-style shell path checks to use the modern test
