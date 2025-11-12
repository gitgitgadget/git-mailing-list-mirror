Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBE2253A1
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911072; cv=none; b=c7hp7FK6aAzhGgYmP9YpWVIZYP1Dz+ui99dgm7H7NKsIkLYaPu+556bxL3ftmmKqXsywopNM6hdQIcLcirsCP/ZI7GqlO2Jz996kg6tYTe3cW4qO+fVnn7/0WEHEE/ewwVKsCvi2IsFVe9Bv8bYUOcMbKI5RDViI5B/PDgl72DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911072; c=relaxed/simple;
	bh=QATQoSGaH6Lyt4hp0CfWUSn1h6UT2SaV0iV1Jsuihi8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Qh54YoY8TzOX4TY+OO9EAiSvlXQ9hfS3cepGyeIG7EtBV2IX0wmBy7yW1eBuKCXS5V8sQAe3iBRVQfd8ROFW/t8c5SwGU2ityEU6OTHnan83aZKKDMNbc8DFqmhvfB1aKsfzhHvzAg6LFUJnxR8p9nhI3gYGf1CawbabWS/t7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFaZKOJB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFaZKOJB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso316144d50.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 17:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762911070; x=1763515870; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDIH5p6D0YP8le+Bfw8/L88rIe6w3Q9BNh+/cOJdzzE=;
        b=EFaZKOJBKGXHMqCmffoF2CBl5O5q9Si4OQJVubQD8aSpGor+PeKaumzpCQJU0MOytj
         oC+7AhBqLv1PkwMR5EeFxdGkYT57920NjVSDTOElaXtKc+VNplcKkS7lmBnlZMukKKqK
         BmmqEPgGLMf4jUtFx4uvQOFmoKmtNDWhiZIqRXmiLITUpAQmJ0bApwoOoEhB5ef5X+VM
         2TezvF80xIeQpz7kuvNE7BqLCcJat7gE2U+1FTO3+kL49a+gbU9Z0xrar4U4xppIQ/Qh
         y9smPMRQk947obW8PRUAICd+b/7abqAz6K4VpgUADHdzx/ooN2f39f+Jvh+l8z0qbnwD
         6R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762911070; x=1763515870;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDIH5p6D0YP8le+Bfw8/L88rIe6w3Q9BNh+/cOJdzzE=;
        b=H4F1fyW+IjOHEPnTp5jrCtwG7itoH6aYTNrPFG5cuAGIRsFL6ybTw/IqG8uk1/xBee
         +Hpyprk7D0Bn9luRzLulO99TyzTsDEtq9QDsjLrLa6/kbYAOb3nXQznGmN3cQA9IFYTn
         CBjoznSwcOZszxalYCuzwfwSF3Wwv8SGOCW7Nzv/osXWLebyZpdTdx8Ds2X+QyRVWcWm
         ulPmNUhXaUcHFI/jn1zad8BX4GMYen0sJIn6ylh6zdkDIhvv/4c6Pxjb0TaTZzE7vx+C
         jzC8s7FHd/1wVRztANUP/iVOduH0R1mxq2n6eNiUA3H+vC1epAuNaNtiFeG6y0PiRT8/
         4bwA==
X-Gm-Message-State: AOJu0YyD1jXF+/yt12hAffI3qXkbJS4R24Bp0RrebtAJQUDm10ArSyGh
	MrxaEbyn0xpkcO+PQSlyHmglNsyJw7rLHxMKZXgP0ev5N3106TtNEQli96tVgA999oM=
X-Gm-Gg: ASbGnctpZ+vpMQbxLbuX45QGNBIxhNJFPDTKDLLEYlxkfQd54YgVKh6ZwS40u4diuVd
	ePn5F+YqACJGaIRb2Z8y1oHT56wCGdXRX5/rbtOe5SCWMct6lZFPH1WntKjAbHPHnvGvJVPBHsa
	LrMosm3i6vNjV6YqOvuafSoXx8c89OU+ygFrFvYD+6R25P8u+j3tzWSF2Sr/tEQauW4j38ETzeT
	8HxeEZIs7dQRQ3MoXYlY5J5OTg6RNjJHAApDJMSokyd1E1I7YoEAOg1AAWZBOWkyJ6OfS1GEFm1
	Z27Ura3Fhh/HbWHy00pf0bg05anBN6ql8sm/hQ8wUDeC5Rkqvxas3CbTzdpC8be6WtxJdAWmymW
	9l9HCjY3Gh71vVCmZwGa2zB48bYt+F2ZXbUUPE2G8+tbQAPfPHYRSYp7P/m5knQopTsl4KE6V11
	wsmyehMhQAxSQ4kgXnsSWfZ/Xm+uIYo5LQm85lAyk=
