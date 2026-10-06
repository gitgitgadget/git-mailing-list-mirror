Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867F37F739
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320009; cv=pass; b=J1IF3kFQv/Og2ULbmfE/BlZZW6k2upX4QbwF/0YicZaPJYFlut2y19PymZYvzDVnCgz//dI+fYcTwQRzT9dgrrlj5RZN1NsLwN9kKawctk1WjSR/cvwGIZ8P09bZVbosMX+oJBr5jIcvN/pR0Pp436Qm866vOtNrGDiRfWL/ey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320009; c=relaxed/simple;
	bh=bUjPt54ZklDa46kYqi7WXXJzrTq3vqXlAXjLJSBsW+U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OlwtNTV0YHZcdZ8BjZ24ddtl7yRQpcDf8k2DNoHfmu8VlwEbYPVZoyk3Anf9wi+pELIj0iBMIkPF1jHipWa/Df95HrrWWaC6rdMqRwRvnT/t0GwyW3H6vO+0/8UxuH2RUO7Gaikn4o/VuVgJ6R3VQHDSL5IVvJ1W1VVe6T6+0RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Awy+AGhd; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Awy+AGhd"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c03744ef27so1206846137.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791320007; cv=none;
        d=google.com; s=arc-20260327;
        b=S5V7rneZEJWR+9ewANfmEoCGvX206VlklP6kluJvaYl0DRTLdaeR2etbvsTOW4CCUl
         VRkyJDvZMRPl0FQ1XDUWtI8+y4wDXwClEtz0v3EdkkiIC+uh42hO7SIwX3uTly+lib2r
         UKZo6RHOXaQtAfuYssAz3C/8e7XaQsJ4ZASYnHZBY7kdsJkO6FYtRUjy+w3Tk09zkwHb
         doPBWI8FP/5G4sPZsDIW6sTWCH1eGT/iVIXQb9qeBHoaBkhXxQ6skqR710hqhaEOHmk/
         4R51Tppdmm6qsQxT9PcAukRvfiwWSnIawPIReU6WdB0J3x1mRZqIFTMy1YA5jSBM+oZE
         GNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=BEdTY69zreYP0BufewAhKfEPCu6PJsJK7lpLW1IE2nM=;
        fh=YDDohotHN5U/HT6QPvOpU8Z/NfOaMCcM2kaLKohTf+Y=;
        b=fy4HEn0OcMNoo5ocNzuFV6ROKFK94rgcDSuN3DfoN8PaKie4pKp3poeqdmxneWV7hY
         lgaxVs1C1xh4LB8SFSNpW1NTxKB3PEIhs8UQt16bMsoUk3nmO29T02K9wY6FuINY1miE
         F1w7Ekwz4u7y2ODmYsQkNGPxodAAdHCt43Cn2uoodvjLMUvkX/pFJFiYBLwzilmxucF5
         Hicb/n/r0eh/XozjOLgXvd7GM3Z5cOeeFZiNoXeZb73V/8SojNEoYf2Tc4dmOPs+6Lwp
         /ROZvHl8PjsypB8NucyOuZtBy8Yj3cSQt3tsWPJlfx8mUyZ/gGSfHoljLvYItLylvbhv
         kVcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791320007; x=1791924807; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEdTY69zreYP0BufewAhKfEPCu6PJsJK7lpLW1IE2nM=;
        b=Awy+AGhdWVswxSN1k6X6OtefV98vVtK9pbQ5q7g6eq4WUE3+95lQRXE+masXF9uErz
         5oZKn+nW1uSl5ezdpHtOLjYngYVSfluYispMSmeaBIMYuuZwH70PDxPaWg2tBbM0U70h
         buSJT0A0863+fBXEK0nEyLP8OYq5CshiJfkvBrLDrLAe3J3UnJwVrlafXGVaklz2MK5S
         lEFsI8XTO7gkai+otLuJ9h/fmULRrHBUufveLKEPnFdcV9R0DsuSGM9Igo4jp/CoMeuF
         NO8OgJWCt4kycFSl4FYbMU0v3d/TVgfjIVvv+W5kFGcl/qv8A+VW5fyyPGr5goXh5wkm
         65RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791320007; x=1791924807;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEdTY69zreYP0BufewAhKfEPCu6PJsJK7lpLW1IE2nM=;
        b=LDpSSN4RwRZPYVuSKg3bJDqs8GAyHU425wsc/AAIMJ+ABxPU/kl/doUzK9/83miDTE
         4t/IEmdM7/MJGPNfwzHLLzCa6sBRJJDva4CD/VmMCGgHWbRQ9hFjrOJ4DmK9M16G4RRU
         AqIXnn4kd0aPfcpfYlmiFLdQgL7SSL//znQFZgKm8MJ2wHAaC3CIkzooJuT45ycb+lgc
         Q/hsQHkjftRPD0HglUxN/SyxcPkY0j+f0JRTUaaL3GBCNkRTBrkeegGFvriN78qpGRu3
         kRGcgePtzieSPUV3b9P/jlRZv0a8z7AP4ibTJu/U+O+nwEihCLnC2U5pCMnB5CRX64wk
         xMDw==
X-Forwarded-Encrypted: i=1; AKwUvBx6yTs5CHlVVPp0T0jYvNogrsPAXUvd4RBl9qdAhLtywVVkGBazrMae/4jHwDfglE2yl8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKshaqSRY+zEfbimkurQmogRbk3CnfUMm5pFEK5VJtvM0k+x/oi
	FuaFwytnuyOwzUfjCKyZgCmt1dfKf1NSbT63U/8KjYLP8Xa2Dqr3MXLh9QJxl8S4i37thiaV1TQ
	t00SwR++5a9dRxyu5uo5behkUaN9lp9s=
