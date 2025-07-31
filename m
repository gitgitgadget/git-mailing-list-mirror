Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA529AAFD
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946584; cv=none; b=nejSmv6kU4/jphTnYvzfNw9jdWP+4N/Cd8sGc/DGDW3q4nVJZRI+AJrAyb81BKFw35qFf9DSXlWi2vocXZ1pEWLYlF/CTtB3SGgmerl+0mBKQNo7fbUn2/FRL/R9MGzSmdoZN+3LcVkwdlIDcX1yuCnVGRcV3I4fq5Y1m2FKduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946584; c=relaxed/simple;
	bh=3MkktxBFF6oXFaGoR8p3YN3YwPkmB6iMDMaWBr6YJCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwOzx8AasxMzKuGj2DK3yPuNzIRxWtTd9dqLXbE2/FCop5+t2Ii8wvpDnmehFUdoXXxNRWNq3Vdd6/g69ZcnxatNGS+tCwfSNs3VcOVZx/OZZsWe0eQXuFRMHeqgBodNSPehQoydfvTcjKA4nduLHP5h9gu8nnrCZJkMV1Jqh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGcTPcod; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGcTPcod"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so96216a12.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946581; x=1754551381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLiG+glWMn95Fj6ksqAxDbw9sb6xaGeQS3ZKEDzrGjs=;
        b=lGcTPcodgmEAGI63fwWOMxpVHCVxXFY+R6d3P1RhpbGPJtO31nk7f9pniNNyxQwX9Y
         z+WVnNff0YxMJSL3hj9yPxqSq9c7FWAjohCd4H8+khYrAVXO6ti0mXpNfEe+HchnBksV
         hAEGQXmsTBQ9epeZbd+KMumgT2JRMaxOUjSfL7CRM+sYvb5BTjLqCNkzghrQTSjmP5Kr
         93UpSIHjiN2DXb0ch7Jk68kHEi/acu8rIf5iRqgG6JRzLiPy6rqtiklMeYzxW7nWMXbm
         mVc37QH5nCL9f512nCk1LKS1Fjs0OFsoH7bJabUQ5IvsKrYR8I9s4i8r4OT11enExfao
         xKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946581; x=1754551381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLiG+glWMn95Fj6ksqAxDbw9sb6xaGeQS3ZKEDzrGjs=;
        b=cx40qDXgnFIg3TB4zCdKso+8mhS8RLg6Ekf+zWVELxJbHbxBaPVP3mt7bQe3bFXgn3
         enuSZ6Cg8rZIXZrHJwrKruRq8zz12Y2oweSwSBu5SU/Zev69uyUA8hDVwwOs9qk41WVM
         /ootAtcAGUXeVDaw3X06mbKkVoCk84VIO5YXjTAk8TYv5OCvkEn6691IK4cZsq8p8Y8Y
         xopdTZ23fGzgcha+CC0pRkl+29zSRrB44w8ZOk5AxgWq8VoE1sZM+Xt3JcCNDRorHyuI
         J8mwfTTPNk3dhYSM1Zuw/IfdIDJcdujmQxteVcSjgSa51AD5Kygn8M7ISbn+IxK7gWL6
         zocw==
X-Gm-Message-State: AOJu0Yyqtcr/1Gd9rXX53/TQcWVirxzJ9IkynA6b5Ksj1gZatFTjT4/5
	TZMibTfMu0/JJ2SRCdPrZ+GReSYiyiUkR0qV5TaARVc7w/XI5EauNRjzWXT69RFEoCu4s4AiZMu
	TkP172wD2dJqEcnoDnsbHFINfOUrk1llqyA==
X-Gm-Gg: ASbGnctKzERAJCPc9nrsRIDuSmoh9bDM1TKsDi2c5waP3tgaQemDrXgbgeYDa4uPwbc
	25qP2UMQcHByNkhwzgp1UMblboN67kbN4BTDp/9EZnfXaBxjky4JPsFQz9uPUaO9MYi0zbCKuCT
	c/DkZ9mtFdq8kX3N581gaaWAZBRZDuXrPE8e6K+aO9sjtia2q9B9ZjsaYYXbjdluEejTl/s80fk
	jBV2RQnfw==
