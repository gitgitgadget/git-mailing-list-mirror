Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1051E376C
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777771; cv=pass; b=bSS41vDfvJYUG/tbM9lI3lvwsJGfcfLDa1mU1VvWVh6JCoAuFrNztSlTAM4aZ7D5QCqlG52J0N3de7lLowLQNnFQ2InbUj9RgUczj3w1cFLATMRGuuCnQuuaqQhVqEkoiphFJNVnYNN/q3qWVCb3ZUPEMUMzzeCUK0u2s5kvms8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777771; c=relaxed/simple;
	bh=C/2NkqygKj9Y+HXi8mvJkUrNd4pWQ0hHjvi4Z4w3vQo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic78XAMo70Tt3Y4FQFqYnPxJo0fs7yBICd+IlkxOs867mxoEaeL9fAFJYcl62+8mUb8uVi5EVGIZfAFVNSpnZjcxuhVv861FCmLHCF97iDf33bwTFigTeedSaaRXVNObtil709Jz8TGQSFyu6amcHHLFgRz1cZUaiEIYKswequU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3NrHpuL; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3NrHpuL"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6102bac3752so3140672137.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 06:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776777769; cv=none;
        d=google.com; s=arc-20240605;
        b=lwuKtDp1muxs+PNBJgz9CG7VuI+Q+Yt9wdapzju1FzpywFG0qPEVppBIZ50DAyB517
         UWThXuLN273Eq7ftfiL9qBFSMQxyTdhficSWug3n0Ddtj8v2xW+xJ8SoT5te5vVZZ+MC
         2NX5f297iypp29JK2lpFRGsbKnqj3+D4JXRSRlHKSfxGT4A5K9NiRVbnHmkbKOLsJ44/
         N4OlASOd4NyYTrhxuSKVbbZVHaNiXp9Ktt8nrK9Nq3ZjtEqruw3W7LEuYr/yRI7gnKdy
         am1k46JkktIuahqLQ5jRf1QgFiSGOj6+ADoixzmJORiGh7w1BFEw7+RsSOsbiu2TKR+q
         TazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=N1+fMIGddg47nw42ht7eWfdSINWQHE2scQOC39Em7yk=;
        fh=cOxbKG8AeF+aLUK9mjYpQk/iVEAL40kEniqv1xdBC+E=;
        b=WL5HDuACTrAGV+s+GJCeUBFPvbK2h/M7iau20YxCJsBwEdOjldkg42CCxBUavXxbkE
         bmIlUI9PLMeZ813EP5nnxeOJjMjqPlJcxbKd7o9Mq5dbOHtN+Itjtfa1jPj4ouZGEDuN
         K9gtJdcJ6UzT31vvY2aqGZWCLJr7TkqI1ZjsShc7tI6HFQLTbMLzFEtUeabf+SdHwXMk
         FtiymKno5oM5dFQUiHMvG/j2Mz6CINui9mXKZVSWPP7T5gVZ+aQqMP+HczukGgXbR29Q
         KgTrJO+0KyXidifDkf4o0OO3W60OF36Cpe5/SDDiJ+atgHo0Qi5QC8ypDnAhKP4RRHIa
         dEHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776777769; x=1777382569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1+fMIGddg47nw42ht7eWfdSINWQHE2scQOC39Em7yk=;
        b=P3NrHpuL09HAZn4/ra/NUwCUl9xUIMVwZy4jkQTS24eBHkccZTmC3gd+849R3IQnXy
         6ht8UGqDTQlyiMnYY1DwoIgHe6VPWAsNZu20p9JGeeVJ4cvQmicuaCkQexuieSW3RMWu
         DbV3Xr7ApOfO5ebgBGWLXY//Xdy3Ww17ZxQlOgAwOdR8OTmca5itbNB5bMAltr7e6ILF
         bN/+MGbboxSuaBGV4lVs/EpfOb2Td63t7zsU2xSHalU3+ogckx7RpOziCxYkTJjpDOSi
         RPI9yQFAJhlUkvYkf+UoZbIiCQSkt59hvE0jOhmDY3+BK51miDW09WRRi3vrs2BrSA5e
         4b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777769; x=1777382569;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1+fMIGddg47nw42ht7eWfdSINWQHE2scQOC39Em7yk=;
        b=Vr7cUrDxjzCV182ox7I5qQgnK/ZhhuO1Z/WcNyl2La0OVbgpELC0JtFhyiCwHsmxwK
         m0I3NNzIXGCQPinx0SaeI0BC36AwtPMQVc882UJRofW9iMvXtfeKwFLwwMS9KXfYxnJr
         TWLFfery1jEgtQySsdJBkmW8DXJytYn89C0FCTObo/QXJOQmZvT6i3GRCJqr6l7AR0Mv
         8lLa3LHjjfM1L1/Kvw7OsOGBsNkk576ESqqwtMiesOulsEE9T67430MKG6K5Nf+wqvO9
         JemvKRpK/kEXK/TT1fGCRBkWcjpB53uA6wYvZPhk7IRTzC21RMxZ5cXNd4FwgsHb8DWX
         7U5A==
