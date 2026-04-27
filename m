Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87138313537
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293899; cv=pass; b=ngYVX5Cmkwhj4bdDntfaGTjPNpoUTNJdi+1yXjsiyNSbi1kbhUDfWk8DJ9Mrwm2bnkoCIvJtit+65v1xtWXbbcsh20kTf9vHwJ7KoAoSkvaPTm8e0aAIKz8E+isp6u/BZJ7KH1vK+AIhO+mAP3Ha2WptatdNIeh18dAiEiBKA6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293899; c=relaxed/simple;
	bh=We6fJ1QOgzrOuNTXrcbuXnMQURPuT+EPQ92UCJgJXS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwxg67jSsJi3V6t5s4333CRZc7pgOJJExnYnH+XhYbChASqsf2+ox2KMU/klqvL/V07UUmoiPzMWc6vZc9D3Uwj6XHal0Nrhw54bE8D9K0gdyBR2NEkUguKLY6J1x7BWbDk7IUAwb4oWRqkuCpL3ci1oASOdDL6WhB9+sNu00RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km0m6lQB; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km0m6lQB"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c8ccc7755so10128531c88.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293898; cv=none;
        d=google.com; s=arc-20240605;
        b=a51m6/AZoAVsqHT6O/+1fOAVHTom+yOCDS/w56v77+iKKsnigVtHXBxTpxkfoIVcLa
         iJG5uDri7aDg1chFK/bma9voeM7dxV4xGdX9MZ4IyvVpCSpwRfUcIG8i+0lrmN+hj5AQ
         ker3Q1UAxY3GGnlmSU7HstEupZnCrLV666aOD9248mRC0MalFjdfb0ulW4rR9WIMdGeU
         Ik7BXllXu/HnzdxqULfPfIToqUNOBjQuXWDhNP8DEqDHnmucrG8HoKVh62sz/J9ZeBEn
         5dPL56abhaxpVz3fU9qwK3vabhHug7RKIjwRr91y3L0XHoPzZHcZEJl16DAZ+sOifFMQ
         mV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AIWKrwoKgAO6c3EtrfkkUskII16ZraY7XoEpf+d1E5A=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=jzpywTvXGyWATatxJq6UWjg2cwVTV1fdlguzHqfGFJhBLYmAsYG92XY1QomntfkJZL
         ncAAmxWaF+xZMFzGddaYMRVL5TH8Zx2J9Tj1r/uPhyD2HeuvlxXTcbd8F0aucdjqlXbD
         uqd3vQfSOtc1J7QyweWVsNcUy143Cdrjy42vV+2uaJLBgz75/HpFi+KHAaHU6LxMhUrK
         NGjXDlTAJ1AcUMFAY2fSsVdt1naxwAKUpniykFcCke9mFz+FW8cm6GsfDaLJONEn11An
         2lcMHntyvXGBuGpOXT/wXQxGdmcx2H0vYlb+X2F7A6QKovpTykHDiHVGvmEUDrZtG6dX
         ReGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293898; x=1777898698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIWKrwoKgAO6c3EtrfkkUskII16ZraY7XoEpf+d1E5A=;
        b=km0m6lQBzSnv3o2GeO3Gtp5u63FE1KLzmXAtqHqFHpjCeUOiP+sGRBzMCZNaSfEARp
         qaEYjMnqhHewekVNlywvOyuNDwZGtj+GWkus1d0wSHXs9zXoV7DPSLGkl60QvciSyuBH
         cznvXtY+DR36VAalWiCD8IhXY/97qRkv/vzIUNRdmwCY77ejerHz0iT2Z7r8xc9bDReh
         aiaOcoEcG0t+oSES36QjivZ3kz5hW/jKOhUAqZ4ykiwzykMaaHJ89UqNyRxQ8kUDJUem
         bson67a8UMcLD0SkFUtv4tkRjyfvZXKWSLupjObk67cTb/JIwE2HQHxuwiWYwsgAFjNs
         OZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293898; x=1777898698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIWKrwoKgAO6c3EtrfkkUskII16ZraY7XoEpf+d1E5A=;
        b=rqpljqVB03jdIv22wg+n5yf3xYF//vnDuSpfThqIhNsTWGGvnzOBaMR6VJjZzDlBsx
         7yu+MzwE6RpQI8stVhygehZZewiSEgyUTAxHw/zkOl93mEwJy5Tkn+vEWi5IeOfCce49
         RVaUBDyiZ93mVFZms8MQMmoIKsEyqhWMy9OispiyPFVa0m6+KudJr2eHpeWdyEAjDKXx
         Q7HYBki4/tI2qjTFlNZzx/3N0u9a31ewQiaPKLqXV1dXFfpQVNMtOAzHHkJIIywhgk+1
         iBHrLSyJVQlXd15VxZNhUMNQ6Fa8MpDzGhDn2pgcNaUg0TqjKIPYg4RLMoQzIic1bVlv
         XGTQ==
