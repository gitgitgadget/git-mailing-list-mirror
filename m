Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250151FCC6B
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758614; cv=none; b=TmFf+uPv0k2MMPQh6bbr32Vn9Df0HdCE3kcbRESuhKwP6XdFayFIJvrPquqQpOIKfTK2V2I4wfpTPbSrXGdiTXgOhukxb97mkf3yYZrJmGMom0xiY9yBmIU876ps6iiTcn7LGCPLMbIpjGI7EsXFa5YHBSfyv4rSl3RfSvcRzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758614; c=relaxed/simple;
	bh=SwczSiG696/JBrVrGtKQD41f6UUJODTCkQM1mKY/u4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uERS4pm+qsZXjmT8HVC9deRiuqVxgs+XPXZzKzM66JIP4PMbZ05WfC18dS2CWh1obUE820VkWk+oSr7O4eScV4NCQhUplmmJYCYMW6v/ZjIZOe/Jkprve9e/3PoqUEe3nJ1zvQBQRBvtIqLS14HkBwmfFKFo8RJuciDQENppD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9ROJOeo; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9ROJOeo"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc52deca0so2394063eaf.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730758612; x=1731363412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvs8OWww0vaQ7zYWUgaqW5mu/Fz2GD9FpiV7ktf8xLI=;
        b=M9ROJOeokvjat10KHySSHXDNj7+Pyt/TU1HVApfH1VIUUGYHyj3seK/6W7Rq9A2rC1
         SezRBGrlpYW7SE6EailzyddREwzLr63l9glWBgVVhAtEx102C7N1t0jpeIRzR4Gxr7dX
         ggLAaxv57wiBW+RV1UIDWMW0/LFPB5+mTgbXcM2EhwlnlAcdhDMMM0xaEJeGs9j0Y6lj
         27s66XjwhEfeaYTvV+XFh0z/BXM9rmar/Xa0Grd92d2J/SPK7ehkbOetuhazHS4js059
         jnExWGkpI31G5LgSQvwxKpB4AwP3nzsfJOEh567pNLBIS1W20+7Yo1661mcEl4Z9gMjZ
         nOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758612; x=1731363412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fvs8OWww0vaQ7zYWUgaqW5mu/Fz2GD9FpiV7ktf8xLI=;
        b=wzB9cbAOvz0M9SFPEJCcJcxZFQmlQMTUkjy2PzM6szra/2GIe5wjveZjbXvJXuoaij
         xCidcKKX595goRU+g7CclYC3UFSEycqzazBegDDu/27mXG4sGvHwY+tTkKOsSPr0J4it
         bEWtjYDFxCSJC11SjonR/wp0KAA7SEZLAgckuBxKfQqX6GZePnMVDj930VJzLaiOTXvG
         EgUq5Y4EGNgAaUgsXc+HqW4wDRc65cxub363C6DvNmoJlFK2WwjpxorOt4qFHhC3HD7g
         YL7hmofAHLBlXlCukWp0QZJ27lajoiQBi2uHEItRSLT9nETZ61cHPYpnwZ1/Lyjo/sF8
         ng9Q==
X-Gm-Message-State: AOJu0YxH2YCmKuC5XqIg538ir1lf3v0DtX2pLEbyvdO+zDTYEmKyvluk
	Cg3O8K1uAtRl3nNisTjdHrLDjc/ul9zbfY1zxDtkI5Jhov03dTILx/JRYUf/
X-Google-Smtp-Source: AGHT+IEa0WJ1UvYgMY1HQnMTYUBsdx54/AgMdU1V81xeMF9NXfKmpZv6rXpsnqrE2PBXnjDS6iUXJw==
X-Received: by 2002:a05:6820:1c95:b0:5eb:6c26:1ca0 with SMTP id 006d021491bc7-5ede633c074mr7891581eaf.1.1730758612187;
        Mon, 04 Nov 2024 14:16:52 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec7064a839sm2006403eaf.44.2024.11.04.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:16:51 -0800 (PST)
Date: Mon, 4 Nov 2024 16:15:14 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 07/22] pretty: clear signature check
Message-ID: <oujqbaznoam2vbvw3vzkg47axqisfutihrc6dtfl5ij7iufn47@7e73cxaz4pna>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> The signature check in of the formatting context is never getting

s/in of/in/

> released. Fix this to plug the resulting memory leak.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pretty.c                         | 1 +
>  t/t4202-log.sh                   | 1 +
>  t/t7031-verify-tag-signed-ssh.sh | 1 +
>  t/t7510-signed-commit.sh         | 1 +
>  t/t7528-signed-commit-ssh.sh     | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/pretty.c b/pretty.c
> index 6403e268900..098378720a4 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
>  
>  	free(context.commit_encoding);
>  	repo_unuse_commit_buffer(r, commit, context.message);
> +	signature_check_clear(&context.signature_check);

Initially I was thinking it might be nice to see the
`format_commit_context` cleanup extracted to its own function, but being
that it only has a single use internal to "pretty.c" it probably isn't
worth it.

>  }
>  
>  static void pp_header(struct pretty_print_context *pp,
