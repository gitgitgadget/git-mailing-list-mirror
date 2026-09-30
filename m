Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CA4C6535
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771076; cv=pass; b=achx6OXIhLm4S1Jthnl4UCe/H8tcWLtLua27EZEHavAAYFBSHcbCCb3PZXS7to4nVWUL+wNXFvKzZASl2hrZ3UQzvp8dZxcSh8sIOB2I6hVUAQThGxnq0pkD164YBZN2duVJBgSsibGKlr4IczuYZ71prAtj60Jy/O+bMYS9Wtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771076; c=relaxed/simple;
	bh=HO4X/WpyzH1ULsK2aieZ0ZVDAJd0HufpBWKUBlhYbSA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLILkMlksuYl4zdKdaGwC1a53tTgkj17/a+0AcV6+eykO+bMxG9BVtGRErbMXPR3HoiJc50qPfIy4O2tKq1Zd/aVfWychgPmp0NcN7WLCXMQOs8MwLEm0YDNhtK3JsEDzkYeBAj9ZgJFN+cVglcC+uscWzlzR0eXK14yAYawVrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLEOxSe3; arc=pass smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLEOxSe3"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccfbaf6da8so1177462e0c.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790771074; cv=none;
        d=google.com; s=arc-20260327;
        b=ryAlfZTs3zS+czpoKNqn9NrA4VD4IQfkh8Bl5/bQ33uasDaVhD47SgRjVVdTJPcEnG
         nj1PMBrr+BM22DsCq+JIX7Tk1Isp1giQ/4C7WJLlxiBmOYC/vJgpmxXPTC/MVozlyIIm
         w5QoJL0xhEobU7jJpx7onkWchkJBQWGG3ym/8S2Jp64vDEghSetc71G6V4jGdRp8Sd5t
         6vG3S1Jc6ol44OFzf7aks2pweZbXi3VeJ0EWWZM9drThp47oLX3Ow1IgMOqlXmo22ThR
         +8btBTM1Fy1PtPL24ZBZnOSf7D06tx/Z/o0c0Iia9vg2WogvlC83+p4h/GpLmmXCYOGa
         Vmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HO4X/WpyzH1ULsK2aieZ0ZVDAJd0HufpBWKUBlhYbSA=;
        fh=pMvtoBRNlG3ejnWNMRWlpfOTh7OAnQ1iiL88wn133EY=;
        b=Psv5Cbr+UlnWayxV0GCQT2kJyhF7tjrFvJJZq4cDiZjA1nblmwhITNZ+umZLjNOuRB
         +LS7QFu1bQmZVUEdAkxXmpoPZAN56LjXWS0OGA9FidR5LFmh6WhTSJXGGlo01a4Qhzf4
         8Kx3TOoY5f0FvvuChcOpNtt1wW7der9BKvdTgPpgOAt74XoDpp3nhOI9KFcGXczg5ZbV
         8dHA06NPvAXquan58Bcae0eoamZFs3ZkC54EuXW0sm7RjHGRSCmOO6Kb1JsXo5f6qOBT
         d6IU1f/tzK8mCSbY44YryxiNwEPozYZY8lofJ1nMYt3XEIe67C4GbwG8ZwrhYIZOpiAq
         MDXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790771074; x=1791375874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HO4X/WpyzH1ULsK2aieZ0ZVDAJd0HufpBWKUBlhYbSA=;
        b=YLEOxSe3BGUGpfJb6bGpKWm8NAvqwzyTCG5e3TbkUF2KCohFPZ883APpTqJnzHLpo+
         MRVrRvKc7jB4z2ChmfJODBJbKFQB2bcQFuzqEFQrv6htoyFjLVDHMLS8j3WDNjonBEgg
         9WL8hT4f7ivP+aw/7MtlcAekXI+fzdGzU7ZrwFVsqeFaT4/XC0pq9trTSjK5e/zm0j1t
         sSMcmk6ElIsz1GpaZmsxgAgoSG0XlULS5uN1UI/poi/7Mo4PsIm6cRmxEhW4VqfAufxG
         l6hISzEnXRO0MpL5I2RHmbojM/liQOwuMWd1MFiEd0PY2ohTcHUeBQCEXB+pAkQr6bjX
         9eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771074; x=1791375874;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HO4X/WpyzH1ULsK2aieZ0ZVDAJd0HufpBWKUBlhYbSA=;
        b=mFRqNiAGa5XC5PQL7EP4PeqWiqIkBwqblhRHwofvlqIeR1dMWyYec1lqScmBTbhCzL
         Mqj7Tv5nsNF+rbqk7Egq2ooqFdhnJtp3DzKpHlZszeHcp4atiqYHvTdzmIb/SQpCSPep
         3+kPJqwVLnzFLuuoyaYkFbRfKy8xmNeVnKvnFHEKZkvyCC3QMZk8MiIDjavcXWwPKK/6
         9dD7xYWHj8x5mKqkeaGbZuzjjxZqteGmnRXMEAkGqz3H24LhahO/eKRzcuuxBqk7sU2Q
         I8QXxKWO4Tqxv+UkBML2ukFmzrxKycqa6QYsOUsNJHdmbOI7uGO8cgL8ZUDWbE04jAJf
         PVvA==
