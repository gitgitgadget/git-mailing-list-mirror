Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE021F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeGIWjF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:39:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40726 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeGIWjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so22303090wma.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ji5k5LH+Nrs/zhAjgSuTaanvc6kswipUBIPL3N/QfH4=;
        b=eLtEaoCnFM76PUnWGX2a728OJSIQYuBXS0kQn2MGcwWrCuuWkwOr2ia6xvbay1Kb6m
         8LfRmSiQvEikacBBjKClFr5QNuvyhzoewAcUUmBWZBcvdQWENtyhu8o5lYadHLE4ULy9
         jbqP6hZWJwiHc/HDhP2MXLG/p0EkZHlcsKbya9gnSQ9NcSyBp8lk6m287Fy2HusSSOwH
         4+W33LUr5cA2PSR6YWRUcdyyXwQntk42+SJue8QpFSouYBHuvWQ0tFGXRqRTk8UVtvR5
         8pAgZWBuAf6osW4ZngtikZaJVqjR4e1wwYTXVQaRh+JbEG6ITTG5t7BIPWyy0BZq0YVi
         Ja6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ji5k5LH+Nrs/zhAjgSuTaanvc6kswipUBIPL3N/QfH4=;
        b=SX8AKYk5xvDEBWnVEcaLCKMZLO9aMTzKouGdAOrHpNYysttoUPr+aOeBlzIW5t9KmZ
         7aQ0gnhmM7W7HOXg/qlwq4TftxHu13vmD4E8o6HsJAwm2n1rJsYP8hA9Mxya8URx/yn8
         WE5fZMoCHL58J8TymhaJGmTlVfVsJcvDnlyixMbDiyJelyatyrcPBgSIbsKMLfCGsMqR
         cSIE9tLwU6KDGD7qCpCx78FHkumzAS7qhR5vP7e7cPyNo5yUtoO/UOrpC6ga77dk59pu
         QW+JgNXoA/mmWbXAJ6MVnoUriBVf59Z22ulDq22h8Il/AuM7rN72ZCqcZ9z46yTf/cf7
         2eqg==
X-Gm-Message-State: APt69E2oG0TtPF+SisC8A0hcNoR60hxfYnwx9XexsEBh4K7xU/V0VC+b
        FYCzryKa0SqWsFfkXurpDfY=
X-Google-Smtp-Source: AAOMgpeFQ2scGRCJYX7f2p4Oc0VA05DRL/ry2R2X61BFTLQpJFUHsjT2RWVTFz/wGFwZ/kpQpoIiBw==
X-Received: by 2002:a1c:55c8:: with SMTP id j191-v6mr12749544wmb.67.1531175941031;
        Mon, 09 Jul 2018 15:39:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c10-v6sm15582960wrs.6.2018.07.09.15.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:39:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] ref-filter: add empty values to technical fields
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com>
        <010201647e19c191-8c24e128-8822-4c77-b3bf-60fe17ecb62b-000000@eu-west-1.amazonses.com>
Date:   Mon, 09 Jul 2018 15:39:00 -0700
In-Reply-To: <010201647e19c191-8c24e128-8822-4c77-b3bf-60fe17ecb62b-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Mon, 9 Jul 2018 08:12:54 +0000")
Message-ID: <xmqqzhz09gqj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Atoms like "align" or "end" do not have string representation.
> Earlier we had to go and parse whole object with a hope that we
> could fill their string representations. It's easier to fill them
> with an empty string before we start to work with whole object.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---

Just being curious, but is there any meaningful relationship between
what was labelled as SOURCE_NONE in the previous step and what this
step calls "technical fields"?  Things like "upstream" (which is not
affected by the contents of the object, but is affected by the ref
in question) and "if" (which merely exists to construct the language
syntax) would fall into quite different category, so one might be
subset/superset of the other, but I am wondering if we can take
advantage of more table-driven approach taken by the previous step. 


>  ref-filter.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 8611c24fd57d1..27733ef013bed 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1497,6 +1497,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			refname = get_symref(atom, ref);
>  		else if (starts_with(name, "upstream")) {
>  			const char *branch_name;
> +			v->s = "";
>  			/* only local branches may have an upstream */
>  			if (!skip_prefix(ref->refname, "refs/heads/",
>  					 &branch_name))
> @@ -1509,6 +1510,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			continue;
>  		} else if (atom->u.remote_ref.push) {
>  			const char *branch_name;
> +			v->s = "";
>  			if (!skip_prefix(ref->refname, "refs/heads/",
>  					 &branch_name))
>  				continue;
> @@ -1549,22 +1551,26 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			continue;
>  		} else if (starts_with(name, "align")) {
>  			v->handler = align_atom_handler;
> +			v->s = "";
>  			continue;
>  		} else if (!strcmp(name, "end")) {
>  			v->handler = end_atom_handler;
> +			v->s = "";
>  			continue;
>  		} else if (starts_with(name, "if")) {
>  			const char *s;
> -
> +			v->s = "";
>  			if (skip_prefix(name, "if:", &s))
>  				v->s = xstrdup(s);
>  			v->handler = if_atom_handler;
>  			continue;
>  		} else if (!strcmp(name, "then")) {
>  			v->handler = then_atom_handler;
> +			v->s = "";
>  			continue;
>  		} else if (!strcmp(name, "else")) {
>  			v->handler = else_atom_handler;
> +			v->s = "";
>  			continue;
>  		} else
>  			continue;
>
> --
> https://github.com/git/git/pull/520
