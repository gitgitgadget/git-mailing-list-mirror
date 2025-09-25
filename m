Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF735957
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805284; cv=none; b=XDxoneU5/ZTFgNM6A/xN+W56bA8pQWfLPcGln9D/mds9VL7pe+yvQH9e8UN8f+ffAse9Y1Bo7fcbqMZh4TP30RXHsWQI1i7AfCdqsnLvQUpXYh6WJFK2gTCURBr8VcXvTNvMoy6wwZE1WcpBUzLJOIOE2vlfUorm98wZZgo5kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805284; c=relaxed/simple;
	bh=5CWzjfGixhPIkf9ZLYWBWJzWKJ7urc+MLyNagFpVUeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzGxCLKCuzjVD9S1eTYSQyy0seIEZZesWBD7hCjcdScNXaQo072363OiSY3VnDPGysPPkz78x9HAXBFJCOHXODLK0R+VwE0PwlcW6i5lEUHxHoRmcEU5lqzqbqiURJnlq49CBoXyLjDcoIvpO8yxxx2VslwJxr5ipEkhVYNAnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSkAz1E1; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSkAz1E1"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-63b7f426926so336384eaf.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758805282; x=1759410082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rK8wya4pnTXypOpcsZcAkDwMi6HpuMneN5CYUjbXCMs=;
        b=TSkAz1E1s71WvTlOg3Bj7KKCEiWmMpqVy3RHU4vahJbvVMsvI7qTcrvAvxCKQqfmXg
         +3OhSGKkpPwcVuCCWKzy5TiDRdw75CX2I3paEVLLFtSaYFfmQjsO/93wnR3NCAOcFlu7
         TkbMtZB++6xmayaXdPIt3Vc8qNW9oFryn1ZxjIn7vzJocLrt98qUsH6sSyho4siqvRJw
         vY2f0PXO6HCaCTgYN6zSTyJl043LVVd99xhGF4WdGb3GY2X3S7q2dO92wOa3jh8OMBHI
         30iLEDseFdozeU5kev/75Z2aGOJFUZdEovxyfHp0XCPor9VwgPsXJO++XBFpU9UMBcXP
         7d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805282; x=1759410082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK8wya4pnTXypOpcsZcAkDwMi6HpuMneN5CYUjbXCMs=;
        b=ai/QlHH28ZEQI5d/H1t/nuJQCKZ71oXE2nsAI3vhzcvCdnFBcXVZ21zk22NSxoeXYu
         u/pb6MlCOBdw+82tZg+FeXKmmekHQpZZeIIR56ZfpFXv5EJ4whaPPckvyfHjYqFZXtMm
         UywHMWvdYyvjcyYTKwPf5UzcWDNhpv0gudsW7nHDa8LAfmGXP4P8fmIiOoGijbgjHarQ
         ixwNuWA59yTutU1pFalNRCjLABT5nZUMgOEAA1nZ/UNXOj+08Muj557wi/OiGgZ3gJXj
         aSN8HWFLM4YLX537ahhNN9kPJ+jCH8YiNiuGYM7E7V0FuAbEXEkPE/ZgElSqNf5k6yfM
         n1qw==
X-Gm-Message-State: AOJu0YwsjjTubqV9KEJo/kZllEGtNPIqQC4gThlolrbi7hdfs2BbBrtE
	NJtNTe8+JWBs6tG5h0bH38Exj5dikYbpaeyteflUsHQf4uM92Lg0lUoj
