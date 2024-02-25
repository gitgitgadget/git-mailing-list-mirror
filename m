Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0431C02
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886090; cv=none; b=ftUcYY6bwveg6vJ6/fRctmliQ6OMJwcFIwc7D5MrJYDjQh0vIaxfmyBBxLyetfiJbEgBeweaLUUHQspIt4M/0NMFzBHuJseoFhMjSKw2eR8lZ7TY12f9/5tog4Fe+/YXC8mEl8jYI1fOoa7UcY3n+Qt7xEL7rydN8r9Lqs2oieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886090; c=relaxed/simple;
	bh=w8oJqvdv/SRNBR2mbjb1nHi1N3rq4gFdNwDd2+PrvxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WGpPlawy0oFF7v3najlb1JN8sgEoCNT8t/LyTt8E97vhCoM62jmb7LQ90lgtGePnj71ikKYVw1po+ontByRSnbiZPmGaYoIWr+lrOsZwNBhwbk+hpc/mVgM5eDf46P1zUTfNoeT+KxGHO9uUvEtoxSObnvLRsD/fM8F5KjvCVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxlh4xwk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxlh4xwk"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1458635276.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 10:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708886088; x=1709490888; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8oJqvdv/SRNBR2mbjb1nHi1N3rq4gFdNwDd2+PrvxM=;
        b=Yxlh4xwkEf/M0O7IX0E/FmkaPD3yea/9qw1nU8APxIQERzhPBfNgIk2sdGAKEg2Bcz
         TlPRUBFgm5R97YNI2BVbfJR3qRfzA0ZMsoRsvL/3DmEXXIdbAn8imfKTskVoVYxxKlWI
         saciqQsHsUgVuZdtZCAIelpAfKvebbjTpABxgMmvWyC3lKyPG0b68uqr3vjX+FI2EJrB
         Pfh0/OLHiOx//PcrZ55W7fxQ0QVMX7PcPy9Q0Q8yRIAV9acV1ciQ0+HoMr0RM1vMF83B
         v0qYweILDNQNTArUMCv4cTHci1qlhJIj2umszuTctCrCRD02fdBQSkjAnRhuHVXkVZRw
         aWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708886088; x=1709490888;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8oJqvdv/SRNBR2mbjb1nHi1N3rq4gFdNwDd2+PrvxM=;
        b=ISGKzRXATs8bj3MFpePlGpZyJmWwbUdIcyH5Oc16v7i6t3vJkIfHfYu669aaanFmd4
         avtldFevqlr7kOE/o9lXsF7be4JBwug3bG6LeCYHXDcty0IQ9jXup2OYPWHt2uFIXXW6
         hUnCEPsaRBpX7ADjf7t0VPir+ggDFFKoOf7R3kaCa+6yjLyIrcrZcqD0Iydho5fLmlYC
         0sxzZPkJJJ0MybYGCA4sUiUjpnqk7MLd0wNsrM9fenN+ralQBhlL0XVTXagJjzNFWf99
         RcDqUKuGIhxjIKXcjHSW5UohyJYhqW0ldQicKLthf+/3qGdWv+XF23Rit8fbxmHn6anq
         rwWA==
X-Gm-Message-State: AOJu0Yx3l88tA3vjljtjX0qeThNK5LhPnFFCCujf4DeminxzYAmY1Y3S
	fhgnzTmfFxOb0u7uZv0QdN10MDRBPgBE2NDgxL1tuxPMwSGT0jC9BfjObV4Gno7vL9I2CPHq/77
	EKqoGUl6qEvKE7qE69ylMz4Hsw1bgC3uhvUFubQ==
X-Google-Smtp-Source: AGHT+IEqp1xLC/EQtt2FwsfN6FhpsGVfvoHO73MCfHhdK6nGYeyGgxaFVVkKFSvcUBwUzkvbsK6JwlbMfcfL+W3stVY=
X-Received: by 2002:a25:b9c1:0:b0:dca:a3e8:a25a with SMTP id
 y1-20020a25b9c1000000b00dcaa3e8a25amr2495809ybj.62.1708886087983; Sun, 25 Feb
 2024 10:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Milan Hauth <milahu@gmail.com>
