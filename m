Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F56182B3
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718456476; cv=none; b=NnRKQ/XNTepK3twyqgjAJn8QsDGJZNEq7j4mk+JkWB7ipVdRXOwgn76DYXhqRQUg4eM4R33MwWi8u0FEiMt6yxasgngJ0mOPth2ltsCJPCpY9lHtl8HXl6zKFYcaijADGugyZBARar72v87vxda85E7/LNlOn3aTuuxJDOXVHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718456476; c=relaxed/simple;
	bh=06zwgUQmusoxiO9Xy3odyVEJUy85htsC0AOLjRGc9ZM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu5tsm+Dtkw0QERIKSTE52JoxPDTWEORWzno/licvupNkJ2Ts+ABsSLiun8TbNUJEi4dxncTTlKcsENhVvPzPIQ3rnFL7u7XORECKfFD5sSlmhXmK7X/UDcaMzFBnnlvh8jLLcQ7Pg06lSIs1Jmay7eXpZxiQLb1e/XzzBMkg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE6u9vVS; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE6u9vVS"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2548c80efc6so1391453fac.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718456474; x=1719061274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EJeGQgDqyxAuoHL7ryTpN2S23RqSo94iA4WBe3TTic=;
        b=dE6u9vVSMa2XsVrBuueb/AKdxl1IyGl8K5VFU7e3wJZAKCs4CbqFvGDpgk0pBI8rhL
         pWsdJbJoxzvXMF5tpKPsCNgoQLvhr2ckCyMgykr5aGVoteLe7i6AadZ7RE8pzueOYbPs
         aPkceAcpUeNlXnEp0Z116ulmNyKN9U48BUIf3ZiKIyEY9wxEFZRF0OxijpdC4QHMNKYO
         aMKQoffBtCW5cSP09G7+dbCzmNCC44mN0PoOB6SVtgY4u9pOYQR0SF06/Z7bNQePEIvY
         B31HTohK1aGhmRXcm6OqUHyiw1+fRqWHwmVd1UYh3uz/CVHvG2Npo52+J8MgNvax5yhW
         li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718456474; x=1719061274;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EJeGQgDqyxAuoHL7ryTpN2S23RqSo94iA4WBe3TTic=;
        b=QGtJeLC/DeYj9YSNsLon3R6RddhWIWTNr58NlDmpaMHWll0XEe3c5+6whlFSlDuPxb
         AKQLS/Xfqb/S36vEK/CfbLOSNvbxBeO3Sa3Erbzcm85+mZZ625rLsFc6OBLl+VJ2he/L
         tI7sUg+2YxLhhhc2KP0oRHL8DT9lSgZho5kgx7qn4Svz+/vX9qJJvgqwFYb3VZCh9upJ
         OYjkoee9/SWmdRDrmwXVfON5+kQP8rIH6yxKYS13aO27+XVAZpZcdkKR0acrG5g7/64V
         a7/80f395PUHYnwVRlG9L2AND/Byl1NVekVDms72Vjpu+Bw4sb5MTtfPPpAOPIWbo3rt
         1xEA==
X-Gm-Message-State: AOJu0Yzbm4pechcITQS2sWzI1ZgY/IUvBiCCpQxomHCV8MNNzKzYvM4f
	T1ZvzBR7SO4a7LoHb2MPDmL2V2hJsnk7e8Tq30ebKybsseq6WVfFCxkOSse7TsRnldk82x0ryuG
	aDZjrtkp3R8PWO+d+nf0W0NSWNNDNGhD8
X-Google-Smtp-Source: AGHT+IFkh31J2mCYB63L8fCjr2srebyu7BcRIqS68j5Ebkisg4n3skW8uD5ZsZtTLrMyUh5f4A70RmT/LEYGrywynzg=
X-Received: by 2002:a05:6870:c6a7:b0:254:a0e3:b2f5 with SMTP id
 586e51a60fabf-2552b1a5a91mr4491922fac.2.1718456474115; Sat, 15 Jun 2024
 06:01:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 09:01:12 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240611072144.GD3248245@coredump.intra.peff.net>
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
 <20240611072144.GD3248245@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 09:01:12 -0400
Message-ID: <CAOLa=ZRkZb65b1NawPBNOnnxi_gjCU9=85cJuxj0mQxyrPJe0g@mail.gmail.com>
Subject: Re: bundles discovery and clones
To: Jeff King <peff@peff.net>, matthew sporleder <msporleder@gmail.com>, Toon Claes <toon@iotcl.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b3cadc061aed53f3"

