Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795589352;
	b=5KXtzB2RaAgdFrevfM7pQtUDz2El4ZNWVV4CGQs3mw8t31PjxTFTb7cYuPUfXrlKodxx
	 up+mC+dThdSeDAPrrLNLhHM1BDSuFM/2WImFvmnfbSl19vh1xBt68IVZ2ItxtVLjrUt8k
	 nL6Hu5rTk/4cgbV9YGYPWKGCiIqvauYsC2mp+jl7Ij0mPuHkyfgExguUbY/rf9kCPm3bb
	 jMZBtzfNjiJZeOxZB4cySzMUs9S/AiJUZIbkBaQTJYUbB6dKHK4VoMHCgb8wQXmZMZ69q
	 Hyznd3Rv9tnCMU+/s1hudDCKvlndmkHsSx/i5bIBNQVOrIgNc6lBI9K7hc1MB7LqARg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NlPLgoCOAZ/qHhdbh96C0mjQJ7XmsBhHSaHI9EWpdYI=;
	b=aBeOgUopHKmKBFmUQDYvtb9kHXaEb95G684rHXIwcK4qmNdfkCXiky8uZHGWWPTUWdq2
	 Zjy2WnyAMmk040Ml5AVLWCpoaOBNm/u5jQm8t41IlD9sM49Ls6equqHgZaZ6ExoNh1Ts+
	 +Q+rzqRi/dV/ZVAgu0r07XZN3O4ddX0n6xzBhitLWGG2RbS4KCulCT33OB2Ll21HF0sY6
	 hmVG/S3TQxnC/UUn8Xm1RqU8ThRr8WlQ4AGMkjwIQAz6+YJLkc9+g/S6CYL1MoSC4HLWI
	 x4l7PrethNvtRO6b+y3fMKCaxHzYmH8fknHbP3n06J5Qy2Epq9wcQu4Pg48EhlA21eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsdTtlfW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C24606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsdTtlfW
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db0791748so6181514d50.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795589351; cv=none;
        d=google.com; s=arc-20260327;
        b=rHQXC+QNJJdJ+hgqI2JpLTKplTIDl9fkI6C0XSLQPCIDOj2DvhBwr++qvIbY0FAtJu
         lvtogmDLxR4KXavhKtKbk3C6wskyTH1awITCd44yX9JMkLrZ4pEZDxZQgWBI10v/cUzH
         aVVrkrfPraJCIxUJY1l96lwEJfM4i4gTZaYNzLpyE1V8JUGISiBl4/LuLnm+3nPrvYFn
         s1n9qXacIJA+zIZoVlGRFc/7mlN6UdAInoN/q4n3VfC7GCSpcDUtoEQGyeqVrXqPQ8cl
         cxl0YxtonZcfC4d5lMHzHEEcBEJuS6x68vLcEWihYyk8rjpvbhZqRb6XvKxmnwfAXq5H
         ai0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlPLgoCOAZ/qHhdbh96C0mjQJ7XmsBhHSaHI9EWpdYI=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=cT5/fzBiaExpZJSQkzxUNBB/s9zaT3/0Cf+CbwPuu1/ec+Mn0b0bU5Qq+E8H4S0KSr
         9HNovKs95OvVzsV4+KdyadvsMwpkfjNVBDnpA8HkqAENoltUUCQ66fdjtlw2MtASHMyW
         hBFHwABIrYCGnMJaaTJh0zPwwpkCXL0OeEdsDSadkmXKcHU+9ryveKjngjgf5zyb32ej
         9qraGdDHtEEkLnF2X9VYLWD7ecixPu5NWjCigQew87y7MhlgXZsxILpHNNNzNYbzRoeB
         xaZ3Fjad9xqC/9bflJcfDuGSnZZVUeR4y+caxVhfRBBe6uMkE2q6kLmrM2hX5lwOsiDt
         FvXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795589351; x=1796194151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlPLgoCOAZ/qHhdbh96C0mjQJ7XmsBhHSaHI9EWpdYI=;
        b=tsdTtlfWWjEx4x1ygSrkByhIYf6PUxrADUeWuAjAABQyYfC9agr7oPJr7z+Uic16jw
         SpG/r8U2Q++Glz/gWg4xLMSfmNMjQIgPsSh0+nohSaO7bAnXluJaoi6N9NY/QaGRl2Gr
         ll+O8iLIKplRJZsO37pm16nvS4FqKhIDGfYWbkcQdJXZe/JDUX+wlZ5kELLPrJILNvD4
         nugv2O/DE2KHAVK7iXkH0emX9SKyPtRRP75JrEIRphsN/gzLlwtjUEoOmK28mO1QXR2+
         Gtk4rxqq4uFw3LbvFm3uR596mZ1kAxsWC5tWOVn8A23s+QAJcoQYMqllJpRoDzXPntLy
         ZkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589351; x=1796194151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlPLgoCOAZ/qHhdbh96C0mjQJ7XmsBhHSaHI9EWpdYI=;
        b=AWKbrKr8+MJZR9clIiqcbSuADN3L859mZtwApeqz61WZ4Swm55u64EDbZ//KSkMhEz
         Jh//uApO8mU/bODfdVAaU/IAykHJaC/rnRxoEZrMX5aO4b1NYMpwyNpNRUTzpK0o4hjy
         1LBRviVK//GEIXFPBABYzeRiJmJ1y5HVbfJWwLh4+F3eY67Na2VUZbukpYGu9gT+PtJ4
         BU/fr0GJ2ksLMBSr1CR9bRuMb+mr0iMIzcl0aTb5AOn3H7iRvYxNq9hu3oWvxi7Im6AW
         QMjKyvBmXv9W3k4HLeCEYZIh3tmKufdwL0/3LOKsc71H0eeF9M+9+RLKWHjiOdEdAFEg
         CDDA==
