Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D417167F
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481780; cv=none; b=Ce7AqNmzxDectETZXix30qQJyoSEPn6nWtU30b22vCpBDPjBC1bwQiyK7Xp76IDMfs/aEXRjXrVq6TRIc/mChMcZvfZ6/PTJYyXQmnPL8BEZcvjkLEVPFzDaeuI+xQ3AKXSREIvqLP8nqf4o7lEcnEDdAT0FCZbvOsiwyySO6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481780; c=relaxed/simple;
	bh=pMgpALfeOtuvT7gmE8QZpIjzYFS+XetQX+XQUYWXk8Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZcOhuG4QyEPXKbyqK77g7wBmm8Komn2kxNe9KLYmOOjQ8A8Y5APMIqm5+ulrY+Dinyri94HRwxctl9GNU+6jOkkv2HQpQoCrlotncCYsv2BhCLBarR66rL2JBQPTUc3AlXItZZewem5JsJs3mfe8C6kcZcRI012DpbNlcf8G18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjzXnb64; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjzXnb64"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23d2462c3b3so141206fac.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481778; x=1715086578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ9qnSyCMq8A8n3n/+o7TuSqKQPNNz2S4Lx0qdQyRo8=;
        b=hjzXnb64tH11nlKSmOgZrK+eJcfTQciVRJ28GN3uq1IjN4V8RrCKPoiREqiuE+Zblm
         PUgXPBDbI9mAXrHs5aYTbMTWO+Wrai432wMfcv4b+aaxhgqrJQQ+vbrV4DxKzlHK4ySW
         m/csaUszZGqPk6fV+XdyWIsRnkzjeOkevlkFO5c8HZlJGUTIwkt4+RNiKUsKMJd4s24m
         Kvwhvc8UPIYzWWv5aVwiD6KpgWlXhum6yOJuhuTsIs0Mr6/S445g93uoHUL12krkOWbC
         x+CbI8SGfIUaLU7vo3BPKVQGD3EYBnRCZ2nC3nGy/BPLBidrdSVvJGz8s3QAZXwvfwkE
         JiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481778; x=1715086578;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ9qnSyCMq8A8n3n/+o7TuSqKQPNNz2S4Lx0qdQyRo8=;
        b=bUpVDkV7H0jSyc0W3AvPtD5RspcuLO42zwo8l5HREcS+3YGDCTkrEYB4mjGSpaXkoh
         vb2w2tOsO+zq54XySDY1fqcKIep4MuAN/yl7dz2t/AQahnonR5tTr75ea2Hntwd3Vyeo
         pSUvcDL6jiVFSkjhG7b3ZPq0qkgmzl85BE++iPjI9Jv7CT9krFx8EV6D0JLSsSofthA2
         GrZQIX73m8xHj1onXTmdN7cfG1wNdOFGaV2qzTj1CBl+UGTqEg9n2TZBJBcm9Q/T2WSN
         2ZIrMm0qfbFtuuid6FBYKJWct2Qll3sP3dGo8rX5JWCEIjUTqDIJXV/mdGR7rZaxgLEj
         K1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUKDu0m9dx/Hz2GOQinO9TC86o1Ssj1l9a1I02xGYVbFj99srMb1FNO4Nw5jCZXvnJtSjgSgm277iTtGd27Jxzklr2
X-Gm-Message-State: AOJu0Yy6aOEUS76y9O4mvRvKFZrOMjSXSzK52gtIOrHtAbYB0fdyEPct
	hRSskukNF2paCFR5ING0trNEm8eR/3Le6KLTCXW4ez1KYVV8kXxxuAj8+FL03sONQPWHaxF227P
	tmQkFhG8PuLVyVTHFplLb0fk+B5z+AA==
X-Google-Smtp-Source: AGHT+IH7zOCd6nsmKlI73k5PBcUGFHzGHH8jyRiSxvCiDu9wNmy6WkvGcVujPFTdRLr+mJ6TXZ5q/94fdLbnkbKxGsQ=
X-Received: by 2002:a05:6871:e804:b0:22e:dd56:a72d with SMTP id
 qd4-20020a056871e80400b0022edd56a72dmr16289307oac.26.1714481778325; Tue, 30
 Apr 2024 05:56:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 08:56:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9659d7da3f38e706af22b4cef0a3e77f780493fd.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im> <9659d7da3f38e706af22b4cef0a3e77f780493fd.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 08:56:17 -0400
Message-ID: <CAOLa=ZT4rFEc0qWOA0iCTgXRC6Bcbzj0v-_ntoKZs3eAdt7vCQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] Documentation/glossary: define root refs as refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005f1e9c06174fe5e1"

