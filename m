Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A227424C
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695980; cv=none; b=IJYxZnfN/DZxYxhD46allv1F+t29FblCtbRnYHEwFpt4E17f68z0VjVe0q8XVwaDPUxtEAIXreT7Xp9F/xgw96JRvPIXtCGGtZloxPSyoDeXMRy5cSwRYZa68h25btmtJPY3Mrn//0NNzjrZI4YWJwSHLw+j5Gz8gdq1WaKqCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695980; c=relaxed/simple;
	bh=UG6yJIs/D2ibKaas9FtYYTnV0KD+JBnoSX70lOPUWFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYpj8pyRopCDKNm59n39ihQIpzE3aiiWlwazmoIMNqwUlW/YJObmpCiwHMTIlA9mnBeLlpvO/IZBlyF+MnnDFF4P4v9saj8uu2pnZC7SuHjESDxoqfPBJH88fmWXt84N/HBXnHfwfDblesy9IA4KtC/osPs6rJTdruLwqryH2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYlgr1Ol; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYlgr1Ol"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f4d935084aso1064520eaf.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695977; x=1741300777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm0sTSzqh4FNSX2IgH+4Xoc1qkmXHlEtKbZWVk1EUTA=;
        b=ZYlgr1OlkyI1QsIiYAgJt7zj4VVQQ0uihfve9sEb13OWxEL+IBjby5xQ9OBMrfCa70
         DxASuoMpt7ED2B522TSGzoul64wlzvWujr9tUxCLhYd7+DlStf2z7G5VN1GUMoot0MRp
         31NzoOPV8SGukCyGhWyE1iOql9OLPa5RxKSgZS89BclvmU6B8CG5CnK7SY7qP2R2nGi5
         JqVb6/AuspnlDBg2CxnR+ERDBTZzI68lale2rSqGXOf774nvLxN+pfCldc86R0tpH3BV
         yFtoL+Hl9VXi356Hzr98ru7Kl+bX+WqRlS0a2JGlm3IM5iatjYnDbiW0Pb+DvgWt0hE5
         0I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695977; x=1741300777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm0sTSzqh4FNSX2IgH+4Xoc1qkmXHlEtKbZWVk1EUTA=;
        b=Ikygt14h4sKDfEkCQHtqF5ddEhjabe5VwJmXs9sS8m4RhYAIlJeQbFN+BZN7D3q57L
         DbxgHYoFjxnagztPyeyk/Yu4dNRNLXjq8MeGPgFFgNSMclWfAnMxdlIYhCk59Uw9c6IL
         CMIpDMzH2v7rSC7QQsl952ln/zqcj9zZ+2V73R+9mOG+iF47qmlYYU8TLpFIkJpxGHP7
         GqsnWpyLXFhTKsslrx7hOjoIYf9npbQmxqnZyalIyWjIFRfl+7V8vFRry/5OxFbMKJU8
         hE64t4SpbSROvBld0+wPNnPSwXVetzMtEWFcTMDh5zxClq5NujqHPUAf8W6Jn1ws6t6j
         iOfA==
X-Gm-Message-State: AOJu0YyEOBZlmuf4JULy9sPXrFNiO8utJWu7YgOe5zuj/nDCTT6GC0H3
	z/ewSEF0W5odhqBIgadecmH/WxYu/kTkh4ynMas2sYr6hItn7aJv
X-Gm-Gg: ASbGnct1kApgx5AYy5AgV5bEfmmsE6mvCZzE5ZDAhq4h1PMLKc6vIJ6cVoXc3wWFbbT
	eIa3pZUX4GC+cwQs6fe8Q0ug0SovcFVNysHpprku5V+mNkudIEbIM0ASoQr573Ajjx29jSNbFph
	g1z/z1PYAv/NXKxw5qer+C2bDmCeiW1Xf42hrMqPSDpYHnKza73R9LpOzOYesxI7y84510o/6tG
	RevfoxQADPR4RdS14NqrjuI2jrfETft4coxNPCbtOkdMUXt2NyCqkNpelDPqjRCIzy+SPe6FDQh
	WDZSxBOhifrdiTub1h8=
X-Google-Smtp-Source: AGHT+IGJ/AMAiuOz0yBgoKy2O11yhF9zKj43MyzBJlM46CzE8sQUfCy0EpThDpWLc98UrWYqm0qRFg==
X-Received: by 2002:a05:6870:b292:b0:29d:c85f:bc8c with SMTP id 586e51a60fabf-2c1788059efmr619933fac.36.1740695977618;
        Thu, 27 Feb 2025 14:39:37 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c15c446bcdsm465671fac.47.2025.02.27.14.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:39:36 -0800 (PST)
Date: Thu, 27 Feb 2025 16:36:21 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
Message-ID: <z5mea66lqrhcjm2da5qyg7e4n3wvxsilhtta45qie5m6hub5o4@ftdgftsmaeul>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
 <20250225233925.1345086-3-jltobler@gmail.com>
 <CAOLa=ZS6yqquxAL_vCUf0FRrMbA6OLeY1VjqMv=pnxAo_17zLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS6yqquxAL_vCUf0FRrMbA6OLeY1VjqMv=pnxAo_17zLA@mail.gmail.com>

On 25/02/27 01:35AM, Karthik Nayak wrote:
> > diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> > new file mode 100644
> > index 0000000000..9472b10461
> > --- /dev/null
> > +++ b/builtin/diff-pairs.c
> > @@ -0,0 +1,193 @@
> > +#include "builtin.h"
> > +#include "commit.h"
> > +#include "config.h"
> > +#include "diff.h"
> > +#include "diffcore.h"
> > +#include "gettext.h"
> > +#include "hex.h"
> > +#include "object.h"
> > +#include "parse-options.h"
> > +#include "revision.h"
> > +#include "strbuf.h"
> > +
> 
> Nit: I could also compile without some of these headers, do we still
> need them all?
> 
>     diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
>     index 86e59a7e3a..1aea2ee726 100644
>     --- a/builtin/diff-pairs.c
>     +++ b/builtin/diff-pairs.c
>     @@ -1,14 +1,9 @@
>      #include "builtin.h"
>     -#include "commit.h"

Looks like this one is unneeded. Will remove

>      #include "config.h"
>     -#include "diff.h"
>      #include "diffcore.h"
>     -#include "gettext.h"
>      #include "hex.h"
>     -#include "object.h"
>      #include "parse-options.h"
>      #include "revision.h"
>     -#include "strbuf.h"

The others are directly referenced. I think it would be preferable to
explicitly state them instead of relying on them being included
transitively.

> 
>      static unsigned parse_mode_or_die(const char *mode, const char **endp)
>      {
> 
> > +static unsigned parse_mode_or_die(const char *mode, const char **endp)
> > +{
> > +	uint16_t ret;
> > +
> > +	*endp = parse_mode(mode, &ret);
> > +	if (!*endp)
> > +		die(_("unable to parse mode: %s"), mode);
> > +	return ret;
> > +}
> > +
> > +static void parse_oid_or_die(const char *p, struct object_id *oid,
> > +			     const char **endp, const struct git_hash_algo *algop)
> >
> 
> Nit: without double checking, I couldn't tell what 'p' was, can we
> rename the variables here to be consistent with `parse_oid_hex_algop()`?

Will update

> > +		case DIFF_STATUS_RENAMED:
> > +		case DIFF_STATUS_COPIED:
> > +			{
> 
> style: The general rule followed is to open the braces in the same line
> as the case statement. So `case DIFF_STATUS_COPIED: {`

Will fix in the next version.

Thanks
-Justin
