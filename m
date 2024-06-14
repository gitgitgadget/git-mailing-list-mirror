Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AED26AD7
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338780; cv=none; b=dH6/PrTMmV4FFfoyOr//KkrTiVE6Ifp7s/8X1dGntiBriiVsj4h6vTrJthFyGJ4Tvs7nTUFBdw7rqjTOxG2K4LbkDwkpm1XOwVorAN28Wskseom89QwM2BGdVTfeL8nuEbvSEHRzp/L4pDR/IobvxZrPfLx2p40UWj8KsPHxuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338780; c=relaxed/simple;
	bh=a1fTuf8YcX508JCnzTccyUsgDKNp6lzQfHYrYbPjRUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdmAc1vArrH2NLqia5LKVjHzJFPiXQF5+CoL4azILwzZf+pS1p+cIkMvA66PvEuO96OZbB19rt0S4chpxtxnXz8EC3fosjqDy2jBZdS2u1+pgdJu2kDhD+1eI1H4+m5TLvDMdfI4+I7T4xY+i2Wgkxb4drHJMRElaQaxdiZfvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-63127fc434aso14319007b3.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 21:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718338777; x=1718943577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFMiu6xEwGGd4M6fBL7/aW0MC5aP5zK5gol1H8ZZodE=;
        b=XPbUjbwm68DmcXrZNvJJZXTrYkV6n3c1ve8wQ2RzUN+W+gnq/tI+xOETwNTdGP6dW3
         zGwpbyW74LmQGHb+Ny6uHZUkZDCr9GN+cGiOdGHxnPx8G2ZuiHZ+c+3pWPsWxcCsDrK2
         LRB0DUwni+iOoRx3utFzk0mlsfuTAWDJMgymsrNIFXvILT1BBr9rMcIPdjBrV2nYxxJH
         GgxummnE+JkrGUgPr/TX4TPFqm/JN4XkWdQMlVi52w+UwK1MDOVl9eM5DiGaN1kT8Bfi
         qLrYd8VJ/1kzK/7p47gyyFZsLxsxwfk4JyQFPmTTcF5a/2eJo9+6kUv4xsOpgWj39K+y
         30bw==
X-Gm-Message-State: AOJu0YzoLS9l9lKOOyY+twlY/VTdPgvfigY9IAl2bKgXtKLAQ5t6h2lY
	6ZOno76pFbU4mUUPlsVAmaDLvpyDgc3xC9dq+gw0sax88u5tdWjiMXvmmFMu/x2cSv9vBQ0l+Uf
	s0bR+nfF4md8Nt7Ej9934gjinmCok15Zd
X-Google-Smtp-Source: AGHT+IFv4NpTYWRYUgoZd5eaRzlYGDAwQm8s8IvOzmhmSjhijIUMKTZbRcYaU/LSw7nhhO/NWww4SSQ1H32+42ZobbM=
X-Received: by 2002:a0d:e3c3:0:b0:615:10f8:124a with SMTP id
 00721157ae682-63222e5a964mr12925047b3.29.1718338776924; Thu, 13 Jun 2024
 21:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com> <71391b18c1a711fee1f5aff6eedbd3f631d37ded.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <71391b18c1a711fee1f5aff6eedbd3f631d37ded.1718310307.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 14 Jun 2024 00:19:25 -0400
Message-ID: <CAPig+cSZPC=41w8kG6n5hdSCUC4+jYJ6cM8UC-WCO3Bcmb2iNA@mail.gmail.com>
Subject: Re: [PATCH 6/7] merge-ort: upon merge abort, only show messages
 causing the abort
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:25=E2=80=AFPM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When something goes wrong enough that we need to abort early and not
> even attempt merging the remaining files, it probably does not make
> sense to report conflicts messages for the subset of files we processed
> before hitting the fatal error.  Instead, only show the messages
> associated with paths where we hit the fatal error.  Also, print these
> messages to stderr rather than stdout.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/merge-ort.c b/merge-ort.c
> @@ -543,10 +543,24 @@ enum conflict_and_info_types {
> -       CONFLICT_SUBMODULE_CORRUPT,
> +
> +       /* INSERT NEW ENTRIES HERE */
> +       /*
> +        * Something is seriously wrong; cannot even perform merge;
> +        * Keep this group _last_ other than NB_CONFLICT_TYPES
> +        */

I'm probably missing something obvious, but here the new comment talks
about NB_CONFLICT_TYPES...

> +       ERROR_SUBMODULE_CORRUPT,
>
>         /* Keep this entry _last_ in the list */
> -       NB_CONFLICT_TYPES,
> +       NB_TOTAL_TYPES,

... but NB_CONFLICT_TYPES gets removed here.

> @@ -1828,9 +1845,9 @@ static int merge_submodule(struct merge_options *op=
t,
> -                        _("Failed to merge submodule %s "
> +                        _("error: failed to merge submodule %s "
> @@ -1848,7 +1865,7 @@ static int merge_submodule(struct merge_options *op=
t,
>                          _("Failed to merge submodule %s "
>                            "(repository corrupt)"),

Do you also want to apply the same "error: failed..." transformation
to this error message as you did to other error messages?