Date: Sun, 25 Feb 2024 19:34:36 +0100
Message-ID: <CAGiEHCub4H7ZCV3CqfFaCRTOhN5A=qy7G_p1pVQw_puyAgjM8w@mail.gmail.com>
Subject: git mv fails to deduplicate blob objects on transfer
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"git mv" followed by "git push" or "git pull"
can produce wasteful transfers of blob objects

these transfers are wasteful
because the blob object already exists in the destination repo
but "git push" or "git pull" fail to see that

this affects only some cases of "git mv"
in some cases, the deduplication works as expected
in other cases, dedup fails

this is neglegible for small files, but noticable with large files

in my case, i tried to move 5GB of files (250 x 20MB)
and i was surprised as "git push" wanted to transfer 5GB
instead of a few bytes for the tree and commit objects

to reproduce: see repro.sh in
https://github.com/milahu/git-bug-git-mv-wasteful-transfer



output of repro.sh

the first size is the transfer size before "git mv"
the second size is the transfer size after "git mv"

pass: 1.00 MiB !=3D 288 bytes # path_a=3Dfile_a; path_b=3Dfile_b
pass: 1.00 MiB !=3D 331 bytes # path_a=3Ddir/file_a; path_b=3Ddir/file_b
pass: 1.00 MiB !=3D 286 bytes # path_a=3Ddir_a/file; path_b=3Ddir_b/file
pass: 1.00 MiB !=3D 284 bytes # path_a=3Dfile; path_b=3Ddir/file
pass: 1.00 MiB !=3D 329 bytes # path_a=3Dfile; path_b=3Ddir1/dir2/file
pass: 1.00 MiB !=3D 373 bytes # path_a=3Dfile; path_b=3Ddir1/dir2/dir3/file
pass: 1.00 MiB !=3D 331 bytes # path_a=3Dfile_a; path_b=3Ddir/file_b
pass: 1.00 MiB !=3D 376 bytes # path_a=3Dfile_a; path_b=3Ddir1/dir2/file_b
pass: 1.00 MiB !=3D 420 bytes # path_a=3Dfile_a; path_b=3Ddir1/dir2/dir3/fi=
le_b
pass: 1.00 MiB !=3D 241 bytes # path_a=3Ddir/file; path_b=3Dfile
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1/dir2/file; path_b=3Dfile
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1/dir2/dir3/file; path_b=3Dfil=
e
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir/file_a; path_b=3Dfile_b
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1/dir2/file_a; path_b=3Dfile_b
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1/dir2/dir3/file_a; path_b=3Df=
ile_b
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1a/dir2a/file; path_b=3Ddir1b/=
dir2b/file
FAIL: 1.00 MiB =3D=3D 1.00 MiB # path_a=3Ddir1a/file_a; path_b=3Ddir1b/file=
_b



see also

https://colabti.org/ircloggy/git/2024-02-24#l704

https://colabti.org/ircloggy/git/2024-02-25#l218

https://colabti.org/ircloggy/git/2024-02-25#l269

> I have a strong d=C3=A9j=C3=A0 vu about this also; I think we talked abou=
t this exact thing a while ago

> this, same: https://colabti.org/ircloggy/git/2023-09-13#l912

https://colabti.org/ircloggy/git/2024-02-25#l404

https://colabti.org/ircloggy/git/2024-02-25#l433

> reading that SO answer by jthill but can't quite get the whole picture fr=
om it -- is it saying that it's a trade-off in sending all the objects vs. =
spending resources trying to figure out what to send?

> I bet there's an opportunity for optimization here; Git could probably fi=
gure out a good balance based on how much data it is about to send

https://stackoverflow.com/questions/48228425/git-push-new-branch-with-same-=
files-uploads-all-files-again
