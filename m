Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450853043BE
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437603; cv=pass; b=oU478c+vQjaVXSmMKMDx/xKqj2MB/h3IDQt8GfqcDPXdYbtAVpXmmG8139Rqc6qns3E+E2Lb4QVdJENa7asw0aZwHizIqr1Lxo1y8/ejn5EgLkeMqJ1pEmcNKKtP6EdyHc82QjXFRurASvmGKS1BQh0amKRXHAHe9oIYBI0tHCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437603; c=relaxed/simple;
	bh=TClwMChDUCSDZXGmU8+6OAnknfGsTkCjC/isXoS+LxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDtnNQvIbVmCN5O36SdPtjqQHD0dVazvGWX6WWcKMW41WYb8FI+HTlKw79jsgwwrpWgxbu+MEc4HBKtMmrW0h6iwkG7fIiM8jTTrqlAY+oaULkLGxRvxNIzLmnopNdPUCZPbuwgj1uIjo+ZHOVVSDq5xm60DznP+gWSFWlLNMIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh9eYpI3; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh9eYpI3"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7991db3dc98so29995837b3.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774437601; cv=none;
        d=google.com; s=arc-20240605;
        b=fsAcjSa3EJwY1PJ3N4IJaP8Gxu5rqPrTcWcTTLFBErDnI511PqlPRv3+uq86VOXhvC
         GNNcVDT+O9AB+QpCXyAK8q6LDXpeYAVPL0IRUYMg9kRYaJAuLsXcaogYkUuXNy6g5kdN
         Rq24femc1GeXXaDFBpvrYl4Zy0LnCRnrXPDUfHXzgmJDgLj5n+dowfgHfn+XKAIw6GHL
         XsAHp6bGgC5zb17OkdLwy4GR2qVNd+gDVk4LKBCEGQsxa/7ozK7g13DHAl51qN9fnmkR
         y48xVxhcgbLwmPyUO6p1p4z1akvAq4tljP02+Y/IxJckKnIzDT30mc7W9QDtLRHI7NIf
         uc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/9KatUVcDfyPjDXF/9OyWfq1z7fjnGiCsu/XA4Pjv0w=;
        fh=UA5KvxvO1lOOHY3IH1K98VPBuWwJBCjAy2l0oUtEpr4=;
        b=jni/Mx0YZF3G0GTHMr65h92PO0De7tAOLRwXgWuPDMdEErdwdW6GEhKdoH4AcSyPRS
         1C3PSQ8WWvhlbP0Y58NFCW+eWMz8wr3IQRhw7DQ4RHcbjax0OvZZSbdn8cOpGnhNuIGk
         ngx/jsgozRRqIn7yW5NiXCRnoEg9jyF4QijYwbBq794w8MPlecphd2ys9rViBiRCpayr
         vW3xpIwTZqQiM7JDVSs7t+r18W4HaDzWJ58RqOI27/fgS8uS3QmPnxwFj1fS2vty7tuk
         WxmTrZsQ+JaUk14HN+iuBX1MIeRRQ/t5cejXGDvYAxTf/LxcTtBYMjfhwqCBtxcerwho
         WRug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774437601; x=1775042401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9KatUVcDfyPjDXF/9OyWfq1z7fjnGiCsu/XA4Pjv0w=;
        b=Nh9eYpI3MPLNTkYr5PluBo6PPJ5LJ+0MDUtPR3JayhUiCYO2/DYeiMf0vLDmIrxEB3
         A2GJYWaJmTp44pvDLjhvmDi3eJEKpTm5qhCOgqtiuBtIJ0eTkpVXqpUu2PjkE+mZGwFA
         tLciMO72+d2Jn7a/xEQjK/p80uNGdNxzp4RnooHOR1nnG3AEyLdhzXuM8fnw/2rWxW12
         pWKCq3NJw3/oMQAQsopxm2RXCa9RO7X2rIjw9NLP3Nf++bHzEnMmaXcrdkK0I62uYoSN
         W5Sg6Rgf0vNwgRJBG2hb26fyj/tfqOPA8JxYx5tr6NggL2tSS56AnI71M+iDrikFCV/G
         e8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774437601; x=1775042401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9KatUVcDfyPjDXF/9OyWfq1z7fjnGiCsu/XA4Pjv0w=;
        b=Yf+F0O9XIzKdB9a+cFD8b7DpeXehmMBm+rrY5YyDyRCnE/HE2AXdErH1O1e7tr2WmT
         Fk7Xw3P5Z5erb+EKOiGF5vm2Q/7UMm0M7/OVHCEoD2TX583ORlR9vaRgD2+/3aTGrULv
         Bfov94WX80z1YbHzJ992alooTA7TRiKOLTzy9wYGSi8qho39kjHQoBTf0zJlZ6sNIxc8
         zdp9dXjeG2I90gFPwuRbng/NRI1FkkOwopgSQyNUCMLqJiYzoOi7I9pvBFsU/7gGLVpe
         ZwGN3vPiGjCXdzuyjeTVnwnW8x2TVqEyWLBojffP7IB8DKEVfTLl6ksV76AfTNVpa7r2
         ZMjg==
