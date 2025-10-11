Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1134BA46
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760157618; cv=none; b=mXBRwW+2YocMkggXS7e+uZP+AghTag4NQ6xBIcQ84BtNunT9XF4nviQa1CBTSk0gAJ0PCJe8z3S/3M3hYJeLfvcmJtCedaDaw33GpLc+6FHtRqBdH8M0KxPk1nfmibDTfGQyu/sWzhtuczDJNlGzqihH3KsYdr1Yiqa2fHKGvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760157618; c=relaxed/simple;
	bh=QA58FhBa20S6Pp/8MBUlm29HNxZ01kwZT5fhOaGq9Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McCqk10Vl2Hf9nEdoC7XeQAbPJQOwKh+br4RPHePoSVo3su8kAwQDApeJS825VRaRjw0V7E0NHnTMTmJx6VnS/j+RIw0JxWwtBHHcIY10K/H1azfhEnZHavTk2ai1tVaXrtE6xmfpoyxfn6f9RZkAFO4QYeDegvMeTkxFh16oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-79be84493aaso1971416d6.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 21:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760157614; x=1760762414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaeBpo+5U5naz0afMAP5plILsp4Wa4vsf9s8OGEl18w=;
        b=p8irFcL6TxG8c2fHAhZT3MV5DvDxuzLqaU4b7rqgZxZrTZTSY1amY6AlAw6UYssiGU
         2zOyH6DcuOd5FoaIavzBwiE45SFdQJJPqWzrYuWSswtX+fS4nd4yitP7D/I1p0ZSk2oL
         GK7pG8yBzdIRU5y+O0eH94aaEC3/xxQoDbZk7a0Sy6Mhr4/IF3bjA54U1QaQf9W3pbRn
         fm/+PWd6gC+n8v3864svqr5NE/dBL3SMemB2/6GcnUbnUJKBXHupfAP83RKJA8LrDPJE
         cwus9uRFEz3LttCmY5jAllE3YOuhNDo/0NuDIfd67JD2I6d57cYqCsDMlDeP7/OQbMdq
         ZXyQ==
X-Gm-Message-State: AOJu0YwZ9Zur575FvK4oZaSU+tGv7H/AzHw9X0YPYllX8Y1ol7q+yj9C
	XVdG3ojPYK+juYoHErJu3glWcruJw8/KwUz4kTqH7nPAqaKHa5rEd5JUFxR63AzqlT+6avafbmu
	QtAtBFu1MwY5J/GPAGXFoza/aQSwLVrU=
X-Gm-Gg: ASbGncs/jwAz6QMYbN44vAYJIzHUl9+ZCAt1e9QQGluRKyRHG/o3R2SNcsvImFeGhNC
	Ovqf5wI+CokrqO/97aKksNBfrQ0pwWnrQS8KiEaOEsCVrrIfN/V6RH4BerkfMxOR31GCDDXuxQC
	mjBYAK6CwJrRWvXctldZi31E3OGZbaTnlneaLK8ju/aabwYwCxkt+6Jvu0AOuPXL/epbFFmES1c
	iaQ2WVAUxGiosx/4g8u3jQQpZohy7yQ18kInsEnQy6u2/8yHRVzpUPMrqQQtfypd3S/+w==
X-Google-Smtp-Source: AGHT+IH1L9GFxB36kA99hcvM9q2K4orJBScvEGsnec5bPKOkjYCXLNo8Da2i5Nrckafvw2chAbyUq6FnD9kmZez8HV4=
X-Received: by 2002:a05:6214:626:b0:87a:a37:fd28 with SMTP id
 6a1803df08f44-87b2ef64e3amr126415136d6.6.1760157614540; Fri, 10 Oct 2025
 21:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <6477f32e23e732fdcc5a9585cc945db8f13d736e.1760115862.git.msuchanek@suse.de>
In-Reply-To: <6477f32e23e732fdcc5a9585cc945db8f13d736e.1760115862.git.msuchanek@suse.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 11 Oct 2025 00:40:03 -0400
X-Gm-Features: AS18NWBrvZoOUalLaKwA7hDbSWOWlIU4eGX1oS71KSSszC9Nkh6bLves_dtX31g
Message-ID: <CAPig+cQRHp7A=gtSkrVS4_EvZ9PyqBOdGGHcEajfLPE=qU4uDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: git-worktree: Link to examples
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Jason Cho <jason11choca@proton.me>, 
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:05=E2=80=AFPM Michal Suchanek <msuchanek@suse.de>=
 wrote:
> doc: git-worktree: Link to examples
>
> Also add advice to put new worktrees outside of existing ones.

The subject and body of the commit message are backward. The really
important change made by this patch is that it is adding a new
recommendation; linking to the examples is just a handy byproduct of
that change. Hence, the subject of the patch should mention the new
recommendation, not the link to the examples. In fact, if you frame it
that way, then the commit message doesn't even need to talk about the
link to examples.

Also, a reviewer of v1 mentioned that the subject should use lowercase
"link" rather than "Link".

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree=
.adoc
> @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
> +For best results it is advised to specify _<path>_ outside of the reposi=
tory
> +and existing worktrees - see <<EXAMPLES,EXAMPLES>>

I'm quite negative toward this documentation change for the same
reason[*] that I was very much against adding a warning message
(reproduced here):

    Regarding issuing warnings: I'm not fond of the idea. There are
    plenty of people who already locate worktrees as subdirectories of
    the main worktree and do so without problem, and for whom it is a
    preferred workflow, so I don't see why we would want to penalize
    them by warning against doing so, especially since there is no
    technical reason to avoid the practice (i.e. Git handles it just
    fine). The only minor downside of the practice (if one considers
    it a downside) is an aesthetic one: having to update ".gitignore"
    or ".git/info/exclude", or to simply consider them "visual noise"
    in git-status output and skip over them when scanning the output.

The big problem I have with this change is that the newly-added advice
is not backed up by concrete reasoning -- worse, it gives *no* reasons
at all -- thus it leaves the reader hanging. As mentioned above, there
is no technical reason to avoid creating new worktrees in the main
worktree, which means that whatever reasons you might have for
recommending against the practice must be subjective, but the reader
has no way of guessing what those reasons might be.

I *might* be a little less negative toward this documentation change
if you presented the new recommendation accompanied by a list of pros
and cons which, although subjective, are nevertheless somehow
convincing to the reader. However, aside from the very minor aesthetic
inconvenience of seeing a linked worktree shown as untracked, I
personally can't come up with any list of pros and cons. Unless you or
someone else can do better, I think this patch should be dropped
altogether.

[*]: https://lore.kernel.org/git/CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00=
R4oO1m2xA@mail.gmail.com/
