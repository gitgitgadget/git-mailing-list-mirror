Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFE4A06
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754099; cv=none; b=Gqfp0iSxbsTOEXmry7vHLPiUc1pLUL3pV5wAbGX6IwXhFojqbgTbyq0Gn7bwUarFdZ5cEALt9vwnDZA+QiH6iXTV8wUGC2b15gzRxEkRpZ5lww1y86N3FqTgYsWa+gok2ScNCqxTCaiWoI7oWJJMQ75ndja1TNUrHyztHKmiM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754099; c=relaxed/simple;
	bh=XmAJi/sf5WsVNGRBErfMsgtshWxxiNZIR01ovpMVpQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTUdnHV5hV2xH8aRm/PLfZUBmxdg+tlEgNJMfvxOG/ASUbJjc2drULhRsNHkWmdPU0OIDOqQ/tf5NQr1eJimEpGrsWrkG96YUnzsqA/JjjJ+5CIDh7r3/hgKApYYavLQ3qERp7ehfLetsbKZkam56WSrw+i0miMoq8Ed+t/0YfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPyufnKv; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPyufnKv"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d0920ce388so2006738fac.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747754097; x=1748358897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsYfxKk1KElEYDjBY5c9ai7vzyA01LbLJ6K9YP5klLw=;
        b=PPyufnKv0cGnA5gMjwHS6F02YphAdc/PAxbdtVUljK2DMP5nBHbOnMDxqreLa0n+B7
         0BOukORtO2H/TzkcyUiRQFV2hnEYZ7SJFeUfEBd6MojI1f7/VMspjoUpT9Njsp9lmXqK
         ju7NK69Xl5HpzYptSXT7V1hn3jkDJdriAAOw0CdEpflkHF/6sNq4lwLz5EH0vi0rrmOT
         2XIBs2VJTx0zKUc4pSknjiz4L1I9un5R6/7J/Du/2W6HHCwFkVjXiq7g71JO4sIoshtZ
         JYT4IJ4w3dzl8W9BrRLjesM/GGMER0oI+ee/OBpVa79eQqdnQu+wPrbx0yFzIlJH1hoA
         nWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754097; x=1748358897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsYfxKk1KElEYDjBY5c9ai7vzyA01LbLJ6K9YP5klLw=;
        b=K2os65mLEhacB1uXGI+rfaFv4DF8Prcf5ouhqGxod3UMx+bblO1aVQ4vnuUOPP7FFu
         xCcQd1Q2Im9tAUDgzSq0O6NlNiUlsrGomlFo4dJ5eDQmREm5UqHgeIka32nCxmw/cHXq
         ItPff/0u1iDUjURXiSRi96ECs89uVkbmtzY82WyDq8dC1Vz44DmD0upmSMdafZAVaWGP
         PL/zX73NAlARf3tyDbQ7VtrP3LcVQ0he27A2yzyAOZr+bE4sUxLo9DwRQx9MnY+PlVG3
         am/NGRuVmxqAuGG6EMA0gQVEEZDjL68gZ5tG75I6tWl/YtdFFtcNULF1TVqNPGW18+mT
         RKog==
X-Gm-Message-State: AOJu0YxdZozASqL9VMC2skzGQg19/n8Kz7e9O6SFz8/+quRL5wGopjEB
	VwH32i/MylZSB1gRnWi9B439/D5UrjeHalRBAX2s7cCgGs9lHmSC9K33
X-Gm-Gg: ASbGncu2jsLDUKPB7z6QOtSg8EURuCqg2fMJKFGWMNkar7okqTCzfH/Vs2RbKHPzi1O
	mnYvoRVLZECuBfNAMYjPUTNB6Fx2kv6aspBbBPlaac7Oe+bX9WxhkqK2RA5yuOFOXGYF7zJEMgW
	JHbKMulEF05ktLGvFjjOloiLtgONvKBoIt+GzwHJNl+qr/lscvWBKa1iUOB6dhEWeVTpFSV42+W
	DypfSMlPWtpAWfyia3FttjJkk7PyYRpTFEzvW8cKFQfs2Uz+Hf7j/9PtAnYFqxqwbhvNZr7Bk7N
	wHsuy3JWZoJePWZmkuJP6geqSa4pS1zykT+MVuxcO7PP
X-Google-Smtp-Source: AGHT+IEaYb4gk/3iQKPkehMZACs3UHLXw6ev8ej5Bq7KyZ5FF1kD4Clb4HlmbSyzdGNyqdRxbyMNJg==
X-Received: by 2002:a05:6870:1b88:b0:2d4:ce45:6989 with SMTP id 586e51a60fabf-2e3c1b674a7mr9744675fac.3.1747754096698;
        Tue, 20 May 2025 08:14:56 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c060e1d8sm2234115fac.4.2025.05.20.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:14:56 -0700 (PDT)
Date: Tue, 20 May 2025 10:10:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <vgqluphl4wdyzlkyoxndm2kspeylpeqhdi2chusytowjhvvqie@ya3yqorppdo6>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250520014920.201736-1-jltobler@gmail.com>
 <20250520014920.201736-3-jltobler@gmail.com>
 <aCwQU-SwlS8MR88l@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCwQU-SwlS8MR88l@pks.im>

On 25/05/20 07:17AM, Patrick Steinhardt wrote:
> On Mon, May 19, 2025 at 08:49:20PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
> > index 20aca92073..68427d93d9 100644
> > --- a/Documentation/git-receive-pack.adoc
> > +++ b/Documentation/git-receive-pack.adoc
> > @@ -46,6 +46,18 @@ OPTIONS
> >  	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
> >  	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
> >  
> > +--skip-connectivity-check::
> > +	Bypasses the connectivity checks performed to validate incoming
> > +	objects. This option exists for server operators that may want to
> > +	implement their own object connectivity check outside of Git. This is
> > +	useful in such cases where the server-side knows additional information
> > +	about how Git is being used and thus can rely on guarantees to more
> > +	efficiently compute object connectivity that Git itself cannot make.
> > +	Usage of this option without a separate mechanism to validate and
> > +	ensure incoming objects connect properly to the references risks a
> > +	repository becoming corrupted and should not be used in the general
> > +	case.
> 
> Nit: the connectivity check doesn't only have to verify that objects
> connect to existing refs, but also that all objects part of the
> transitive closure of reachable objects exist. Might be worthwhile to
> point out here.

That's a good point, I'll teak the wording here so something like this:

	Bypasses the connectivity checks that validate the existence of all
	objects in the transitive closure of reachable objects. This option is
	intended for server operators that want to implement their own object
	connectivity validation outside of Git. This is useful in such cases
	where the server-side knows additional information about how Git is
	being used and thus can rely on certain guarantees to more efficiently
	compute object connectivity that Git itself cannot make. Usage of this
	option without a reliable external mechanism to ensure full reachable
	object connectivity risks corrupting the repository and should not be
	used in the general case.

> > +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
> 
> And we do have the object now. Do we maybe also want to have a check
> though that the repository itself _isn't_ fully connected to ensure that
> the test setup isn't broken?

That makes sense. I'll do something like this in the next version:

diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 10c67c2bf8..f76a22943e 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -80,7 +80,8 @@ test_expect_success 'receive-pack missing objects bypasses connectivity check' '
 
 	test_grep ! "missing necessary objects" actual &&
 	test_must_be_empty err &&
-	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
+	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
 '
 
 test_done

Thanks for the review!

-Justin
