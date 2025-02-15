Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67B623
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624693; cv=none; b=O0riLUmQK8+PKFeNAqhVYU2jb0zYTQI7ze4W7baH8XnkohC4fbUS1jyy1gKakXRHobk7vCVOlLizxADqP4mHsX4fWmHYUxPVbVMc3HlDdg/JUPzioChtdVY+JPyD/F/ifAtXeQx19sCVpNMcmEaFqnABNTKwmX4vNe8eWtCma3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624693; c=relaxed/simple;
	bh=d2GEgGnUXsk6cpANhLLG2JIoSa8K9R/IqyzteRaX7q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1josXFIuQ54MFXU3os0l/Z9shkRrk7YB8HGn65GgFnEVTk+FO5S0tWDhISADTpHhQ1udmTeT986wTuv4gBY+8nvDvBnOgMFBOCfzKN84FAJCVR6j6g7OVpPqi0jy5XaO6Y4W3w3dQF2kd8APHy4SWJ1UduMQKuBkYEv8v6IkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjp+hb+Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjp+hb+Z"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so5611387a12.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 05:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739624690; x=1740229490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/Xmpc8+3RDLRekXgrr+VMnFrTPwFvudCmEZk3VvpZ8=;
        b=Yjp+hb+ZVsZR82d3IXy0AMEFtAclfP0UEHccWKO6uthymP+pQiZOvPDoWh2D5TuhPV
         Xz4EDrj0hQvUaV29SIQgRiOXHNzKh2BoGB7lf6Y7Hnpdh46St754w2sUq/E8Ktybt8Ls
         vI6IMK0cwBFjhdJIALxjM2X+SgLF42PPysPRODAgP++oeZjrpIjnqvbQnODuShW5yaQ3
         CiW8Ns9kBIQ8r4UArCcJUgXGaZ4UvY5jezl1PwQhIRvkTQ/rIqKu2tT4T3YGFrHJA5wL
         XS2xT6LONhPU5AVQ4fFD2qoCHNZsMU/vxwAbKEFZ6SDN3mYrzHmL8MtK2/Uf/+AjrK+J
         fMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739624690; x=1740229490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/Xmpc8+3RDLRekXgrr+VMnFrTPwFvudCmEZk3VvpZ8=;
        b=jkTRApBWWH1AvJhT6217j/JuwEiDFGhMUaQDZQZmsQqj7gPOWLMQQM9Fbj+CcnOCBW
         mpj6iw4KJ2z631qoFAJx+g6ZFLfr4VIRCiIjbgeHyJsCiFYr8o7n8LGAnc38hrc44hX0
         CBmNKf3I1VBK1V1VuhTflsXyHRQmeQ3POIgibU4CoAOp6mD+9DZIHCIxBeBHw2C//YNm
         sva6xqAwwgnusJbngPu8H+z70dV9q1P1SJ/HxenDZMBLY646Ch056aY8SjSX4QXPvL8+
         a1DZ1JGiZlyTlKuBfmL0rFGGHhCHVMlQoJoDcKhK436J49mH7gCiLshQJniKZSBRWpP6
         wwCA==
X-Gm-Message-State: AOJu0Yz6ubOZIRNjXDvTaoIhPu6A0mQkF2f7D2HdOv3V7UzgEFP+h+pG
	VJLTzeY0xbEnz2eqnsQxG8O7Ie1s7uwnfAoZBiLSwvuHpEWL9sJGZWc6iZXijR3ugyID+R0wHP0
	VrASg8VG5RPwWgCr4nbkSaXj1Amo3PqQt
X-Gm-Gg: ASbGncsHSE0IPRzbB+W669AqGijfYz5z21V+ZFKrWQ+czsCpGWfC4uuG7nfih5Pkt55
	P72MacSR1q3r3qtamSde/8mFDuHIYJO54/e/9mjZuMKWl/w31lTWpPH52oXaZSIDef8tRRD7vA0
	U=
X-Google-Smtp-Source: AGHT+IHXPSYh5huiPg+pwA2Lh6IYwD1FDt2oWZpZ+fQynxSc5Yw9UIR0rVMB+v9TnrLrmiSyjEHRq3uggYpgGkIpOFw=
X-Received: by 2002:a05:6402:3495:b0:5de:5e08:babd with SMTP id
 4fb4d7f45d1cf-5decb8d50f6mr10247942a12.11.1739624689936; Sat, 15 Feb 2025
 05:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
In-Reply-To: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 15 Feb 2025 14:04:37 +0100
X-Gm-Features: AWEUYZnsgoGUZpibTIwlfhHebpgF3Wk-EWiOtq0UFp-djoGVjfM0F07it4sbgZE
Message-ID: <CAP8UFD0aZ-Ea96n1Tk9i2dS6ECoCFpyW_FQUVOP8Z2z8_=xXwA@mail.gmail.com>
Subject: Re: free(): invalid pointer, error: git died of signal 6 and error:
 git died of signal 11
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 15, 2025 at 3:10=E2=80=AFAM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> Hey.
>
> I see some weird segfaults on a fresh repo.
> It has just one commit with license files, then branch from master in
> which I have a staged an initial skeleton program.
>
> From there when I do a
>   git dt
> (which is an alias `dt =3D difftool --dir-diff`) I get most of the time:
>
> $ git dt
> error: git died of signal 11

[...]

> The same happens also on a fresh and empty repo:

[...]

> That's all on Debian unstable, with their git package 1:2.47.2-0.1.

Thanks for your report!

This might have been fixed by commit 98e4015593 (builtin/difftool:
intialize some hashmap variables, 2024-11-12) that is part of v2.48.0
and v2.48.1. So you might want to upgrade or maybe patch your version.
Let us know if that fixes the issue.

Best,
Christian.
