Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5B26ED41
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905952; cv=pass; b=MpiEZiz8tZLpewRL3moKrD1u57AkFLBfVfSa6/Oc+0uG7STRDwuAswGfAYIPFMAgmGVGTyQpy6BKLtlDvyFNZcxpz/KCJmUsoqkq90J7UrVlUqRQAEMJ5V1GOFt5kMCpmJ/z6YbBbC3L3xQ4YeEzmb2KwGc35DUobNwgM7iL81w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905952; c=relaxed/simple;
	bh=6cymx+0WTn1RmXVRQEiHZPo0H+yeZKYc4OSNim0lqjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu1KhgJsXpvX0NeHiorGxmhs7onK/lfmIarfT2YlcqT0lCnDQXGftxPLDP8VgwwPVXisoIpDnhYAXG8O6gSq/cZ/n8d/VFkznAcLVVqaidDn/7xGjLpL24fCUfJS43GiZbih7zAsphY7qCje+bs87tdDUkk6SIsbvAag4lerKsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xud0G7bJ; arc=pass smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xud0G7bJ"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-821c01c2fc5so1191567a34.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 18:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790905950; cv=none;
        d=google.com; s=arc-20260327;
        b=bLQmC6vJ1DuY4fhXqbL9JlJjAe8rhHHe5Tq/5PIpJT5WdAOOxpYx8/wUFhuWBK2bU1
         PWiUt92w0LInYhRNcwi0oEOXI/19BdZ6nJqi+J2VDadRo8tGGkKnxhmqZEGo5CN6r7AP
         2vZ52t8lBZ/edsZlfRARaxLwlEpiURCW5Zl9AR5GsbTuEdvMjE6t+65nfD1dd9kLcTNY
         cBkSh4x8L1jTBI3OfeQ+8pMpLiQ9SvoE7y6Bl6tmUnb7CBiF6QG8YJEpcc5uA9/GwhdO
         5zBchU4nyiUYMt99K/Qzzp8jRlEOOK9dBGr8HagEwYX/WltvEEwLzrtk+y3IBp1Eb9Q1
         cRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cw2/l/GYfEbbtJBxFCqpkEaUx6aTPGgXvvPkR9uZA5c=;
        fh=urkPRB7mpnEfkfj03wlsD03je+w1rBpOOP0ZuXkTb8Q=;
        b=jfzozCyzWwnqtEEAgWX3otZL4pbC7WwNsQ+u09nlbiTWDvrDxGvtxV177Gt1cjxvoG
         OzBT9ezAIAcbBR6ppNyth44yESAsSEWVBFkUbSykkm+kzV2etwvjJU09HjJrUZob7EXU
         0CfNswz0fxOO4ajntlQCTmLSLj7dmFU5LzV3AaDQiFcsN6MvDVqCI8uuwKvsHdBVeQbr
         dARt6LWrhrpAbCQnP+V/LyUtFTkoT1VtOA8vD4hpit1aGx2fDV4kAoPaHi+lLfw12zXH
         j11cAmP+w0c3fbmkYRWv1B/qyzWSCVMXk/R8XFLIdeO3N5RBEs0z9dIWUgbUyFhOZeWw
         Ot5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790905950; x=1791510750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cw2/l/GYfEbbtJBxFCqpkEaUx6aTPGgXvvPkR9uZA5c=;
        b=Xud0G7bJ2t3cvBhRv1cF14H3QhfqyI8NdGfm+ppkSDDrGhBP+hG9eDQFQurAEmHbVy
         JgfIuWUTNEyq87cleNJw7HOV1I61cjjPfgBBrgqSRZn6ueM7Xi8KGUNVBEG5zzP6dg19
         2R2NdmQDDU3CKqdxnCq8GOO5rbrNqF3q9SpyUmbIGl7C8eBMitae6qOGSan4f2KRRZDQ
         wKE6owKND+py0Fb98IlG8W4mzXyh6ZiwXOE2nhijDnBdfjZNb8td657aolTwYoLZfOV/
         2qLw++faMaw2HeYy+LVaA0Rwz7g+3yiyit7/8WIvbI6RZzXChpB0hNEktS7YwZxU7MdN
         pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790905950; x=1791510750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cw2/l/GYfEbbtJBxFCqpkEaUx6aTPGgXvvPkR9uZA5c=;
        b=rccQk0ye7H6fIb4hSSSH17A7NfzyqQRUFI6NOl7Qdqlp9G6F7Odj2yroI678+ulmz6
         gHkfxzajGc39AUwJSc5ZDabiPEwQb6HWgCWQTEV2xT2f8LEcy/gA3uDehRXhYAtgRBLz
         H5Omsbp8hugx/A7kxAm5UsfqUNl1IFU8QjW8wk5u6Dsq9FA0fhsnPMB6PT2lGht+qqkJ
         ydl0GQdngEYyF0lOxAYXB/QBXszHD6Aw9pVGKP7hDmGfcAXZZsXSY80gv2I+H53NZCtm
         4GwOAFyEMjpFRYkrbXfbon3ZLrustH+KTNsEHfdE2KbrnnmruK1VbLEeurlzjbTBS7a9
         59sw==
