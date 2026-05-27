Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C53A6F0F
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876273; cv=pass; b=IkMDwLdWpRosL7g3PZeU8hXa/3cqqIhps8IaXf81PbDKXP4RpbHdxh7KJlip7TeYkHvOJWwcVHrdq2EhE3cuq3aeqbhBUZYPGSnmEqiKt533kvKNSaLDnHJ4mHLOBKi4LN47jdq5ZpwXim+d7ddU7gTFPCLDFxEeqA9xlMwqGK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876273; c=relaxed/simple;
	bh=Al+MY3aizSXcJEZBCC0d5yeeJJcFUVEZDpenzofJwME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+GWG+Vhm7BGSv0CSl0Ida7Hl/canLpCIw/7fCP9YQmn+w0aBXn9ypFpDMhk98fYs9QwvXtnVtrFHfLyH+eCgl4kWGKPixfwSrpNdX+fQlQsKDHd9jfdHbx6FAvLlBm9WHVteTxqxaLg+kFzA9WAKHJOO1HEqhE7cI1K21/ajB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=BkunhAlb; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="BkunhAlb"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bf0b47d2f1so100525987b3.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 03:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779876270; cv=none;
        d=google.com; s=arc-20240605;
        b=LZsIsUF5uyJTS4aBjggPeEgxdKLYek+bbBgKXpH2kSS8dzysskx7FOYZsmiVODCuu9
         icZZrBEVprwfRzTIzl9uK6ajExp5NGQ/odNA4gCI6AInvTgKjEZR34EFJWTejEzL3tKW
         wmA5wTAmwIjH8gOdlXzdrkYDwcVtT2VOVTXWZiA4AhSbvQ+UuaGr8vDjUNlxdGrA1h5u
         vrm6Psm/bZfzB9yFQF+OmF/OunvDD73vT/LFMapAyiuJb6ZlQ4y7IgPglf4GWXVu19NY
         Gngyhc4efhXnrAg/z0L5ygdT334LF9KzA2L7Wr9bh/o/mXdNbhDmEym/cMDZmPmQFxH6
         kQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Al+MY3aizSXcJEZBCC0d5yeeJJcFUVEZDpenzofJwME=;
        fh=ua7AJFhAjCObxU7QDBcGPVVnMPmipTCHVyCvKCf6YZk=;
        b=EJC1+/pUMaI3OyXuGhGEcGGuV06aA6Dq5/rHEo0q0ebjLfSAuqfsE2yIP1bqRx77uA
         jaHep/LwVrEYGWkB0t9dSYniTnU7EMFhwXTCMT1tysjtIw6BZat2j/Ct+8DwjEbH1iff
         O8eHdYSZ4joY3J8zUWBvtJRZAdLKIFXhYYaE8KZ7xSfqKaye6BOUFcpWfGgF70PuEXPs
         s3NkW13sPISvfaG9eyA4fNvmv8uJBk5B/Klc0qVYgWVWeRpW7Kp/e3dkaO7qo3Ut7V/6
         a0BPNDx/6NX8AnGtdsBzqzQAJWTk6iQaeRGA2zn0h83N25Lr826IMl4RZxBhILsK/uvb
         Mz5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779876270; x=1780481070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Al+MY3aizSXcJEZBCC0d5yeeJJcFUVEZDpenzofJwME=;
        b=BkunhAlbda9ezbS2XFE4k5T5dB1tHXzwKgAzdg5O55lsfmvGx8G9OFEOiAZDv+QAcx
         J4RMwianIwtaSV2q/TzHtTNyxP2MxkYjKO9Hg61+6RVXHF1vJ7+ESS4Vm565HVxPKVjH
         u/H8uHmS6lKpTuQU2HzXM6V5EyrcIQUFQjq7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779876270; x=1780481070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al+MY3aizSXcJEZBCC0d5yeeJJcFUVEZDpenzofJwME=;
        b=Fu+YR5JOCBjGJwRq5+hE1nNCWYspYXXc1Sb007NIycV7pArEq6FNBM44UzlgyyhMH/
         GvWOZLm0oCaPc/M/9alo9+RCRMlkP6LqxO1KGHu/QVnxJWr+1ApLSbnKetz42OLfWWYA
         FEIyGFK6bkhFY+Aoog95lon6YP2P000Du7C5x9qqUaLOYuH6QE0Xd6QguxYkGpEXttTa
         CWGMK/gyf5HByZLAXXXFYccQ7/refEW1xKrtviOw6n1oipeMXWP4BT/i8VjXuJU2LPK+
         lbdI/ff2lHAH+Phu9L/dFKNc+tDLhUmrOqriD8MGLpeDs0Xozbsg9yB0t4yEayJ9KVzh
         1UOw==