X-Gm-Message-State: AOJu0YymP33Z2k1Tul3cr/arGUmdWsu/J4M8TTdIY6WIXj788/hGWeea
	XF8+0LpRGLPk9EVXZJJBb4sWNNFgAw0eELwfwUHByDB/I5GujQAMd/Np8VsOp4e2+m9GT4BhKG7
	tqd2NHB0qWmTzNUShzMizsWoSt4/qKo4=
X-Gm-Gg: AeBDies3WqUjo5fikwuni11fnSvZbFLSbjt2EEucwMijk/9HCUCKNKgNmwKY8vGCuhC
	ZJsNiybat/o3r1/jRzdzZNKsayxmCZ4JZXfn2BtN6myHNfYWdJNTHANgnJvzk8BOSljLrEaEWKb
	8ikRTRiDLu6CRSKP9dHcNlKzOv5zkOJ3jkc6dFVVcrJZrdqyYSnsdTFjonsfzFAKF+iLlGWg2vW
	fVEPGKFAtKbRJIAyYE64giXJImIN12nZRsVbR1gKybWCUlkvd9iyrLKI1QKYkhUKUSPIMCHw8lZ
	vNH72HX2ey9xyFyh
X-Received: by 2002:a05:6102:3e1a:b0:606:49d:1861 with SMTP id
 ada2fe7eead31-616f772e6b0mr8535420137.27.1776777768597; Tue, 21 Apr 2026
 06:22:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 15:22:46 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 15:22:46 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD2vO415UfEUw34_Whh3bTG0ECV99APH=uaDyiGLiNq1yw@mail.gmail.com>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com> <CAP8UFD2vO415UfEUw34_Whh3bTG0ECV99APH=uaDyiGLiNq1yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Apr 2026 15:22:46 +0200
X-Gm-Features: AQROBzDWkLFVGmv7Ugl5WIin5AwIN0WTnknQDWHEnXklV_7mllmML8JQKF5tXJ4
Message-ID: <CAOLa=ZSj_fmDNo5bgtYeRs0piCq+QR4aydDtRsqK19nPnDFvbw@mail.gmail.com>
Subject: Re: [PATCH] refs/files: skip lock files during consistency checks
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000be2a4b064ff84f8c"

--000000000000be2a4b064ff84f8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Apr 20, 2026 at 5:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>
>> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *=
ref_store,
>>                         strbuf_addf(&refname, "worktrees/%s/", wt->id);
>>                 strbuf_addf(&refname, "refs/%s", iter->relative_path);
>>
>> +               filename =3D basename((char *) iter->path.buf);
>> +
>> +               /*
>> +                * Ignore the files ending with ".lock" as they may be l=
ock files
>> +                * However, do not allow bare ".lock" files.
>> +                */
>> +               if (filename[0] !=3D '.' && ends_with(filename, ".lock")=
)
>> +                       continue;
>> +
>>                 if (files_fsck_ref(ref_store, o, refname.buf,
>>                                    iter->path.buf, iter->st.st_mode) < 0=
)
>>                         ret =3D -1;
>
> This just moves code and associated comments, so the following are
> probably pre-existing issues, but still it seems to me that:
>
> - "do not allow" is not quite what is actually done. There is no ret =3D
> -1 set for example, so if files_fsck_ref() succeeds with the ".lock"
> file it could be allowed, or I am missing something?
>