X-Forwarded-Encrypted: i=1; AJvYcCWLhD9ZPZnj89mWZBx4ZyAJnUnTCzzp/skNzEeX0ICmjJLMcnXuw0+N5zTju/ZLLgiKxNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS4wZaj7nKKnGgi90erNeeEo428ijEdfTxpsHTarkdmyhDGEl
	OGWI2uGKkPRJ7dTey3FoF01xdRbQlNFSO+E4QH2PtsP3ydD+bdFF2gKQUxduI7cd7uAMP8hx1mF
	csmHQ2U0AW+Y9G3VBbmh6LI2ppLq7aUA=
X-Gm-Gg: ATEYQzxy4vHHr6enpS96i9z8kXQLq9yprfkQ3UnAfF+TqlPrKvHFV+ozdd5+cYFMa2x
	+YsdH7iP4cBI7xYZ0PhvRsa4/l5UXYRRHDjEDgEnOAxJiJNoJFlm+zQSEysFnPq2PQ9es/N106Z
	cnQSVl7zpHP+2OUjo07ZXxKgMybVNzYQ+r0s+6bHyIpEB86tvMn69CpOYOzgycwYC0lETv4Y0QD
	Ede52bEmVWDhsykUu4CP5+8Bl/RVm2XOcykTtl/L1c+sLz4Nh/BPA7vYPUT2wXOWJjdR9QPBPt1
	e7lhgflIzGi0pCALGhXWyp5+gtD0PEtJS/8Dd9sKfEy2r1aSWzkYhe/ZF0ngfiWJZn4suCHlejf
	IBpuZU+I4F0uQD/gh7VikBEI=
X-Received: by 2002:a05:690c:7408:b0:79a:440c:fbed with SMTP id
 00721157ae682-79acf371461mr26133037b3.13.1774437600987; Wed, 25 Mar 2026
 04:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com> <20260323215935.74486-3-pabloosabaterr@gmail.com>
 <19cef686-6287-4916-8fec-a9ffe33f7889@kdbg.org>
