Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782E3EFFC9
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561782; cv=pass; b=fhjH6VhFhB4d95d1yzbObBfOilhrOlVyHHiDU72ZS1QwHGsMlhY1x5m16Fs2/zmv1d4C7r0sP6+VjzvdnupQKgpD6RJcvVSG0UZw4ShiGI3VwDwqihjbaMfaqrAsjESv6oImo1ia/I9Kv9JBlotcPan2wWOMm5IPOyZR42gWjhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561782; c=relaxed/simple;
	bh=vJqsQptBr2qstF1aLe036cDhn+H0C6wjJqU3JvPxNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdtFijV0Jp8mzMeagTD9o8KO06kSvHr3WVjhQp3H8zkiN+y4VyTafHetgERKzXnvn8/5cVV0nb9XN9wBQ9aldWXsX6KeSnS6X5qrzwux4TI+Ml0uOu16KUABPHq2PFk7+zd+IKHAO38PIFG5PDFbK5AE5NPlYJcbIoZkRKaI5BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVe0Acjt; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVe0Acjt"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91c22d27dso5111555ad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 05:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561780; cv=none;
        d=google.com; s=arc-20260327;
        b=mBEW1aguscYBIDXKRYe83DFv9tA10rBy/T1UoUCOl43+RpI9gJJKvNWqcJCS3TFdrv
         udZb06jdHDuz6T60Rr4CHyUk1uwQKuXMRbBjOTYQvgXV0GpT49wmfJJ1QW7Sa9H1pFda
         kf7fjZXLkm5Hfmy5lziHhKphjqe9IME3rwtTifu5B4EqWxGPJux5v9JLP34KHFr24pxZ
         b6xKtplXGxSpq9MmTsA4xO+VkSn8qtKUsmu3zcYvkNfTdFbMHtmQ4v/SzoRjp3Rn0c6+
         1vWZvrd2jlt8i2p95/FnJlOhv56t0Fs7TTJb1DGBy/bKKDZsGcxb9f4KyerECYsYWZzD
         h7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bohr5OWUxaPxjz01ayTGMZIpoJuU8oHt0nyYSIlyGbE=;
        fh=o6ADUqR/bFWoqJD/RJ42kch0R3mvd3akwb4flSQuLC4=;
        b=GZDookMuYGUU5zyZeHrdmF0mG1zN98qN2u8idGEuRBYockG1AGlGtnNQjlyXd6E4df
         SlVZZ2bbsshurCmdWfCumk9WQu3frjXBMbmD0+6aF3QPRqZRPT0PQq5WTVzfrjgLNa3e
         6TWpOvlDNQk5hEgubas8wW6l8KO6DWdvB8rz97qSelJDDRlMl7sIKGXvrk6B0QztyYOR
         cuWdYbeu1odJstZchQ5TcOjmjCwQs3rWCqvaspq6wX+Ri5sXaPIYGCeO/c5FARFxOrVG
         zqjU/0fN88D4H7mELMM4B4ATiKtl+B0wSBDJDNf627xWoQdv1zPkQRQgAWUFl4oLzz0p
         mCjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561780; x=1790166580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bohr5OWUxaPxjz01ayTGMZIpoJuU8oHt0nyYSIlyGbE=;
        b=qVe0Acjt+wr7G0LIbaR4SsLI+Z1vQM/VYI2MvRL8TvVTjh9NiL+wryreo0cqTWsLQj
         yWj54Nr+3gjAwyyFMTk26AERWPlHfdBQCNcFHXw0OZZ2sL7GkEDNx4Njvn0Gx0/Se+fm
         q3IxYT4ikBLo1cJb3+T16UR3aW5nmFOwCjuaUdIsW4eOjFwV2dd7B/PP+fIOEparOWb3
         sP/oJAVNA22ptO+GAZCAHcHWFkIacsob2Ik8a94Ew2ju4BVvqDtizMAOImhj9x7ZvLd2
         mvMn1Jz//er7roCmyG3xCVrmGWGg6MAu7tjsszgS8MduQnhyfWvfqORz426Xe2L0Au80
         ve5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561780; x=1790166580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bohr5OWUxaPxjz01ayTGMZIpoJuU8oHt0nyYSIlyGbE=;
        b=0COHAO1TwRxftOln6U6+ap86BKPF6F4lAzZjz4Km64Hap1klp+2z14Pz8P/J+k2lbL
         PlH4KaVtLcq4jwZgrS8J9gCtiw1i6GRo2OPDEkoHwTO3S4uqIzyObJ1SmTaGA/6wDUcU
         MRub4ltfTnJ+vKGD75/aY/soFzdVVbM9Zk3Oqe170iMyf4YzzTFQ96MapiCmJlXHlPmj
         96DOjofnZdFWdQ+kzKv28DB3zCTAUsMi4V+l/RuBhEm0oknc0obQA6z7VxZg0gfqXLPz
         pLnZaAxXd6zRlD08k6WfNvw1vv5NWCJW0UIbuSwKP5yhh8rGEjZbPALCuer1qbjlT+vh
         cfNg==