X-Gm-Gg: AYBFou1byRhqzZivA7LuLtFtT0guEPtEUEm5Ti+8EucmiU5f7+Qn7LVNpLHuEhyPqTt
	XpbI1s+GYl3YvOc5T2Dl2+6wPl77pjVA9RmmQvawXREnMEP1qvtDH9Dov5CJIOBDPQBcoX+Zl5Q
	iR4fR14M3peOVFuoPTWt3JMGzlgvaOWrYgrFU2NYG4+oyR6HnUbFOE6MCn/d9ZO1tgdtbVBgoJZ
	NjzWeC1I850qNH2ZFcozMv2xI1F5syCx9HGpfoxUsLKWzHKrLM/WwbcwnLZQriIeNrSjT5VOvEs
	9NaV5+90ftQNGtCIWtWSAWw3BrjE5WGKw8XcgWcUMgerSjHYQNMH9qOtN8FnUvKZTDNZhpyPhTC
	LBRHXFbuqMT5VCx8zZHjhvRlRNoLhlrlBcDv2fRibSfoY8g==
X-Received: by 2002:a05:6102:50a7:b0:7b2:cd8c:2b1f with SMTP id
 ada2fe7eead31-7ca36f42a81mr3626137.3.1791320007042; Tue, 06 Oct 2026 13:53:27
 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:53:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:53:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 13:53:24 -0700
X-Gm-Features: AclHuK-489QC0VsZlv0Qwxkhp6OjGd8IA_VrP0Z4qJ3SAcJ1OBFFSRbKUCeGTz8
Message-ID: <CAOLa=ZTHSRmwJgsxi9Fq5ek5wVsFYUHD_ohwSmzWLQjcM3TYLA@mail.gmail.com>
Subject: Re: [PATCH 00/13] odb/source-files: move alternates into the backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b30c35065d32305c"

--000000000000b30c35065d32305c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> Originally, when designing pluggable object databases the goal was that
> the object database can have multiple sources, and every source attached
> to it could use a different backend. This would have allowed for quite a
> lot of flexibility, as you could trivially mix and match different kinds
> of object storages in whatever way you like.
>
> But while well-intentioned, this design led to a bunch of conceptual
> problems:
>
>   - We're now trying to read objects in source order, whereas we
>     previously tried to read objects via packfiles before trying to read
>     them via loose objects. This led to a performance regression when
>     using alternates or when using a quarantine directory.
>
>   - Some data structures are supposed to only ever exist once, like for
>     example bitmaps and commit graphs. At the same time, those data
>     structures also span across the union of all objects, so they may
>     cross sources.
>
>   - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
>     GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
>     backwards-compatible way. In general, introducing an object storage
>     extension into the current status quo where alternates may have to
>     be extended to become generic was proving to be painful.
>
>   - Some mechanisms of alternates assume way too much about how exactly
>     their backends work. Alternate refs for example assume that the
>     alternate is backed by a filesystem path, and that this filesystem
>     path may also allow us to read references. This is not a given
>     though, as backends may not even have local data at all.
>
> In short, there are a bunch of conceptual mismatches when we have
> alternates and pluggable object databases coexist. So while the original
> idea was nice, it does not result in a system that is easy to reason
> about.
>
> This patch series corrects course by moving alternates into the "files"
> backend itself so that they become another implementation detail. It's
> unfortunately on the bigger side, and I'm sorry about that, but I
> couldn't really find a way to split it up further in a sensible way.

I went through the series, took attention split over two days. The
changes look good to me, but would definitely like to see another review :)

[snip]

--000000000000b30c35065d32305c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2130902cb9bdc322_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRlg4SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEwzQy85cGdCN1JPSVJuQTIzT05xbHQxNDhJbVhncQpKS0pkdys0dEdW
MnA5ODhxblNzM2p3b3RNYXJUY3JHZGppNUYzSTJFVE11R2R4MnZQVFZTNFJzTGgyZDFNdVVYCmhF
M3VRdHducGt4VWQySUNmZGFMdm42WEFGMjFFa1Y1WklKc0JIT05hanJuei9LWmFQR05oMEpySWJj
MVlmazkKSE9nS3JUelUvR1RDdm1saHNlbnZodHF2em56ZGpyTDdWSEMzQVJHNHdjOWxyNnFESkJa
OG9HclRiaE8ybU5NVQpyRlUxLzhvakhZWHRtZDZVT2k5RjhuQXZ0RkR4N0wwYnR0VWZDdnRhNzRD
czRTZlM1cFBWWkRDaW9ZbmUxTkczCksvbjdZeFdjeUFpQmVZUXB2V1o4LzZNQUdZQWdYSVBqdDcw
QXFpZGM1clFRV3dtNFRlWUFYR0ltbzhrZVpxU3oKREd3ejFrTlNMZFhZVWtiR1lYdmh2MFZFSVJi
cllteWNPcVdUNlIwbnEzSE8vbCtRZ0tLSzVOTHdLYlVBVkVETAprUWJWc2taZ3liOWIzWTY3MG5l
NHFvT3ZESEVzOGpaVEhkdUhWTWFBNjdXc3pXYXQ4YTE5UnM5T1BVcEhLVVNVCjJ4R3FjQVcxTGNR
RTM0V2xMRDRTSWNMMmZVd0tYbStybHdnTkVNOD0KPVZRbXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b30c35065d32305c--
