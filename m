Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693D339A1
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331181; cv=none; b=LjDOo9/4xN7edPDMZf6x4eOWLSe0V16NnNB9XaLZPQhLftwB06RiZoOtFSM7OmoZyR8anUTzogB8cStc3v+S2Aey9/kLQrnC9U2ZqinbbWf2rGlQWoGejGvKNLJIV+UiUe++31Y7Fs2JpZZ6oTKGYH3In78AoqcVKedzO6RK8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331181; c=relaxed/simple;
	bh=IR5JTnBuNL9md/AsAiAIBK0SrRIg+2JlDAKs5aJrB8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TR6ibznKeX1GmL25ZANVL18tqxYVuO3oY6xSUVRqdxIdzIWD78KONn7fHxiLHs5DiAXX2lDMn2ygoIftjvQfA1zn3ueFRM/CO4VG22iqrFFEDyv7J/aMTdVaQRq8IcVYc0n48rT9C64j69YtKlZx8iyUm79t/Nb9wb1qMNXyqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDlXEl7J; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDlXEl7J"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a6f3f88613so29892501cf.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 17:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751331179; x=1751935979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GMQYHpJUjnzK5Q54TC32AHVP8kvRYA4Zeb1j7321Sc=;
        b=WDlXEl7JU+z6oODtRrIT4GzVAuvKEclikyqQ8P3L+6VxEQMqosXw9NqexvqL7/AmMA
         FdoN7zid98Q9LpFoxjX/vVYj2yHLogfaVKP00aSSfEUmytZqRAk6bLcHb5hy61a0F1cJ
         N9ycbTM9/0VmU2YDza6nU2KXB9in+gYJXznjk2to5/QNcQgaVT8EohVP5336lu82Oitq
         4jjJpz19RtTDK6+jA/DhvxF8VNqqSwNXmhDmfvJY8bGHddtg5GZ7/Fa11Jb6+O9NU+6I
         5LkHRj4qjaoN3JQ/21OxdtEsEpDaaOkVS3l45u8jHflDpmYd+7JplaOk0RhH56hrvIv1
         kVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751331179; x=1751935979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GMQYHpJUjnzK5Q54TC32AHVP8kvRYA4Zeb1j7321Sc=;
        b=tV0+jEVNcvDr7/q0WAR+JRyXMbaqv24KI1beTUw7D31YJcXMYKdVxTPDhMd9dwWy8x
         V7L8qZPvfuI2eOlGP0ZKxsNCoUm2aMs7RALHpLS+QRDHr2Q2v69bG2oaT4nuGSCsIxAX
         N0dI6fYTYaMcFlHTT0lzchuoJSYEf3wbyLvMn+IbPe+1evIKbjT+4Mzy24hXJp30Bsvl
         r2eWSzFPPlk+9a2sqNzfpKWW65QODpZKPSozZMafGgv9UwpVfIxUWrTcgX4M8nko7clU
         ZIpppUtMmgqsYz7CZ2kZiyys/wo+RnHqwZTmw6jn4rgDp6lUUUjqcWzJrGjU8G1ftvd7
         Ph0g==
X-Forwarded-Encrypted: i=1; AJvYcCWkVjw0EdKtRXX3y1zyfulo5CaOn/ypMbzcSpyhJ4ZqjqtaDj3CWCWrIhHdtBKKJ/O2o/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28EoUQDHVzbxn1UAL7Fg0w3TXxJSRDny0RVvAr1kJfmFuGuxp
	fGpp1YCNZ+b2yehbi6U+feMPcGacbdOQWgUdJYub48+E1ombZ3Ho2mJWgC0GzB5HshglLJ54LpP
	eNl5CGP8x72gRPNnPpTR5nq8hPTYcnswa7rSQ
X-Gm-Gg: ASbGncuN0tvhbl4EaFyIPxr6MwEoxoo2H75YNjIk0HV/nelwfeUYLgj6kRqIuEec0y0
	9DW1un6JDlzzWwvXagxYOygzcjDFQnZdr1DFOCusEfwSNb///N/Fs2+0wIRmgL7DwFHS6+O+otu
	A8yyRuRnmKkIdGyre/n0Pqi4xLCWAAFIOB50+HR6kh5Xq4no3T2gtAAkyFCOSPdhDrft6QGqbH5
	GQ=
X-Google-Smtp-Source: AGHT+IGMVmZa+vQD66qeSlOF1IFFJ/MTTMj1O1doMko37RC9syBm/FPFzqSHdd5h2K5DKq51dNDmXMvLoYfIRE6h47s=
X-Received: by 2002:a05:622a:2611:b0:4a7:14c3:7405 with SMTP id
 d75a77b69052e-4a7fcbb0be4mr283608131cf.27.1751331178869; Mon, 30 Jun 2025
 17:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com> <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 1 Jul 2025 06:22:47 +0530
