Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F011DDC37
	for <git@vger.kernel.org>; Fri, 29 May 2026 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015928; cv=pass; b=sk/sPs5oM+O9u66l47IicicXpTh3wN71T/IMYW/Tw7cr2+Fve7WK8LTe4EQdF1HQ1XLFxw4gPLdFnz6ypwIckCwDcUSmmsDnr4+3fQpy2bm6peNh3YZBk9MuxT+Qq2LOEh6DkYsnUrX8erTAMmgl8fGDo6cVmIEzLziqjZVgxXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015928; c=relaxed/simple;
	bh=/5F8YamUELkGTz/THDvPMsal40OpJs7l3+MNBBOSMyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxq1cP9yx/2HIF54WPcSAxr8HKYm/TqypemC/2QufU44d0GgKO2IoSAm1CAikUyUN6r34tR3PX5sGAuisPyvXsqeF3ITHfj0iogVTJjQeAyhC85n16d25n/1ySyNKSMMSgBusYDMPBpGF+goZScpGAawUSj9Opz/MUrQVqPzZ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZeICez5; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZeICez5"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so4825081a12.0
        for <git@vger.kernel.org>; Thu, 28 May 2026 17:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780015925; cv=none;
        d=google.com; s=arc-20240605;
        b=HrcXEOox8+2qWyrrdDhmulhKfyrhH8Q6Rj+/MRbGzzPOBoEvmuLkTHWCguDqhufy3r
         5nc6xb7CQv+MaJR4omtsJTYHVbMexg/knsD/x9yN/eSzHZHzyR8WTTKPSOdxHGKZydbt
         H3GZ55glG8J3HVoUBkRKJStzeGAfKTGZXW59pQZYqEDc1X2tMNXhzSQjv/FZJdDHXlZp
         oW93UBqTDkVwLQR6rojW4ThYAcMnEbo9MxEAZoINj+2V4CwZk6JU5nUTa2wmCNrIpZ9l
         wpFk4MWDaTUWeDpOBl6p4UYiBnO59kk19BdR0jgPuFi3HHgVr/NK9UJLpjL26OqcstZl
         dfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lpDkwxVq8A2vxJwgFz7ItJau4+xeM2fMr2eDkWnvnhI=;
        fh=WKPpNHkStZhISqcwjU4nQcSjgfLoVONx+M4qDiVis0E=;
        b=La2tG1kcLKRIudv1Tm1o6JPfYk45CxdnCTcCbfl6yvVMGWPIb2ffQNbtvB1HJ/L6TR
         q9NYWrbaQgDlg1LL1gzK1k3CWZPZvGwHs+8Ltte1JdgoF3TimNRCbWA9vT/jmdYm/B30
         lRxMniwGKcSRXwKrwbe3x6c0KecvvkR7poSqdUNaDWBC8VAGp1gjidGo+ejEE5nIUuMz
         TiqQ3ikkt4/RYzLu5+//Av4Z/TghzaVkc4EzoOEppVYIWuf1cqt3NyJeQMrpORhPDxFr
         MlT2nvXTCesNwRITt8UT2wiYvgRYnETNJKRlRMDfe4Wd6EKFIPbNMJTYK0V4JYjSEFJS
         iM6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780015925; x=1780620725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpDkwxVq8A2vxJwgFz7ItJau4+xeM2fMr2eDkWnvnhI=;
        b=lZeICez5D6nRS0nquRhESZ6rJBxpGkUwftDcEOdiUCrxL1QHjpfTlAgKs2WrwSU52Z
         CFa3wyX91RfHHMyMVzxJ77Pt4wgkAr29LcK1Zwq3yX3MLEX0SGku0wR8suTW9z1yg9Q0
         2MY/UhwJzNHiBeMDuF1etTxHFk/wIHsZpDRlRRau/uMu75GH+JdRpS9vRec7HkJdMRJx
         f0xog8MR67c/P6xDcNU3R6W3wr47zRgAiYMU029GfS9xcXF29EBa9NyscIE5+8KOcLWB
         Il6+lCntCY0Vf1h8zEVhTT4aAviAyq2a2yoDC6VZfQ5UmNfdMXX6exXYnUt4n/gptNZ0
         aYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780015925; x=1780620725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpDkwxVq8A2vxJwgFz7ItJau4+xeM2fMr2eDkWnvnhI=;
        b=hOuWGz0C/9dvj528Qhg+0pz4LWlPAudeT9003POQjMANYFuRFphzg5tIxIOQEywkLO
         86uuVybnb6RgDSZb6sw09FzI/FWAKzdvShMJWPRspglKfT2tVpv/ITW5uENn0NBKNjsi
         csY3Si8FH/AsW4uMMGS7v0PqtdSD0G50Mia5eVcS6hzSKeGxXZCZvyuXNmygZNk5xn2T
         rMvUWbwuTGFOEVJBn1UZcw1jQPOb3zTPIbhknwr2Hd9zvLN1JZYFnESqnK60uA9XX8UH
         cVpf5vEh7qzNyV+v1/F2YcO52OGyr8/6r6uvfyTkANxYu3idE59MGdDKajTLOrrSBT3U
         2YPw==
