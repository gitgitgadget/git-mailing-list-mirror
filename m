Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6E364049
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308507; cv=pass; b=CV5CVz4MpSMzrpUr1QzL8uvaKroQEgeO9rICMxEN90/lbiuJkxOWoQ73m0HUTeT7VuxaqpgYKS7ck+eOvVcE9m0UXWFc5VUMdaH8/NSAAFHZkEQrPvlKu3dvaTMwD+z8+qBApNK6RNWA+ZhPxZD3LQyDPO3Cs5djVQfofNrJ1Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308507; c=relaxed/simple;
	bh=N3XYDvv3KjwmqzixurxHND8feD8NcJ2jQ6ytPzTaHC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwkap0lVW8rb/TTP2X2YwPB/pE1E0YNlzRAswLzYjcmXBSbiUCJ7IWN3X9Dol1ONOdNN/PzXU/1TQCRN7ENTLyxTm/TWxSVPgWGW+u5V00F9YeuIbS5s6vYIOnLvXAQeoC2u2+Gos7hmFW5gDYDBgywwjmhLuaUh3+RS3KkBV30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKsFIgTO; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKsFIgTO"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43a12c2ecedso3304723fac.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308505; cv=none;
        d=google.com; s=arc-20240605;
        b=eqXiUCqVVd2cXVWLv0QNnwUduqG0vOaW+pLvnPdFMiH5M97VkdfxwX/NpKVySKpM4O
         HXG8vQVRkv0pSNMhU+5zk62NSsO7f8K7FNNfo3zTGHQbc5ZIaOLS+lnR+H+th1zhft2z
         P/1oSw6o7mI6o+5u+w8qCptUJuHQoTgepVQWQ3ToPjJccld7XyBTmsLZwQ1jmgRNQIfe
         +fW0/b98RzJakiXhJbA7GUofgX1jRRH41SEsqi4ENYew8cBVpQr71MzSkKbFZrSqDLMu
         cTLfoK9E+GQp7RJIKymYZzA8qnt6b6W+sUkcOKNOC7D6n0jMRHSqdmvb3joQGmC3aeAd
         2NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fIZPuq/V3YV3RgbVVUh2tmAIn0uO43NuHka9CHIOT9w=;
        fh=U5Mzpq6BM0HeBglPd2k2lERDjMI7QJiyWvBhmdSaSyg=;
        b=fajATc9kH+tDTqThTCBSQXCfNYNmcHQCe+P4FxVKk92JKAAEDr6VoYiZeHhBsylmid
         7sxmaPteaQ257qkz+F5fXU7HzlGvoovVC2FpW/19rQZaE6OylfVO1m074IXH8fRHuU95
         rASCqvMIzPVmNDsPIYgKdFs17MJ4Lui+riYxzzVHp1fG6kN5IrAGrWiI4DbKAY8ziNMA
         jzsV0wt6l4nuqydI0xT/COmqv21yo71Q0/NZY9+lzmI+rp7hkhd0jnWse9Pk9Zv3Qh9m
         lP+/8fefcX33HDSCAIguu6643BZ26jv6H1bMcDzqbcxgOZAsha+ExHMFYvsI+WI1ePFh
         uCbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308505; x=1779913305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIZPuq/V3YV3RgbVVUh2tmAIn0uO43NuHka9CHIOT9w=;
        b=bKsFIgTOvX9N/DxoASen7M6b+eVgI+lzt/Gjunws4Z5ysOebYLdM3zorSW41YVAfg3
         05FG3jIS0JwrnnsE+Syp9hr27sCkcI4ETWs4cGSsZgrdsDiXTS+Nc8VswFTlYf+6vpj5
         8ZLT8OgeDeRff5tAGRDohcnfAhw7F1QixDLCmweo3qJ0eMzOGx1sHIqYSM6pHHhTiOsc
         VPQTc3ZkmA722CIL9Op3Y5lsRdj7g3+1/dD1xPkax9TL4btFOfxW+867ei0rWcAo/WSy
         U17sKTKCCeVEUeAnI/vhVzVJj9QGCkUxe90s+9EXsqYclfvH/WMmFckXY5DahcyJHN8/
         TkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308505; x=1779913305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIZPuq/V3YV3RgbVVUh2tmAIn0uO43NuHka9CHIOT9w=;
        b=iRTT3MZyaGued2/QqxeTwg2bDHuJ1PC+pQ/k1chpBnx+1oYkvwMrb4IoARDZKqC3Xj
         YdQLaQhDEEwE519T/imL3b1dLNJ3H39wZHqrEVDBz2bkfKHOZBMDghdHZhv9tU+HSuaD
         rjhm8lG3uR5tSeqHPkcu8NBnYF01hWaByftnm0WVnybBzmZ2nEU59R01FIN5zsuhdY+t
         bwIiL+EaeAVtytZulHuvvySnCVz0yGhR55FnsYOb5BObIkOvYmAyz90hwsCulvppCCrT
         CVoYVycj8W/VR1c3oHLewhBvB64pbnEyGHTZS+BQqrJRva4nF4aN7FNSrIsu8HXcLfF8
         WSPA==