--000000000000b3cadc061aed53f3
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Jun 10, 2024 at 02:25:19PM -0400, matthew sporleder wrote:
>
>> I have recently been playing with git clone --bundle-uri and loving it
>> because I can clone with almost-*zero* resources being used on the
>> server!
>>
>> I am a little confused by https://git-scm.com/docs/bundle-uri
>> mentioning "discovery" and things. Is this something being added to
>> the git cli, a special feature for other clients, or is it still too
>> early-days to talk about much?
>>
>> I would love to produce bundles of common use cases and have them
>> auto-discovered by git clone *without* the --bundle-uri parameter, and
>> then let our CDN do the heavy lifting of satisfying things like:
>> git clone
>> git clone --depth=0
>> git clone --single-branch --branch main
>>
>> I'm not sure I hold out as much hope for pre-bundling pulls/updates
>> but any movement towards offloading our big-ish repos to CDNs is a win
>> for us.
>
> I don't think the server side is well documented, but peeking at the
> code, I think you want this on the server:
>
>   git config uploadpack.advertiseBundleURIs true
>   git config bundle.version 1
>   git config bundle.mode any
>   git config bundle.foo.uri https://example.com/your.bundle
>
> And then the clients need to tell Git that they allow bundle transfers:
>
>   git config --global transfer.bundleURI true
>
> I'm not sure if we'd eventually flip the client-side switch to "true" by
> default (which is what you'd need for this to happen without any user
> participation at all).
>

This would indeed be nice. We at GitLab have been experimenting with
bundle-uri. While it is easy to flip the switch for clients under our
control (CI pipelines). End users loose out on these benefits, especially
for large monorepos where the servers spend a lot of time computing the
packfile.

> One gotcha there is that clients are now accessing an arbitrary URL
> provided by the server, so there are cross-site security implications.
> It might make more sense to allow only relative URLs without ".." (so if
> I fetched from https://example.com/foo.git, the server could use only
> the relative "bundles/bar.bundle", which would then be found at
> https://example.com/foo.git/bundles/bar.bundle").
>
> -Peff

True. But I suspect servers using bundle uri might not always serve them
from the same domain. I know we were experimenting using cloud storage
and providing the client with a one-time signed URL.

https://cloud.google.com/storage/docs/access-control/signed-urls

--000000000000b3cadc061aed53f3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6fc8fe9e42afddb2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adGtKWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzM5Qy85cHZ1T1RISGMyaXZPU1pmc2laQmJ0TXVwSwpudFMyQU9zOCtt
OURDdjMwMk1zY1J3V050MFg5MnY5VE9pK2pySW5ibHRHUFNhTkNxbSt5WnRaQ25KaStLejh4Cnhi
cURCR21ZNExQdjJZR1MzM3FCa0RZMlh6TUdvRDJUMFJ2OUFYVnRxY2M4T0traUJUSTZ5NGpCWE5r
ZG9XVFoKS05Fb2JqeUdQWUhOQjY1YVRrd3UxZjJXMTYrUHlyNElpSVRReW9wOTM5ei9jN21xaGk4
WlBBNTJELzlPUmZ3ZAplU0hUak8zd1E1QzE0ZUR0RDBlb0VUL2dLTjh2c3kxc1k3NkhxQmxMWVVM
RG1XU0U5OUIwbzJYVHZPczRXMWtiCnVVMEUyNE9US3FXWXJNOHBlNE81Q2ZKckYrdjFiYmJSaDBJ
U0NyZmhiTGVKRmVJTm5zTnhOcWRUQjkxeUIrUlUKLzFrY3NuU3Nxd3F2K2R6N2M1ekJaRXNkdys0
NE5KMFdodjVvRkZMZithd1JKaGlyQ2wvUzlVMHk2QVNQdHI1dgo5WHJ4R1Y1WFNOb0M1NlBkYkY2
STl1RlhyeENpQzc4ZDZKeWZ1N2NkejFiUGlIWHl1b2pxTXNyZ1NrL3Q2MnJFCkR2Yy9kbjR0OGNs
eEZVWjJaSExvbkZvS0JzaWk4K0pwcFdaUDVJYz0KPXl2bFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b3cadc061aed53f3--
