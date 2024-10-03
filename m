Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCF6EB4A
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981057; cv=none; b=ffRy/ZV6eoLBxQ7ZUczxxsRJepqIxvuBlIKVUB8B70nQp/o9iOmv/2MVxDDsuMbU+zWOD//XtXv340DnahfXo60HhEXCu/9B+zyPTuDMRrILfvOulrdheQsMz5mpMMet0HKXWs7bbByfBT0kU0FvvAEMlpEOZHaoy2XrzjkD8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981057; c=relaxed/simple;
	bh=kOtAwmkJfQRbY1nb3X3EBbuneg+wUK19NeXaBMDEVmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYuL8gAcNSRNgOMXldOaWwnYlI0bG9POrm2W98WHKsaf9Lx7/Eh0UNoHwbec8PfxZN19uwhTFOxejFZn/DeL2mnCLpcfT+xqtbJtFYgufE60aM0a57iBNVgX4m1NXcPh7juQpybmsycQU3yf8txErTDcNCwdQlwfhiocqAz6tDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lFQDaPsw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lFQDaPsw"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2598a0070so12490997b3.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727981055; x=1728585855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkjQ06RAeEH3eJydvmMco0xaG6x58J5eso0dX5c6m8c=;
        b=lFQDaPswLC99JgPZCIIXejhd497bpeux5fZ9eTWdAivSPoZvtTmcWSBbTisnWZGfbC
         zA+Ke/owClfG1C/zTIaHY7DAYLou4RFkU5BaDE7xl5NByfaI1fjEYIP5SQn9/BxQ1Dkt
         +ie2LWXSKo9TcyxFJNc1Wb+PpdGlcoNQ6zKzS6QvWQWVg2jwpJEb5UCOIaIAJnjJsvFW
         PGZC1v9uI3PB4oFHGD7RZKZqAfzh7aVIBHQm/PuAPcUZep6ZjlfQZdWc7ktr6RwjX54V
         XL0iAnHAPHGTXV8qFnDRs/lCReB92XvT3XVrlnAKAYG/wic84FdAsXFLy8dD1cAU5tLw
         f5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981055; x=1728585855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkjQ06RAeEH3eJydvmMco0xaG6x58J5eso0dX5c6m8c=;
        b=vIK5yB1mUfL4NEV41ffnbkcvz5TyjV3ORGQQvEKQ0qoXzopQffmlf6/VB3srvZV36/
         s5l3jlYGpNsHzxkRJJt8ibutv4v29QbnccFOr4nVM9Q1OaZoPZB92lQhdRi1cWIVFaDw
         4doogE9xyjmb7tc2waRsVFrO6zzlFAe+40N1i/If/Xy+2VoVY9KrLEJntHajnuUr7W4m
         bDkevq0s/xtyZD/n0gmoKDGFSUBGNFYfKh+vXTq88dC0PiXWEkjtInzNNZ13G+G1eaZx
         34E3TXwnpy58/mIMSE1zn1YxX2OfSHxwA/PewmWQB2wXhDfpDKN6+/7hqxUrPR06rmBP
         uPRw==
X-Gm-Message-State: AOJu0YxIFlxFpMzlO6KsKLlFQRIat2M9L6XgU0Wswo6e7sc7kDpqAKwa
	9XB0snN851UL3fZONtLJtsV78jkX7oyu6AVpzbiSdGZZbEBPr0LzE3itDO2zpW0=
X-Google-Smtp-Source: AGHT+IGgpxmDJTTeMJvitN+hnKyFF19e3K//m+RvE/S1XnN8NTj/SufysiNbuYULlGQxXBrDTFTXDQ==
X-Received: by 2002:a05:690c:4604:b0:6e2:43ea:54e with SMTP id 00721157ae682-6e2c7036eb9mr2892617b3.21.1727981054684;
        Thu, 03 Oct 2024 11:44:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bbea9a4csm3298617b3.46.2024.10.03.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 11:44:14 -0700 (PDT)
Date: Thu, 3 Oct 2024 14:44:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v3] Documentation: mention the amlog in
 howto/maintain-git.txt
Message-ID: <Zv7l/Fw5gdkWlDxw@nand.local>
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
 <88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>
 <14497a9c-8683-440e-b179-2b10b4516d9c@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14497a9c-8683-440e-b179-2b10b4516d9c@ramsayjones.plus.com>

On Thu, Oct 03, 2024 at 07:32:04PM +0100, Ramsay Jones wrote:
> > +      [remote "github2"]
> > +        url = https://github.com/git/git
> > +        fetch = +refs/heads/*:refs/remotes/github2/*
> > +        pushurl = github.com:git/git.git
> > +        push = refs/heads/maint:refs/heads/maint
> > +        push = refs/heads/master:refs/heads/master
> > +        push = refs/notes/next:refs/notes/next
>
> Hmm, s/notes/heads/g perhaps?

Ugh, serves me right for trying to send this out late my time last
night.

Perhaps Junio can tweak this when applying? Otherwise I can send out a
new version.

Thanks,
Taylor