The intent was the same before too, we didn't want to ignore bare
'.lock' files. Then, we raised an error and we'll do the same now. 'do
not allow' is a bit confusing though, will amend it.

> - a filename like ".stuff.lock" would be treated in the same way as
> ".lock". I wonder if it's what we want.
>

Good catch, we only want to ignore reference lock files, these are files
which have a preceding text before the '.lock' text. We could simply
check the strlen of the path instead.

> Maybe ".lock" or ".stuff.lock" would fail a check_refname_format()
> somewhere, if they are not ignored, but it's still a bit confusing.
>
> It seems to me that either:
>
> 1) we want to ignore all files that end with ".lock" as they might be
> used by some tool as lockfiles, and then:
>
>                if (ends_with(iter->path.buf, ".lock"))
>                        continue;
>
> is enough, or
>
> 2) we want to check that all files matching "XXXX.lock" correspond to
> a valid XXXX ref, and then we should not completely ignore them, just
> ignore their content but check the XXXX part.
>

This would be the most idea solution, but practically it gets
complicated. The lock files are created for all reference operations,
for new references the lock file would be created before the reference
exits and we could encounter such a state.

Also there could be a lock file created for a reference update, while
the reference itself is packed.

So to keep it simple, we simply skip/ignore lock files.

> For a bug fix, I think implementing 1) is enough. We could implement
> 2) if we think it's worth it in a separate improvement (with perhaps
> a new "staleLockFile" fsck message).
>
> Thanks.

Agreed, will modify accordingly.

--000000000000be2a4b064ff84f8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33e2e27da4f85500_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ubmVpUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGFlREFDQjVQenZ5aEFiTmkrbHR1aC9QVStjVzJNWgo5R3VmUG9Eenk1
WUNBTHZkRkpvRzdEWjBkc0txK1dVaGtmZW1FZ0xVODd1RDd2dWVrL0ZYT1c3eHM3MzRldVI4Cnhs
Y1ZsclVLUDZVTkU0VURmUXN0Qko5R2FPdDMzeFJNbXFBZDFZUWtSbXMvbUthS1o1cmhsWVpHRDdy
Ry9vZEoKQTRTeFcwSGcxWGpHMCtEQ3VFelNydlQrVlBXVnppMzNzSC8yeXM2ZEpaQjF6OFp6T3ZW
Tm5pZzhVeFZWUjU5RQpaN3pyUjlFZjRGNFk0aGw4amd6T0k4Sm9YcGo1M2d1cDJIbnZYK2ZxNFNl
VmFSemFidUNMSEFVUU1FN3RrY0ZaClpXZUlUMGk5V25hMEFyVVVMWHdaYWQzTzd5VXFXRHl4Wllk
ODQ3cCtVU0sxaVJnK3orTlB3TmEvdUgwRjNOOUMKa25OVUNqWGNjZ3pXVk1MZ0xHUGpvSXk1Ym1i
N09WZzJ4TkVUYkxNcnRvV1IyNll6ejVvem9EVHNDSDVDYnc5eApXUTVQcnpYak9OQ3lRdjJSd2pV
dmg5TWRTMnJJbHdKYUM2dURQYVlzWHVUd0dUQTFIL1lJV0RVMk55cytQVUdVCng2TU9jWmorV0Rz
V0kxY0lqeFMreVRBQjM1cGFnUXdxWkpDWWFpdz0KPXU5OUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000be2a4b064ff84f8c--
