Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B515379C22
	for <git@vger.kernel.org>; Fri, 22 May 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779476812; cv=pass; b=bVk/9i5BpaD8Am4rNADCOm/hBgtfp4Da4PLrEoRkKOFT9dvS80t/SqrGVevRNDUzIUyyYRl8BaSqjJIDra4Cqf4Ma7nm7LRLqrjPBycd+dMZ/hiPjj8TsKqu/Rb4DcjCrUqsitu/nhwlyRbi9ILiWqilvT0D7GJODCjAVCEblsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779476812; c=relaxed/simple;
	bh=n1ODWD1Itpig3XrCyfknzXcfazqRTHbN0J421+0PDjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPRXcpcM8a7cWiaVgYyAdvkG1v0YHwb20N6YhVatJIqlqq2q3g+mOPYm93O6yDD8lulkJvbE5OQ1XipTccEa8N3O8JH3g/E6bzMEQneWjplZWEBbJMKjKPqwuoxzV1cqsC8MPfzJYxZnE4mcJs5EO2JiavAEb/qRDP4KK/4rsXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrx7ul1v; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrx7ul1v"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcdd1b492eso7678454a34.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 12:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476809; cv=none;
        d=google.com; s=arc-20240605;
        b=ekMhxKIoY9oVIFPh8a3TFjuF+ib06cuFXB6WFSB7p2Dd3ipR1Xx/VpK/V3zi/dW/L7
         pPXbo9d1sTtRvJEMo3MjfkgpVpQH9Bztn5PDx9KN8MfI2i6u26SWYgGWGi9rJwTgocya
         Hn+Lq2Pa3BG7do5z3BIJJ042pD4zaptkWio2uEUV+MzIaAsCCB+7u631PZuJEnJH0SR7
         o3dvRX96Wn30fOWIkTxChhIaFWTq36MIBJeBoQE20GHLZDon+TFzMPxnLI13Fz3AfKB7
         9RjH/F65VYfi5d0GSi/LSX33KZdTUz7QNSjquz4UFD36hmZFSLoRMpKnDbeBpqeOiAJb
         cMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wbrU5LVZNtOBo7j5fTfo1yrx1FK08Mo/vA8vRI1r2YA=;
        fh=A3cwKf6sV2ZdmQ4xhJvAimPAp4Uh8FQrUSAAwPR1Epk=;
        b=Idm6XcFoi6Bk1NCsd2jy6Ahb6e4KN1uzZ2ye3fV44+T5NIRwPKzJJmlqXDkH/ZKW6f
         pm9it2dhZIeZdZY30I57WT4utPtVJlkAJPRTH9CLgMu/Wa+QYvspmAR9ZDlPHVMGHNlM
         8sQTcMkuw3FiirvUoCQBtZeZgOnyWA8VdEXyhgdt4o98sMXFLaW925bwn9KbOTdp+qNv
         VQX48VAGWDkSI79NkfZnTLRCceThPls80HKxbXyAy8WPuufEjVnz6rMicCMg7qSvrU90
         3T1085sV6tvPq8CgDdhutw7b2joI3hHcumnYQ3JpdJM1AFDR5m1/RDh2DyfoQTiWoWu6
         yRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779476809; x=1780081609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbrU5LVZNtOBo7j5fTfo1yrx1FK08Mo/vA8vRI1r2YA=;
        b=Lrx7ul1vjjQLnyEQJ2rZJv+gz8s3t/v9oa6QGmCWSE2gdDRgdiUuLZkvYrJhPYJQE4
         R/cE1OfUT2Nq5Qxtl8sdEup+OVbgbiIq2W9uQ//OPN2ggX3C9iKvUmEkFUiv5OM48lKN
         AorL/zYgBVgOWKAXUpPPXQ45FuaQe3uT+XsIxpDlTKDFnRItVgWOiy3C3CSZYzXDjib4
         y/gaLTdnliXU9E39kPMGz/VrGowU6r2A9Wn0akJzzVhgYWSWK9iOSn5oq2mDWLmwu7QG
         S7qF1aohwYJV3H1hpQhGp3HFwlQ7Zmdb0P7BhKk9mJJlPg6uQ5EHYT66EorCI576OYFu
         BqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476809; x=1780081609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbrU5LVZNtOBo7j5fTfo1yrx1FK08Mo/vA8vRI1r2YA=;
        b=lE6YZobcEd4uU8J2xJMWPOjm6OADKfsJRD9tN/LTiB/RbSk0NTB+VUV3AuuOBek6Ft
         QomFpuVZ774R38fNcreJhizcj/egZ2O241gcyj8D4xuCkLkjfHSwCCHNtfbO2CbCtrQM
         4/1Q1rL5TcF+9CS5ZO86TVP1c9bY05f0Fk55ARJRmMWA9py1y/6BSrA9hAGgAcEkB/Tn
         rf4djOBghT3/n0THsfqpfAUna9eftdEyVfrRkx592HR6IyvHHSJpcdBvAexs0O8I3N7L
         SBFFZ6xDX5IDRR9oKdzA8h5SwxwUGog8ant5Agc8bCdruIXYDb8Np2MxUfvtC1kBI5Co
         tn1g==