X-Google-Smtp-Source: AGHT+IG3WnTAGihh2xwaoaO7AyQla81g/IV/sUvtpCacP+W4Fbfz35UgdZ8+yJSDbm75pb60NnETxXoZmpgYudtn7QI=
X-Received: by 2002:a17:907:1c95:b0:ae2:9291:9226 with SMTP id
 a640c23a62f3a-af8fda80bdemr767747166b.59.1753946580688; Thu, 31 Jul 2025
 00:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com> <20250721141056.2283349-4-christian.couder@gmail.com>
 <xmqq1pq9xoqe.fsf@gitster.g>
In-Reply-To: <xmqq1pq9xoqe.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 09:22:47 +0200
X-Gm-Features: Ac12FXym3JFpy7TUYOhvAHcK78LHtfkQ3kofw6E3haFCawdpFRa3qZ6dkAoLNL4
Message-ID: <CAP8UFD0urQ_0dbHjyF16w9HeTVxwo_r3Yi62hbwcC49m=aPZHw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] promisor-remote: refactor how we parse advertised fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Jean-Noel Avila <jn.avila@free.fr>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +static struct promisor_info *parse_one_advertised_remote(struct strbuf=
 *remote_info)
> > +{
> > +     struct promisor_info *info =3D xcalloc(1, sizeof(*info));
> > +     struct strbuf **elems =3D strbuf_split(remote_info, ',');
>
> Unless the primary use of an array is about passing it around as a
> whole "set", name such a variable singular, so that element[4] can
> be naturally read as "fourth element"---"fourth elements" is not as
> natural.
>
> Also, can't we do this without strbuf_split(), which is a wrong API
> to use in general [*]?  strbuf is a very good data structure to work
> with when editing string data, but an array of strbuf is not---you
> would not be editing many pieces of string data in parallel.
>
>     [*] often string_list_split_in_place() is a better alternative,
>     especially when you do not have to heavily edit the substrings.

Yeah, string_list_split_in_place() is used in v7 and it looks better.

> > +     for (size_t i =3D 0; elems[i]; i++) {
> > +             char *elem =3D elems[i]->buf;
> > +             char *value;
> > +             char *p =3D strchr(elem, '=3D');
>
>         The pointer elem points at the name, and the pointer p
>         points at the beginning of value, which could contain '=3D'.
>
> > +             strbuf_strip_suffix(elems[i], ",");
>
> This does not even count as "editing"; split_in_place() would have
> removed the trailing comma (and replaced it with NUL to terminate
> the string).

Yeah, right. This is fixed in v7.

> > +             if (!p) {
> > +                     warning(_("invalid element '%s' from remote info"=
), elem);
> > +                     continue;
> > +             }
>
>         elem pointed at "foo" or "foo,"; we may have stripped the
>         trailing comma, but we didn't see the equal sign to start
>         the value at all.  Bad input.
>
> > +             *p =3D '\0';
>
>         Terminate the name by replacing '=3D' with NUL.
>
> > +             value =3D url_percent_decode(p + 1);
>
>         Can this helper function fail and signal that it saw a
>         malformed data?  If not already, shouldn't it be taught to
>         do so?
>
> We are inventing the syntax for this data in this series, so if this
> helper takes garbage data silently, and if we are not willing to fix
> it, then we can even consider changing the syntax to something with
> a helper we can use that already has a good error checking.

I am not sure what the interface would look like. Should a version of
url_percent_decode() that returns NULL in case of error would be
enough, or should it use `return error("...");`in case of error?

And it seems to me that an error can only happen when the string
passed to url_percent_decode() contains a '%' which is not followed by
2 hexadecimal characters, or do you see other possible errors?

For now I haven't changed this in v7, but I am open to suggestions
about the best way to implement it in a v8 or maybe a separate series.

> > +             if (!strcmp(elem, "name"))
> > +                     info->name =3D value;
> > +             else if (!strcmp(elem, "url"))
> > +                     info->url =3D value;
> > +             else
> > +                     free(value);
>
> As url_percent_decode() always allocate a new copy of string even
> when there is nothing to decode, value will always be an allocated
> string, and if we are not storing it away, it will leak.  The copies
> we kept in info->{name,url} are ours to own.  Makes sense.
>
> > +     strbuf_list_free(elems);
>
> And because [elem..p] (name) we only peeked, we can safely release
> the whole thing.  If you used string_list_split_in_place(), you
> would only free the string_list shell without having to free the
> underlying string.

Yeah, it's better with string_list_split_in_place().

Thanks.