X-Gm-Message-State: AFuF++n4YR5QrHUI92p3wzPs+uIcKpwQ6sQli2RhXUHJ1vRj4ao6uCGE
	N+gpclSh3ZUKmPWGvDUJcoIo2CbqSDVe4HkUaOoIa9lSs5FoB4/Gn5JoTyPQKUttQpHu4g20js3
	TNeeXUzal73PsrzX+FPUbLhl6pOQp4DE=
X-Gm-Gg: AYBFou0XVd3Z8E6DUy9YAZ/b2kZ3qxHmhG2chdNtIr/B9Vd+F9hgrfQ7BkFhiM7jPH0
	0jN24R4OQYuL4MVY5n6BFInLv5KSv/RG+pMwnrV9M8RM8HgTqOSdnsVQTjUPQuWJ8ePx+pcuwBM
	XIxCmO0VWrBPcb/Ua895Sfl7IEWqnaiy4LGe260ZYKchQ4nvXCHwuba8Unl94MimC3068RHZmru
	TRufJtoH/fRlSbPaLO30AN+GxH01MyBkd0v5LLYIJgWiqxYdN1PCcJ96HvkxdBwzlY9CUng+ZmL
	lrA+QU5mihdpxCq1xVyhNhaTiK5Nf6meuOdf9e9K9gKYS1OZk8ZkNUV3kTyMZyLlc3KBvT/RfUT
	hhV4irYZtt0bYkY02udh7JkjWURKofbOS2hN5Rt/v9SJDISxTFBXhau6huhd/uZg3H2fjSSZPNz
	bJ8qNySaw=
X-Received: by 2002:a17:903:4b4f:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2dd8e00565amr54361685ad.7.1789561779742; Wed, 16 Sep 2026
 05:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260915233305.334115-1-tyler@tylercipriani.com> <20260915233305.334115-4-tyler@tylercipriani.com>
In-Reply-To: <20260915233305.334115-4-tyler@tylercipriani.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 16 Sep 2026 08:29:28 -0400
X-Gm-Features: AcwNN1V4K7Zm6Qnv0aVB04sr6t-wSCVNRyFNC2YVV8tCLwOq4fzL5yoBl3n50ic
Message-ID: <CALnO6CCpxwenphyZvEX7gjvAmLPidv+4iT98uh95mXj_MvshQg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] push: --force-if-includes should allow fast-forward
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

On Tue, Sep 15, 2026 at 7:33=E2=80=AFPM Tyler Cipriani <tyler@tylercipriani=
.com> wrote:
>
> In set_ref_status_for_push, we verify --force-if-includes's reflog
> reachability checks before fast-forward rules. As a result, valid
> fast-forward pushes may be rejected when a force push is unneeded; like
> when the reflog is expired:
>
>     git clone repo.git repo
>     git commit --allow-empty -m 1
>     git reflog expire --expire=3Dall --all
>     git push --force-with-lease --force-if-includes origin main
>     ! [rejected]    main -> main (remote ref updated since checkout)
>
> Rejecting fast-forwards is a mismatch with the --force-if-includes
> documentation "Force an update only if the tip of the remote-tracking
> ref has been integrated locally."
>
> Instead, defer check for --force-if-includes until after determining if
> a push force is needed.