X-Forwarded-Encrypted: i=1; AFNElJ9gT1YHhhDQJVl+5jf4zCW969xZA8wjM2Y1MyWPvcnEJp60E5J4KrB6GcMAEpZWzNQ6B68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOg8vOryIJlyuKlSFIzbKJWPE7CNUVYVa5maCs1OCIJuPHh9X
	187vLBUAg8YVgVHeDQaGGCAVTk9RQL9tjXBlNGjtBhYlB5YZcelq5d8ZbyDVTdmZ95uzYQ4VhdS
	kEz2jrZpfmPFYwpMZKn/OgUUZzA58NcU=
X-Gm-Gg: Acq92OE/eBroulYFq5oUXIau0xnj/j4I2tOpO7A4yZV38xpzQf5BEa5Oajpz+Vtp5mg
	vlx3xP1Kkyx5U7vmjtdx62eBTqnDtoMg+H7yvJsOxiL4nXDBJTnjrDWpmVKxpCIQPw5kgiroIM1
	IcMY2izWFlSOPTtevF4EkdNuyF0mTIvLNSaiEAg5faRB1vVeTymzCzPE5p/EM2MN6fGOeAVoU1F
	3dLcHzerSVPy0MKK5oF/8L1AjK/K5f17pXlx4QZWY/UjZWQMNDNJgMmOxpubhRDvulvtvzKiKMh
	RHgwAZ0swSvAfGKTsWRj4uMB1yt1VyL82+A2efYM
X-Received: by 2002:a05:6820:1ca9:b0:69d:7b21:14bc with SMTP id
 006d021491bc7-69d7fa8fd95mr1936175eaf.5.1779476809192; Fri, 22 May 2026
 12:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
 <8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
 <xmqq33zkui4q.fsf@gitster.g>
