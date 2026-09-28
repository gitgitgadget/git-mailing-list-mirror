Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C434DCD2
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586104; cv=pass; b=LAo6BGOqVtvzzUjaJVcbkVr0ZL66o9vG9KzPhFS28X94dhpouvlG5gMhdDsCBKWsABNfv4x7K2DtOMdJ/ZPljxd4p9Kjxrzk7VPq2MgyHzfCSTfKUt9gIcDNWVxVvDfHBJ8p9mt9gF6XOlDMqm8fzOJ8iT6FMSO5B9gEWre7ngQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586104; c=relaxed/simple;
	bh=UfdjZTBD8x4p5F15ijp9whC+79JIB4JxZ7v7JEJ7EWI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=od646/X+6aDRP5LimUIHh99MSK/RknkqR6Iu45O+Q02U8mMxoWT2Gcsvx6o78uA2MzJX965CU5Rvak9jzvjptNuKzCiYqqAYUyDu1p0ShKEeJ+4HhbsEA41H620nxnIpim7QRGBEsiIjiwJW9OY501OwZ/4vVx+3Nhu1eVgI2DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agLXYAF1; arc=pass smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agLXYAF1"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cd1d9d65e2so1752895e0c.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790586102; cv=none;
        d=google.com; s=arc-20260327;
        b=B9XwqOCJDq3HbK3ENmcUARfxUrqZvEKa8YCLQas8ulHJdWop66Bxw65/FXyd6CdPMc
         PkPSVq/mYd4OTi6EM2eUzTExD8tEtP2KzvrFeowIiwtnJ/QFaZJzXs/9z46vhG3QR3GA
         h0z01oYHhthbWUX0BC4OnG3Kw3KBfwUwTnUkX4BkCdKcLcpa9w+Wn6jrkXwDKCuq+2R0
         /EpoFrY9imMoREnGwMk1Va+GhJ30UtkIqJjEBZvmcFuUTOnAQZDMHtiyA97bGHR2vk4I
         HKvrTtKSU2unHB2OlaclqgCzHN7oZEKlxS0QptvBbv/fb4BTb7s0ANnxBgfSgQB4J14w
         MKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=UfdjZTBD8x4p5F15ijp9whC+79JIB4JxZ7v7JEJ7EWI=;
        fh=xU0B1hFcg1s7z3sfDv4I1DqDeEfem2l54pyh341YYRU=;
        b=afemFSAof6Nl12RrAS0EbvCmXwKQton21jjgeK+NyRGxivEXgV9oUN+lGKdzUKNi3I
         yXQh5Ekn0UK62oYdv0g+dGQV0avrf1g8kiU5lCh9+T7g/+QDnWbTaDa6pzklfT/MULVb
         CHh3nCq+w/CYPAsknBHTWn2qTIyOocq/geYME7tPX+nOKdFMhxgArq7B7lLErzfsZ2YH
         I1E1jgMVHvOim8z4d/DcEUTcNhobwKOnkkRwQZ0sdCErod2Cr8+rAKJozK3RjjuqaRVr
         Uqn6hpPQvdUTjGL2WtI8ZEOzKdoc83bbrwwKPtKKW8+uEKgPFcki/Ml4JVbtJivzeMB9
         JDXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790586102; x=1791190902; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfdjZTBD8x4p5F15ijp9whC+79JIB4JxZ7v7JEJ7EWI=;
        b=agLXYAF1xm3bPc3HMDtNuLMmDWVjX5lpu1w+N92MBbza2ymDeelbGjgpB2KdGqcN/m
         fWNy6+Ft0n+8y8PW2k0uIeYEtozCa6oYktkmyRtokGSxxJP6cN3OiMSXa2Qwmcln2hoF
         T0HGOJKw8F9yWWHtcsF+OLx+g+6busyxdY6xD3q0zFC+/HL6jN5InTktV9RQs2YJFw1E
         FWj7bDz2LABpd27XkBXksW912p8oxHROi1Kf89apjNBMdBg8rSE1JYqkSgIjIrH4OoKq
         3dA77wr3dj9XY7288iJoA1qSWoMshRUG1Zh6vj3ZE8EqEuzB/fjtb1oxdDiFBs++Y44U
         JdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586102; x=1791190902;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfdjZTBD8x4p5F15ijp9whC+79JIB4JxZ7v7JEJ7EWI=;
        b=GZQ3MLwWf1LDzz+jUwJAMrOWUt+VRLarXrkT63VGcrDu98MwDzd00ETWAzBBlDEQ6f
         S2q5rjJY5+wL+uxUj2jCyKopiu5jSFqelgxoHgpIuBS3fy+HgfUaT0OdB/JfRC8llwCa
         zd9+HocjE1eAokOumns6Vtazj9t6Dd/XEef4/15nBIHr0UEv2KVnZL3O4znBZPFqA2K+
         U+w8xYo+157dVbJh67U7E7j/iB1ndTssreYzg00CKZVDcL3T2zIiZpp5ZsL8d/JR1F8q
         UL7qljVyLM0Q7bDgZlXlpim9vQGMYECO99NMN5wQNonaa/QHQ5b17LTG+IssGr25xTsv
         FK8A==
