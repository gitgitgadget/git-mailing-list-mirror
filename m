Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BA4C8C6B
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602814; cv=pass; b=ZB4YKhI+yTszRmRkH8RS5GZm7CkbiMy1LJr+thXdUd3klL6zOzn5Uxl1KoCVZqtJULzx7nVLa8quY92JGUVzbQ+WUzfhv7s/o4ORfurHploGyia9IZ/YyDDFqDEyhsWVpwT31yhKYBDA+JgdTfvKeBSfLGTPiSrVPl29oRjIG7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602814; c=relaxed/simple;
	bh=KVea81Q1E85qvCGeth1fypA0Xy2A1/suA7PM5Qz0Rlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfm6jvpR+mb62AGylNKQTgeiAnZ5GDWvfyvwjmjX0Lrg/lvRcXmnxSJAiOXzDc2QKIHzHkZpWYYnEHMlT3cGax/0F3k14LsjpK6fI40vzkAg2HNEW5yOaM8VOmpFqDEiXXBHtGvXPBwtK7KWXZZh58H4JvbGvDIUZg4wvd72rwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc2d8F1y; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc2d8F1y"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1480aba0484so140757c88.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602812; cv=none;
        d=google.com; s=arc-20260327;
        b=g/7t3K7RtykhcpBkfjrIAoX4aleS+7UIakOBVy4CFHkBYxsuUIqRfvbvzwrEoscXK/
         thLMm0KSltLj3ZfD/xIF4bhuGxBD7d+EA/p/TBIc6kQY3DwsoHFuorCkCmGzGJYhBTSH
         QkSWX74i4i6YgPMo/7m7sAYBidWyQYE/gFqKXssN7xLNuZMjX14KvO/7QMGTwnjKzKW0
         zsY1KiKJhethIwUgBu6tnlZZ9o8b5qA9XYY9LfoB1AnS2fHBzvBgyxUuYfpPzIAQcaNa
         3BDlx8db0jbW5KK4HrT5r5vcNjWHakos3H+5+JbR9UM8W0M5gwaEzNeOx5c4IqA5tX5a
         Ausw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wIlUcOQzik9TDSaM45dUCGP9hQggpFk7nnM6UFHmq+A=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=qEGSLdnJKoJx22bpzA6Ena3eEedp411eOHqGa8BJYym0QLyp1advXJVqjVxdscoD+U
         obDYczidEJFnRUNB3eBQWOp+w8i7g2YhMDz8azWoBbLL/wAn1F5zKn0wq8TQ/tNMtZQp
         nB60dX3V+eEFOInHFSOsmLuedJOSqMxPyHXnWBwf1XASdQn34NHGHU9xxvI5XSiNLwIv
         lkSVTM+0W7ZuJQZWnp+7n2J8QAmB7Wl0/EN1ILbwVp2CJDtVVobtU+9YpV0u5/J6Z2hl
         alzM0E64nDBkq2XKJJprMSES9u2nd3Enu3QnalqMi+7mePTE1Pk+Lv9V5ZeKNnK77BtU
         Ubow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602812; x=1791207612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wIlUcOQzik9TDSaM45dUCGP9hQggpFk7nnM6UFHmq+A=;
        b=Zc2d8F1yKLtwU4JPfqJgEacYshErQXJ4OxClCJBgmJRe34VaMqp+ZAy5PowVmwgoKo
         jLYG7fXdohYCAUAnyBET1rltsaq1VN0x7wUHgQN4G8HkUlt1/S7pv1jHemywXSmpTsQk
         VRF/X/Q7vezec7+xXO2eTiulHdGjyLQaelb80fifL8KGQgBYho5x3coq8X/AwXur/H3j
         ZmQ4uSeDudW9jmfmVGvU2bhgB3gQveMt5Eh/JCZW6RRqnUkIkevUUDD4dFdqXTt30E25
         iIptzmcxMXH20UbN+RZJxbFNFOb/GkDfzQ+y2PtJ/Bb0Atlxsch8Pyj8lUhu5ZjC0vww
         eFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602812; x=1791207612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIlUcOQzik9TDSaM45dUCGP9hQggpFk7nnM6UFHmq+A=;
        b=mfHg0ZUQ+OgjyOS5dV9tnelGFmTPVOh895EoYbPUxYsWDRSIHSG1Y1HkPdobt4+woG
         xj65OHpua3Crrmd7DaH8FpAGGlyHDebrG0htFyOoNWOsq6+AFg6LrpvQln6ZQ5HHRmJQ
         XElA+W4uSgC5TZ7iy/ezKYojtUbwMR+HgRoX1GuO+gZxVLpbcoxn59JlZCYmFnSLAIJW
         zbeA+Jhk+jkIEi2m0ErMekSxHVypjOchqP4CDAtOuv9wthndkLq9fvxzJ1iM00XzGvWG
         o4MxOLawxv3TzQyG9q6PJoR2X11peqNheKpUHiFitDeYPBXdXJwTE97vYMcqkViB+V5G
         xkxg==
X-Gm-Message-State: AFuF++n5briCM8/x7zmeQWHTnKGDwJoYRSG9SMsrC1jtJbIuzoODhGOo
	vVMBU3lrMW4DmxCtB/OCBT2GldrXX5rpzMTlp8I0ODEmb81kes68Y5hM8vSb09b82ftNaSgCwxV
	rpyg6cAMxyQMXD1tQiJGxvznMry21FP4=
