Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E473101A7
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873960; cv=pass; b=gXzK1UsQHgUBtV0Nj5wrdQMBsn9Grl5VPTpRa4ki6oeZFPefZhzQ7jprF6pgmfeBsivoBtEojwq8iDUIv+2Y8emUUfRxvCHnVPryj0XrTu0ImNRWVtBG6zHsLbAEaM/035LHGyJ4o5mJcbL2xFrQitZYAciCvZiWJoYnmkOIS9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873960; c=relaxed/simple;
	bh=ckR/gfsNotNQO6D531WXpE7p+hSfDJXihDcCHtFugD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uClwUGTX6G/Ld1hlaARBSeDAg9uczXVGiToqkx0QLR5yrsCoQJ0viOo4cVR6zLBc5ghmQH5Qwm0ybgki8M1Rz0Lu73HBGcuCmDd/VQlwGdSLKcnqm4LFvHWDawTbnWzdBIci8oOKCdN4RM8QALE+TUxQDWoiVaBs5kniadnHhuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbfqJipb; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbfqJipb"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93cc19d8d40so14848585a.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 23:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791873958; cv=none;
        d=google.com; s=arc-20260327;
        b=BaKQbl6zg/W6jYVbIVNbEEuJ/h6IvXv18C+9fVeBPY4145jui7uExfWtTUpbG3QYkK
         yQorF3i4T5/OBBfelq4foNnZmxjOEIZfHE/xfSyooEnlrhxbdKZmxErXZI4Z615T2sQn
         ZMg4gkuUDCZU/QAqeZ1e6USSBT1y/9rYEVWh9dxrFp21m1BsJDLPoH9Ju0Nml+o21DzJ
         WdHDtNaJFK2hss5a+ojTLlDSYbJ1xFV5nqUa2mI5eAUKmg4nncW6Kg1lS/zSES7iXCwz
         CCOtrl0Cal6gnWyFFd1Mu06Nz0uo6xLjPlaqpEx/OkDmJmTsjGj5feToZ48uv2ulCnox
         YYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gRPe9CJbm5VrbnV/fmHIC0Lv455DNdRbAv+ACG0IpA=;
        fh=GXNYqO2WufVttdr60JNmAXkE5Clt1o/AhPQ6w0DkCmA=;
        b=Ua9ObsRTeQHy7LWZtx7lQwsMGgJNmbs9/olbdkCaFXM/fuaCvNaITKvGnbwpc6ncyx
         LaB04iV9j9592heQbOqyHVVdYFqlKqGBPdvQ4XvhSftVzLf37KcR60+t2VSq7s0r53rI
         V/C0jjUKt4IeV88XiY7203rRzv4EKP3MnaXoiZvm6/ppcSrTgSHfW2lgzMtYPzPxT0XU
         yL5o1oP/PWBZ90OB5WpsRIJYX0LfAZVFeCpZmcTXVQB5cGjAdaUWl2//O/ywDjH91Mo9
         nS7D2k3PMEbPX6/b5s4QJPBhdij+kumTwtG2bjc3+XWYWpuTwYewY7wWLjsPc7Yhpt7O
         p6Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873958; x=1792478758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0gRPe9CJbm5VrbnV/fmHIC0Lv455DNdRbAv+ACG0IpA=;
        b=KbfqJipbSWlOICqcCBf0EHKkO0NDctU5VxK+n24nAJ7zNEvETTSWdFSGjO1P/GeV19
         6XzPuNvofwZOBLOQnBO4CBzhhQVtFsTl5uSnhpbQ4EfR94IBXWkFXi39ng1f/CIqMuOd
         xlRPM57XPOraseboTstWlV1fQWqJBf34H04WEVFQGzBuX3A/6Brii3pbzBUMw/w45HHd
         pytnsAWuhoHFUzKwacmio3OZwbVRtqxX04/aOJW0nMRPb4a8+596nENk8RwiiNiJ6Ai5
         F4H2uANs6bOrEpLnZKHYYtN2BrFumqBYiDWABPBmtdzbbuYIARTnHBkp2K2xtoHbObUl
         yo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873958; x=1792478758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gRPe9CJbm5VrbnV/fmHIC0Lv455DNdRbAv+ACG0IpA=;
        b=T6ut4XWmy2GaZR2S0GjQm/Bjqpw6S/uNb10C3zjSBMLlytAZEONT2eaAOBNwzRZIae
         /yk8J+uK0ZTsmfrgFQPgASH+WvzWzundBhJYMV09z+EX+KUfPg1SPoAM2YUILTX27zHb
         dCvXEwPUeYTgyzHJmOz1FixX+2B3Blx9grUqHn/ZrZ3Ws7P0g8M6gA/nKODbPyA3hVn+
         Kar2MeO9PPbluQFu1ItxtybdS9xy8i43OAuWFb9brS9Cr5ue236vQgettNtlgqkikYPB
         pUMEgDwY+bBYfszydhQQgRpkhlG/f02UQ0/V1PmEOgbbenA89rubVcYzuJ9+net4Sr7K
         s6vg==