X-Gm-Gg: ASbGnctEonVEKmotYMvbQS+jR1accNYiH23v57gmSRoq1XXYchuobH4nxtT1LxeWxxM
	+k3AWYhPhlGBeDUUEk0hE5a7/o9zNsOlc2L+sUxvMpUhAYSy7PXIybx511KsOQx0Qvl9SuqWlo8
	9CR0Bw9WjunryAPcsmA6dSVZF+fsQWU8rhC3RPZoa0ljxyfp399S+amSwgdcDrk4S1i9A7ztMIS
	w1gzdytqskXvb265jGdjCqUfBg6dGwHXztiGJvI1g0SlArQ+72mB4G3Su/FC14krAX0xLcmBdP2
	jlV6EcuTZFd6uRDangGWDQGoI+beDcA5lMrVY4BgabBNf3G424+j4bBXNqVO5nVc///n4Ua60yb
	OXQZAuRhwQExubo0Y
X-Google-Smtp-Source: AGHT+IG+aYtVLjHjJPqUZelhiORQw3tOnWOxNHuX64WoE4Nm0jkh81l/frhSZzztvr609p7302R3NQ==
X-Received: by 2002:a05:6808:f88:b0:439:b9b4:2d77 with SMTP id 5614622812f47-43f4ce618camr1615299b6e.34.1758805281640;
        Thu, 25 Sep 2025 06:01:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43f5123bd55sm334117b6e.26.2025.09.25.06.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:01:20 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:01:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, 
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] builtin/repo: introduce stats subcommand
Message-ID: <a3qgun7qrabs6wplbv5p75cokmr2flklnvyhzteytiu356b2pp@nruhrm4d2hhk>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-4-jltobler@gmail.com>
 <aNTVa3-RtYNPlcHc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNTVa3-RtYNPlcHc@pks.im>

On 25/09/25 07:38AM, Patrick Steinhardt wrote:
> On Wed, Sep 24, 2025 at 04:24:23PM -0500, Justin Tobler wrote:
[snip]
> > +static void stats_table_add(struct stats_table *table, const char *format,
> > +			    const char *name, struct stats_table_entry *entry)
> 
> We could of course accept varargs right from the start and thus allow
> the caller to pass arbitrary formatting directives. But I guess we don't
> need it now, so it's fine to not do it.

I was on the fence about using varargs from the start. I figured since
we don't have a need right now for multiple formatting directives, we
could just pass the one. I might just go ahead and implement varargs
here in the next version though.

> [snip]
> > +static void stats_table_print(struct stats_table *table)
> 
> Nit: The table can be marked as `const` as we don't modify it.

Will update.

> > +{
> > +	const char *name_col_title = _("Repository stats");
> > +	const char *value_col_title = _("Value");
> > +	size_t name_title_len = strlen(name_col_title);
> > +	size_t value_title_len = strlen(value_col_title);
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct string_list_item *item;
> > +	int name_col_width;
> > +	int value_col_width;
> > +
> > +	name_col_width = cast_size_t_to_int(
> > +		max_size_t(table->name_col_width, name_title_len));
> > +	value_col_width = cast_size_t_to_int(
> > +		max_size_t(table->value_col_width, value_title_len));
> > +
> > +	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
> > +		    value_col_width, value_col_title);
> > +	strbuf_addstr(&buf, "| ");
> > +	strbuf_addchars(&buf, '-', name_col_width);
> > +	strbuf_addstr(&buf, " | ");
> > +	strbuf_addchars(&buf, '-', value_col_width);
> > +	strbuf_addstr(&buf, " |\n");
> > +
> > +	for_each_string_list_item(item, &table->rows) {
> > +		struct stats_table_entry *entry = item->util;
> > +		const char *value = "";
> > +
> > +		if (entry) {
> > +			struct stats_table_entry *entry = item->util;
> > +			value = entry->value;
> > +		}
> > +
> > +		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
> > +			    item->string, value_col_width, value);
> > +	}
> > +
> > +	fputs(buf.buf, stdout);
> > +	strbuf_release(&buf);
> > +}
> 
> By the way, is there any specific reason we do the detour via the strbuf
> instead of printing the data to stdout directly?

Not really. I think it's just a holdover from a previous implementation
that was passing around a strbuf before printing. I'll go ahead and just
print directly to stdout via printf in the next version.

-Justin