X-Gm-Message-State: APuU4Z8VljkhJODxUzxEBySlAoF7nF3wS++u9q38TsvatfQGOoNr0GH/
	kHq9FFQJTT+wN1NakH7MqEp7iI5d577ubM6y3snyWCLSxn9K3pBzaH9qUFEF6auL1YLDFVKGx4C
	rFEbAOAvFEz1Cq9i06H/Sbjy3neXT0Yw4rIvNeuk=
X-Gm-Gg: AZFdTZfGcB/w0mCPY8sdC9WAU+4acYTY8grCclEXAa/K+xxnLhBo1IFJpV3QkgzysTK
	OGCbgdarYVcl6qSFNkXj+hw4izhu9hcW6XS8zONiIzHGkEwgC1Y4Opwqg3ij9WhBI6QvoTdO8wf
	HOLpI3lgDxQqfcEiRIcFBqusXsoC1CNEpi2Tc/v72gWkzTIKr3he0Cla2lSEdwthUJ3PbOR2Nas
	2TtqERyZUiY1cbW/1SXF6PaXn71971eGPmmecev7EB8u1pDkR5WupJjV2R5qOT4KH5NY0YzjFS8
	JvIhXBeUkej4QJjfqkN8brFX6G0KPEzYEOO4Pi2vVM57OAvsFt715FBK4wERhIWG0LlQpzmNBpi
	qg2DW5AqtrbUHyNBQj2FEoObcoAmPEIeSiXXtEcQJIrWpdkd2+HPik778WXA1/pkzvliwZjlPuT
	EuEsTYS+YL5Db1Qua9orcPzfl+NMvMSW7MpkN6O2AByB7YrKC8tvzg52XQ5LdNq7mh4LdrVA7WD
	HorKOkmMd2HVp7a0pQM1wwsPg5G7zNbghi+xoBv
X-Received: by 2002:a05:690e:128b:b0:67d:b274:39de with SMTP id
 956f58d0204a3-67df44251b5mr6470057d50.65.1795589351060; Tue, 24 Nov 2026
 22:49:11 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-4-okhuomonajayi54@gmail.com>
 <xmqqy0ahg28l.fsf@gitster.g>
In-Reply-To: <xmqqy0ahg28l.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 07:48:59 +0100
X-Gm-Features: Aa3M54qm2f3w3ioDV2Ec-lP0lou5vI60mQIGcPXTwOVvmQp5YBR_TZ7cmlK4qdw
Message-ID: <CAFpMFfBwDU+iwxSsZPDK0L23moJQEfhD-zDqXWoaCbn+WQFctg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] notes: use the tree's repository when writing and pruning
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> Unlike prune_notes() and write_notes_tree(), copy_notes() does not like
> to be fed a NULL as 't' and use the default_notes_tree as a stand-in.
> [...] Dereferencing t->repo->hash_algo here would probably be wrong in
> such a case. Instead, this function probably want the same
> if (!t)
> t =3D &default_notes_tree();
> assert(t->initialized);
> dance as the others have.

You're right. copy_note() reaches t->repo->hash_algo without ever
substituting the default tree, so a NULL 't' would crash where it
didn't before. I'll add the

if (!t)
t =3D &default_notes_tree;
assert(t->initialized);

dance at the top of copy_note() in v5, matching remove_note() and the
others.

And thank you for the thorough read through the whole series. The
reviews have been genuinely helpful, and I'll roll all of this into v5.

Okhuomon

On Wed, Nov 25, 2026 at 1:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > write_notes_tree() writes the notes tree into the_repository,
> > and prune_notes() looks for missing objects there too. Both
> > already have the notes tree.
> >
> > Write through t->repo. tree_write_stack_finish_subtree() takes
> > the repository, passed down from the tree. prune_notes() hands
> > the repository to its callback in a small struct.
> >
> > copy_note() also writes through the tree, by calling add_note(),
> > so it uses the tree's hash algorithm for its null object ID.
> >
> > Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> > ---
> > ...
> > @@ -1368,7 +1379,8 @@ int copy_note(struct notes_tree *t,
> >       if (note)
> >               return add_note(t, to_obj, note, combine_notes);
> >       else if (existing_note)
> > -             return add_note(t, to_obj, null_oid(the_hash_algo), combi=
ne_notes);
> > +             return add_note(t, to_obj, null_oid(t->repo->hash_algo),
> > +                             combine_notes);
> >
> >       return 0;
> >  }
>
> Unlike prune_notes() and write_notes_tree(), copy_notes() does not like
> to be fed a NULL as 't' and use the default_notes_tree as a stand-in.
> The function begins with a call to get_note()
>
>         const struct object_id *note =3D get_note(t, from_obj);
>         const struct object_id *existing_note =3D get_note(t, to_obj);
>
> so they can give you note and existing_note back to you safely, but t
> copy_note() has may still be NULL, if the caller gave it a NULL.
> Dereferencing t->repo->hash_algo here would probably be wrong in such a
> case.  Instead, this function probably want the same
>
>         if (!t)
>                 t =3D &default_notes_tree();
>         assert(t->initialized);
>
> dance as the others have.
>
> Together with the earlier review on [2/5], if we were keeping
> default_notes_tree support, we probably would want to tighten
> how t=3D=3DNULL is handled by each function on the call graph before
> moving forward, I am afraid.
