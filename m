Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063A26C393
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255700; cv=none; b=gJul1T+MrHVTJ5n4gTHKUc0/2GUJ7dYbF9G/hw0iyqj7LEvziZGZDhXUeGCO03HPZzAtWz1kavkKK2ZCc8P0NmzXAsXcUXzWBfUbF+xB7bKV4eOUEtrvYuEP6WJQXBlBHKGfi32y5+lMk2kuEfqamY/+w+dXer9NQ75M1qHiecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255700; c=relaxed/simple;
	bh=KdRO04Qg+Kqabn2K8gz9Qfdw5eQmXBfG+B8X7QwlFt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3eCnK91+Z2sQFaUlgrIOTfjEp3KZtqERoT0ub6uhbhoHmHZoTrczdDoBbpT8q1O/9zVRarmN3NlLo+r1sl1ySIMNAw0+IirbL9tEr8iyDqF7mIcV3qaJsc3+uUggX6RbMl7kFVlR1oNpdaU7MMbACUeD9lQjl2obk0t8iaMcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fb1ded3afeso14119996d6.3
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 00:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255697; x=1753860497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFmy2afBzROPwexzsp1sdNX0H1hUV2J0tvM6U2sKZoE=;
        b=p60+ygnpcpmQ5pMeOK0noweKwJybX7CNMozmE2bzvkZtQmrS/EmA1j2eGjYjYJWwA+
         GgeyHHRff4l4TWG6ApjNCqCee9jTGVxF/fWKUls5Vy+UfGN6J51HmeCtHF7HB/vW9WxK
         SDmE4HEPpNb4XXNNozqP6quJPJTFS3+vv+5dCVWvpEEWpnyi4od4d0U5uSKL4w5CV4/W
         VDux/OilyjjPLh33CtSZMY9RCGOv4uGsTMHe17J/NQhP2j1ixVKvFs+sd0zMDOTD/gZA
         2prXB9YKvMZ3A4XXqD8YLuO3N62oUnG3sjwHvoem1cZnOco0v8QaM0LKzi7qJHL4qfmj
         cIDA==
X-Gm-Message-State: AOJu0YyaowP/DiuSOBv6I4liAvDFYFDjZ/+N9HgKWQV+LX6quEqrbFeZ
	CkBmje42W/85kqHB6EriRey5S2G+gaXNIARKVkJT6xiwlzkF/KZLzeeWvgiC0AgNDfinqsC197O
	ZB/WZho316kPlEiAiLRvghYqM5OIDUfvyAKkN
X-Gm-Gg: ASbGnct6u/1M4DbTyxgDrMq0TEUFuzpAtiRJnuXfjV81hqvaE6h80F2UT+VsM4qifFl
	cT03k4NE1wIlT1kBT35VwFEIdxP8E/gXZkWcHF87ZcHOPwbynUg6+Z+NIk42Za7goZt2YBhk3WW
	VfGRKZUUo75bKDoaYaP+mxPMgAcfNmkl7Phnf1yBPQXfiqP1O375sBXhOFR7KW/wqiWg8MPtXw2
	UQsocprcO690tRi/wtw6ghl9em+TK5CTDrG5CbMQhpMFs26PA==
X-Google-Smtp-Source: AGHT+IGAfxImdcXFpcYRCwpi7j9EmFOKOKn1iQvl0npBjkACOg4lIjNflw1LVq5NNdh+cetr/heAGpTGfiDXAZag5UE=
X-Received: by 2002:a05:6214:d08:b0:702:c124:8370 with SMTP id
 6a1803df08f44-707004b981dmr11683176d6.2.1753255697402; Wed, 23 Jul 2025
 00:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722174102.1876197-1-lhywkd22@gmail.com> <20250722174102.1876197-3-lhywkd22@gmail.com>
In-Reply-To: <20250722174102.1876197-3-lhywkd22@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 03:28:05 -0400
X-Gm-Features: Ac12FXzD0q3W5PS2S-DTgP_3PoFG9HB2Q_TXX8cXe0NxZtcUALGM2J3mMSwMA-s
Message-ID: <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:41=E2=80=AFPM Hoyoung Lee <lhywkd22@gmail.com> wr=
ote:
> Initialize `fd` to -1 and unify all `open()`-related `close()` calls
> under a single cleanup label. This prevents undefined behavior when
> `fd` is used without initialization in error paths.

It's not clear what this means. As far as I can tell, the original
code never used an uninitialized `fd` in error paths.

> The cleanup logic now safely avoids calling `close()` on invalid
> descriptors and ensures consistent resource management.

Again, it's not clear what this means. Although your previous version
of this patch did add a call to close() with an invalid descriptor,
the original code did not do so. So, the above statement seems to be
misleading.

Those issues aside, the patch itself has problems, some minor, such as
making the code a bit confusing or misleading, and some major, such as
calling close() on an already closed descriptor.

Unfortunately, there are enough important context lines missing from
the patch itself that, instead of directly reviewing the patch
directly, I'm going to review the code following the application of
your patch...

>   int fd =3D -1;

This new initialization (-1) is useless because...

>   if (argc !=3D 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
>     fprintf(stderr, "usage: %s\n", usage_str);
>     return 1;
>   }
>
>   fd =3D open(argv[2], O_RDONLY);

...the very first time `fd` is mentioned (aside from the declaration)
is here where it is unconditionally assigned a value. Thus, the -1
initialization is wasted (and potentially confusing for readers).

>   if (fd < 0 || fstat(fd, &st)) {
>     perror(argv[2]);
>     goto cleanup;
>   }

Okay, no problem here. The `if (fd >=3D 0) close(fd)` you added to the
"cleanup" action handles both the cases here when `fd` might be
negative after the open() call or a valid descriptor.

>   from_size =3D st.st_size;
>   from_buf =3D xmalloc(from_size);
>   if (read_in_full(fd, from_buf, from_size) < 0) {
>     perror(argv[2]);
>     goto cleanup;
>   }
>   close(fd);

Here `fd` is closed manually which is good because...

>   fd =3D open(argv[3], O_RDONLY);

...this code immediately assigns it a new value.

>   if (fd < 0 || fstat(fd, &st)) {
>     perror(argv[3]);
>     goto cleanup;
>   }

Okay for the same reason mentioned above.

>   data_size =3D st.st_size;
>   data_buf =3D xmalloc(data_size);
>   if (read_in_full(fd, data_buf, data_size) < 0) {
>     perror(argv[3]);
>     goto cleanup;
>   }
>   close(fd);

The descriptor is closed manually (again) because a subsequent open()
call is going to reuse the variable. However...

>   if (argv[1][1] =3D=3D 'd')
>     out_buf =3D diff_delta(from_buf, from_size,
>              data_buf, data_size,
>              &out_size, 0);
>   else
>     out_buf =3D patch_delta(from_buf, from_size,
>               data_buf, data_size,
>               &out_size);
>   if (!out_buf) {
>     fprintf(stderr, "delta operation failed (returned NULL)\n");
>     goto cleanup;
>   }

...although `fd` was closed, it still holds the previously-open
non-negative file descriptor, which means that this `goto cleanup`...

>   fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
>   if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
>     perror(argv[4]);
>     goto cleanup;
>   }
>
>   ret =3D 0;
> cleanup:
>   free(from_buf);
>   free(data_buf);
>   free(out_buf);
>
>   if (fd >=3D 0)
>     close(fd);

...will arrive here and the condition will evaluate to "true",
resulting in the already-closed descriptor being closed again.

>   return ret;
