Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADD3B8BA5
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293772; cv=pass; b=GttKJcGRVq5EGNVh3Uug+IbuiwbjydbXwZEla2EYpG7H3nY0PFP2Mgmjb4HlzbXhorgiiWbIqAdr7bd5+Dk2LpWc4boBVGOIvU0XD7t4dFaW3Npadzsso/7Fru4lLtk+OcwKaB2ANa8GDj+C6cEtWMEm6e6+nHbo7d5Tvs6/2o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293772; c=relaxed/simple;
	bh=Nko6jX72qoj31oeoGkvgimVQ0ch5pKxUdcz0xh9nSmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpFFXQCpkW1AvGTzDuOB0GZ8M65HtK+8OMgFZ0vOFlUsRPfm81dKlk3fe8dhlTQz6irKdu+QmPH0sRIGBMswvj9kYn+pEZYt4WLUlPJLssKCYh+lrqAk8xV+70SZRAZzbe8EmjLHbHua4BUeDKwvf0lIltRpKRwQQs/UDVYLBtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVQFWIxS; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVQFWIxS"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12713e56abdso7269520c88.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777293770; cv=none;
        d=google.com; s=arc-20240605;
        b=dBVHvsqx4vdWg7WVYYBhY4TGucjckaOLdp1VaMn1JGEuz1Q75x3gCmGNP3P3HMRMIu
         tgOVJNVdELLNA5cXqD8eXGMouq0sEIrBPolILWIFcaevKOHeMagKSPGy0GY+g2vPt9HG
         ok5xuOBIdpl7AvIHjKCoxwVJ5aknVSmri7SSPVVQo6xRfq0yHXIEunkqli/JXqArtYkP
         +PEhMzpFNRYwOUEDvRBmSBMFePb3HHTpEfV7ImD0zFRKjUiQpKXOalLXifyy0RWmz9nU
         1AUm33NJ8A9JvHSXS8SNZdgElf45yZzcu8Kvyt7BYesWfKEnGxGMGqTFD+TZ2KfLrbYY
         R9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1K+Zm2cBS6JjBqFlZq7jlIHxkXLAZNdYIThxrpsFos=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=gH13qmxesNhD1fm5vaOJzHosrlLXPZgxWzvhT/kOFl4MvOiGa8yjfNA8ZeLhAL6j2F
         nqXe0FnKmxOfdFjS0RhupkUh6fLpJ+Lq/fnGh3C3smjYAruBcd7vBWjBfidbbqWBZZwd
         pGEsu/NHY+KPf3VH0FETU5P1ht/I+ausmsYselSDoX1C38uGMoFgdwuKBs2F2cZPnk0E
         KwZU5nHxIg3hGBiqsj5bW1/4+6mt5biDKl1mG3cp++EeKvM4UgAdqtot2gOZ5UEKDZei
         zS+/9xs2QTfqUOTVyFcTZLhTttVx2a75wKneEi6PyGTudCkusqHq4CMncAFQO594nPCB
         ly5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293770; x=1777898570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1K+Zm2cBS6JjBqFlZq7jlIHxkXLAZNdYIThxrpsFos=;
        b=rVQFWIxSjhvx+9sZXof+WAud1mnaNcz7o9Zln+hX9ua3cA5truUgsuAkael8NIO/pJ
         PDjeGmdrZMtHqcPfMY2m5hKzUIhRijSKqHl4/11+wqR17SPxeA46RYxvFOcIZaK4wm6E
         2O63fTC7CDavxaZ+VEWpgFQ4K0sKacIIKPsg3+N2Ra3ZpKqbfRHrUGtXJZzWyk+JRL6O
         hYZmhRgy0SoYwv0C2b+jwhwOJqGckVbmUao3BTnN8+xcyWvQ7sthyYjfeqfL+vBORwUj
         rJ+Jx3JpqjUccRpc5xLNYjJP+Gs4ueq/wsNpnF0axBnItLLn8OCIxIyNzg8BGMYO6Eoh
         oLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293770; x=1777898570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1K+Zm2cBS6JjBqFlZq7jlIHxkXLAZNdYIThxrpsFos=;
        b=gi4HA8UmtRzys2xt/vhVHJFWcbLk7b6CnanSTinemdscl+6DSmoIZM1GmJQQ+A7crv
         K03YMe93OHThXbeqmcDlyb3h6YcdE3PiH2qTsgxW94uisPSRtowXG8teZUD174rs3cPs
         X/vasp/GHKvLZcgh/QWnUBI2/Na9ELcFE/NNEHEVxI09QXxN+RC1kX+cu0VGg0EspRig
         Pb8AX52ROqZX3T/Xh6MOumZmrvuwiGhPbxpEW4i+JeZulBUyQ6CbQRHKXWIffVrwyQc3
         1LoLkYp49Ec9YrVqCUcFpr1jE7L0W3Oebq7ZfZs/gMUnTHHM3fdM0Zo9zzsDPuudLD+a
         IRCg==