X-Gm-Message-State: AOJu0Yz9fg5m0osZ3meTSFaviYjYsfrbNvavvB17yaD+cGsacEp86Z+W
	vGxi33zbRd21xTVynk6YZ/8EelbD1Gg9JGnKEyTE2Q0Vjj1lwMv3M0TdAcCxWPgtemGbeoLsTUq
	zOAyBpUlhkFfKDUminWMz6iugGosYDfo=
X-Gm-Gg: AeBDietIjvUOjAM7qFq0dfbmraJIhMMd0CFMpiGWFNobAzpKfteRR5SahZ1++rBZzsP
	jz9fdU5LjI2v/pjVvR4/2+s2ivIh1dPMmM115Z1NjSn6nIoGiKwKvL9XomSmL9kJ6rlj9pLyytq
	rtgOLNbtVd1MMuM0baRDXc+ttVPpcebKCMMWS0VfVhZgoVGDBrudA5K/tt4HbmW/aPIRY/pq5Fs
	aZRWE+wxl9bLQdcGvoVycpGl2plsxpxTITZswxyFs8ocrwZhq4mxHuks0ktONWo38kpeuHuFZ5j
	AOgoB3KRk8TASEpMsGb15Cid3sNmoRAtOObBiyKTm2Fwi7dYwfloinDEkgu00z0/gG27yCHPyUM
	x+eQ=
X-Received: by 2002:a05:7022:2227:b0:12d:b218:e02e with SMTP id
 a92af1059eb24-12db218e22fmr15766594c88.11.1777293897690; Mon, 27 Apr 2026
 05:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-14-christian.couder@gmail.com> <acUkzY7f5302uWD8@pks.im>
In-Reply-To: <acUkzY7f5302uWD8@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 14:44:45 +0200
X-Gm-Features: AVHnY4LMjSLJwO4lleTl1n0JC2xyLd87zEzRBAqQUE0du93bh5kLpxRSpQv3wZk
Message-ID: <CAP8UFD3AWRjgKnwdppS7=Q7WL5pO3r1T_e61ZPqm15W8aY3mxg@mail.gmail.com>
Subject: Re: [PATCH 13/16] promisor-remote: introduce promisor.acceptFromServerUrl
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:16AM +0100, Christian Couder wrote:
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index c2f0eb7223..4cb18e1a6a 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> [snip]
> > +static struct string_list *accept_from_server_url(struct repository *r=
epo)
> > +{
> > +     static struct string_list accept_urls =3D STRING_LIST_INIT_DUP;
> > +     static int initialized;
> > +     const struct string_list *config_urls;
> > +
> > +     if (initialized)
> > +             return &accept_urls;
> > +
> > +     initialized =3D 1;
> > +
> > +     if (!repo_config_get_string_multi(repo, "promisor.acceptfromserve=
rurl", &config_urls)) {
> > +             struct string_list_item *item;
> > +
> > +             for_each_string_list_item(item, config_urls) {
> > +                     struct allowed_url *allowed =3D valid_accept_url(=
item->string);
> > +                     if (allowed) {
> > +                             struct string_list_item *new;
> > +                             new =3D string_list_append(&accept_urls, =
item->string);
> > +                             new->util =3D allowed;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return &accept_urls;
> > +}
>
> I'm still not much of a fan of us getting more and more function-local
> static variables. It just feels wrong to me, and like we're accruing
> technical debt. I also doubt that the performance overhead of storing
> this on the stack with proper lifecycle management will matter at all
> given that we're in a context where we talk with a remote anyway. The
> handful of allocations really shouldn't matter in that context.

OK, I have removed the static variables and it looks like the following in =
v2:

+static void load_accept_from_server_url(struct repository *repo,
+                                       struct string_list *accept_urls)
+{
+       const struct string_list *config_urls;
+
+       if (!repo_config_get_string_multi(repo,
"promisor.acceptfromserverurl", &config_urls)) {
+               struct string_list_item *item;
+
+               for_each_string_list_item(item, config_urls) {
+                       struct allowed_url *allowed =3D
valid_accept_url(item->string);
+                       if (allowed) {
+                               struct string_list_item *new;
+                               new =3D string_list_append(accept_urls,
item->string);
+                               new->util =3D allowed;
+                       }
+               }
+       }
+}
+
 static int should_accept_remote(enum accept_promisor accept,
                                struct promisor_info *advertised,
                                struct string_list *config_info)
@@ -901,6 +986,10 @@ static void filter_promisor_remote(struct repository *=
repo,
        struct string_list_item *item;
        bool reload_config =3D false;
        enum accept_promisor accept =3D accept_from_server(repo);
+       struct string_list accept_urls =3D STRING_LIST_INIT_DUP;
+
+       /* Load and validate the acceptFromServerUrl config */
+       load_accept_from_server_url(repo, &accept_urls);


        if (accept =3D=3D ACCEPT_NONE)
                return;
