Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD17320A32
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924053; cv=pass; b=ZoZAky6rTWQYAlluLQBIvuEgXeAIoa0j7DmcTQH9IYHP3Tphup9iwuyPJ574nANWB6dBM4DvwYSn3MF9pJjfKt0QDwuPK+EqSt8tCKyMn9vyqhe7jfcMRuYE+7Zu00Ez3EEjrcG4bfLJZIdmJw+crc8SP5Ht3t4Fa3LAWctwPAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924053; c=relaxed/simple;
	bh=IuyKtNYg6T8jecXJS4xJRyZw1nnaXJtTgjnKI0kU55Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYUSOHK8tyTxuJ4wsBd0zdREWmN5oXHX08pMpxs5cI5u/5ZSXhVZzH16C54INWnLrBZhPVgFGCGha7Zh+yBeLSNvl9QoND2+6FcEy6H37pkqmDviujLAWlLVO5koH3DCKm8eeAs7YqB/2V3GnH1CP3/rCx1VGZIixnBNvxR7Kc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzjPQN46; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzjPQN46"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso1413613d50.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:47:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768924050; cv=none;
        d=google.com; s=arc-20240605;
        b=FZESAlfvKUAavGk5zNB3ZQpbx8CNy8kzLwxQh5RjZc7DDoqOnXXJaPVhOimaqdzRnG
         YEmYP0zTbBdkXZS90ohWSKmKHzs/b/a1ifnhmFwuWXxK7RVrIw/7HxdBO7hNeVQi5WaU
         /wt+eI4IP2G4cHyObPD4g3YHVOrikYUNz6itFSDq7l3OIAydnYUAusTTG6El7ZmK6gDT
         rzBNCvJDpKdqdfCNj83d8sRmVrVJ40wmwpTmT6UIjEsXgNLgGXA5jGIR8m3NsGIk9jSG
         u43R3Df9upsRs0XRZrq74kVkE7Fg4bNr7PMcmtuiYP2ZwQ5YDUnC2N2eS54/od9xzJ7k
         Sggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jpVo/XkLj0DLRRFnq6D4KiSVGxly/GCImiRpDLqsiHU=;
        fh=5FCxOMGwsMBFof78zquH2VQ2iCUvoIVnKNjkv38qamA=;
        b=Vh0+OnfW9WogYc9nuMjMpWVVYwSdgEyUwTuLDczOYo389iup7KmCH3eoSOOb/vTCZn
         QRt0w1l72vBBHSZK4w0IYjC+bxOaVI10+fWd4AvR5JAXbe3DSMJ92zLrii3wrEjGIM63
         jI8N0QsKEagGjaNqo+jkI6VCKD4J1KuCcra7BDlF6wfl3MIQMEpA05b19wTt+3UT2YVF
         kJFyOH+VA2sw4GJlAVVZpCQ3qzom8gi4fnowbvFw1NtUTOy7oLutQYV+NdPdlBkRySMz
         Yo/6rs2D0rnt1mBKpgBBvOzlpbxC6ExRxXy143BRNRdknvBreSUMoeuFLRE/y81171Pm
         EZqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924050; x=1769528850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVo/XkLj0DLRRFnq6D4KiSVGxly/GCImiRpDLqsiHU=;
        b=OzjPQN46nEmaysELXETlIUhvMBzRZW85uJx6y5pORqVvF2c9nqyWnSFBEtEwffgiXM
         MWQz4/djtBr6hKlxNR7fmHc1ilYTel7R50LPls2B38CNeK4ey0ASnO8gCIpW12vJ9KMD
         Kwvsao2+wJN+80UgIgbdTUrs+FtgogNiwEWyWVlx5bJveQMutx9QBqfgtf9yTx79Tp/L
         ezqqqAZ/A5HyXiv3L5fWHa5/SS98CWuaYHcD+WFkgfX0YZFssW6E+v6rWJUd34rjCEA9
         u7M0vzdr8oEDl6jWpLq70Gd0C/X24pXjYIQq2EdDNDwGDIwp9kwODb4WMTa37SpBTlVm
         k//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924050; x=1769528850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpVo/XkLj0DLRRFnq6D4KiSVGxly/GCImiRpDLqsiHU=;
        b=cxSKYfEIb+MjLHL9p98A0WXaB2bHBgN4FNKVxolD23mBK4VxKzveM96ltksRgsVeiO
         9oCON6ZVtaOcXxOsHhrHDF4syFWOBPNSw5o9QxijNprYaR5hBAaUVPn7zJ+GCbyP9/lW
         aQEDNURwCWZ0nFj8OyZ3GrdjXIGPjnbZgGlEJnD/K13m8KSaNH7tcgSWkyPh9dhVtCV1
         9BSBDiNeAqvTbrDyAojpc8mu+AkifNb7asYcQKo2R1wMEbX1wLdvCCslvBvBRRA2MeGS
         F+uytqKUEohP9sA1Why/GBffq7mqwxacUwlX0GBfM5Crynpbh/A3+nKQzUd1XAGnSYfe
         coNQ==