"push force" ? :)

> Opted to create a deferred_reject_reason in set_ref_status_for_push
> rather than move the computation of reachability or verifiability to
> winnow scope of changes in this patch. Lazily checking for reachability
> or verifiability is a valid followup.

This paragraph does not match our usual style
(Documentation/SubmittingPatches[[imperative-mood]]) and feels
somewhat artificial to me.

> diff --git a/remote.c b/remote.c
> index b7b5ac0d28..db0b50b030 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1669,6 +1669,7 @@ void set_ref_status_for_push(struct ref *remote_ref=
s, int send_mirror,
>         for (ref =3D remote_refs; ref; ref =3D ref->next) {
>                 int force_ref_update =3D ref->force || force_update;
>                 int reject_reason =3D 0;
> +               int deferred_reject_reason =3D 0;
>
>                 if (ref->peer_ref)
>                         oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
> @@ -1693,16 +1694,17 @@ void set_ref_status_for_push(struct ref *remote_r=
efs, int send_mirror,
>                  *
>                  * If the tip of the remote-tracking ref is unreachable
>                  * from any reflog entry of its local ref indicating a
> -                * possible update since checkout; reject the push.
> +                * possible update since checkout, then remember the
> +                * rejection in case the push is non-fast-forward.
>                  */
>                 if (ref->expect_old_sha1) {
>                         if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>                                 reject_reason =3D REF_STATUS_REJECT_STALE=
;
>                         else if (ref->check_reachable && ref->unreachable=
)
> -                               reject_reason =3D
> +                               deferred_reject_reason =3D
>                                         REF_STATUS_REJECT_REMOTE_UPDATED;
>                         else if (ref->check_reachable && ref->unverifiabl=
e)
> -                               reject_reason =3D
> +                               deferred_reject_reason =3D
>                                         REF_STATUS_REJECT_UNVERIFIABLE;
>                         else
>                                 /*

From these 2 hunks, I haven't yet seen the connection to avoiding a
rejected force-push in the fast-forward case, but my read is: we
remember why we might reject a force-push for refs whose reachability
we are supposed to check.

> @@ -1746,6 +1748,14 @@ void set_ref_status_for_push(struct ref *remote_re=
fs, int send_mirror,
>                                 reject_reason =3D REF_STATUS_REJECT_NONFA=
STFORWARD;
>                 }

Then in unshown code, in those 2 "remembered" cases, we check the must
fast-forward rules. If any fail, we set reject_reason=E2=80=A6

> +               /*
> +                * If push is non-fast-forward and we were asked to
> +                * verify the reflog but were unable to, then reflog
> +                * verification is the right reject_reason.
> +                */
> +               if (deferred_reject_reason && reject_reason)
> +                       reject_reason =3D deferred_reject_reason;
> +

=E2=80=A6which we now overwrite with our remembered reason in the rejected
case. I think that makes sense.

At first I thought the unshown code above, conditional on
!reject_reason, would collude to make it so "deferred_reject_reason &&
reject_reason" could never be true, but I was misreading the results
of this patch. There are some arms in which we set both (namely,
because those remembered cases don't set reject_reason, allowing the
fast-forward rules checks).

I still wonder a bit about cases where we remember
deferred_reject_reason and never set reject_reason, but I think those
are supposed to only be the fast-forward cases. Perhaps we want to
make "deferred_reject_reason" more clearly indicate that to save
future readers headache if they insert code around here? I'm not sure
the best way to do that, though, so maybe blaming to the log message
will suffice.

--=20
D. Ben Knoble