X-Gm-Message-State: AOJu0YzZHc53HQ+ugi/J7RyGr+cVYdCFFKpBCh37pg9VdVNMDkRLubjH
	ioG5pYIxWS9dKg2T7/yO5t11/lVrkNsKEUnloda67ync1WmRqmpyvTyg4j0Vm8WadulNf9Ezu3j
	YmiitrgUydxi+98Eo0IKRQIkqVHEJS6s=
X-Gm-Gg: AeBDieuN9ItDav2VVOnZQlf1VGVUCrRDVpJBk7hJSuvtba3U61QWMfvaZ6N7DCCJTFF
	mgVzLvxTrg5WqIBUzS9aVl8yRhdp9EJdX6hqpA/KM39DRjsOOmtpn9Q1zRDHfCmErKOV+OXW/ER
	p6XdCWgU8bwIHAqGfrGKXB9mFaXZHhqMU3tE9oSz5gP+c980/+kogWEc+IVUxVjWPsU8AHZBmYv
	wC+yacKG8sqGsqGipnvNmzqlxwLAJzFTl9sljEPKr3ZhVCjiU9Rcr4cq6ksvyAPKJJUxWvuw3RM
	2UR41E/jQodmb08wsSbkuqq+4PDt4yplvd384ae2MsnjU+f7KR2ZvZlGfxlEsRhPvwaXG3lBEAg
	Fv3g=
X-Received: by 2002:a05:7022:eacf:b0:12a:6d05:3941 with SMTP id
 a92af1059eb24-12c73ae94cdmr18456251c88.2.1777293769986; Mon, 27 Apr 2026
 05:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-10-christian.couder@gmail.com> <acUkuD6iuq6nTeHn@pks.im>
In-Reply-To: <acUkuD6iuq6nTeHn@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Apr 2026 14:42:38 +0200
X-Gm-Features: AVHnY4LOCFE0JSkFiM-vgQIgb4kDrXIUxNXoGQ0KgN4Ya4Eb2Cv3o2keRmOcuGQ
Message-ID: <CAP8UFD0BMWJZx95pQFsj5aDgGLEq+R4OuaxB2Hcv3ZNwAw7QpA@mail.gmail.com>
Subject: Re: [PATCH 09/16] promisor-remote: add 'local_name' to 'struct promisor_info'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:12AM +0100, Christian Couder wrote:
> > In a following commit, we will store promisor remote information under
> > a remote name different than the one the server advertised.
> >
> > To prepare for this change, let's add a new 'char* local_name' member
>
> Micronit: s/char* local_name/char *local_name/

Fixed in the v2 I just sent.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index bdfc5e7608..da347fa2dc 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -434,15 +434,19 @@ static struct string_list *fields_stored(void)
> >
> >  /*
> >   * Struct for promisor remotes involved in the "promisor-remote"
> > - * protocol capability.
> > + * protocol capability:
> >   *
> > - * Except for "name", each <member> in this struct and its <value>
> > - * should correspond (either on the client side or on the server side)
> > - * to a "remote.<name>.<member>" config variable set to <value> where
> > - * "<name>" is a promisor remote name.
> > + * - "name" is the name the server advertised.
> > + * - "local_name" is the name we use locally (may be auto-generated).
> > + *
> > + * Except for "name" and "local_name", each <member> in this struct
> > + * and its <value> should correspond (either on the client side or on
> > + * the server side) to a "remote.<name>.<member>" config variable set
> > + * to <value> where "<name>" is a promisor remote name.
> >   */
> >  struct promisor_info {
> >       const char *name;
> > +     const char *local_name;
> >       const char *url;
> >       const char *filter;
> >       const char *token;
>
> I think it would be easier to follow if the struct-level comment applied
> to the general description of the struct, and individual members would
> then have their own comments describing their intent.

Right, the diff looks like the following in the v2:

@@ -434,13 +434,14 @@ static struct string_list *fields_stored(void)
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
  *
- * Except for "name", each <member> in this struct and its <value>
- * should correspond (either on the client side or on the server side)
- * to a "remote.<name>.<member>" config variable set to <value> where
- * "<name>" is a promisor remote name.
+ * Except for "name" and "local_name", each <member> in this struct
+ * and its <value> should correspond (either on the client side or on
+ * the server side) to a "remote.<name>.<member>" config variable set
+ * to <value> where "<name>" is a promisor remote name.
  */
 struct promisor_info {
-       const char *name;
+       const char *name;       /* name the server advertised */
+       const char *local_name; /* name used locally (may be auto-generated=
) */
        const char *url;
        const char *filter;
        const char *token;

Thanks.