X-Forwarded-Encrypted: i=1; AFNElJ9jIEWsTQ3yIi7se0SpDlqcVi0e0FyoUJf6+uSXgZxJG+8V3Ty2cFiIvs7rxcZsJRgsfbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoLYeP7Der9fXhxBHlLj3U0wjTHxpmMzU34NcXYueVN3evyOm
	nKbTiRQp1GKWaTc8+OwvUuL2/YOTgrK4mk1jfKXLcUqQxGiLt3/nyu1X7XAXEMT5J+z6K6FjTGf
	CYB6QiypiUgYsFM3omTH1cKHnEot2MlU=
X-Gm-Gg: Acq92OGoaH9emo3GEt/cYKQgmdZ7/lX6101MfBe3CzHCaVZ0fRvxjASSbWmgsAbDJIM
	1j87Xa3QiMu8CUtij+++JgXUFQ39z6ZOlSXEagxdY2gzHhJ35IiJffeKc8qZjI2SslaTqUlhABl
	Lmdb6bb1CM2qIuJCBV6cUCFPXbJaKuj6uTObgbfA+1jsgQitL/b4oycU7GPbSGwjKMYL6q50FMO
	4lXWk/2/WGBUO2EV75bNg5BU7bue+52K+VnyLz+Fk+bUKK4mn69RDzrKncaRSVAcyGc/xoAbSmB
	2UhETuZSW2QX9pdibvepRECr/2G393PBFROjoCWejowiIEySjzk=
X-Received: by 2002:a05:6402:1cc6:b0:686:d801:96c9 with SMTP id
 4fb4d7f45d1cf-68c11e2282cmr225551a12.14.1780015924224; Thu, 28 May 2026
 17:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
 <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com> <c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
 <xmqqpl2jlyr3.fsf@gitster.g>
In-Reply-To: <xmqqpl2jlyr3.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 28 May 2026 17:51:47 -0700
X-Gm-Features: AVHnY4JS_W1cnIWf7fe1qB81gtoSYRKJo_LH-mkTfBN2kEvdvWu1DSO6iLutNLA
Message-ID: <CAC2QwmLtr+5J++PSoecKtMw=Bdq_jCYzEK7zeourHH7tMk1H5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] diff: add long-running diff process via diff.<driver>.process
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 6:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +struct diff_subprocess {
> > +     struct subprocess_entry subprocess;
> > +     unsigned int supported_capabilities;
> > +};
> > +
> > +static int subprocess_map_initialized;
> > +static struct hashmap subprocess_map;
>
> Can we avoid introducing new global variables like these?  Would
> "struct userdiff_driver" or "struct diff_options" be a good place to
> hang this hashmap, perhaps?
>

Will clean this up.

