Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700030E858
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410358; cv=pass; b=Dd8NlnBrAKT7lN3MmuPzmV/RbPxL5fccVjMuBUYg6GC/L3hpWMTqPPNg6EC3L1kW4t3HKcUIv6/qxi5C8GcTdZSBrcrVEAsxjGq4l5K9CGfANmJ8l8W2W+I23Lm26sRA8JmQijO7I4MxtgU5aM/zmDjgnDizooV0kuTJ2riv4xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410358; c=relaxed/simple;
	bh=aF7OFLi+0wlziWaV8l/fLaQWYRYi+neLrdB1pfZP/WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKL7mbmp/sMTIfHS7d8qfRarfsqrKl7N8Qg3eZ/itjRnTcPC58dWFD5W/mpDj58YUsUKaM3jUDtOTT1qFsxnObB3NvtIW4S77qqGdnNPgPFUOPax/hX8jZr2yjxH0dwDxozAimCZ5/VCzEZotN6IRKbOC5fulhG7aEMaXnhoGM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTez1hlu; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTez1hlu"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5636274b338so1826832e0c.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 12:39:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770410357; cv=none;
        d=google.com; s=arc-20240605;
        b=bKmZlResHnO7oVcPqzYK56xj9RRO1i736YN8/+l83pINEQB7Edx2vvT0fMq/V3DaCF
         vh7fFmoe+Ixe2+/txgTPm5ydv4pc4A3fqMbIALDdlLvBI8BQER7xPgo0hcbeurb2UdTB
         IbRT0OlpNvK9uInYgTC1S05SJGLAIdFygT2a2liQpxZRSL3WvMD03btULsuna/7v6XA+
         BTxcZ6dvjI2bfWZ4ZRuMKfN0Vz9vyh3ZtR8gTBzJ3gX+KGR2COHQvf3tZIBU3Q5ZbKYd
         5rTSooCp7r79RaBboneUFdM+RnMwIHT2lwxUSsZh9/mo0XweSjtRdFchFy9MhqcHdtxC
         5JYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q9BpxcFjaNxfZmJWwXgiYEiFIxOdpbllzdz5l36zJl4=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=Jm94lnHTZU0yoP49pPEQYcJeZZU84Jf4yCs4FTp48M5kQ4Y9SrLg8jfIzulb5CeYaZ
         pjMgOUPqjAGpegW+wDqjdabODj66KFhMlLRNWBBP0zOvbq7pWoJouP2ywIC3tH5Cmala
         l/lmIY6sZ1XMOGqUQ2rETh8RlN64DfUm9fDi4IiADHDkyZsPlEdHcZTNsO2FRMpoAAtv
         eWp6z6LR1Zv9vcnPFPVVR3yAPx6ClxwFe8OGHtLRbXK0h/LmA/udc/wXKSx3G5tHd8mL
         5aY70OX0tI+LMQiajbHvZrDHCDyolARyTRSy6VqSszFp3mfug3KrHKC/mocrZYFQPbTs
         +gyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770410357; x=1771015157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9BpxcFjaNxfZmJWwXgiYEiFIxOdpbllzdz5l36zJl4=;
        b=KTez1hluTJrr+9GvH17LHF25Zm/xfa01Lwva+9Ey9lObZgR1jNNMYdRokjZx0yb/KK
         IpcNkvRTPcJUoTDm3eBI/d8KDBQMr5VACbIKn6+LeHHcN5KSx9APDb2RWvSD6s3hqvTb
         VGeBdzcLsvo97IUa7SvTStoy2ocedX91eoKKOsifkVJhL+4zDq2RJ5Cj7j92XIFPn2Ii
         PLoqiYtHiW+K/dlkFrHN+NDMNqKBmx7FmEcQGQdBm00KbZDfaz8Cofm5soM61b8ovWul
         sg2Jd9G3ts33P9mVH6d9KSjp8ZwHkeMXkgY6yveivl2e2sG0sPFAcDpAHDpLTFK8XNHn
         1rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770410357; x=1771015157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9BpxcFjaNxfZmJWwXgiYEiFIxOdpbllzdz5l36zJl4=;
        b=u7Mu1bY9yEllFZioXy7t6JRDSw57B0mOGR6Oif6a6uoe5wD3rqxIIX7DuCApvPvyBG
         YDSoWL8V05i85BmqnC3r+BGsFZXmGwS0m63384jYcGuSHC2lxz6qe+ruLQT8mKO2B9GB
         cwk9ozeHSejrJstMS1JTfPo3rtiCD42UlSsq3RqoB8PK3kFyY3ywvzHcAZfYcYoWu5bB
         Evy+De9zqgDq0mcV/tRaYoGhSD0RETicvnSFT0dT8yoNsAVapRupYOZ2HT9rIOPzWv5+
         1c4a36XjN0O+Rb7GHJw2GxmZ48rvIf/3T7lIav1wlkYs9GKA658q5rKbRn0aQWadQHIz
         LluQ==