In-Reply-To: <19cef686-6287-4916-8fec-a9ffe33f7889@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 12:19:45 +0100
X-Gm-Features: AQROBzD7Wt2a5fYdFwOhVcfTiu_XQ5UP1kC_Swp-r2FuwbpYrJuDSq8c1rz7Twk
Message-ID: <CAN5EUNTTVB6Ou5H3_M2AYUTX4mi+CLrDS=W8tWv-hfgwTctrZg@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 2/3] graph: truncate graph visual output
To: Johannes Sixt <j6t@kdbg.org>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Johannes Sixt (<j6t@kdbg.org>) writes:
>
> Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> > +     /*
> > +      * If graph_max_lanes is set, cap the padding from the branches
> > +      */
> > +     if (graph->revs->graph_max_lanes > 0) {
> > +             /*
> > +              * Get the maximum width by multiplying the maximum number of
> > +              * lanes by the size of the lane "| " and adds the truncation
> > +              * mark ". "
> > +              */
> > +             int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;
>
> Please be to the point in the code comments. That there is a
> multiplication and an addition, we can see in the code. Perhaps:
>
>                 /* width of "| " per lane plus truncation mark ". " */

I'll use this one instead, thanks.

> > +             if (graph->width > max_columns_width)
> > +                     graph->width = max_columns_width;
> > +     }
> > +
> >       /*
> >        * Shrink mapping_size to be the minimum necessary
> >        */
>
> > @@ -1022,6 +1043,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
> >        * children that we have already processed.)
> >        */
> >       seen_this = 0;
> > +
> >       for (i = 0; i <= graph->num_columns; i++) {
> >               struct column *col = &graph->columns[i];
> >               struct commit *col_commit;
>
> Is this empty line really needed?

No, I'll drop it.

>
> > +                             if (j >= 2)
> > +                                     truncation_max -= 1;
>
> I think it is more idiomatic way to write this as truncation_max--.

I'll change it.

>
> > @@ -1288,12 +1365,20 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
> >        */
> >       for (i = 0; i < graph->mapping_size; i++) {
> >               int target = graph->mapping[i];
> > -             if (target < 0)
> > -                     graph_line_addch(line, ' ');
> > -             else if (target * 2 == i)
> > -                     graph_line_write_column(line, &graph->new_columns[target], '|');
> > -             else if (target == horizontal_edge_target &&
> > -                      i != horizontal_edge - 1) {
> > +
> > +             if (!truncated && graph_needs_truncation(graph, i / 2)) {
> > +                     graph_line_addstr(line, ". ");
> > +                     truncated = 1;
> > +             }
> > +
> > +             if (target < 0) {
> > +                     if (!truncated)
> > +                             graph_line_addch(line, ' ');
> > +             } else if (target * 2 == i) {
> > +                     if (!truncated)
> > +                             graph_line_write_column(line, &graph->new_columns[target], '|');
> > +             } else if (target == horizontal_edge_target &&
> > +                        i != horizontal_edge - 1) {
> >                               /*
> >                                * Set the mappings for all but the
> >                                * first segment to -1 so that they
> > @@ -1301,13 +1386,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
> >                                */
> >                               if (i != (target * 2)+3)
> >                                       graph->mapping[i] = -1;
> > -                             used_horizontal = 1;
> > -                     graph_line_write_column(line, &graph->new_columns[target], '_');
> > +                     used_horizontal = 1;
> > +                     if (!truncated)
> > +                             graph_line_write_column(line, &graph->new_columns[target], '_');
>
> Huh? The indentation of "used_horizontal..." changed. The reason is that
> this whole if-branch is indented too far by one tab. Perhaps an initial
> clean-up commit that only fixes this indentation?

I'll fix it, but I think it will be better to have it on the patch
with the truncation logic because
it is a tiny cleanup and doesn't really justify a whole commit for it.

> >               } else {
> >                       if (used_horizontal && i < horizontal_edge)
> >                               graph->mapping[i] = -1;
> > -                     graph_line_write_column(line, &graph->new_columns[target], '/');
> > -
> > +                     if (!truncated)
> > +                             graph_line_write_column(line, &graph->new_columns[target], '/');
> >               }
> >       }
> >
> > @@ -1356,7 +1442,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
> >               graph_output_collapsing_line(graph, &line);
> >               break;
> >       }
> > -
> >       graph_pad_horizontally(graph, &line);
> >       return shown_commit_line;
> >  }
>
> This removal of an empty line isn't warranted, I think.

No, I'll revert that.

>
> -- Hannes
>
