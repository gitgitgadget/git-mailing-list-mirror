Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC79433D8
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256243; cv=none; b=VhLXT/gKGm09bu9V0NC8EQY0IdSVnhFevoZHOQYCFgZM2NE1/HFWqPBwpF928qbvwMAifC8YA/E50CJZh1oDRQEvKnR0yWI/FmbLasFso1YO7GaxeQzAQxgDLakMb2x2qs9/pnPTdAs1tAALy7zGrC1Q1XLuMpd057i/KuMzVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256243; c=relaxed/simple;
	bh=dJjYmZA0vT2HNd5jbk5dgzXSL+BVOOKHicthkNPgetE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nwzPkfh7PupEvglCa30pJTaF438VzZONP1DlM6x42qOJXYSV/8s+JY37R9B8+Rw03ckzqZVLqmWQTWwzXL5VsREg4tJlziME4mhHaRP2KvyYc5Q1hR+R0qHLrtdA3qFyGRvoYH2N7W3oiIEHB5GaTY1HCYXKhVuCCF4hjmH2iHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM8oLamf; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM8oLamf"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2fb9263a6so769460a34.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708256241; x=1708861041; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJnqGQkelK+HIT3g+5eE2MBbkTqfN3N3BJV2BR8qsWM=;
        b=KM8oLamfCiBGxX3cas6RABoeMPlOjfQx/yuAzXmrpSx3N61EAlHII/SCq87bMcT+3W
         laMsXB13pyFPU7Uvj/I8gD4mrZkrLKF5agW5PvXiQM3qBW+GQr3qBNWNNJoTgp0fGua5
         cDJwUQaO+jvuVmb6r2r7WOm8xUgIbbbxSxzed36Yregr7hNs9IXPOUHM0tcVPdEjfPV9
         lG4tbJoYPbWU7GzJNftkKyapx1rB3MaPbSOI0sxdgbmBIUol3uMyllaZYEKD3GucDk88
         b5XD2+vNXlwE154cU8cIwpkPm6eOwwPNruDgv2Ffq1iDOeIPeRPoMtSnBYUDTb4zRN66
         TKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708256241; x=1708861041;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJnqGQkelK+HIT3g+5eE2MBbkTqfN3N3BJV2BR8qsWM=;
        b=ACQzg+HTfh9e6A2M8YRnuGbyPCkKJNc23Y9P/A7j0YQlfsZDbg7MJLtqwdmAsUtgKz
         Wk8rXEGNZfhtgIsDRj0VMbNHsuiMCqphf1UcqX+0OBBeAKPGGpmnE4hVT06VYddkhR0e
         pXppTF7Bq77KVrVwzQKPNcUvI7G+LIPlyl84zC7G8mhbfgMeHaj6WvPHd4OePB7pkpET
         ZtZTcHsEuGXmldqqgJ3mbCM5ZpWdWl02N59qKAdJJJbsm8h/tvmx5feTqf7dE6qGUedG
         V3k+mF+WBbXNfNsxd7+UYyIB9AJposg1auYpXWm8jaP4kKBFvfyCGSb9DgXgxRwX7r3H
         jbZA==
X-Gm-Message-State: AOJu0YxPTNXEha//M2GhIX6NjVLg4gmKYmUUxrCes5FtaL/1p2in1Uxu
	440U/A71izyJvxN7WmFJj2JpTQShaFGddr6d5CBsTetebKCI4HXANevVx/H2iCPz3H/5qOa1Lts
	FzwVhZD+/+PXZqZN3wyjPdomrf+QqCuL4MGE=
X-Google-Smtp-Source: AGHT+IGQ35VoTKJfyJ+CPcHdFQsKJxobXj4FfTVyY7WnP/7yh40GMCqNGiwfQRyHztcxGSg0c4kMw7Wh691zuCAtIho=
X-Received: by 2002:a05:6830:328e:b0:6e4:423b:623e with SMTP id
 m14-20020a056830328e00b006e4423b623emr3510453ott.11.1708256240946; Sun, 18
 Feb 2024 03:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: eugenio gigante <giganteeugenio2@gmail.com>
Date: Sun, 18 Feb 2024 12:36:57 +0100
Message-ID: <CAFJh0PTiN18LcKP6LW0d1u2gkodBD2cOJRBzU_subBaFpzM=CA@mail.gmail.com>
Subject: [GSoC] Use unsigned integral type for collection of bits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
I was looking around the codebase for some field of a structure that
stores collections of bits with signed int type.
I used this simple grep command to search for it:

$ grep -r -n "\tsigned int" .
> ./diffcore.h:63:     signed int is_binary : 2;

The struct in question is "diff_filespec" and Junio commented the
declaration of the field as following:

/* data should be considered "binary"; -1 means "don't know yet" */

So, if I understood it correctly, possible values are:
 1 -> 01
 2 -> 10
-1 -> 11
On the other, by changing it to unsigned values would be:
1 -> 01
2 -> 10
3 -> 11

I read somewhere that one should always prefer unsigned integral type over

signed integral type for a couple of reasons [1].

These involve operations like Modulus, Shifting and Overflow.

I didn't dig too much into how the field is used and if there are cases in =
which

the mentioned operations are involved (I would like the community
opinion about this topic before).


Moreover, I don=E2=80=99t know if such a change breaks too much code and if
it=E2=80=99s worth it.

Probably it's not that tragic since the header 'diffcore.h' is only
included in two other files,

but maybe I'm missing something. For sure, various If conditions used
by the function

'diff_filespec_is_binary' inside 'diff.c' would have to be changed.


Besides, it's possible that my grep command is not enough and maybe
more "signed int" can be spotted.

Thanks!
Eugenio Gigante.
P.S. I was insecure about how to send this email since it does not
include a commit.
I decide not to use git-send-email. Hoping I didn't mess up the format.

[1]
https://embeddedgurus.com/stack-overflow/2009/05/signed-versus-unsigned-int=
egers/