X-Forwarded-Encrypted: i=1; AKwUvBy0uq5jYywBrSNFSyqEd8UMgO5wTNz65QWltcqEGfmFL+nqqtOpyZjZ58waMfBeUjfdTqU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO+7ZNHJRu9CsJxhgVkaorxTNFsaVGjuuy3Rn2TT/j5DhTtb1h
	Qjei2GmHO3/EAvlCYkikQL6Hv95Y098FupWZMzeZYOPYH6jFUnRg9DYEvzJwJnUwxXoE87/Ab+R
	Br802mOSUCvikrQqYIFj6LZu0kEUYVBDe+A==
X-Gm-Gg: AYBFou0mqlo1yHi+267qg/XGGtyDmi/H2E9pYV7GIRfv56Yh1SdjqDvYjhb+iQJQKU2
	UNPkNDYgRnBywf+e5rT4HG3r661OeOjpOL7N5FIOPT7/PVQ35gywmCUUrNt4n/dZ+PB+DAgkMUr
	nK3KDhfjFYBFq+0jfdFGFDDFbvLv1AEqWuujj+e5vqvo842H7DOk6yd+YvMsofgLIhsrDcl6I2d
	1ELRu8teLSBIv3OrH1wotbAXTNwJS7a5/rbb5dg6pMNs0Ko7oz16R8IuxWl8gKtTbzHh00iHBUX
	iC4DwYwK0U6naBYI5Uxkxpl1jLavGDTrh89lUhbjsG8mLd4OXCPRSb0FAaS4Sw1lHEGGLgAdppG
	omYUgE0pp3x1d1rUCoq+M05YEKQHqqr9UqHhcg4Ez2E3F
X-Received: by 2002:a05:6122:3b8a:b0:5c9:a60b:e5b8 with SMTP id
 71dfb90a1353d-5cb0b96d101mr5667368e0c.17.1790586102083; Mon, 28 Sep 2026
 02:01:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:01:40 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:01:40 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-1-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-1-11499557cf31@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 05:01:40 -0400
X-Gm-Features: AclHuK-jXqQfV2tmayHJra4RVluiZNyZfHztxuudm3depxvMs-k3pn9mcDAAH9Y
Message-ID: <CAOLa=ZSxnDLBK+ayCWd3PJ6+3NcYzWCUFdkcnvx8qDBcaeODYQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] path: drop useless `safe_create_leading_directories_1()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008e1084065c8750a3"

--0000000000008e1084065c8750a3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `safe_create_leading_directories_1()` is being called by
> both `safe_create_leading_directories()` and its `_no_share()` variant.
> It is ultimately the exact same as the former of these functions though
> and is thus quite useless.
>
> Drop the function and inline it into its callsites directly.
>

Nice, always happy to see '_1()' functions go away or be renamed.

[snip]

--0000000000008e1084065c8750a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf85abfb4e879efe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xNkxQSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMCtMQy80dzNseUNPNlRKUUs0VjR4MHJ3VnNKWUw2UAo3elRaUHlvT0oz
OXBVaXpXZ2lEQnJqQXh5K1hrVGFCOWRCeTlJallDdFBPSUY1aVM0TEwwT2Y3c0NYeGlHa1U5Cm1W
VGpydmhHa1lFMGdXem1hOUpiUFBFSXp1ZlNxa0hGYUM3dGlKR2NESTlqbDJkdmhVZjRMWjg3L04r
K2R5cVgKZEZhWXBqRzV3N1lzUk5zdmQwTDVxNGkzZm5EMXptTW95ZzNaRzB1em53UmtQZkxFRzkv
N1cwaDFjL3lOM2VzZQpmckRMdDhUV1ByRkhSdVZ5dDFPeDVhSk5HNFhoWHpWQyszR2hwMzgwL3Z0
T01yNmdhVkV0QWJGRncyWlZKUEJnClM1ZXcrWUJiOC9XbWV0MmJJZ1h5Z3UrS2pXa0FJODlndnkw
bHlSSXdmOGw0WE5mUkhteXdza0Jtb3I0a1ZwbmsKeDMvRU1ReHVIRVlhTDVHRUFFa2lKSmRadkg4
RHJEd294bTVCOGRtTXEwb1hZcGIwZWV0cmpPR3lPaFpDOVFEeApPYUZDU01xSlJXcGZKTGk0emxi
MTlrUElzSVluYXlKWkU4TXRJWFZaTnJvRDYzUit6bHdla3g4LzdjamhNTTc3ClJab0RMOUIrZ2s5
TTlTK051UC9nN2R6ZVFleGNleHJQOXozcCtGcz0KPXZFa08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e1084065c8750a3--
