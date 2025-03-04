Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F145BA2E
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109758; cv=none; b=uEPo7PterL4SkBSR+DYSHlYCDHBEhQFvVcK01ljldM20F4AuMVtrv6ZMlDXlUSISHhrWpBujdYB+wYTZW/CFjaFkA2BGgBrVV3aacVgIFuwRoFHnxiFjB9AJ0HBEjKTaox+3LGLARSgmzTRjsJcnVNhca6WOa18x6z7hujh2R/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109758; c=relaxed/simple;
	bh=Kw8EdvnDNDyeeG2K8QzAQ0VcLQyoQSeRGRq6/ustAQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLig3Fi5te401Nv0hDEcISd77T5j9nnyGpct5RNaIkV1zHqWK8yj1SxahWOoRHvW5MkqHea1n44lqE0A68Qt/SXbC7+iDrHDZwOOAOFU4QZjgV6Qf4h1lFBB3ACOvYKdKjUdarozP+vpqN0M3FkJGpT0hgs02nwl2wHKYUVLOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e890e0ebeaso9213156d6.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 09:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109755; x=1741714555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgphVZ+9XHYiThgfXy4IvUK8Svz8NBIodhnMaaKgi5A=;
        b=EEYGeu+r5SCjP3GFjzVqUGQ3CeW/8opxzwBDUf44xPkF3U4kfM7u1MFsKtGiA0GJAq
         e1NCNFAUpTNJ83MXy1b91bwC/A+kHLd4LEkv6ejOpQH0snRiCPY9Cq0XQe3Ik4eqxVaZ
         d3k7Wq1WwcNQDZ463lpqq5zxsRpRMK6XBfF2z13z4GeInugoZ2wUZ6VQiI3V3wNDzFKP
         sV/2MznkhVqqlR6nYNWMDebC++jNsBdUai1DcX/AsLZdNjsaWh/g/Ot/2zIyP6ufpPEr
         TzscBSAQbelrfQ3X8ZOmdx9XLXDMYq29ilDthZUmElCORnhf7E7y+ElbfSSzAA7EbP07
         iLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXn4RH89ehiZYXHnViDx5Bs4wyZ8M3XlYCnMuq7aX7RpAJ6WIAvDImIgc/URuZN80l8lKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysR05lddcfriZnDiSWVL9VSM6P3dI15lS+NSpWXGFuoz78QemP
	t0I9yWtKFgtY2gkcPpDtdCDoPr9DaKbu3S/Ylv0JAfjg8F3J3Ka8p1VmyRNJJ575O7MrR1Obs50
	9k/nScxin11p56WUYZuJajdJVkis=
X-Gm-Gg: ASbGncubgqj8g6FmQgaeHhZRk/hM5wgGVs9NZnbfyuKkGU4LafctpTW8Lv2VyF7tItP
	3yROtkxCpDloECPgebsNu318R/jQj6v0lKhJefb49+Vc/CUa4Q1UCYaQdTC5pSQOu76RRdEergM
	uLh7dvTotgG3bFxdvNbqmshoYJAe7yv13cmFLgmi5FWNIXgBHkbMRAAsXO3H8=
X-Google-Smtp-Source: AGHT+IGFrsdJYDbAfgxeKoBZmOl6CnSrD8UhzSaXurMrOtaFe/jdz1a5npfogJK0DZ/UDKiw6SLH2ZFsB0qD0KiAPZc=
X-Received: by 2002:a05:6214:3008:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6e8e6cfceebmr746336d6.1.1741109754850; Tue, 04 Mar 2025
 09:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com> <xmqqldtlt304.fsf@gitster.g>
In-Reply-To: <xmqqldtlt304.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 4 Mar 2025 12:35:43 -0500
X-Gm-Features: AQ5f1Jq6_DBCd828l3PS6SNNUAFupLC5Qz4GFSJOEEiUbor_2wMc2FG4h2igI2E
Message-ID: <CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 7:05=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> Mahendra Dani <danimahendra0904@gmail.com> writes:
> >> >       remove_object() {
> >> >               file=3D$(sha1_file "$*") &&
> >> > -             test -e "$file" &&
> >> > +             test_path_exists "$file" &&
> >> >               rm -f "$file"
> >> >       } &&
> >>
> >> The refactoring is true to the original spirit of the preimage indeed.
> >> But we could also improve it even further if we verified that the path
> >> not only exists, but exists and is a file via `test_path_is_file()`. I=
f
> >> we decide to do that we should also explain the change in the commit
> >> message.
> >
> > I will improve it further using the `test_path_is_file()` helper
> > function and change the commit message in v2 patch.
>
> You may want to think about why there is "-f" there.  If we remove
> it, do we still need to have any check there?

That's a good question to ask, but isn't the implied suggestion of
dropping "-f" going in the wrong direction? If I'm reading
remove_object() correctly, `test -e` is being used as control flow,
*not* as an assertion that the file exists. That is, the expectation
of the caller is that the file will not exist once the call completes
and that remove_object() will return a success code whether the file
was present before the call or not. By control flow, I mean that the
function, as written, is the same as this more explicit version:

    remove_object() {
        file=3D$(sha1_file "$*") &&
        if test -e "$file"
        then
            rm -f "$file"
        fi
    } &&

Given this understanding, then it becomes apparent that this GSoC
microproject shouldn't be applying *any* test_path_foo() to this
function. As an alternative, given that `rm -f` returns a success code
whether or not the file exists, the microproject could instead
*remove* the `test -e "$file" &&` line entirely (and the commit
message should explain why doing so is a reasonable thing to do).