X-Gm-Gg: AYBFou1kAC0bt4+Ixr2GXdI0phEP2NlkVl1JebSTZVkcBIzXuRh/86EOaQGNDCEli7O
	jDfOqY0irUQqR2qgq1PJ0M7oKN0fEWKSOub/P7z3QD4gXe0Alcm2X5zMK1g1KzLzwJWuBRHooCv
	3zgsqs91VZ7bY06szPgwu7/DUfBgRFrnJNdcJwk2IV88AZj/kTFJ2TuGWrikwAenNcwpKtNdV8w
	5oYf1Jt9aola40NzS3OOu0w4ks8+ntv9lluJFGmEceBuk/uiJClCSV+mwSC/kfMkyyWRgI4CF4D
	Ar5Pnq17dX3gm71ff+d6SMN8PqvLNOoBGJ1T1ex0Xnoq1OwEjqRlSYz+tPh5OJVWFvwEhd8zaTx
	9CXIIJKauY8chy6Zi/xTEjrt9oPTaCMP3yqtNn9kOBZwIM432yr3oQx4QmVA9U0nZET9NIJempQ
	bSno+tjJYESN6uIEEQ6w6bDDeDftmRF8gxmJEFSpY=
X-Received: by 2002:a05:701b:2313:b0:13c:d071:f97c with SMTP id
 a92af1059eb24-146cfdd1e92mr10672537c88.11.1790602811478; Mon, 28 Sep 2026
 06:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com> <20260908164129.560396-2-christian.couder@gmail.com>
 <xmqq7bkvy74h.fsf@gitster.g>
In-Reply-To: <xmqq7bkvy74h.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 28 Sep 2026 15:39:58 +0200
X-Gm-Features: AclHuK_VX2ubiTysv0X24u8wuneTTwxFsXgw0xOUKBx-INFSi3U8fbu7Z1lk_Ns
Message-ID: <CAP8UFD2QgC+dBs40=En9sgg=dLKfkmV4ejdChYfgGggY+mXMuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: factor out lazy_fetch_objects()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > This is a pure refactoring with no intended behavior change. Two
> > things shift in ways that are observably equivalent though:
> >
> >   - the `GIT_NO_LAZY_FETCH` check is now performed once up front,
> >     instead of once per promisor remote, and
> >
> >   - promisor_remote_init() is no longer called when lazy fetching
> >     is disabled, which is fine as nothing downstream of it, like
> >     is_promisor_object(), needs it in that case.
>
> Yeah, I too noticed these while reading the patch.  The latter
> change may be a very good thing, in that the calling sequence around
> promisor_remote_init() seems to be anybody who needs to access the
> promisor remote information is expected to _init() the system
> beforehand.  If it were "call _init() once at the very beginning and
> then do random things on promisor remotes", then moving its callsite
> may have to be done more carefully, but with the "user makes sure it
> is initialized beforehand" convention, the postimage of this patch
> follows the pattern exactly.

Yeah, I have tried to explain this in the commit message of the v4 I just s=
ent.

> > While at it, let's also convert try_promisor_remotes() to return
> > 'bool' instead of 'int', as it just returns whether all the objects
> > could be fetched, and document its return value.
>
> Meh.

try_promisor_remotes() is not converted to return 'bool' in v4 then.

> > +/*
> > + * Return 'true' if all the objects could be fetched from the
> > + * (non-)accepted remotes, 'false' otherwise.
> > + */
>
> The comment was not quite understandable, at least to me,
> especially around "from the (non-)accepted" part of the sentence.
>
> Also "could be fetched" made it sound as if this were dry-run but
> isn't this function actually doing the fetching and reporting if
> everything got fetched or there are still objects remaining to be
> fetched?
>
>     /*
>      * fetch remaining objects (given in remaining_oids) from
>      * the known promisor remotes.  If accepted_only is true,
>      * ignore promisor remotes with .accepted member unset.
>      * return true when all requested objects have been fetched,
>      * false otherwise.
>      */
>
> The above only mentions half of how the remaining_oids parameter is
> used (i.e., only on the input side), but if we are adding a comment,
> we should document how remaining_oids and to_free are used as well.
>
> The semantics of to_free in the entire callchain is especially
> tricky to describe correctly, I am afraid.

The comment before try_promisor_remotes() is now the following in v4:

+/*
+ * Fetch the remaining objects (given in '*remaining_oids', which
+ * contains '*remaining_nr' object ids) from the known promisor
+ * remotes. If 'accepted_only' is true, ignore promisor remotes with
+ * their 'accepted' member unset.
+ *
+ * When a fetch from a remote fails, the objects that are still
+ * missing are computed, and '*remaining_oids' and '*remaining_nr' are
+ * updated accordingly before trying the next remote. In that case
+ * '*remaining_oids' points to a new array that this function
+ * allocated, and '*to_free' is set to 1 to tell the caller that it
+ * owns that array and should free it. '*to_free' should be 0 on the
+ * first call.
+ *
+ * Return 1 when all the requested objects have been fetched, 0
+ * otherwise.
+ */

I hope it's better.

Thanks.