In-Reply-To: <xmqq33zkui4q.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 22 May 2026 12:06:37 -0700
X-Gm-Features: AVHnY4J9lfLYFK9a7vJW3kglX3h8HP149ppubnbtzs7x3SEcmzJbE9XdQBaj-z8
Message-ID: <CAC2QwmKkwnr+TvLDnDuLEvGJeoraB=_YWC6idA57dxUqQ_5Fcg@mail.gmail.com>
Subject: Re: [PATCH 1/5] xdiff: support external hunks via xpparam_t
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +/*
> > + * Populate the changed[] arrays from externally supplied hunks,
> > + * bypassing the diff algorithm.  Validates that hunks are in order,
> > + * non-overlapping, and within bounds.
> > + *
> > + * Returns 0 on success, -1 on validation failure.
> > + */
> > +static int xdl_populate_hunks_from_external(xdfenv_t *xe,
> > +                                         const struct xdl_hunk *hunks,
> > +                                         size_t nr_hunks)
> > +{
> > +     size_t i;
> > +     long j, prev_old_end =3D 0, prev_new_end =3D 0;
> > +     long total_old =3D 0, total_new =3D 0;
> > +
> > +     /*
> > +      * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
> > +      * them via xdl_cleanup_records().  The allocation is nrec + 2
> > +      * elements; changed points one past the start (see xprepare.c).
> > +      */
> > +     memset(xe->xdf1.changed - 1, 0,
> > +            (xe->xdf1.nrec + 2) * sizeof(bool));
> > +     memset(xe->xdf2.changed - 1, 0,
> > +            (xe->xdf2.nrec + 2) * sizeof(bool));
>
> This, especially the starting offset of -1, looks horrible.  The
> internal layout of xdfenv_t might happen to match the way the above
> code expects, which is how xdl_prepare_ctx() may have give you, but
> it somehow feels brittle.  I guess the assumption that changed[]
> does not point at the beginning of the allocated area (e.g., it is a
> no-no to free(xe->xdf1.changed) or realloc() it) is so pervasive that
> it cannot be helped.  Sigh.
>

Agreed it is ugly. I wanted to make sure the entire changed[] including
sentinels were clear as a defensive measure for downstream callers
(xdl_change_compact). I agree this results in something that is ugly
and brittle, but in the end I thought it was superior to relying on the
fact that upstream zeroes the entire changed[] array. Maybe if the
comment was more explicit about why this is happening it would be
helpful?

    /*
     * Clear changed[] arrays including sentinels.
     * xdl_prepare_env() may have dirtied them via
     * xdl_cleanup_records(), and xdl_change_compact() reads
     * the sentinel at changed[-1] during backward scans.
     */

> >  int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> >            xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
> >       xdchange_t *xscr;
> >       xdfenv_t xe;
> >       emit_func_t ef =3D xecfg->hunk_func ? xdl_call_hunk_func : xdl_em=
it_diff;
> >
> > -     if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
> > -
> > -             return -1;
> > +     if (xpp->external_hunks) {
> > +             if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
> > +                     return -1;
> > +             if (xdl_populate_hunks_from_external(&xe,
> > +                                                  xpp->external_hunks,
> > +                                                  xpp->external_hunks_=
nr) < 0) {
> > +                     /*
> > +                      * Invalid external hunks; fall back to the
> > +                      * builtin diff algorithm.  Re-runs
> > +                      * xdl_prepare_env() via xdl_do_diff().
> > +                      */
> > +                     xdl_free_env(&xe);
> > +                     if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
> > +                             return -1;
>
> If the external tool keeps sending bogus hunks, silently falling
> back to what we would have done if there weren't any external stuff
> may be necessary to pleasantly keep using Git, but two and a half
> short comments here.
>
>  (1) "What we would have done" is exactly the same as what appears
>      in the corresponding "else" block.  Can we make sure that we do
>      not have to keep updating both copies in the future with some
>      code rearrangement?
>

How about something like this:

  if (xpp->external_hunks) {
      if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
          return -1;
      if (xdl_populate_hunks_from_external(&xe,
                       xpp->external_hunks,
                       xpp->external_hunks_nr) =3D=3D 0)
          goto diff_done;
      xdl_free_env(&xe);
  }

  if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
      return -1;

  diff_done:

>  (2) The writer of the external tool may want to see some trace of
>      warning under certain flags when a failure of the tool forces
>      the receiving end to fallback.
>

In diff.c how about we emit a warning rather than a trace on
fallback:

    warning(_("diff process failed for '%s',"
              " falling back to builtin diff"),
            name_a);

>  (3) If the tool throws too many broken replies, perhaps we want to
>      disable it automatically?
>

For the RFC I wanted to keep it simple, but I definitely agree. A configura=
ble
failure policy makes a lot of sense to me (e.g., disable after N failures).

> > +             }
> > +     } else {
> > +             if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
> > +                     return -1;
> >       }
> > +
> >       if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
> >           xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
> >           xdl_build_script(&xe, &xscr) < 0) {
