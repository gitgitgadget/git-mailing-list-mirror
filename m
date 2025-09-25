Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF51246BC5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844295; cv=none; b=N9yzF2Gy+Nz/2HhdwMOMCXjjdDp0iz0G299X/QVcGutN0M/gWM+LXUqIqXzxiIGkhGlkvXqWsfYbIYXNyj97atKzqsrO7K/NzgLEDA6dp4vWylx916yZR4g8X/3RFWY1xvGhh2IGQyJl+gFeY8okiFmku0kBzPr+cpzRp82LNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844295; c=relaxed/simple;
	bh=UAK7wpq+3gW3YDBGbJnKfhT8kk9ix8R1zbABoGmpmyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMj3XtYxv0P/8/kGGv3ZTkYtPII15Q9CIgku4RUbJyU7ybZerxcwCn3bC6ygx7sqVcLi6vsTCNdbiXmFFjbCvSAQ+36qATbCA4cwMAv52HCCxIzOFVcBQquR1gG29XPfvyIMj718OI1V/mIK+MVnhQZ/7wkj6zA3KMfP/6tKD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85f66d9251dso14437185a.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758844293; x=1759449093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT5wdaA8KTIoCVgSd4TdA7Xs5z16AAH9glesB/3jU24=;
        b=YmpjFzsdWRW3qlqcfs4gBi/rPnmGl2ahoQ5S6QrUzMcPrM94xI3Q3mJ3QrwU2pEsrI
         tTwS1NnYBMD2qVfea5DKLzaK1BlJCc4ju1j6UGLJjqG93VuEHjTHyPeyVgro/KJ2SEeV
         BBQ6xGldz/rampa2701DzOPn99Ao2sMmT0/ijG0dRYZGmGp/uDEpXXnGdMThmxlo5JDN
         DoJHdXuAotaEriheEnV0tQHHeyChyy1U8Fe7AThQ0qT6QHlkWfMY9I0Y8LkEmv+9FCC7
         6ZsySFaSqjB362VBO9l/RiPfhQetwGBLUcC7lcKNiZFHL7peYfDQ/d3MpCKzPYwSJTAI
         EEwQ==
X-Gm-Message-State: AOJu0YzW6jKOQcAJayJ4qzz/45NLM7/CM7IecbmsX4FwxVS7v7wAivKq
	8slqOz3TPagMK2Ig2K7X7tWiHZZxzBHhHZTi8uyKmPmTIm4O+YwnvP0fURtNuvDuxarkSpzUEH/
	Ch6Hx3TI8agsHIvlCe0eAAzTqwHCAS8w=
X-Gm-Gg: ASbGnctn1CYhW489UZt4OSbyDysbYfci+syxOwQJygj1yZtTZ2KujE/ZnZm/4qiTN5q
	PKAc3ZDxWmSucwunrl7Hz9qQ0WA6pxy4KOziFpDGmbDrbPNNRqioDUAi5tO1O5iaIqO+SoxPteb
	LSftt91Wfx/M8NGMAXmL1L2eQ+oNsqFq6N94bwvlX0qGI8NldXn+73EOJ+QOVqNG9whbU0A7cOq
	nEkdg==
X-Google-Smtp-Source: AGHT+IFq1vbyZuH5QJ9yB6KkQRaaOz/OF6zsUmxT0FrQ7WOpcXXmzDWfrWiRyP5mPP7rv4XYDaO3EsP4ilN6cM88x24=
X-Received: by 2002:ad4:5dcb:0:b0:797:1974:b824 with SMTP id
 6a1803df08f44-7fc2740a087mr48978746d6.2.1758844292763; Thu, 25 Sep 2025
 16:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924212426.2930029-1-jltobler@gmail.com> <20250925232928.3846-1-jltobler@gmail.com>
 <20250925232928.3846-5-jltobler@gmail.com>
In-Reply-To: <20250925232928.3846-5-jltobler@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 25 Sep 2025 19:51:20 -0400
X-Gm-Features: AS18NWDuxUFjODkSRvQuG1dDx9g1OoMCLekY3cVxz_-hzLvUyJvVSJqXxBfmmSs
Message-ID: <CAPig+cTSpq132SZQHUzYHJNqY-nOYizFW71Lu3o6a6m3jDNVJQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] builtin/repo: introduce stats subcommand
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 7:30=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
> The shape of a repository's history can have huge impacts on the
> performance and health of the repository itself. Currently, Git lacks a
> means to surface key stats/information regarding the shape of a
> repository via a single command. Acquiring this information requires
> users to be fairly knowledgeable about the structure of a Git repository
> and how to identify the relevant data points. To fill this gap,
> supplemental tools such as git-sizer(1) have been developed.
> [...]
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
> diff --git a/builtin/repo.c b/builtin/repo.c
> @@ -156,12 +159,205 @@ static int cmd_repo_info(int argc, const char **ar=
gv, const char *prefix,
> +static void stats_table_vaddf(struct stats_table *table,
> +                             struct stats_table_entry *entry,
> +                             const char *format, va_list ap)
> +{
> +       size_t name_width;
> +
> +       strbuf_vaddf(&buf, format, ap);
> +       formatted_name =3D strbuf_detach(&buf, &name_width);
> +       [...]
> +       if (name_width > table->name_col_width)
> +               table->name_col_width =3D name_width;

Here, you're using the byte length of the composed string to compute
the table width which you will use for alignment purposes when
rendering the table...

> +static void stats_table_setup(struct stats_table *table, struct ref_stat=
s *refs)
> +{
> +       size_t ref_total;
> +
> +       ref_total =3D refs->branches + refs->remotes + refs->tags + refs-=
>others;
> +       stats_table_addf(table, "* %s", _("References"));
> +       stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
> +       stats_table_count_addf(table, refs->branches, "    * %s", _("Bran=
ches"));
> +       stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
> +       stats_table_count_addf(table, refs->remotes, "    * %s", _("Remot=
es"));
> +       stats_table_count_addf(table, refs->others, "    * %s", _("Others=
"));
> +}

...however, here you feed the function translatable strings, which
means that the display length of the composed string is not guaranteed
to be the same as the byte length.

To resolve this, you probably want to investigate Git's utf8.h header,
in particular, the utf8_strwidth() function.
