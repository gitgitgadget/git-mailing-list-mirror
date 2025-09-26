Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3401805E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850695; cv=none; b=I7YsDEtA/P6nfzdpXiDsgKlpO3yNVxVhVDw8g1XfO95LktB1E+M2MumuI89jCEzKvuDw31CqU4VT30hczGRuYPvm+K1ng0/GDX+iT+Xp4TdUHenu7O19c8RVxDYByI6lWrSUHNNCgFO7/8eW6VB1fuapFULzm14JlZDfC/Mmteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850695; c=relaxed/simple;
	bh=vDDxdo3ojlZ4Wye88zsJtafPg9Z4NEn9Zf8NLZjqD/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+7OdVmLoUsNk6twx5RHYYIEM616+v61bTgK+VL590k4rIdRhdn+ujs0JuBTvpYdwomhFY/hlV6ihWraU8Xn1ZLIDrCIsi/HjttQQpiwRFFi04hUVJNWfJTRIfz2KptqsPZc7oAr1kjzoYQgyqFiMHTMlseuPraUpHtbvzSg860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdy2xX2t; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdy2xX2t"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-35b7f8e07d5so1281143fac.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758850692; x=1759455492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FBNApe9g3ULrayqRh0991NoK5j18ZUdQF+6jssrw4nk=;
        b=Cdy2xX2tt9CnVNKFU/JNPzhxojyrrXWGRgY0rDnAjeiS/lbJ2lyvC1/ovncT8WQyvL
         KnEhaWFKJRRlBraO/wsNwOn3rzp57yxGa6OkUhdA8AGqSfxFmKA7ouHYY/TLncFOqJtI
         4i3PtlqWMPUaLjBOdMGTIAIocVzXLwxc5yLagImUGvhcht9QkBtdBYUeXIqvNSnb/rCD
         abv0LnWclE5V+k8X+TN8B3enHaPs+fzOdTDn6vy2uPT69Q0Jdu2UxYan+qB7iprDEB3W
         yx3USMZOoOUlcQponSMa2ezf+tTFFhfRTI0Y/aYtGn8PsRd+mGPQz7lxQD+E/IdkYoia
         owBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758850692; x=1759455492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBNApe9g3ULrayqRh0991NoK5j18ZUdQF+6jssrw4nk=;
        b=lPQCJCjdSTe/tcqDJdfCbE+LUUMQsfJMkPaxwVjPwLexW+8elNeefR8/aJmJqogUVH
         D9bgbcl0K/qUcrXnMq4XdM8XJaNjsj/r6uj8nG+S5jxgg2iGtPLw6jNPq01+zlvJBkv0
         NP86T1FmYZfVoUGpBXn1u3h+18Hpauy2q4x92UhFoDOH/ZhXiqNmlvgqNKzS/yHKRTq4
         VbZm4D+UVahOxGIEyWKq9c01s+sTOyk4hx0BFtXzBXZjQXZsi5bAehgCyCMnyaB9SBUR
         p7bIaGyVG8bl5Q2huTuq3HSKiCS2RXFJNMDgeye2S350vH4BqoMg+NGpvpcIjTde0GYr
         lCPw==
X-Gm-Message-State: AOJu0YwxepKWi1et/IivniTOc1b/BYZ0J1SR4OEOJ8mVYjwDF4sGfi83
	RPLSdOMRxLPO0/DWkkpJDfNHZ9v2wHUxoUhX0eayiK5ZXFm2ow6G4UIL2vNEYA==
X-Gm-Gg: ASbGncuh2GNDSkv8zVNiGmK979pjeHjdM1nfyr/KoeMc+9wzjFlw8WZZE9SPyU7yn6Y
	wpfN1EcDl6aIp2vpiv0Ocvd78sTR4I5dkOhC0ZeVy0zBOzUaZ3UHBBGvqOl1giPS7VkRYORa46A
	CZpXUJgIqEaJAcG6sYOmbSsiE1SYMdvOpIOW+mQvlSKHwy9QLqlhsMviUmzAJOzXBzz6pSy9Sj3
	O2KtrjYNEYZL/XXz/5cB2DPYq3R/vHrPYnD81lB0ApQJwsbDigDVchSrVXCHMSVo8I0FBqUVhFX
	BPRiciX66ZS52ntotUCIuU7Q7qUEPks9pBEDu9W71ZchfJUlC4wKwLx5J364gnqVV9f10es9qvH
	p/GD8HZlIB4yjvD94
X-Google-Smtp-Source: AGHT+IEfbFWlGhpLIrKwvzFqrL8Jr8fSE8yUpLnoNhfJP/t1IdjQ3MPQWrVs+nhIJ8H/0xmmRh+0eg==
X-Received: by 2002:a05:6870:8094:b0:358:ecec:93 with SMTP id 586e51a60fabf-35e903d565emr2813017fac.0.1758850692295;
        Thu, 25 Sep 2025 18:38:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363b3ffc433sm1012782fac.28.2025.09.25.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 18:38:11 -0700 (PDT)
Date: Thu, 25 Sep 2025 20:38:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/7] builtin/repo: introduce stats subcommand
Message-ID: <wugagxpikclvhv5ajxzmeb42rneuv3hoi3bd23lqt5uysdotdg@gxvmipzrajdu>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
 <20250925232928.3846-5-jltobler@gmail.com>
 <CAPig+cTSpq132SZQHUzYHJNqY-nOYizFW71Lu3o6a6m3jDNVJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTSpq132SZQHUzYHJNqY-nOYizFW71Lu3o6a6m3jDNVJQ@mail.gmail.com>

On 25/09/25 07:51PM, Eric Sunshine wrote:
> On Thu, Sep 25, 2025 at 7:30 PM Justin Tobler <jltobler@gmail.com> wrote:
[snip]
> > +       strbuf_vaddf(&buf, format, ap);
> > +       formatted_name = strbuf_detach(&buf, &name_width);
> > +       [...]
> > +       if (name_width > table->name_col_width)
> > +               table->name_col_width = name_width;
> 
> Here, you're using the byte length of the composed string to compute
> the table width which you will use for alignment purposes when
> rendering the table...
> 
> > +static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
> > +{
> > +       size_t ref_total;
> > +
> > +       ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
> > +       stats_table_addf(table, "* %s", _("References"));
> > +       stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
> > +       stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
> > +       stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
> > +       stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
> > +       stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
> > +}
> 
> ...however, here you feed the function translatable strings, which
> means that the display length of the composed string is not guaranteed
> to be the same as the byte length.
> 
> To resolve this, you probably want to investigate Git's utf8.h header,
> in particular, the utf8_strwidth() function.

Thanks for raising this. I hadn't considered the fact that the
characters in translated strings could occupy more than one byte. I'll
address this in the next version by using utf8_strwidth() as you
mentioned. :)

Thanks,
-Justin
