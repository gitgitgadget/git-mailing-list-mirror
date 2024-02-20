Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEA150995
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462724; cv=none; b=f12n1dGOYWmY5cOjCLd6/ML7Bp4V3aCs7HgWvqILR/LQ8k3HlPye/fqr8kA0PxVQdztGyq22GXLpGY8KSRpbIsl801pPuLebPYQ+76aky7eEiNL/0EutkRDl/X4QEDgL/ok+/X4dlBYSO1Vc3MbWxNuuCMKrtpNSIcaYK2yoe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462724; c=relaxed/simple;
	bh=rW/TfB4LhSUbJQL6ick08F9EB1L7Y1/5MCEH7WyL2DY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OyLSXIKCbqpoANhZj/KdktYrMkKS4/OdwI2RoKSHl1ZA3ztE3eYTVuC4c6t5ZgaoB/7V4mygIlpJ3RPasyCbQLBlOWdSQEdge9Pzxio2H/fWEynKxencJdOtPTRbVfe+4eNTRhcLW/nlVcWaJprc/LXRCUq4hUc/voc2wZit3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3169Y2/; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3169Y2/"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a8b9b327aso2169367eaf.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 12:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708462721; x=1709067521; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqFWhZLK25qZNBgN8Hd+B1BAruiyTW4Oj6as5MJvXRI=;
        b=G3169Y2/lkX0o3dYCOmCcilDx+SpDR+B5m9DrND/bvp03oq+Ku9SNCD6/SiUryJKBQ
         g3pqRirNlQwJlCAtPPr1e7c0crNtv2lO+Y1eaLhvjNU2S21EHpIynnCy/Xez4t/bH2vs
         paXIYXOkgGr/faMLZ5mSX1vW79XMyeZ3iDuMleX6W2U7vM/gMwF+sldtJ6xjNrGAi3b9
         l2atFCrFF61PHH8J32D4/KZ1gPdlgL+syzvJ8tw2y/Plu5Z25oK0ajBlc/li4ZXAwNaj
         2bxFYFKE7anHI30waqSurhug793ETnP91GaSWluvQG8jcFtnxbeHJ0V9ftPQcUVGTcYN
         Qz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462721; x=1709067521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqFWhZLK25qZNBgN8Hd+B1BAruiyTW4Oj6as5MJvXRI=;
        b=C6czv83EY63AXCnNcP12uDTtmIP7YV0Ubxf0NHIdeEouxvWw1v7EJXJmQjrtYpBq6y
         LAcdlv+68FrZ9Ho/LexNiEsuTrMe7AD4I1bdDKDXBvnm6BaFKqQkKgJRawRBvsmad/WX
         3Xe9WfVSQKcyyrjpuIhG82CgGV3x+S2HoRDBF6wloitlhc3XOolU9yySyKzm58+miRjX
         RqyzIhLKjy+Xy2+xuLLsFK9jvh4JPtX6U9W0P6eCcXQyCLyyI9ZpTf9zuVnc2f9Kor/P
         0RARVjpcGrMKlFIbP3OJKek0Yk712sX4eSKdfhhBh9pEOeZh/U7btGU8oA7ax3ZDNy34
         a1XQ==
X-Gm-Message-State: AOJu0Yy0zXjCI0zstvhPw1fJ5Xq6klbOClv7bcFMwGZ5Um1g/teNMdR+
	z58Abig8FsyYqD+x3pC0kB/RkEhzbASkAlHDXCYlhoV26e1xAa3i4UkSd/A/lBPzbYgev8ryt3P
	mG305buH1KOQsUXcUhspe+kCYHLebH1ErLxM=
X-Google-Smtp-Source: AGHT+IGc/ZEirkybtQ4gtU8iJP+aDpcGn+4RDqKsc+XSzMcrU5AmWAMTaqFqC8m9VeH5IE1yY2+v/VX2maWho8neLj8=
X-Received: by 2002:a4a:240b:0:b0:59d:3d0a:e5e with SMTP id
 m11-20020a4a240b000000b0059d3d0a0e5emr17114986oof.7.1708462721269; Tue, 20
 Feb 2024 12:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?TcOhcmlvIEd1aW1hcsOjZXM=?= <mario.luis.guimaraes@gmail.com>
Date: Tue, 20 Feb 2024 20:58:30 +0000
Message-ID: <CAF7CYk6dERu7Lb0iKeq7zwtZVVd_bG2FMZReSDeejcu1JGiaFw@mail.gmail.com>
Subject: Bug: impure renames may be reported as pure renames
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

please see the report below of what may be a bug.

Yours sincerely
M=C3=A1rio Guimar=C3=A3es

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In the rust-lang/rust repository (I cloned today from GitHub), if we
run the command

    git diff-tree -r -M a04e649^2 a04e649 --
tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

we get this result

    :100644 100644 da931c3edaf6f9de6805e771f2b3b28edd27001f
11b659eec97323ea5190dac1771c7ca3241861e7 R100
tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

However, the source and destination files of the rename are not 100%
equal. If we run this other command

    git diff -M a04e649^2 a04e649 -- tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

we get the following result

    diff --git a/tests/ui/issues/issue-83190.rs
b/tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
    similarity index 100%
    rename from tests/ui/issues/issue-83190.rs
    rename to tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
    index da931c3edaf..11b659eec97 100644
    --- a/tests/ui/issues/issue-83190.rs
    +++ b/tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs
    @@ -1,7 +1,7 @@
    -// check-pass
    -
     // Regression test for issue #83190, triggering an ICE in borrowck.

    +// check-pass
    +
     pub trait Any {}
     impl<T> Any for T {}

What did you expect to happen? (Expected behavior)

I was expecting to get from the `git diff-tree ...` command above a
status of `R099`, but never `R100` which should be reserved for pure
renames (i.e., renames with no content modifications).

In fact, if we search for pure renames only, by using the `-M100%`
option, such as running this command

    git diff-tree -r -M100% a04e649^2 a04e649 --
tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

we get this output

    :100644 000000 da931c3edaf6f9de6805e771f2b3b28edd27001f
0000000000000000000000000000000000000000 D
tests/ui/issues/issue-83190.rs
    :000000 100644 0000000000000000000000000000000000000000
11b659eec97323ea5190dac1771c7ca3241861e7 A
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

This suggests that the initial command in this report cannot return an
`R100` status, as doing so it contradicts this last command.

Note that we only get a rename in case we lower the similarity
percentage, as demonstrated by this other command using the `-M99%`
option

    git diff-tree -r -M99% a04e649^2 a04e649 --
tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

which outputs

    :100644 100644 da931c3edaf6f9de6805e771f2b3b28edd27001f
11b659eec97323ea5190dac1771c7ca3241861e7 R100
tests/ui/issues/issue-83190.rs
tests/ui/type-alias-impl-trait/nested-rpit-with-lifetimes.rs

in which we see again `R100`, whereas the correct status should be `R099`.

What happened instead? (Actual behavior)

What's different between what you expected and what actually happened?

Anything else you want to add:

The rename detection machinery should be fixed to report pure renames
(`R100`) only when the source and destination files have exactly the
same contents.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[Info de sistema]
vers=C3=A3o git:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Thu Jul  6 22:12:47
PDT 2023; root:xnu-7195.141.49.702.12~1/RELEASE_X86_64 x86_64
info de compilador: clang: 13.0.0 (clang-1300.0.29.30)
info de libc: informa=C3=A7=C3=A3o libc indispon=C3=ADvel
