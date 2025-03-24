Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BA25E803
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818115; cv=none; b=YNYi09OlCKECqnxa3fO15HGhwUp3YI7dzDpp1bYSHUKO/VSnPZojXvMGx+SNBa/SxSHIDqGNTSucvg6jBJtiWMTjbOL9P90YmIrfinssVI4+uDOmvcxB27fRg1TuVrpTEnX8e1OlKXsrKW8H4UfDhjr9MLsQ+k/+IPAG7u1qd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818115; c=relaxed/simple;
	bh=t14Ck1BxBaeUThITLMGiF5zhxppUQCt7zhKPu7bTw6U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRfxaZEnez1bt5hq8eCemhb+PGtUJN2fHuUicIAp8NhQ4fIZQbkW0L+97jvbF9iDeJPgcHI5N1BpWnlu636fq1EisCDmfuspjfQfCIKjiC+2xFC0fMoRhUWXcl1NOKKj939U0JnXoKvuY2HE3AFiYumwoVbbBTZ2WWo0gFBRSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2sxupc2; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2sxupc2"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso1747843241.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818112; x=1743422912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t14Ck1BxBaeUThITLMGiF5zhxppUQCt7zhKPu7bTw6U=;
        b=Q2sxupc25XOY+rE0VcCyR+YzEBwuzQzcFnq3/3kuNh6fU8d/HNdaF56LkliNMcDSQy
         5sNIL1CphZvKc0tSWlHE/Kv6CUzl4ozGCf++STO2BFJ46I0wIe9K5jrEvp/TgDJQ+RH0
         +GWQbterBBHrOZ3cHkMLY+vVb2rkOpM9/MouIRNwbgCR+lYy4qdvEMvzMg893/hR8tcB
         Z81pFQLHqttrVI49hjWetEiajfH71WjBqQsROoxx4sIU4uZc88PP7Ak0TdL9hi0XfPbB
         vHIPcXAX8JULGw6ax8/0uLHNWZ/vFcAV+KQdHzv7O0jqxFYa0ochCWAcEp4KVPx3lGBj
         AmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818112; x=1743422912;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t14Ck1BxBaeUThITLMGiF5zhxppUQCt7zhKPu7bTw6U=;
        b=FtOLXrcoM2wfkhuQhTfiBgbEVZk4xduUdiopcvuqpD5t/8LD71asTtkzICS5ATsvau
         qbaHoZ8oZJuAkcpOFOU53o3YYcc8fFjPSXDKyMEqfKd0tL7TpxLrkq7HnSJn5PP7ML8F
         d8WMESDCzNFFi/e6cHJ2Y2Jgh1kgKIbKC9TeVJIDiuCQmWGLlOrtCU9SYJbsjxFpVN+h
         RQ9GwXAgTr4dHE8eBsYkcn5+cYYv5qvzMkC2vwxMCFgublg/8zp90xauHu9FTgpmU9+0
         jNibMz8xqCWKgE3ck3qHzUhH/DQYRK0Xzni8E7uFdrKvltkmJLc+bMWnFObCbWXyiReT
         ADsg==
X-Gm-Message-State: AOJu0YyMxle2co+LAc52mOzFmFSWz10O/dwLm3msN4ly7kceKTXz54XT
	m7Z2eaLDA0WX9tgXFhLU/udXqa+fh6Tcp3q4iDxL3lzMp5oL8rcv8EWl6RFB7sffHhFSkaFDPE7
	tNk2TOKnRU0zQyaDUjCGQOgpqFss=
X-Gm-Gg: ASbGncsImMpiIE9KaF5IJ/lRco4aejDOT94LFL6X2pp96G95dQE1+GwqBCCCXBiFjnr
	VI+RS2jajwEbbr4V6k1Sbaj/1RgRQs4EENO0lietbJsIpVlYqDhl8bdAj8FLofzPxvnZgScvGiO
	wU5UOY2aGZw6BVoKhd8AmUbfyXHzhNeBvMbctUeNL6fEy0rxst3YWu2r4gUwk=
X-Google-Smtp-Source: AGHT+IEYmOAPrJyVmwjBG8aj2BNqeqvHnmwHBl0qqvAnEgvV1/QAoDdAgjp0zPllvFhMDIbopECZRo961sgkWODMqTg=
X-Received: by 2002:a05:6122:130f:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-525a837cc32mr8156250e0c.5.1742818111999; Mon, 24 Mar 2025
 05:08:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 07:08:30 -0500
