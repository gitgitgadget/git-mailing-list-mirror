Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853425;
	b=CcOdF/Bq+ZEk08/Rs1gBiAev6NBJiwnW652F20im1OunpBXxre+tzgdgKk1hgzWNsd/L
	 MsxnuKFb2BvBW4LRSuKpg8uvn1hSwTHOswUEzATL4HNU2XPAcq9i8KL6gMdwO+Y76F1Ms
	 +uR3ACdGXIUmIPzM9d5eBb4qfz5Bq58BZ7wF5/QXtOA693Eg/EdLp+GKVfIrqOG4eEJlO
	 e32ZcAtSZ0sEyiIepr3rragqERhPeZmigwX3k3WJ6ROeT0Ipgr8bqO6f/nZJ9ZsWaFh6j
	 efaro0CINmzuQ824mnyKg0OphrbVwANoZCux52Y3gwMKaFQyg+og1FSbI3OebYIeM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RIyBtEUgxvGVQ1lBVZTEaGFl5rmHACFSNxyqrS1TQpQ=;
	b=QHMP3eE9lpYzW36Hvmo9CfKOgSV3FWabitaJDXF6mRyUdgdAadbhuwln4cBzsYb3eH4S
	 +trpdJpmSMD/E0LNwiAq9hS21H98aQ0h5cCMCupZpb3BJu77h44NPMsXt2We3YMr5d6Wg
	 b4MWYkX5vAGUegyQGLxdXnPoKjgTdZ+Mqalm2Lnjo+g3Ia4yYFRMPB8U7CCKPpfjkf1UO
	 SX0Oq9KFTK7PZGlc1p4bHBJKdFgom+OH1dF2PPEfwSUooqydpimG5Nt48n9R0ewLJXt/g
	 wUxtwflc1SAHoJWxv90+1S1qs+cvFQkSyjFJkN4qYt00KTI1khqBodsHpAZUldF25LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMSvB534;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0C606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 14:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED0C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMSvB534
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so264225e9.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792853423; x=1793458223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RIyBtEUgxvGVQ1lBVZTEaGFl5rmHACFSNxyqrS1TQpQ=;
        b=nMSvB534N7UZooc/3W1lxAZDj2bd0fXuqpeeKALl0r9aas45V9wTpLspMBbC/y+rYB
         0wGeSf4m2CwdXivaOQHMQiWE1GYGHe3n3xOl/TdKMrbbesG0iM/zijf9LtBSVZzE4mVI
         /y3eiPladYwIQmOO5yEAe3a4GZD576aFPV1nrPYC3NAyPjbjRUBioVSeFU63EgYQ0YfG
         f8aC6LSs5Ocqs75PxXgUVM3jz6rh7ORozHuCHuvFKPA9GNY5XxstoHfqZCWs0Svn0OCS
         VS3Qw1VzcFxvj8Rp8Ii30nPGln6poEhHYbeRr3w5RDsPSPoGjuCWwXL2eecKbWQh5NpA
         /CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792853423; x=1793458223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIyBtEUgxvGVQ1lBVZTEaGFl5rmHACFSNxyqrS1TQpQ=;
        b=hJZw3p8A0gxqQw6Jf6QA5Is989lthQbsENL1Z4Vz2joQkZ9PK3DPidR/B433+JNkb2
         pYq3IAB8Ik+3NnylYUTTwulI6dTy55vuIMijMU2fM2W1QxMe5BoeEDOImpIpDomd0gPz
         gKaurkrqIa7tOJD3jWbgDYFzm9flP+WbZDjxf3mN+MGlGcwmmj9EWoM33D18P7oP58LJ
         7q/WORc3mMhXOOkFtx0QGZbcOkpeNHO4Be1cj6xCdBs3cfT8eQlAvrCAzbSzNvE9fVBV
         B0j2lX9ZmZmQaCbUlt1kMeBmVMZvTF8up0mDxcPMwCSmqbVzuA7zdHYfC/DMXjGVO/kn
         d3xQ==
X-Gm-Message-State: AFq9FYJUAeyKVgtb+so4l3o+7MYrxAdB056u+4so9D2dfardTBXfpqh9
	mjefev44rN3PAtB2YqneErxGs5iUWrnTQB/Lwh9Z5Ws0JIE2vdSxeaVq
X-Gm-Gg: AYBFou10Qu93MH94ajDErCifrS6XHcZ8Yz/utymf9DClA+X/qpu8MB6i3S0uDozGmG1
	+8cWXu6NzzeOUbdQ4qPYxcm0F6YUxvF22Kd5uxdOvE/87wkHqBLX90oK6oHOWvw2w3L7Qa8kiJe
	g6SWp4btQt7Uy0+65TLitzAOcRQ8fBzgIW1oPdo3ru98iNjonwnCYgb1pTpwe2c670jXjedbwmZ
	hLtsQiai23GxPOtnpyOQBemLg8wKOYSiPimYKegn7JoWIrTg/IKZBkFodcQdTam202nwBLBHzS0
	/Yb/99hOt689cfJqo7sucAyKey2aJLH44JYLbaTOythfeZOtLvmpmq29PaXwLiO/3knJnE21uiS
	n9fDJR071NM2uDKo9YWTHWmmmJ7GKFygjA43TQ8v4eglKMOqp7LyvQ7QWYe/75/tTkZ0aPKoLqu
	xsWt8/fFT30zyv9gxhJw4XfwlS0fyouc+am8x/tEK25NCYVmgCMimh8cXkCxxYnH844a+6tOwrP
	0TzoxMOa3laLlKVGw3lhOIHBhwUEw28qa0xnRhzneAneP5xxfEOSU6Y+OBR7I+m8FYU5aVQ+gHb
	ldc//4aT
X-Received: by 2002:a05:600c:1c26:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a35aca500cmr37826585e9.21.1792853422848;
        Sat, 24 Oct 2026 07:50:22 -0700 (PDT)
Received: from localhost (62-165-238-23.pool.digikabel.hu. [62.165.238.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm56132205e9.13.2026.10.24.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:50:21 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:50:20 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/7] setup: introduce object storage extension
Message-ID: <atzFrKoU/mrhq31L@szeder.dev>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
 <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>

On Fri, Oct 23, 2026 at 01:49:11PM +0200, Patrick Steinhardt wrote:
> Introduce a new "extensions.objectStorage" extension that allows the
> user to configure the primary object database source of a repository.
> The value is a URI in the format "<schema>[://<payload>]", mirroring
> the format used by "extensions.refStorage":
> 
>   - The schema identifies the backend that shall be used. For now the
>     only supported schema is "files", which is the existing object
>     database backed by loose objects and packfiles.
> 
>   - The payload can be passed to configure the backend, and its
>     interpretation is backend-specific. For the "files" backend, it
>     allows you to configure a different location for the ".git/objects"
>     directory.

Please justify why you want to make this configurable.