--0000000000005f1e9c06174fe5e1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Except for the pseudorefs MERGE_HEAD and FETCH_HEAD, all refs that live
> in the root of the ref hierarchy behave the exact same as normal refs.
> They can be symbolic refs or direct refs and can be read, iterated over
> and written via normal tooling. All of these refs are stored in the ref
> backends, which further demonstrates that they are just normal refs.
>
> Extend the definition of "ref" to also cover such root refs. The only
> additional restriction for root refs is that they must conform to a
> specific naming schema.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/glossary-content.txt | 33 +++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 13e1aa63ab..683b727349 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -550,20 +550,39 @@ The following pseudorefs are known to Git:
>  	to the result.
>
>  [[def_ref]]ref::
> -	A name that begins with `refs/` (e.g. `refs/heads/master`)
> -	that points to an <<def_object_name,object name>> or another
> -	ref (the latter is called a <<def_symref,symbolic ref>>).
> +	A name that that points to an <<def_object_name,object name>> or
> +	another ref (the latter is called a <<def_symref,symbolic ref>>).
>  	For convenience, a ref can sometimes be abbreviated when used
>  	as an argument to a Git command; see linkgit:gitrevisions[7]
>  	for details.
>  	Refs are stored in the <<def_repository,repository>>.
>  +
>  The ref namespace is hierarchical.
> -Different subhierarchies are used for different purposes (e.g. the
> -`refs/heads/` hierarchy is used to represent local branches).
> +Ref names must either start with `refs/` or be located in the root of
> +the hierarchy. In that case, their name must conform to the following
> +rules:
>  +

The last sentence here doesn't clarify what it is referring to, perhaps
something like 'For the latter, their name must follow these rules:'
instead?

> -There are a few special-purpose refs that do not begin with `refs/`.
> -The most notable example is `HEAD`.
> + - The name consists of only upper-case characters or underscores.
> +
> + - The name ends with "`_HEAD`" or is equal to "`HEAD`".
> ++
> +There are some irregular refs in the root of the hierarchy that do not
> +match these rules. The following list is exhaustive and shall not be
> +extended in the future:
> ++
> + - AUTO_MERGE
> +
> + - BISECT_EXPECTED_REV
> +
> + - NOTES_MERGE_PARTIAL
> +
> + - NOTES_MERGE_REF
> +
> + - MERGE_AUTOSTASH
> ++
> +Different subhierarchies are used for different purposes. For example,
> +the `refs/heads/` hierarchy is used to represent local branches whereas
> +the `refs/tags/` hierarchy is used to represent local tags..
>
>  [[def_reflog]]reflog::
>  	A reflog shows the local "history" of a ref.  In other words,
> --
> 2.45.0

--0000000000005f1e9c06174fe5e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee13463c65715f4a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdzZtNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlAzQy9zSG5TVGFqbGlNWS8zc3pYdUo0OHhXT3VDKwpIOG9CN3FwYmRm
QnJjQVlpSDVSNVhtNkdvL25KdnB0SVhMcnhuMnM5aUJ4bnJQU0lDbW9lNFd0V21LTGJleGJDClMw
OXgreHBscU15STNSZWNRQlNPSXovdDhpdDFXNXA0bWtXYVZmT0dSYUJsd0tCUE1BdFdKZkh3Wi9v
bmVZcloKa3BrWERYU2FhL1ExV0R6Mi85WUlhTUZKQkdncnQwZlU5YW0wbm45MHUzZCtnNXFHSDdT
ajVzV0E3QTcxbE5GaQpQUmt0d0N5TFIzUFpnRWEyYkhBMG5lZmZ2cWF5ZEJpaWFCcysxellOTUxE
MEs1M1B0QnlyQWRrNWpQNTNkczhlClh5NVlySStUNS9SeElBcTgyMzVIUXR1WlByMEdXNm05QTdP
M09UYWVSekNPd0NKVDl4M1RWWVR3d0JSTnBLMm4KMWZLZHo4TnRhbE1GOVcwa1NhaVVBUHdNajMy
NHBWbXM2dlFzNTZJYlJ6TFlYVGtzZnFJR0dwSytkU3lTQ2JQTQpXK2VZbGYrckpjQmhGNHhRdEoy
dWJWcndYczdFS1hEOHpsZW1EMVVKOUxvb2FOcEYzU25jMm9yWmdwT01JSjZ3Cm93TVN1Qy9UOGxO
Z1ZBS3BiMTllekxXZGhPdzNUQzVid1lIcWF3Yz0KPUJlbVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005f1e9c06174fe5e1--
