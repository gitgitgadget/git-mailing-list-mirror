Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E078F2D
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780543; cv=none; b=ZCHn/6JIQZzgbterRxVEuzGwjNm6pc5F8V/8hFj2/ousR/9kFe/ySUsr+1PtAhWGkV76aK4tEXVLr5aZZhfO+mygktlZWpRLb8uhlEeHJi99L8FMzL5pLH6Ick6RIo/zD5ABsjdqFj2rPJ1Oz6WPIhTbdah9r7PhoeHuZVgm4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780543; c=relaxed/simple;
	bh=Rmzbo0s1dJn3d2WFr7Yr0XA0iH7qht6cwJsAZCRIa5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPbPiWCqa7O6cwGd7PSVu0OAj0HlGrM3tlDVZvGFdFWZhxGyyU19FuZ0i6lrctpNyO4xgvFcJbx829CLzI72RCS1KwAJkQo+JwMSOz79HkvJvZiUUy4GDZNr9FtgoyDHcg4aNwVt5Q+wx+BnKnkoOxgnmWMCNH6Bky1wb9AT5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGEDpxv0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGEDpxv0"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47677b77725so34407841cf.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 18:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742780540; x=1743385340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxzWqI25wCz+w8PyC0zV7x4x0xWwJRdkY/mNoTmNAiU=;
        b=aGEDpxv0LzHc++2K+Ci1Y57BJKjWDkU9ySvAPoH7vDu03va5p5KA75N5E5eQeU0QcE
         CFWlSqXueYpO3X3KPFV3+PZJkBolLpk7Lzpoc4mQcXb8UYLhOGhuxIgSAORSBWwtL3jQ
         gOV1OMSbOFyOy67al77mCK7BLdG2+x00Epj64zNV+OMIIm0gHfupDgxKzP13bZLnD/it
         yiuNubtyCASxGd63WA/YaKHuS4634q4jYLoixF9BBCeuwelTJQvOWww5EeN/E674Hz2S
         LNofjL9CGnlrIhAerk7+S5qvuqkc6KggRxfQTczZ/xC2WbHyAWoruQRyXPlYV8HBJwKT
         Ep+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742780540; x=1743385340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxzWqI25wCz+w8PyC0zV7x4x0xWwJRdkY/mNoTmNAiU=;
        b=S0DOoPkRPBl1UpeRCWKt9TPulfafh1ioqNkM8yd4iGQj0PEDVuP/tjcF60Y/PVPkle
         zyZxOcAt48D9cbTFHQGUrltelYBJlQtECW02MpnI22XSaDn3NxMswzPnbmc5aULxdRKC
         x2CdQ0jDeakOO3aL7LzN2DqFKGWPnq1eU8BLvMOC7Ops7HHDq+56i5VGed8tJjOAnj5q
         OIO0Fe3aPUA0c9cO+q5GNdnUK/vcRdBQ349DE8VECRuulOM5yXAbGgMfO+FmF7TecCTy
         tfAqj1GeDsUOP0eD7gh5ee5KBgYBa7ySZvVqSD3i5T7OaD6N3hfLDBu6JlaXS9vZYwXw
         158A==
X-Gm-Message-State: AOJu0YwAURBdjMsEYediAoJl075QxFmo1d+dahUz/uaeCShQ73k5Qt/e
	HGhn1QtkVdslPnTaCuLQeRoQsuqcxa9GKgu9rtEZlIibtbxsUs0DcYi/Zn4R5hRz3dBwfhW9Dfq
	ORqEcWyORJ+BUiVEWhGzUac+cuiE=
X-Gm-Gg: ASbGncshNRLU0zuBR4iQEKbVlzACW4QzEXdR+cJFFOJgdwTR8Hg/LAzdXEdwzKMztOg
	97f7FzaVjhxbSZcajWSEB447qE/8x/KCJk74Ckv8YChzcInuNxrUf0ZvHCYl+MCd6SCcXohtAt9
	ViL45rN2iF5V/KfbpGFGth0fd6PhqED0UDhn/jU/tYSrZZOJftHxK5FvKNjdnH/O0l+TBJWw==
X-Google-Smtp-Source: AGHT+IFsaCaGXvVe4Prg7OQmJ5lGOdHlN+EJToDuk5yPoJgX47LcAXqbf4OYLXjpUDBNTYGxSmxIBEx+8K8lRz0PGBQ=
X-Received: by 2002:a05:622a:1e11:b0:476:ad9d:d4e9 with SMTP id
 d75a77b69052e-4771dd94395mr141499661cf.24.1742780540418; Sun, 23 Mar 2025
 18:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa59evffd.fsf@gitster.g> <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
 <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com> <xmqqiknzqu2h.fsf@gitster.g>
In-Reply-To: <xmqqiknzqu2h.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 24 Mar 2025 07:12:09 +0530
X-Gm-Features: AQ5f1JqegSuWUiH-u-TCXqwwMcL2ktXG6RyKK97yjfddz65Eaj9CL9GpUTC8_RM
Message-ID: <CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:38=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Refactor config handling by replacing git_config(...)
> > with repo_config(...) for better repository context
> > awareness and alignment with modern Git practices.
> >
> > Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> > ---
> >  Documentation/MyFirstContribution.adoc | 57 ++++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyF=
irstContribution.adoc
> > index 45efe117ab..3ae85016d4 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -316,26 +316,47 @@ on the command line, including the name of our co=
mmand. (If `prefix` is empty
> >  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's =
not so
> >  helpful. So what other context can we get?
> >
> > -Add a line to `#include "config.h"`. Then, add the following bits to t=
he
> > +Add `#include "config.h"` and `#include "repository.h"`. Then, add the=
 following bits to the
> >  function body:
> >
> >  ----
> > -     const char *cfg_name;
> > +#include "builtin.h"
> > +#include "gettext.h"
> > +#include "config.h"
> > +#include "repository.h"  // Required for repo_config_get_string_tmp()
>
> I do not think we updated Coding Guidelines to allow // comments.
>
Since this was a tutorial I thought this was helpful, anyways I will
remove the comments, because I get that this would be bad practice for
newbies.