X-Forwarded-Encrypted: i=1; AKwUvBwB+e6obi/+f8bNSrP84/rJkWr9ay9m1r+npEaD6bKdj0lP6H6LmvNeuHRr31sm6JH9sFE=@vger.kernel.org
X-Gm-Message-State: AFuF++ndTg+MmtkSQHFBxaOJkXGwX4v3Pr8ctFUPoPpc0NR6YdNL/BuX
	oOUlKoSuvkDKJYhYYB3Dbe3qwNoD4ln+bu8MNrPjkZ1lfkLHNUDCXc8xHzg05w6tiGD8T4rhLRQ
	blosQx/mVp/J3Hhr/Zvxv6b+wZxFVNxk=
X-Gm-Gg: AYBFou0VGhPa0GbernhJikZ7tpyiGWzJc55a91IHnWssh9WlSHkg4ySn1ka6HkDdEwx
	p9Bki/hJtAHQGc9F3QmCKDzl4uwsaL97T5zV2N1oGnYAJq3f+ZyLDfYeQp6ed2bfbRyP85HDo3S
	y28NT1mvt72FKfE9TsA3GQf/LpOd01ErLdqaYa5ZQV9nKx1kDSkZkBDl3aw766C1s6D7uSGrJS2
	xQk4/vu7sw9xhHIqRaS5YxT+U7AWtWJSoC8QzjEYf0f6ocds8/W0+id8WdVfge0/2wNgVzIxEOc
	+lcWKZewFbPvtMYa2ifld+U3iXGLJj+KHwkVnC1ePm8ItYcYPd2unQ8unQO4jdYHMQ81AYKBqPc
	HZEClF5EsIjtQjdR4eiU+PH+n+Q7E3Q==
X-Received: by 2002:a05:6808:30a4:b0:4f5:20:d847 with SMTP id
 5614622812f47-4f52a985746mr1126698b6e.36.1790905949916; Thu, 01 Oct 2026
 18:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>
 <20260929014415.GB1089022@coredump.intra.peff.net> <DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com>
 <xmqqa4ozg7dk.fsf@gitster.g>
In-Reply-To: <xmqqa4ozg7dk.fsf@gitster.g>
From: Isabella Caselli <bellacaselli20@gmail.com>
Date: Thu, 1 Oct 2026 22:52:18 -0300
X-Gm-Features: AclHuK98yOBCG8XyO3bLsKg_AfOyeyaoqMzADofKJiVeLZg-5UwAnYAY3xrJ3Ew
Message-ID: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_hostname=3A_includeIf_condition_=E2=80=94_anyone_already?=
	=?UTF-8?Q?_working_on_this=3F?=
To: Junio C Hamano <gitster@pobox.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Interesting, I didn't know there had already been a discussion
about this issue. Thank you, Jeff, for pointing me to the 2024 series.

Junio C Hamano <gitster@pobox.com> writes:

> "Ignacio Encinas" <ignacio@iencinas.com> writes:
>
>> That's what happened. Similar to Isabella, I was looking for a small
>> contribution but it ended up being more complicated than expected. I got
>> a bit overwhelmed and decided to drop it.
>> ...
>> I hope the discussion from 2024 is at least helpful now if this ends up
>> being implemented by Isabella.

Ignacio, if you don't mind, I'd like to continue the work based on
yours and credit you when submitting the series.

> I was re-reading the thread yesterday.  It looked like we were _so_
> close to the finish line before the discussion stopped, which is a
> shame.  All the good bits were already designed and the only thing
> left was to assemble and package them up.

That's encouraging to hear! Sounds like a plan to go through the 2024
thread, including Jeff's suggestion of exposing the hostname via "git var",
and send an updated version of the series addressing the comments on v3.

Thanks,
Isabella
