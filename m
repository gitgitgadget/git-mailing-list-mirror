Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EE3630BE
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041600; cv=pass; b=E+ZjCf8m7ypFdov/bbr5zbC4EAx5/s07LbaGhK0DERkDhO79nJgVEYauVGUG9pp8NMXfH1Dg2CeoZKZjVCR0of/SosFe7EjSKO4d1D48GX3dOTVh36HB8+siF22UZoGGdmRtA8wS1W/RWYrCYNdV5wF/Q+kjZjvdgWJKOH/nRlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041600; c=relaxed/simple;
	bh=at/n2z+NyuuZevJud0uMt3zqEzRoidz7+C2ylEWWIEY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDsd63ZwhzGV9i2kDpDkUC3OXuSR+zvYgCbw+f3yfoacTTEVXso1LYqlVFYTZzqF1ycDLuy25EycEuvHGACRb/hmYGxhNiWe7JgxoI1OdI2nh9OY0WIOwOAGTN+z4WE79VOIMlTlNPsZQbS0zVJcMJhbEk+DpvGC4qN9Hh6Jdto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzUO1nq3; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzUO1nq3"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso3387265e0c.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 01:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787041597; cv=none;
        d=google.com; s=arc-20260327;
        b=hGqqkk0cUo3p8DkzPVyUjkbJ+rv4eTXSdJQr1Y5bhBdakSxlSCYAQXvrgAStawfENR
         qK3yghhA4v1emo8y5dBm3/52/TiYLVq1RYFzj1rnOW+g5dbSCCr2YJ5BCZkv62nmlT6s
         jCQYP8LrzeqfMa8LKd4VE5dh6abNdfO/1WmDhyfmREoRIFUdsPSElIkqPXNZeQJ/ws69
         Uwydl+FBUCy6qWy9QyrgXpZGEAUu1MyHhAl+gDFefERka2iiKR3gHUrFLb3CS2UHQyJV
         1tfhDkfz0VBit4oKdWIS/3U2SKsfQcKL827zoieb98qYs7tHCbqilkKtPTDqIyfHkFZn
         O+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+YynhsaKv6ONFSWKQULheRPgAc0PHa1TbivC2ti0lMg=;
        fh=wVjIwmG4CjnEl0HZ1hxabp2nhYHURsyWwEWwCn/XbsA=;
        b=VM8IoZP6c3EEPFL7SJlQOhl4I1wvO+NqqARTLgwyjQkeI+BvZviWyWJ911YbwsFdlP
         vNuME3TUWAuA7OBjWj7cF6a1WrE1vWNpXy8b1L1I/pM+zvDvsLfjdkkOpEhSOUv9uxHI
         +SCC+6Q2dnf65fj0NgnkHYIQHbnuCBFXLAiwJkistTFOUkfk115VN91o2T4Ot5K+o0mJ
         Fv/747qeau2FgjaQhsbBR7zkmK9+XKMK1XFtgpgg/nQHM6RkPe0g4f1rg8TbVrTRFS1S
         vM3DM930x2ExxlgAyFnGftfYHzbeH1v3Faw060EhQCk2/p3eBAfCdwcpskRVqzV/CGAF
         8g8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041597; x=1787646397; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+YynhsaKv6ONFSWKQULheRPgAc0PHa1TbivC2ti0lMg=;
        b=qzUO1nq3USFrQKl5F53YFX0xRkQX1ZaaGNhWUlU+j9FfTCm8HElZPYKRT5/CoQ3cG8
         Whgzf5TtK3HMxnEWoDZsgCflGBaLO+T+UtpGz8L4JH6eJxrcpA2SzPEx+v33sJMyBO7s
         pZdo9gs74UQzpaORTSbGurVTylVAJjw+59kGtUqKKoXJOs1iTbO2ooyciwsBHdQePmoK
         8E/+tAGAc1aF1u3j+nZPpJsI19mPUEmAntqAZsg/rxWqhlY1v1r1iH09SHVVWJZGYT+0
         e4ySTruQVi4Vv07P7kNbXSpmTwx7ggkMk4Bhzq7MNQsHumNsZufTl1SNn1VlWRy53yEd
         xXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041597; x=1787646397;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YynhsaKv6ONFSWKQULheRPgAc0PHa1TbivC2ti0lMg=;
        b=BiqTEUAU0oESH9tlKzM1zLchA+qImJch1ieHV1vrPtvWjwKSi6KXt77m9aXzeaOanO
         PlcjSGedCOe/m8YaE1Dhd+oyTTnvyNbT5gF7YRJyP/DxDdO9GS0mVGm+jBHLKLrY7sRj
         /jZ76S0LXrjDpJmUJP6pC7NvP+6zEJRxtTK7uRIEBJz+Yj2mfAzHEiUk2rZYEPxRHsem
         j2+Zjdt0nW1WnIneXZkF5kymOpDfG7X8omAnQXW6iIk+ETEc5LGEbEDbRerawYUVXKm9
         Em0L2ro7JN8ahwyefPdwWGy46GwRNB3aPU4jG8T/LnlgLkjI1sgLjk0nOX2iYQA/hyVX
         fV1Q==
X-Gm-Message-State: AOJu0Yzz3LiJKQRhBpMdF0FQUwO+w0bmnlmwbfseLdIrATrQ7tCtQ2oI
	fcjqfpwqYMJQkdeOjp5flphTaGCQrB0XCDyoy0SiC51aiTDEmwtiOFl0EECdQxGc4OTELyD583E
	6+GnWQXhZ1IqNGkMalIVh3g9F6Paj+iQ=