X-Gm-Message-State: AOJu0YzOgR4TlDiFI+jdBxsG8jXOIPlWcOIDiVvkGW9KVfwMZPOOTVcH
	p7BWgyPa/5/C+stHim69MDQ5HFkaLb59eDtObCtWpMrqNdPoEVT9TvzTZUP0HSMW6dbdIGWEJXA
	GNjDfeJ7Gmm1Bq2UVzcQlBCpEcO/Ys0E=
X-Gm-Gg: AZuq6aJ8uUhF9LV4JBYRXq4P1QKkceAqgiZh+wizPevLxjBHW/VNe9CowuKSvQoC9X4
	6s3fvdYSn2DGataQZoEiXPEo8QiG3uS6wGuTfUHpgVtX6dBppQKAUqY0gmvGuZaZTOY9LH2dINn
	gKIDAfiETIsTquSYmwQ/fyGXgiCZ09m0xxDNN7M+ga0Ng5l28hu8CeEjTt7fxPp/ZU5A77vuoNb
	vqB1DWGppSfqC8b58091dZBkxTI6Mez8sm0ijQQg2BzFl6aqrWK6bjGIx9qsUM0GfTqMU0JJgfH
	2tiB1+m0K4TWPjY1Jew+JvvJjCI=
X-Received: by 2002:a05:690e:408a:b0:644:7398:6670 with SMTP id
 956f58d0204a3-649176c6eb7mr11182463d50.7.1768924050248; Tue, 20 Jan 2026
 07:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260119123339.48435-1-amishhhaaaa@gmail.com>
 <36b50d7d-b9f4-4ff3-b00e-9c98ad690749@gmail.com>
In-Reply-To: <36b50d7d-b9f4-4ff3-b00e-9c98ad690749@gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Tue, 20 Jan 2026 21:17:17 +0530
X-Gm-Features: AZwV_QjFPyYK5YeQIpEkGEaFW1YqPhrEWO-OdQD3LAszRJM0vMt14snvGKnE6aM
Message-ID: <CAPvEtrcGYXeXWn-p=EipyE07gqNcP1qx_=V94cSD5XLwk4mdDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sparse-checkout: optimize string_list construction
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Jan 2026 at 22:34, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/19/2026 7:33 AM, amisha wrote:
> > From: Amisha Chhajed <amishhhaaaa@gmail.com>
> >
> > Improve O(n^2) complexity to O(n log n) while building a sorted
> > 'string_list' by constructing it unsorted then sorting it
> > followed by removing duplicates.
> >
> > Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> > ---
> >  builtin/sparse-checkout.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 15d51e60a8..7dfb276bf0 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
> >
> >               hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
> >                       /* pe->pattern starts with "/", skip it */
> > -                     string_list_insert(&sl, pe->pattern + 1);
> > +                     string_list_append(&sl, pe->pattern + 1);
> >               }
> >
> >               string_list_sort(&sl);
> > +             string_list_remove_duplicates(&sl, 0);
>
> Shouldn't this line be added in the other uses of string_list_append()?
>
> >
> >               for (i = 0; i < sl.nr; i++) {
> >                       quote_c_style(sl.items[i].string, NULL, stdout, 0);
> > @@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
> >               if (!hashmap_contains_parent(&pl->recursive_hashmap,
> >                                            pe->pattern,
> >                                            &parent_pattern))
> > -                     string_list_insert(&sl, pe->pattern);
> > +                     string_list_append(&sl, pe->pattern);
> >       }
> >
> >       string_list_sort(&sl);
> Actually, there is a string_list_remove_duplicates() just
> outside of the context of this diff.

I was wondering if the string_list_remove_duplicates here is redundant
as if we refer to the code that adds entries in the parent hashmap,
refer:

from git/dir.c
if (hashmap_get_entry(&pl->parent_hashmap, translated, ent, NULL)) {
/* we already included this at the parent level */
warning(_("your sparse-checkout file may have issues: pattern '%s' is
repeated"),
given->pattern);
goto clear_hashmaps;
}

It does not add duplicates to it, and we are only iterating on
parent_hashmap in this loop, the tests i have added in v6 do fail on
removal of other string_list_remove duplicates lines in this file,
however here i tried testing but i was not able to find a covering
case for this line.

> Keep in mind that you're not actually testing the 'list' command, because
> the 'add' command already deduplicated. You'll need to modify the
> sparse-checkout file itself to get an interesting test of the 'list'
> command.
>
> When not in cone mode, we should not be removing duplicates because the
> order of the patterns matters and we should not be reordering them. I'm
> not sure if that's relevant but it's something to keep in mind while you're
> testing, since the command will revert to non-cone mode if the
> sparse-checkout file doesn't match the cone mode pattern expectations.
>
> Thanks,
> -Stolee

Thank you it was a bit tricky to make the test fail directly on list
command, i was able to do it in v6 after this guidance.