X-Forwarded-Encrypted: i=1; AKwUvBy5qSZiB+UHCPRsbt6t01BBhYX+mJogl1PKKkN99LMD4pclz3eamh34iCxwRi81pXmuYrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/rwII74iuCGqoOxLvBBpeLQBM74oifQx5qjIOa8Ltn8cb+ct6
	WEfXjZ517KSiftbv/brFtm3gzBDQSPkSxtReSRRnm/FAB/wf5gZM+YkZQ/Ro9OcF6rP5xumZLX4
	9pXYhOfT2rndPrenyGnZaWKQd2Zri8Rs=
X-Gm-Gg: AYBFou16SIHVZD1YU0fJdu4qLy3YwvxE9DLkBMuqWfLBjRtnyvEaYOqdf1EXWjVkqaH
	0j+KIUtV7KNG7mkdyccFowYUI3NamDB4AsIOT+3FwT7UXU2KnyG7idApvXTH/iImSHCszcSGi4x
	ScC7JUiIiP2BxTl7CHqr7fM0ItVQFpSw174HYAzUubCuIcFMWgTZdvwcpJP9H7Ctze6dMlJKQUy
	SN09T1gnkjER2tNMFxAavqtqp8az9z6P4wXxdfT+g+ETSgr4vBN6RcddLVSqNX+KvUFEI4zE4+T
	wxF9FG/xA22YNUMymqcsWtBOh7aqrn9FwlaEYorxq34PMevIlKrKQNXND5rQKB7rA6jWKXj9Lxl
	QoaUUXuDSBjuu9fmxpMhFhYaR3bIZ26Tjzd+6Ax107yJ4Dg==
X-Received: by 2002:a05:6102:508a:b0:7a8:e81e:d7fb with SMTP id
 ada2fe7eead31-7be90626e3bmr207879137.10.1790771073681; Wed, 30 Sep 2026
 05:24:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:24:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:24:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im> <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 05:24:31 -0700
X-Gm-Features: AclHuK-g9rRmVxaGVEpM1CFNkMGlH4231zOQAMTignWWM8tY-SL9i4rwNTJ0tFU
Message-ID: <CAOLa=ZSMixcSF3enAPNK74U4Qn93veafvodpiPpgZNJEnP+M3A@mail.gmail.com>
Subject: Re: [PATCH 6/7] meson: update wrappers
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000b8aae3065cb26114"

--000000000000b8aae3065cb26114
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Our subproject wrappers are used on platforms that do not have the
> respective dependencies available. Most importantly, this can be used on
> Windows to have an almost-dependency-free build of Git.
>
> Update these wrappers via `meson wrap update`.
>

Okay, I've verified this locally and it matches.

[snip]

--000000000000b8aae3065cb26114
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 73fb6231cf7364e7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xOC8zMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0dlREFDanIxTDRMNTNTWHFSVVQ2cEpvRXJPbkpJVApFL0trdW1DZHRW
YTI2QXp5ckpDaWZaK0dVdFByQzdxZE5tTXA4LzVXeXNwbkxacGo3TkcwcTlTaUQ5bU40MUswCnZF
VklIZHVnODRZdmNQRHFpdkJBMEs3UkFLay9nM3BZVXB0V2tJYkgwQ2p1QmtQMW9FKzlXWXZwMnpr
NjhYUFcKVTlPdjBiM0lUcW9HeDJQVW5sNjUvSlZjVTdMVmRMRmJ4SXhsSCtMVWorTGdCN1IrZ3c4
akdmYlBzOEhqUUVLYwp3QWpHcEU0UkFwVEZtY21OL3BGTkVQalZaRUE4NzBwY0dxMEo5UFZCeVRI
SGRuLzlPcHQzVXQvUGswVnVEN2s3Citia2NmQXhuY1JQanZlZlNHd0VNOTA0UVRrZWRuV3J2R0dM
VytRQzdOMjBJbVpQRnI5YnBLNjdxRWdHZXlZa3kKb096TVNUWkg4NjEvdytISHZrckJiVWxneVBv
RVF5T0NiZmxDUWRaWlBEM1Z3WC9uUUYxYlpUZUFHeHExWGhkRAo0RWlvZENXM21qRnlmTndKaU9R
S0hLdnNRN2NHaEg1N3NjQXRlcVFSQjVuRFAwYjIvbGxiU0hML1dibm1GWVA2CkJFVDZHNmVzL0ZJ
ZVpsejlHbW9ZdWhBeUJhSVZXL2JuN3VMU0c0Zz0KPVJ4ZEoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b8aae3065cb26114--