X-Gm-Message-State: AOJu0YyjjWCnAwDbCbwX3HFKYR8N/ENeJuugNN9wr6ontM/X9MINLhi9
	e87fytnf4AmaG8m1ow0GUtnNHLBgvMPGDw3BLObaEh0oj2AjHTTpHFGG7YKwTBNJHLcYapAPb8O
	QLv1lPCIulY/IuW6rixE8S7s/AoPyW7I=
X-Gm-Gg: AZuq6aIl1fEikoLEj/k+tr0G1DBWj40dgF8J6v8yphJsWAi76MteKF1yGlE2umYAMhB
	BrIiSVw72+UMMqe8mhuvaNvq8CaQ5+UkjKBhGQFi289u0zSpqTIXOJrOMLzCd1jGF3l7PU2NcLO
	4Tlp+PLWwuPnILhkxrYjR16OTStPNLzvMZId/a+TC3o7jZVubsnMP9uhIPja0oTzTB5FafHpEe2
	nTPIL3T/ivnZzHiA0mezXTRAk9QRFwn/X9DctbGXb5yvwKjk6Tc0D56lWOUzFtAiO5gmfvCo5Q=
X-Received: by 2002:a05:6122:2492:b0:566:222b:c164 with SMTP id
 71dfb90a1353d-56706408a2emr1213724e0c.4.1770410357367; Fri, 06 Feb 2026
 12:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <10c0a4cb36534f5ed1ebed783b37d03a56007f97.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqqzqxelw5.fsf@gitster.g>
In-Reply-To: <xmqqqzqxelw5.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 6 Feb 2026 21:39:19 +0100
X-Gm-Features: AZwV_QgzIVgl7I59VtR6MOFMnaB5dq2vZJOplrbkvGI6btzQJ5zjgY71RSL94ys
Message-ID: <CADYq+fb3zP0KiPSGGnnbHsX86wc0fWGjbv8s4BNaKPsO+T7znA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] add-patch: Allow proper 'git apply' when using the
 --rework-with-file flag
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 8:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > Subject: Re: [PATCH v3 3/3] add-patch: Allow proper 'git apply' when us=
ing the --rework-with-file flag
>
> Style.  Downcase "Allow".  Applies to [2/3].
>
> Avoid "proper" as it is not obvious to everybody what you find
> proper and why you find it proper.  Applies to any value-judgement
> adjective.
>
>     Subject: [PATCH v3 3/3] add-patch: allow all-or-none application of a=
 patch
>
> or something?

Okay

>
> > +static void apply_patch(struct add_p_state *s, struct file_diff *file_=
diff)
> > +{
> > +     struct child_process cp =3D CHILD_PROCESS_INIT;
> > +     size_t j;
> > +
> > +             /* Any hunk to be used? */
>
> Funny indentaion?

Sorry

>
> > +     for (j =3D 0; j < file_diff->hunk_nr; j++)
> > +             if (file_diff->hunk[j].use =3D=3D USE_HUNK)
> > +                     break;
> > +
> > +     if (j < file_diff->hunk_nr ||
> > +             (!file_diff->hunk_nr && file_diff->head.use =3D=3D USE_HU=
NK)) {
> > +             /* At least one hunk selected: apply */
> > +             strbuf_reset(&s->buf);
> > +             reassemble_patch(s, file_diff, 0, &s->buf);
> > +
> > +             discard_index(s->s.r->index);
> > +             if (s->mode->apply_for_checkout)
> > +                     apply_for_checkout(s, &s->buf,
> > +                                     s->mode->is_reverse);
> > +             else {
> > +                     setup_child_process(s, &cp, "apply", NULL);
> > +                     strvec_pushv(&cp.args, s->mode->apply_args);
> > +                     if (pipe_command(&cp, s->buf.buf, s->buf.len,
> > +                                     NULL, 0, NULL, 0))
> > +                             error(_("'git apply' failed"));
> > +             }
> > +             if (repo_read_index(s->s.r) >=3D 0)
> > +                     repo_refresh_and_write_index(s->s.r, REFRESH_QUIE=
T, 0,
> > +                                                     1, NULL, NULL, NU=
LL);
> > +     }
> > +
> > +}
>
> I suspect that the extraction of this helper function out of its
> original place in patch_update_file() should be done in its own
> patch.

Okay

>
> Do we need new tests to cover this new feature?

Yes I will include the tests in the next version.
Thanks

Abraham