> > +static int send_file_content(int fd, const char *buf, long size)
> > +{
> > +     int ret;
> > +
> > +     if (size > 0)
> > +             ret =3D write_packetized_from_buf_no_flush(buf, size, fd)=
;
> > +     else
> > +             ret =3D 0;
>
> Shouldn't "size =3D=3D -24" be flagged as an invalid input?
>

Will fix and do a broader audit of input validation and bounds checking.

> > +     if (ret)
> > +             return ret;
> > +     return packet_flush_gently(fd);
> > +}
>
> > +static int parse_hunk_line(const char *line, struct xdl_hunk *hunk)
> > +{
> > +...
> > +}
>
> This gives a silent error diagnosis, which is good for a lower level
> helper.
>
> > +int diff_process_get_hunks(struct userdiff_driver *drv,
> > +                        const char *path,
> > +                        const char *old_buf, long old_size,
> > +                        const char *new_buf, long new_size,
> > +                        struct xdl_hunk **hunks_out,
> > +                        size_t *nr_hunks_out)
> > +{
> > +     struct diff_subprocess *backend;
> > +     struct child_process *process;
> > +     int fd_in, fd_out;
> > +     struct strbuf status =3D STRBUF_INIT;
> > +     struct xdl_hunk *hunks =3D NULL;
> > +     struct xdl_hunk hunk;
> > +     size_t nr_hunks =3D 0, alloc_hunks =3D 0;
> > +     int len;
> > +     char *line;
> > +
> > +     if (!drv || !drv->process)
> > +             return -1;
>
> A driver that does not define process is not an error; it is
> perfectly normal in the current world order where nobody has such an
> external process and even fi this patch lands, external processes
> are optional.  So here "return -1" does not mean an error, and
> silent return is perfectly fine.
>
> > +     backend =3D find_or_start_process(drv->process);
> > +     if (!backend)
> > +             return -1;
>
> This is probably an error; the user specified drv->process, we
> either tried to find or start the process and failed.  Isn't it an
> event that deserves to be reported in an error message?
>
> > +     if (!(backend->supported_capabilities & CAP_HUNKS))
> > +             return -1;
>
> Backend started, but the "hunks" feature is not supported.  Perhaps
> in a year or two, this external process protocol may have become so
> popular that it gained more capabilities, possibly making get_hunks
> obsolete.  We may be looking at such an external process that uses
> other capabilities but not this one.  This is not an error, so
> silent return is perfectly fine.
>
> > +     process =3D subprocess_get_child_process(&backend->subprocess);
> > +     fd_in =3D process->in;
> > +     fd_out =3D process->out;
> > +
> > +     /* Send request */
> > +     if (packet_write_fmt_gently(fd_in, "command=3Dhunks\n") ||
> > +         packet_write_fmt_gently(fd_in, "pathname=3D%s\n", path) ||
> > +         packet_flush_gently(fd_in))
> > +             goto error;
> > +
> > +     /* Send old file content */
> > +     if (send_file_content(fd_in, old_buf, old_size))
> > +             goto error;
> > +
> > +     /* Send new file content */
> > +     if (send_file_content(fd_in, new_buf, new_size))
> > +             goto error;
> > +
> > +     /* Read hunks until flush packet */
> > +     while ((len =3D packet_read_line_gently(fd_out, NULL, &line)) >=
=3D 0 &&
> > +            line) {
> > +             if (parse_hunk_line(line, &hunk) < 0)
> > +                     goto error;
> > +             ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
> > +             hunks[nr_hunks++] =3D hunk;
> > +     }
> > +     if (len < 0)
> > +             goto error;
> > +
> > +     /* Read status */
> > +     if (subprocess_read_status(fd_out, &status))
> > +             goto error;
> > +
> > +     if (strcmp(status.buf, "success")) {
> > +             if (!strcmp(status.buf, "abort"))
> > +                     backend->supported_capabilities &=3D ~CAP_HUNKS;
> > +             goto error;
> > +     }
> > +
> > +     *hunks_out =3D hunks;
> > +     *nr_hunks_out =3D nr_hunks;
> > +     strbuf_release(&status);
> > +     return 0;
> > +
> > +error:
>
> All exceptions that lead here look like events that should be
> reported to the end-user.
>

Agreed on all points. I will restructure things so errors are flagged when
appropriate (i.e., user specified a process but one was not found / couldn'=
t
start and exceptions) and non-errors are treated as they should be.

> > +     free(hunks);
> > +     strbuf_release(&status);
> > +     return -1;
> > +}
>
> > +/*
> > + * Query a diff process for hunks describing the changes
> > + * between old_buf and new_buf.
> > + *
> > + * The backend is a long-running subprocess configured via
> > + * diff.<driver>.process.  It receives file content via
> > + * pkt-line and returns hunks with 1-based line numbers.
> > + *
> > + * On success, sets *hunks_out and *nr_hunks_out to a newly allocated
> > + * array (caller must free) and returns 0.
> > + *
> > + * On failure, returns -1.  The caller should fall back to the
> > + * builtin diff algorithm.
> > + */
>
> I do not agree with this.  If it is a failure, the user should fix
> the external process (or disable).  It shouldn't be hidden behind a
> fallback.  As I left comments, in this round of implementation,
> there are conditions that returns -1 for soemthing that is not an
> error (i.e., not configured, or process not supporting the
> particular capability) *and* in those cases the caller should fall
> back as if nothing happened.  But some error cases, the caller
> should't hide them.

Will address in a follow-up.

Thank you for the feedback!