X-Forwarded-Encrypted: i=1; AFNElJ+IKJyczise/DanDngpwBFP8QuHzzMlnXMP+KHZXZaJl8jtUju6cxY+D4Kj6+VfmfVU8As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqBy+Bv4lquzy0ydrXWFaloIYSHCOTNjcVAaOgIstCoWZz/k3
	2CTVqKqb29ToYPZL2Ie1h6lumnCJNCYXJUvH1jjFfk96acBrttpo8y9ksS/55suuF5dLacWp7/G
	LsrM2/DmNS2g5zSHXsv74KnZOJp0/nDbsy9Qn0zWGDrmita9SXonajswULA==
X-Gm-Gg: Acq92OEswZPpUqtkYJyxpVmK9Ym3+ESjY3WmQlW/+4d0qsL7N9JlsBWhENM693qF6aJ
	2wuT5YZ1WBZaP3ZCW8/NvwqlxG3eHpwEcG6JoX+MTKpcpoSBVfK96p54P66D38/mIQHonq0tMLS
	GfSNPK9dSrHwaQfCDMetZUvtIRVAFleugzBR771nuqid96NH8SoUUD2EZkm3i1Ert4a63vpmiJg
	FNmqwauGEILv9pJ1t4p+SiDxZoac0YPqwouM46e9FRAIa+wybHWt+zAMDSM2pZ6aCEx4r+R3TkN
	O+km23C/XlPdsuU=
X-Received: by 2002:a05:690c:e3ec:b0:7bf:4a9:1a86 with SMTP id
 00721157ae682-7d33ad502c5mr230564817b3.45.1779876270324; Wed, 27 May 2026
 03:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2123.git.1779625693328.gitgitgadget@gmail.com> <20260527083216.GA981444@coredump.intra.peff.net>
In-Reply-To: <20260527083216.GA981444@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 27 May 2026 12:04:19 +0200
X-Gm-Features: AVHnY4LqpK26yHWS0BKltcDUpk8S_RaHKlDPJbtT_jxT_lOhX6l55k1qwDIekzk
Message-ID: <CAL71e4MrVqC1=AR6x0_8S=8kVqPdDkhgCZRb4etFsxTzd6s_8Q@mail.gmail.com>
Subject: Re: [PATCH] fetch: pass transport to post-fetch connectivity check
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You're right. I dug into this further and realized the problem is deeper
than just the flag not being set in builtin/fetch.c.

Even if we add:
transport->smart_options->check_self_contained_and_connected = 1;
to prepare_transport(), the optimization still won't work for fetches.

The optimization is fundamentally clone-only.

I was unable to reproduce the benchmark numbers from my original commit
message. The patch as submitted is indeed inert for non-clone fetches.
It looked like a simple improvement, but it's clear that it was incorrect.
I'll drop it, and I apologize for the noise here.

-- Kristofer

On Wed, 27 May 2026 at 10:32, Jeff King <peff@peff.net> wrote:
>
> On Sun, May 24, 2026 at 12:28:12PM +0000, Kristofer Karlsson via GitGitGadget wrote:
>
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > When fetching with a transport that sets `self_contained_and_connected`
> > (as index-pack does for self-contained packs), check_connected() can
> > use find_pack_entry_one() to skip connectivity verification for refs
> > whose objects exist in the new pack. This avoids sending those OIDs to
> > the rev-list child process.
> >
> > However, store_updated_refs() never passed the transport to
> > check_connected(), so opt.transport was always NULL and this
> > optimization was dead code for post-fetch connectivity checks.
> >
> > Thread the transport parameter through store_updated_refs() and set
> > opt.transport so that check_connected() can take advantage of
> > self-contained packs.
>
> That makes sense in principle, but one thing puzzles me. We only turn on
> the optimization in check_connected() if the transport's smart_options
> has the self_contained_and_connected bit set. And we set that only when
> we were told via check_self_contained_and_connected to do so (and we
> pass the appropriate option to index-pack, which tells us the result is
> OK).
>
> And the only place that turns on check_self_contained_and_connected is
> in builtin/clone.c. So how does this optimization work for a non-clone
> fetch? Am I missing some code path?
>
> -Peff