X-Gm-Gg: AR+sD12CE594bpRDDb0bVwFKqmZlTxYgq1XcJMLXHXxILGss6RsxXAsNy/Wll3+B3lL
	5G+XkdGMCfiZ5X/gYYKVVp//311BTcdeLiNgxl896GVR27kC23E4GHB0nLwGlDMmVeVaE6n35Ex
	TfoX7uLAmq2FU5UwVbV23eQb9llqGVw7bjkbVujJOTZ6cjwHAEI6vpW0X3p6+Ipds4pVrCLrX9j
	j1tGjecF81/8XM+deuAvWxU6pJFqbpLyg9oT1F1OBn92HjGSwLcieDnqz551q7dAbGcO88M6QaI
	oUeFWU8naFPkiyknuObhLLeccD4FmnM+UpAK23TM21BEQ2Gn5f1pXaXeSUTLzJK/3eTamOyp0Sr
	HEsD0oDxsAy4dUn9AGzWPV9Orh4ZwQrMtxus=
X-Received: by 2002:a05:6102:5794:b0:74d:cef6:af78 with SMTP id
 ada2fe7eead31-76f2ca40261mr7445347137.7.1787041597440; Tue, 18 Aug 2026
 01:26:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 03:26:36 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 03:26:36 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqse4c2wyu.fsf@gitster.g>
References: <20260817211936.2943278-1-keni@his.com> <xmqqse4c2wyu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 03:26:36 -0500
X-Gm-Features: AcwNN1XYRkmoobU80VDab1w29yIe9IYDyRHXI7fCI_YBHWa1m_zeTMdbbvoR9ho
Message-ID: <CAOLa=ZTykwSDcFaEmEJJ1PTnX5L9=2t+tkCWhF+hV4J9EPBwWg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] config: surface editor failure in exit code
To: Junio C Hamano <gitster@pobox.com>, Kenneth Lorber <keni@his.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000009d6d8906594e0b69"

--0000000000009d6d8906594e0b69
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Kenneth Lorber <keni@his.com> writes:
>
>> When the editor invoked by 'git config -e' fails (crashes or calls exit(3)
>> with a non-zero value), git notices and give an error:
>> 	editor.c:launch_specified_editor()
>> 		return error("there was a problem with the editor '%s'", editor);
>> which is then lost:
>> 	builtin/config.c:show_editor()
>> 		launch_editor(config_file, NULL, NULL);
>> which results in git always calling exit(0).  Note that the value is
>> not explicitly thrown away with "(void)", so this may not have been
>> intentional.
>
> I do not intentionally exit my editor with a non-zero status myself,
> but what I hear from others who do is that they do so to affect the
> invoking 'git' command, e.g., to stop 'git commit' from creating a
> commit.  They somehow realize they botched the edit, and they want
> to prevent 'git commit' from committing, signaling that by exiting
> their editor.  A cleaner and more modern way to do so, by the way,
> is to empty the editor buffer.  In either case, 'git commit' itself
> exits with a non-zero status.
>
> It might have been more consistent if 'git config -e' exited with a
> non-zero status when it noticed that the editor exited with a
> non-zero status, in that sense.  But we have never done so, and that
> is probably because we did not care ;-)
>
> In any case, I am not sure whether there is much value in making
> 'git config -e' start behaving that way.  Even if it can notice a
> failed editor, the damage to the file is already done, and there is
> not enough information to undo the damage even if you wanted to when
> detecting such an error.  This is quite different from when an editor
> edits the 'COMMIT_EDITMSG' file and fails.
>
> So, I dunno.

Wouldn't it be better to notify the user that something went wrong
rather than simply brush it off?

I would be in support of the patch:

  $ GIT_EDITOR=false git config --edit
  error: there was a problem with the editor 'false'
  $ echo $status
  0

As a user the expectation here would be a non-zero exit status.

--0000000000009d6d8906594e0b69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f84b44317d17fb23_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRUZ6b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mek1CQy80ejFxd0VXZzRGMjFDa2dPdm1UZFczeWlEagovTkEvK2lUbjM0
L09lbnV4YnROOG1zbXMvaWRSMDNJalhvenNpZXp0eTRISnhTZyt0UStwRGxCUHZLTUhCbnZRCkRB
WmRhTGErRUFnaGRKMEVlQ2Y5M0dXOU5EZ1pNQVhxOEo2d09UQ3pzTXRoREh1UHFuMVY3NDB1d1N6
TjlXakIKeXJtTUl0ZkJ6ckVITnBhZ1dWZ1pJRzE0Y2lnd2JoKzRxTlVPR2kvTnZPSXlQRDhXdGNM
MS9KMy9sOE9JSk1vQgpZQ1JrVzNsS3Z4ZE1QRVNYd3ZscTFSYlEvRzlNZ1BDNU94OUNCQlhXTDM0
U2RPVkZLL3RIa0VHN2ducmM5dWtnCm9PcGFHbzF0b0Z2clNnaTBxYTlMTFA0aVF3NnVDamlncURT
UWoxOEVpUzdUblBBMld0R2J6TVNpdUVaalNWNHEKRVNNa0lDUS9tZGRLQWRvWlR4eCtDTlRyQ2xQ
YWFBd3RGOEVydkxqZmpIOHdVeFhVb3lHZ1J0LzFROVFZd09YZwprY0p6NHgweENqQnJ6UzdHSEFG
M2NpRmhrMFUwaGJ2Zi8wNnl4Z3lYcHdiVEJsekJJNno3SEhqdmxIQVFQM29UCjIrSEI1dXg4cFhN
SVk5OVBRWnlmS0VNTFlqeWpOOXZzVmNvLzlLcz0KPUgwbWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009d6d8906594e0b69--