From: Karthik Nayak <KARTHIK.188@gmail.com>
In-Reply-To: <CALz2WHDNFuAWh-ZZ-9NOmY5+1v8_sYkLxHUZEHYSssWTS-9BtQ@mail.gmail.com>
References: <CALz2WHD2_F_S3EROi-U-tevjVhGqSCqW4maZwibBEwDOE1SiCQ@mail.gmail.com>
 <CAOLa=ZSkMp+H9PZeBZXK47=fx1sH=S54AuPT=oUosm7F7V8MGg@mail.gmail.com> <CALz2WHDNFuAWh-ZZ-9NOmY5+1v8_sYkLxHUZEHYSssWTS-9BtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 07:08:30 -0500
X-Gm-Features: AQ5f1JrvmUcO_vFzcjhotof-wQB_GzWQtx8iu2V9hwuZp_GAUEwQUanU0SV6WcQ
Message-ID: <CAOLa=ZQ2FWJa+4C0U59e339+nBF4oxPZqnhHeiy8BDQTvn8mag@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D=5BPatch=5D_Modernize_Test_Path_Checking_in_Gi?=
	=?UTF-8?Q?t=E2=80=99s_Test_Suite?=
To: Sampriyo Guin <sampriyoguin@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, 
	christian.couder@gmail.com, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007971be063115760a"

--0000000000007971be063115760a
Content-Type: text/plain; charset="UTF-8"

Sampriyo Guin <sampriyoguin@gmail.com> writes:

> Hi,
> I've submitted on GitGitGadget
>

Nit: I would also suggest you to not top-post in the mailing list as
recommended in the guidelines 'Documentation/MyFirstContribution.adoc'.

> On Tue, Mar 18, 2025, 2:55 PM Karthik Nayak <KARTHIK.188@gmail.com> wrote:
>
>> Sampriyo Guin <sampriyoguin@gmail.com> writes:
>>
>> > Hi everyone,
>> > I've submitted a patch using GitGitGadget. This is my first patch.
>> > The pull request: https://github.com/git/git/pull/1918
>> > I'll continue to work on similar patches. I will also explore any other
>> > patches.
>> >
>>
>> Helo Sampriyo,
>>
>> I think you would still need to submit [1] the patch on GitGittGadget.
>> This would ensure that the patch would be forwarded on the mailing list.
>> Finally, the review happens on the mailing list.
>>
>> While we're here, please make sure you also read the following documents
>> to help understand our guidelines:
>>
>> - Documentation/SubmittingPatches
>> - Documentation/CodingGuidelines
>>
>> [1]: https://gitgitgadget.github.io/#how-can-you-use-gitgitgadget
>>
>> >
>> > Any feedback is appreciated.
>> >
>> > Thanks,
>> > Sampriyo Guin
>> > (He/Him)
>> >
>> > PS: You can call me Sam too!
>>

--0000000000007971be063115760a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 927b0ad9ec3fe669_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maFN6d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGg4Qy8wVjdicXUzRU9BYVlnZ0dkN3UrZDR3RDY2OQpQcU15RlkwRnA4
dkV3a3d6UGl2MDJsYUoyVHAzU3l6Nkk4VVZ6d1l5d3llYTQ1N2lEOE5BWmRla3k1aU9HMFB5Cjlh
WU5XaWs4NXpOVm9iWTZhN3AzY2lrWitDaGRoRW5MTzczMlYwS2dJdUlqZUpWeGhOTzdMRnFEWDhX
V1NXM08KSitlY3VTcVo2UHFmTlBZditjVU9Jay80eWczY3ZFNGI0bmNwMVZvL0pSaks0VXFIVGVW
SXhpZEV4WWF0N0trMAp1WHE1blVPd3I0ZXp6N3NmUnVJZXpMY2tKcW9tdmNMMzFtZ3U1TkdXbDRJ
OVQ1UTI0K2FVWlByUjdBRXNZZWxECmJLdTIwY3JTeFdsRmlPS0RrZTJvRmZnVjVVOTk1ZEtnbmE3
TXVmZ0dkM0FaTmQwcjBGL0w0c0Vhb2d4ZFFReDAKVWJ3NzhLTzJndFNPcHowT0dlTUp3cHJOWjRq
TDIvVzV0bitnSVRCZ0JQODViYnQyMkgvNnc2dTdHZzAxSXZIZwp2TmQ5ODVZSW90TmFJQkF4ZG5l
d2RHSnNFU2FFbWFOVzhEQ3R3MGhLZUZ6UzQ5ZHZ4dWg5enFrbXB3TUQwbTFrCkh4Q01lTld4dGRT
bk1UYXczK252Q3cyVVNZdjNHQ3dwWU9tVHNERT0KPXF3VjUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007971be063115760a--