X-Forwarded-Encrypted: i=1; AFNElJ+0EQiQJ8s/UgIXX2wR+Tcl/Zw5pchz6/kcf8ytxds3DVl2xPtcKD1u3T8/eiU5JLI2i0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl41YGUHcgPOLccnf0Yf69hLV+f98AF5s01EHLMItpYnvMebT
	p03TRb4IbP+rbcvw5BLJmiv3mMTCdJ2yx3r1/+yKMV6yCHFQq8ngOdmAofXDAdTscxH82Oo664U
	GNiy7Ivx2T7xUoGxofuiQbt1DSjNQvXM=
X-Gm-Gg: Acq92OFNxYOv75iRRKn0gBILZD0kDEJIXUbaFv0Qr6Krno9LsR7GnGaatx0nPj49cVC
	4m8xWuP/LuToE/JLOnl8Plothvy4ezaETwpXLA8IHABCypmndVcdD5Cy9eKl+d3yI8U3APqS94X
	FzDXJcymDcvP2XYjvjT469is+tLCp8Ci3qIkbkmuMC9tJ7zsbTVYDTX0F523mzN2DLhtCw4NZzS
	vyyqUgIm/gNM49tUPZ3erz76GlhNnurR7X3Dc+s4VNZ9e9kufJvs3EZnpJnyTl48rwap598pmUy
	OSYn5gzcq70c0tWH87ZJ3opehLBLpk5XGA/wlB/O
X-Received: by 2002:a4a:e90a:0:b0:694:9071:b60d with SMTP id
 006d021491bc7-69c94b454b8mr16594747eaf.44.1779308505170; Wed, 20 May 2026
 13:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g> <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
 <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org> <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
 <CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com> <xmqqo6ic8564.fsf@gitster.g>
In-Reply-To: <xmqqo6ic8564.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 20 May 2026 13:21:33 -0700
X-Gm-Features: AVHnY4LtzgDaCKZqd5_8BJnF5Bbk4iEXxN1FSj3qdiNrEMIgMtGXaIKH86kHnwQ
Message-ID: <CAC2QwmLXk=CXNo8+Ja0fL5pN1YYMTkh7XHAUwN1c9VxuFhyy4Q@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, Johannes Sixt <j6t@kdbg.org>, vincent@vinc17.net, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Chris Torek <chris.torek@gmail.com> writes:
>
> > Call it an "implementation note" (or, if you like, a "practical
> > consideration"?).
> > Something along these lines might work...
> >
> >   Implementation Note
> >
> >   The --word-diff option currently operates by taking the same
> >   line by line diff that you get without the option, then massaging
> >   the result into a word-by-word difference. This may cause an
> >   unnecessarily-larger diff than you would see with a more-clever
> >   implementation. If and when Git acquires a more-clever
> >   implementation, the output may change. Note that this is
> >   similar to the --diff-algorithm option, which may change the
> >   output.
> >
> >   Regardless of which algorithm is used, _any_ diff simply shows
> >   _a_ way to achieve some particular change. It's impossible for
> >   any algorithm to tell whether someone deleted two lines and
> >   then put one back exactly as it appeared earlier, saving the
> >   resulting text, vs deleting a single line, for instance. Only a
> >   keystroke-by-keystroke logger would be able to tell what the
> >   human operator actually typed into some editor. Git does
> >   not have that information, and having it is not desired.
> >
> > Chris
>
> I understand your frustration in the second paragraph ;-) but let's
> not go there.  The first paragraph is excellent.  It gives readers a
> clear enough explanation to understand what is happening and stop
> complaining where there is nothing to complain about (which is
> already hinted by the "Note that" at the end).
>

Thanks for the ideas, Chris. Here is my attempt at synthesizing Chris'
suggestions and Junio's feedback:

  The `--word-diff` option operates by taking the same line-by-line
  diff that is produced without the option and computing
  word-by-word changes within each hunk.  This may produce a
  larger diff than a dedicated word-diff tool would.  If Git
  acquires a different implementation in the future, the output
  may change.  Note that this is similar to the `--diff-algorithm`
  option, which may also change the output.

Does this work?
