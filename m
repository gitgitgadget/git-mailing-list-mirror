Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BB282E1
	for <git@vger.kernel.org>; Fri, 16 May 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385530; cv=none; b=pZR5nvnEdaCTXgX9ij6s/iIyb6YED8eHwAPSOHLZ+RBV/8ZQUQ2vxAMqbCCiyjmWd14wGKuRsh3eAOH0YtLgvewHUS2tmhBKJLmDHyqh8hx0elBFeoXR34Esbxc0mU1+ax2iBp+urlQuUUEyD3PbsnyN/a81ID+MzQ3WziJPFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385530; c=relaxed/simple;
	bh=SWfHbXDiTI24pPTghP+9CZTZB20tjSyLh88a7zeWpgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc8qIggg0gM1T/3c+MRTjGLU3wlbMJCmyuNDdxm7w0EBEnyx5BNyPhZFIEKNjXx8MhCseih+5kIeC+3p4qbKgHJ6ztO90y4f+/HVx1gK0zt2Qm7lRUlx7oJ7RxOma21HtMg53Gv9Ls//zb3oz0XWMTp1QLfDv1YwWLnAkdFJcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcBqzaR/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcBqzaR/"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8b27c2d7bso6459216d6.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747385527; x=1747990327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgG5QAXUZ/AR/PBe7uwYgRyjio+U27xt16RZj2q2BmM=;
        b=gcBqzaR/0kb/6xqNsr062n8meMwma2q63Jv3o+1xADB+VO4gO2UVEnpsb4KXMveOL/
         Wn6zW1hxSjsGS+yWsQ34ApVuw50Q638BZnx52eZ/71LPQxc66ZcMx7RD1p6v91lmiY07
         y7abqhNs1H1IC+tHRmWs5SuuyMjSmLtw9PyfiH63QSc4Utgagv2KAw1yosFsOsMEhVw3
         oQpXmoBOHWKAZrDJ7uEphwbx85aBdJ7Q1kyM+0Cvo7dYNZtMd9m11Xbi503vP3jB2EIv
         1/5kEp073ATTNeceAQBl3OZNCRAjcZXJJ9vgpPccapNzUW9hq5XJk9Vxsc5jfKrSSAfv
         r/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747385527; x=1747990327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgG5QAXUZ/AR/PBe7uwYgRyjio+U27xt16RZj2q2BmM=;
        b=vXOIsI1lbk4j/Gw9+L8cu0oFHezZnc3JNlD2MQPlBsz7xyWqXD/RUUGCRXZTs7A5Qi
         JsTYnVAyj3P+WovRERXCVTZBY5QzgIN4G8iLYsH5KvXG1p8u8cJ1sowK5Uw4iOLdazXO
         xWzG08/br7efz6U1sIu7XeHJTRtDeBhJpmLXDHDNExT4RPy3WpE4jyCFaSoos50bhP2s
         P61ENUSM7f8fLzjC+SwHglCNHONOtD6qCuvFlk+p1XJlk6JCDxZ27HexrTXrrc+C5u8h
         4ooJMc9qoIc4YLS7Y0IeMXLNWq8Wpk+kXgLWyGvMm45DZKPStdP2MI8k3FeMIZRqfQVW
         3EmA==
X-Gm-Message-State: AOJu0Yy0r9qpMGlGkHgqlMg3XaIkDdBvmLba8NprNLb/NoRe/9FuDW+9
	RN02TbC/8xojpQVUXm1JJ+pqMU4KJYjuLgSHuevK7ZfQjs+Y/VRV//5x1IWeDwlu0hYoP4W8EfN
	ZHwmvYGPsuNK5rf4FWSOdsxNwrgZxKoI=
X-Gm-Gg: ASbGnct22CKTCM0sRFJPGA+Z2+WjdzEUNuqJaX36K0QdT58usCcVnEfZGoA9vfzRBIy
	71115jG4xs3lOzC1O9zoR9M742VdmrRSc9l4GoNAY9VkfbXKpxV7MJSkrRpAsjs2cAz/amzH+1n
	xEvL5k0JFO8ZXm28fiXG96dgZnPu5RfUu0cseozoqYz/wBKK400fE2ZRaqxN+22XQgUOsGEFbd3
	m8=
X-Google-Smtp-Source: AGHT+IH0Co0i35DuCLSjTeBRNOpAWq3FzG9L/2sfW2ACwhOYtqqJy6nmD9zvdJs2zWW/5BbJlnxd2B+GzpElVgTVXmA=
X-Received: by 2002:a05:622a:995:b0:48a:bbd7:19c2 with SMTP id
 d75a77b69052e-494b079b8eemr27902951cf.15.1747385527371; Fri, 16 May 2025
 01:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7c2kgp8e.fsf@gitster.g> <20250514020108.24396-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqplga6c80.fsf@gitster.g>
In-Reply-To: <xmqqplga6c80.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 16 May 2025 14:21:56 +0530
X-Gm-Features: AX0GCFtSwnsiUUKkBVzeNpj1eVTwDc7FrhmA_BXr7H-sVr-LCDqVj4XgLeP1xd0
Message-ID: <CA+rGoLfYLcx+tM6nif7E5vZDce7PeGyGJkTRraT7kF3ACAzBfA@mail.gmail.com>
Subject: Re: [PATCH v3] submodule: prevent overwriting .gitmodules entry on
 path reuse
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Add helper `submodule_active_matches_path()` so we can
> > re-implement the old =E2=80=9Cis this path already covered by
> > submodule.active?=E2=80=9D logic without re-reading the config twice.
>
> Having duplicated code to implement what is supposed to be the same
> thing is a bug waiting to happen by them diverging from each other.
>
> Isn't the fact that our configuration reading code reads things just
> once and the caches the result good enough for the purpose of this
> code path?  Do we have a measurement that tells us that the extra
> complexity is worth the maintenance headache?
>

Well when I first sent this patch I didn't quite understand why test
4137 was failing
then I read the tests and I didn't have a lot of idea of the code. But
I think it' better to remove helper as you said
I will send a new patch with a different approach as I've spent some
time understanding this now.

> > @@ -3443,7 +3452,11 @@ static int module_add(int argc, const char **arg=
v, const char *prefix,
> >       int force =3D 0, quiet =3D 0, progress =3D 0, dissociate =3D 0;
> >       struct add_data add_data =3D ADD_DATA_INIT;
> >       const char *ref_storage_format =3D NULL;
> > +     const struct submodule *existing;
> >       char *to_free =3D NULL;
> > +     struct strbuf buf =3D STRBUF_INIT;
> > +     int i;
> > +     int allocated_sm_name =3D 0;
>
> A separate flag is not wrong per-se, but the idiom used in this
> project more often is to have an extra pointer variable that points
> at an allocated piece of memory (or NULL), and free the piece of
> memory unconditionally.
>
> "git grep -e to_free" to see the idiom in action.  Even better yet,
> this codepath already uses the idiom.
>
> By doing so
>
> > +     if (allocated_sm_name)
> > +             free((char *)add_data.sm_name);
>
> becomes
>
>         free(sm_name_to_free);
>
> and we can keep the "add_data.sm_name is pointing at a borrowed
> piece of memory, and we will _never_ free anything through that
> pointer" memory ownership rule.  We were borrowing from a separate
> variable sm_name_to_free, and we may free it when add_data is
> getting destroyed, or we may be borrowing from the .sm_path string,
> which we would free it when add_data is getting destroyed.
>

Interesting, this is good, I'm going to copy this : )

Thank you,

-Jayatheerth
