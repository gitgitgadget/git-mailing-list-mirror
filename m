Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D044C659
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186636; cv=pass; b=Jz/ej21bkZ9k/P2eQKaePa5czIYO+vyJFRjerVUn74uD/uga1n/yObhMBMlZZPyC90R8/q4ZNDeWqZiqRlUQhxkSRfUqXXCUk1zoEGIpDnSkcGgNdbM8+i2Wj6TzLHFG3xg/lGyvxYg4JQnnet4lvWyIMQbr+SfZ6FGcVwyhsrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186636; c=relaxed/simple;
	bh=keNR2l7+JZ7oX5SeX8uvdK00FxTCZva116JK2+KZOAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtsiBxvGd6539EnPaNjGGLgsSA0/k5PVc1fpNzglIZ1qHPdvkOOSo/hBEQk9VnB1FkEFButtYyuPdKxhr2MqcpLeFG4vM2aeJAm0tkvDK0fndVXV0AsuruDzhPPvBAgv7UrtUBHKPj/kpE6bhlTgmWupBbT5IDRB6kVSLm/t9QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0CPRO9p; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0CPRO9p"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d94c868ea5so564065ad.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 07:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788186634; cv=none;
        d=google.com; s=arc-20260327;
        b=iK9NycpCkurBSH1PWKnkBVoCENhn1phM7JTzypIcjp3JDFoIRCyS8BmoV1cazP8vIa
         YaRoFvtJREjp3/uLylQIwprWMAk9+6zDMMgz9uuyHqh5lLcyI5drUKgnHgeiKGMU8IGk
         iiyvRAu25wRFYXlp1KsmWQokldlt7bHoDjV8Fl2z1yPOteK9maUcZqMhE9YNqIbN8TZX
         kt5/iVpikhbChzdQbYfTwDA9XSwnBXbHCOeNSeTATn0G1LwhXcg2gUe3BwTRhsnZ9KRP
         hqjy3vhqyO4VK7eMidr3jBWv8cZHYBPNGPYdWejo5Gdr0xQfgE+/Keh6z0RdY7gGHLFi
         4NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dJjqEJNDsCUsiFpPKqUABiiokzJQpRElyDyfs5TBmI8=;
        fh=JS8EzgH7NJXffXgXVaLtRNkoBHWCFqWxvYCmvgUp5qk=;
        b=Qwty3+DadF5gJhil4Sul1QB6WR5geZKgk2d2fXU69eZvBwgXA8D0CDppNx983HUCak
         SBjKmnz9zP8juIudZJz0VmI8KpfdzH6Zo5fqQeU+RpE8bwW4mWmf3YA8m5ZpQGY7PSXP
         PF21hYR2hsXW45e2CAB+pbtuEkMam8/W+n7nVgWjHi/k9xAnjwCmoRB4yTSSkjgJmH2B
         IXVHid6YgRfdxj0Qhr9PTkrvRBjC4g/WuPkr2FmH5TaRmbjn6j8G0S/6tSaNEtf2hq03
         RYz4B3SN5LqbWe7pd/Uq07pOtTNShsuZSjA2a3FZSmSQgJGSA5pJRkzE1kMK6DAdueQS
         a43w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788186634; x=1788791434; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJjqEJNDsCUsiFpPKqUABiiokzJQpRElyDyfs5TBmI8=;
        b=V0CPRO9pVu9kWajTCcEEpjQ/fVSVPfWwOm6wmFMkzjxfmk/ygybQWqEVN1poG6HCmh
         qdzmGwSpk12h7Oufqtt9eB5gGXQRBXBZ335GrbMPkvDX4fxdND7/BglL6Did5vId1HHg
         1w3Em97nI6amsSbtTuMfBU4gL5wl3dQKbk4Dwg9KCa70bNJvGiQYpu7qsm0z+bA20P8o
         VNUmER8k5u0ntJUoQ+WFy0CgoBTdB0l0HCIOUnYLPnq0Kys8k0UdMZlAU/L/vFUGRxKI
         5nx+YoTBre6MJ/wplkj0O7PPRTnYiLdylwCJsc1y+dEYPmslP1uWx/u34SgCUaWwY5xS
         +BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788186634; x=1788791434;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dJjqEJNDsCUsiFpPKqUABiiokzJQpRElyDyfs5TBmI8=;
        b=ePEK7joXfGeQloTQSFrmKnnWUyW8jAMjJCWHXuDsBziUweI1YvMMVrB7rCgKI03GeM
         YE4U2QobXsax/H1TqvfCMzIBi+PWJ3DHJONmEv2kpjac6VFr5TQB9f3e6hL7D7/7Oeh7
         odxUYiuwKN6BqrDgKPhqI8vd+RAe+AHKbjEGkJYgq+Y541lYSIOW0DoFtmXHDubqzwic
         dQ+WYj5mGCS92h1ZGJ4bfMWwJJqJlS7kLr3sJMCzXbqLop1jfzP7ocq708948mr+u0H5
         9lFmW8NEXjvy4mT28Nr4CSsjutz1hHKv4BzxVJ62TJDTOF7ULaWOGEP9bAgoYUi18bRp
         swHg==