X-Google-Smtp-Source: AGHT+IH3Yp82vPym57trCp7O4ifx1G9+x+rbYkefceh52ZRiBPwetth5MMkPeWH4J38Hse1RI3yB2g==
X-Received: by 2002:a05:690e:2553:b0:63f:bdfa:639 with SMTP id 956f58d0204a3-64101a5a319mr1073084d50.30.1762911069894;
        Tue, 11 Nov 2025 17:31:09 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:747d:b1d7:7731:c9e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6809defsm37827527b3.8.2025.11.11.17.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 17:31:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Date: Tue, 11 Nov 2025 20:30:58 -0500
Message-Id: <F6B66286-64B0-47AB-A31D-50A253F001D5@gmail.com>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
In-Reply-To: <20251111223647.GA4055973@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 11 nov. 2025 =C3=A0 17:37, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFGiven a set of attribute macros like:
>=20
>   [attr]a1 a2
>   [attr]a2 a3
>   ...
>   [attr]a300000 -text
>   file a1
>=20
> expanding the attributes for "file" requires expanding "a1" to "a2",
> "a2" to "a3", and so on until hitting a non-macro expansion ("-text", in
> this case). We implement this via recursion: fill_one() calls
> macroexpand_one(), which then recurses back to fill_one(). As a result,
> very deep macro chains like the one above can run out of stack space and
> cause us to segfault.
>=20
> The required stack space is fairly small; I needed on the order of
> 200,000 entries to get a segfault on Linux. So it's unlikely anybody
> would hit this accidentally, leaving only malicious inputs. There you
> can easily construct a repo which will segfault on clone (we look at
> attributes during the checkout step, but you'd see the same trying to do
> other operations, like diff in a bare repo). It's mostly harmless, since
> anybody constructing such a repo is only preventing victims from cloning
> their evil garbage, but it could be a nuisance for hosting sites.
>=20
> One option to prevent this is to limit the depth of recursion we'll
> allow. This is conceptually easy to implement, but it raises other
> questions: what should the limit be, and do we need a configuration knob
> for it?
>=20
> The recursion here is simple enough that we can avoid those questions by
> just converting it to iteration instead. Rather than iterate over the
> states of a match_attr in fill_one(), we'll put them all in a queue, and
> the expansion of each can add to the queue rather than recursing. Note
> that this is a LIFO queue in order to keep the same depth-first order we
> did with the recursive implementation. I've avoided using the word
> "stack" in the code because the term is already heavily used to refer to
> the stack of .gitattribute files that matches the tree structure of the
> repository.


Worth catching, and I agree with your choice of in-memory iteration over tun=
able depth.

My knowledge on memory models is a bit weak and I didn=E2=80=99t check direc=
tly, but are we implicitly assuming that we are less likely to run out of he=
ap memory in such an evil case? In effect I suppose we=E2=80=99re turning a s=
tack overflow segfault into an OOM error?

That seems like a fine assumption to me (I=E2=80=99m used to languages where=
 the call stack lives more or less efficiently on the heap), just wanted to c=
heck my understanding.=20

The memory use has to go somewhere ;) presuming there=E2=80=99s no good way t=
o only keep the relevant entries in memory, since I can of course find a lar=
ge example that also uses each intermediate macro, so the code would need to=
 get a lot smarter to collapse equivalence classes, prune unused paths, etc.=
, which seems like a poor investment for what AFAICT is a little-used featur=
e*.

*I love it, and use it for custom diff drivers and the baked in hunk headers=
. But the diff definitions aren=E2=80=99t easily shareable, and I have to be=
 aware of when to turn them off, so I end up not sharing the corresponding a=
ttributes either.=