X-Forwarded-Encrypted: i=1; AKwUvByFb+8e7N9290nhpu/WURR/yGc4gG0VK9yPvD2UXPEVuEnn+WiGHz2S6fcr4HpEkQY+UwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVztOdNmNqjs/g2W0eY84MwjJmp+zJaLbgrzHxohDPDk20RudP
	1gbVgVh+WS1ZxEPrEQPurKS5mzCCX7Yogkdv2bXUOXtk6zjrNh4w96Gv+s4kbbwxluU80ZLh7NT
	hBur5AhGGIFT8fHhGYB4fLedsm8An+ZY=
X-Gm-Gg: AYBFou1T0/FVCgtjRaJs3c5mGLRJX93YDj1DFp8EcOXgtigVn8BuFidU/61txFeJIzU
	QkgVsTT6BF+VVGrnxTCN48hvtYoGzDmVCyomVpoRCuvOqOkDW8put4qaGfpXQ/Y4I+ay6r4djLj
	Hvwi9fIxWSpK6f74pjpGnn5CbRTnz5dLzlSyiJsIA0ol4tkcbdAask3Mq2sD6SymUJ1FDnLNl5g
	038P++sRVdzl9ggCAS0t25+y0vuf4IkIOng9Rj4Zv9cG7oVvm4P/rIgu00uwtLKTGx+UpNn0oKH
	CeQcQ4INOTlQ26qoqs6UZHvkO4+gWbCv+wKouj60wmXuFn/9oqT0AMpCcaiqErVu3Nef8AC8tQ0
	PQyShumg3uZRi223Are3Ke5yVj2nz5YxvJSfPspxuzMPShg==
X-Received: by 2002:a05:620a:254a:b0:93e:5ee9:ca87 with SMTP id
 af79cd13be357-93ebd29bf3bmr2180912885a.6.1791873958206; Mon, 12 Oct 2026
 23:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm1no29m.fsf@gitster.g> <20261012175638.3712-1-tboegi@web.de>
 <xmqqik3668ff.fsf@gitster.g> <xmqqqzhu2xre.fsf@gitster.g>
In-Reply-To: <xmqqqzhu2xre.fsf@gitster.g>
From: Curtis Smith <curtis.allen.smith@gmail.com>
Date: Tue, 13 Oct 2026 00:45:45 -0600
X-Gm-Features: AclHuK9IKnnFqTZ2iXVq01po00HjmXLwpm4TM10BhA-zRw9wVWhKqnePW6BbKAY
Message-ID: <CACnh8r+gBPJMF6kGdzpM8guEp_UiVh_P6qpvKi8uLCx6MFFoRQ@mail.gmail.com>
Subject: Re: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when
 conversion is active
To: Junio C Hamano <gitster@pobox.com>
Cc: tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> If you two are collaborating outside the mailing list, that would be
> fine and I would have no reason to complain.  But such collaboration
> is invisible to others, of course, so I would like to double-check
> that you are not unilaterally taking over the topic.

We are not collaborating off the list, and Torsten did not ask me
before sending v3.  v3 is my v1 patch 1 with the optimization taken
out, but it keeps the size_change_is_conclusive() helper.  In my
reply to you on Saturday I proposed the fix inlined into the
condition in ie_modified() instead, with no new function.

I would like to keep the topic.  v4 follows in this thread: that
inlined fix, my tests, a short log message, and Torsten credited with
Helped-by.  Thanks, Torsten, for the review.

From your earlier message:

> Wooo, that is surprisingly simple.  Even attribute look-up is not
> free.  How much overhead are we adding to the case where no clean
> filter is involved, I wonder?

The lookup is the last test in the "changed & DATA_CHANGED"
condition, so it runs only for a path whose size changed.  A clean
tree never reaches it.  With no conversion configured, "git status"
on 10000 files with a size change takes 26ms on stock git and 24ms
with the fix.  The full numbers are below the "---" in v4.

On Mon, Oct 12, 2026 at 7:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > tboegi@web.de writes:
> >
> >> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> >> ...
> >> Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> >> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> >
> > How is the collaboration going here, Have you taken over the series,
> > or are you two working together on the topic (or I take that your
> > intention to CC Curtis is to work together starting with this
> > version)?
> >
> > I am wondering if we want co-authored-by or similar when we lose the
> > RFC status.
>
> If you two are collaborating outside the mailing list, that would be
> fine and I would have no reason to complain.  But such collaboration
> is invisible to others, of course, so I would like to double-check
> that you are not unilaterally taking over the topic.  Can you
> confirm that you are working well together, or say something
> similar, before we proceed to other technical points?
>
> This is a tangent, but it is the reason why my mailer settings
> drop into the trash all incoming Git-related messages that are
> addressed only to me without CC'ing the list.  This forces me to
> resist the temptation to collude with selected others behind
> closed doors.
>
> Thanks.