X-Forwarded-Encrypted: i=1; AKwUvByTAq/d/le/CKJHlBjULMSUEKxv6DhrWN0s2eTJELMGgw0oRRuH0donrMKyc2lvVWS8cwM=@vger.kernel.org
X-Gm-Message-State: AFuF++mod5rgMWoWERNODpuMBr0cHM2yENTlqSm0ad0xTYFb9stlOmPP
	KAmTWmSFcHN7QHTTTZnEL5SuXFVfPuaQ0RmllYrrvrkR/Y2TrsWyqm3foWG9xKfr/C0FLh4/Asz
	jOG0dbBb8dYmbN8C5gLLsaDzgMYwGIn0=
X-Gm-Gg: AYBFou2nwzEiRBiFeYjF72NWynFdPHal31R/A2/Hh07+1v7YLdLAEFAq9mq2INdcriL
	EiYX+YR3fdX36m1jtiyDw9dj7bgE42wH8n8j/Ysbj1MH8S6HQPtwEyFjGWduzk/tnft+z3a6QxJ
	ym/vdMTb0pGAL9ChMAR1dzgYRwOBFmBPauRbHPuyVlLCq4ifUHTPIp1oFHtQqC8huHXgddICaPf
	JtUwSoOcRE/1Qzcyd7Kx2p4a2E6GjHejW7kzqnYhHgatDIs90QgOAqj6gyGPCgUlFl+h3NfOov/
	ziVVKwx27uXVoZj0GpkHgDQIM1uCe3KBXAJ9SqcgbCOX9RXWt+NqFDcslH72zLjEnqMpf5PvkmR
	cV1aDxMeLaD04
X-Received: by 2002:a17:903:196b:b0:2d5:ccb7:12c3 with SMTP id
 d9443c01a7336-2d74dc2b30amr401625875ad.2.1788186633961; Mon, 31 Aug 2026
 07:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
 <xmqqwlta2agt.fsf@gitster.g> <CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
 <a8955129fcb7478f9739c8586c6975e1@CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <a8955129fcb7478f9739c8586c6975e1@CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM>
From: Diogo Castro <diogo.filipe.acastro@gmail.com>
Date: Mon, 31 Aug 2026 15:30:22 +0100
X-Gm-Features: AcwNN1Xbt_QIH9hLWgcTR2MKLC2EGI5WF5fQhbQ5u2X50Q6oF6qqWJwB3tuP37Q
Message-ID: <CAJw8QBMmv=zLN6sd_W9uQMF3H6Baatyq=TogLyZSFXK2gN4V8w@mail.gmail.com>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git add'
To: Junio C Hamano <gitster@pobox.com>
Cc: Diogo Castro <dcastro@diogocastro.com>, 
	Diogo Castro via GitGitGadget <gitgitgadget@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	Thomas Haller <thaller@redhat.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

I think there's some misunderstanding, please allow me to take a step
back and attempt to clarify.
My previous message was a reply to this:

> I am wondering if the solution is to compute common prefix across both positive and negative ones instead.

As far as I can tell, this "common prefix" feature does not affect the
semantics of "ls-files" or "add", it doesn't affect which files are
reported.
It only affects the performance.

Your first example of "git ls-files -- a/b/c a/b/d :!a/b/" already
works correctly, the pattern ":!a/b/" excludes everything from the
first 2 pathspecs.


So the discussion to be had is purely about performance.
My point was that computing the common prefix across both positive
*and* negative pathspecs would not improve performance, and might
actually make it worse.

The "common prefix" is mainly used to avoid walking the entire working
directory.
A couple of examples to illustrate:

* "git add -- a/b/c a/b/d ':!a/b/x'"
    * Under the current implementation, the common prefix is "a/b/",
so as a performance optimization, we can look only into the "a/b/"
directory and ignore the others.
    * Under your proposal of computing the "common prefix across both
positive and negative ones", the common prefix would still be "a/b/",
so performance wouldn't be affected.
* "git add -- a/b/c a/b/d ':!a/**/x'"
    * Under the current implementation, the common prefix is "a/b/",
like in the example above.
    * Under your proposal, the common prefix would be "a/", so we'd
have to walk _more_ directories, which would hurt performance.

Does that answer your question? Or perhaps I misunderstood your point?