X-Gm-Features: Ac12FXzh7hLnhpJriCCwpmCL0ukT38u01AXAnawVfD7g1CzMvvPguRs79be5AMQ
Message-ID: <CA+rGoLd0dhxFx0TuCdrGhRgU0=1imLw+dM8eM6Ca3t9r_Q5XyQ@mail.gmail.com>
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
To: Karthik Nayak <karthik.188@gmail.com>
Cc: ryenus@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:16=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> [snip]
>
> > The original implementation:
> > Starts a single transaction using ref_store_transaction_begin().
> > Adds all deletions to that transaction.
> > Commits the transaction.
> > If any deletion fails, the entire transaction is aborted.
> > On case-insensitive file systems, two refs like:
> > may conflict at the file system level (e.g. both mapped to the same fil=
e or directory).
> > If Git tries to delete both in one go, the transaction fails due to a l=
ock file or unlink error.
> > (Above are my assumptions till now).
> >
> > What has changed is:
> > Deletes each reference in its own transaction
> > struct ref_transaction *transaction =3D ref_store_transaction_begin(...=
);
> > ref_transaction_delete(transaction, ...);
> > ref_transaction_commit(transaction, ...);
> > ref_transaction_free(transaction);
> > If one deletion fails due to a case conflict, the others still proceed.
> > It avoids rolling back the entire prune operation just because of a sin=
gle failure.
> > Keeps failure count and returns appropriately
> > Signals that something went wrong, but Git can now give partial success=
 feedback.
> >
> >
> > The question I have is
> > If this approach seems viable or perhaps any solution,
> > would it be possible to write a test case for this scenario?
> >
>
> You analysis is right. With 'kn/fetch-push-bulk-ref-update' in the works
> (possibly be merged to next soon), we will start using batched updates
> in git-fetch(1) too. Batched updates allow individual updates to fail,
> while allowing the transaction as a whole to succeed.
>
> Unfortunately, because our transaction mechanism doesn't handle
> conflicts, we separate out pruning as a pre-step. So this bug would
> still be present there.
>
> The issue with the fix you're suggesting is a huge performance drop,
> since creating individual transaction for each deletion has a lot of
> overhead and the reftable backend would perform a lot worse in such
> situations.
>
> I can see few solutions overall (including the one you suggested).
>
> One solution is to drop duplicates in case insensitive systems, this is
> the shortest and easiest fix for now.
>
> Perhaps something like (untested back of the hand code):
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cc0a3deb61..bc79d74b82 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1352,10 +1352,16 @@ static int prune_refs(struct display_state
> *display_state,
>                                         goto cleanup;
>                         }
>                 } else {
> +                       const char *prev;
>                         struct string_list refnames =3D STRING_LIST_INIT_=
NODUP;
>
> -                       for (ref =3D stale_refs; ref; ref =3D ref->next)
> +                       for (ref =3D stale_refs; ref; ref =3D ref->next) =
{
> +                               if (ignore_case && prev && !strcasecmp(re=
f->next, prev))
> +                                       continue;
> +
>                                 string_list_append(&refnames, ref->name);
> +                               prev =3D ref->name;
> +                       }
>
>                         result =3D refs_delete_refs(get_main_ref_store(th=
e_repository),
>                                                   "fetch: prune", &refnam=
es,
>
>
> A bigger and eventual goal is to simply introduce conflict resolution in
> reference transactions. This would allow us to use batched transaction
> together for pruning and updating of refs, and using batched
> transactions would ensure that single reference changes can fail without
> failing the entire batch.
>
> - Karthik




Agreed that was a lazy fix.
I had thought it(multiple transactions) was not a viable solution.

Something I find interesting is

Loop through the refs marked for deletion (stale_refs)
If the filesystem is case-insensitive
Convert the ref name to lowercase
Check if this lowercase version was already seen
If it's not a duplicate, store the lowercase name
Add the actual (original-cased) ref to the refnames list
Free up the memory used in seen_refs map

---

struct strmap seen_refs =3D STRMAP_INIT;
...

for (ref =3D stale_refs; ref; ref =3D ref->next) {
        if (ignore_case) {
                char *lower =3D xstrdup(ref->name);
                str_tolower(lower);

                if (strmap_contains(&seen_refs, lower)) {
                        /* Skip this ref it would collide on
case-insensitive FS */
                        warning(_("Skipping deletion of '%s' due to
case-insensitive conflict"), ref->name);
                        free(lower);
                        continue;
                }

                /* Keep the lowercased key in the map to catch future
conflicts */
                strmap_put(&seen_refs, lower, (void *)1);
        }

        string_list_append(&refnames, ref->name);
}

strmap_clear(&seen_refs, 1);

---

warning(_("Skipping deletion of '%s' due to case-insensitive
conflict"), ref->name);
When we find duplicates it should work fine I guess.

Let me know if this direction makes sense or if you'd prefer a
different handling strategy,
happy to start sending patches.
