Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A742AA6
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765591040; cv=none; b=JtL/mIU4ggCXS0icbf4JXIANuPvwcJMiYKVHV6/nOOavUnGxWXnX9Fd/mAGGn9dmBtIieTgFE70q6LS0AXNwrS0q4fxmtdx1fYd5ku2z0uS7juOAYkTHjpv1sAf7ZuRFC7GmPIJfJZJNn4j8Dp7zOO3US5WuEKTTtjFi/92GYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765591040; c=relaxed/simple;
	bh=sNx9dbUG/PDvSNIVqPAdmJwDavml2vNUlD15/uJ6Qqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0QEnRgcMccmvZVps1DC/5CbFK/JWB8srjJaJ7O9wM5dsF3PFbRgqOPG4paprdYUqTLyp7qIKf+SXijIAp78fFU7wwSae22J+xm5Jt0eOrwRu7eRkHVMqZKnSrq0rcGlpJClYbNc557N+RGTeMOiioMzlQs25YtqA5P2qC5bRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=admqCsIL; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="admqCsIL"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6597a87048bso1039815eaf.1
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 17:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765591038; x=1766195838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxm4Yl5YmRYlbAHtuDgS6LF5ajWHzWfeCp8mo80Rig8=;
        b=admqCsILpV4hcyaiyxje308E4TyEn3i8vtjX/6XG6p1Exyacq6MdLiW61nfaKVnxeJ
         NWqdB47dda39rQzzfXl+1T7Op2rBOQWHyzfXFxejPpidKGYa0B6V0qysjTrX8ZE/QxHa
         /ByUXO0/yGhyauVf4w13ASc+LdvSj9Zp/BWWOi9j5CEJ3K92Uc2EN18KK2l1NgauzJZB
         u5bh+6y4+8L/9Cioof6dGcfwnwOtiVvhOtIIzGF1ziQKE+apOvg9b+FHHsIa9JNN3KFL
         6ZLYVZb+e/D+VufWs4MD4D6dalTY+juyyjYLm5sT/E4SFXl4xNe2y2UHCQ0cxLNM3GPC
         zVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765591038; x=1766195838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxm4Yl5YmRYlbAHtuDgS6LF5ajWHzWfeCp8mo80Rig8=;
        b=W7BzTV4MjP/ZJ+brf63k9JWvMzghjRV7acXgZxlfgv3iFQFQGdJK/+x5s/cp+XlYBq
         apBeM6nI2Pb/27VBByLtjir1cqgpNwmooZ4OTfEzYJbsAhDXwrKIQ2I3nww+EIZBHuGO
         T4fEELCUS9HLHcqm7cOMfQrX3X2BUEeXdQ6I205eebbb9zzpr7WnNoFaMR5+2TvDHts4
         eRtYv8nmVQTO5Mq27ZfYkehh3Z+POKILQS2zIbmo2mMpkh6ufxM2R/bSLu2YaTsN6sg5
         c8WFkkrz3FQrrKDFD887UJo8cdFdj8TMJkmCfPFOuq+CA6NRLrbtLXw+tpPirsziDthb
         K60A==
X-Gm-Message-State: AOJu0YzCysiCrXVaM2bS2eERVoHhG3988lzXk/ZZS2YtkwW5KVh5w7ty
	ckG1F4g23FrB71VC1dEchF+Q1nQwVdVv9vruwhn7N1v4X0oCVCwyOUqDzCDeVUTtdOUh1C54bz7
	BHm/I3UDKqkX5HrnaHkm8y5pwvv2oSRU=
X-Gm-Gg: AY/fxX6ESXYMuLLFs2AmGvJKhdKV7QyeSrk41vIjE3P9mbwnVDYaMhUVpIGCzV4a3TU
	wj7npe2Xxwn34LP098tKqMIJDEm4G3ussiUj7p+Bgu4dGsTGx913T6pxHhE1B1KiO6UecSZBtg8
	lRNe+YIysZx7UNRNDTL2ET2WFSheYyJ0vFWsKBLquVHH17Wz5ERlusr9OABpwyxZGPh7v2v2A5m
	hB8HnhlMlvJPktw+nB89cwEOEOSPk9/6484ZGHZV3vot2GQU3AS2h22Hz24krylFGLPAr7wNuF2
	Ku1j1FypMq2onc+YHgufLupGZG7E
X-Google-Smtp-Source: AGHT+IGYZnXiecdwh3L5a0clF0P/tyduYysRmDX15+IQTNj/vrmDhCMJwBvlQN9vwVNpFiL4NGGf4Sl9wd/UlVnUSQs=
X-Received: by 2002:a05:6820:2d9b:20b0:659:9a49:8e33 with SMTP id
 006d021491bc7-65b37faab4emr3072447eaf.37.1765591038073; Fri, 12 Dec 2025
 17:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
In-Reply-To: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 12 Dec 2025 17:57:07 -0800
X-Gm-Features: AQt7F2rrt2WqkVyvi6tmXI9nOaF8uLC__GGIThkwENwqAh1XzLiZdnkRNiy44AE
Message-ID: <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com>
Subject: Re: Different behaviour for --find-renames between git diff and git merge?
To: Luca Balsanelli <lucabalsanelli@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:06=E2=80=AFAM Luca Balsanelli
<lucabalsanelli@gmail.com> wrote:
>
> Hi,
>
>    I'm scratching my head to understand why on the following case `git
> diff` and `git merge` give a different interpretation about a rename.

I don't see any difference...

>     git switch master
>     touch aaa
>     git add aaa
>     git commit -m 'aaa'
>
>     git switch -c branch
>     echo -en 'A\nB\nC\n' > aaa
>     git add aaa
>     git commit -m 'A\nB\nC\n > aaa'
>
>     git switch master
>     echo -en 'A\nB\n' > aaa
>     mkdir dir
>     mv aaa dir/
>     git add aaa dir/
>     git commit -m 'A\nB\n > aaa -> dir/'
>
> The `|merge.renames` config variable is true. Changing `git diff
> --find-renames=3D50%` (the default) or `git merge -s ort -X
> find-renames=3D50%` ||to something lower does not change the following.
> |
>
> `git diff` prints

Actually, it doesn't; more on that below...

>
>     diff --git a/aaa b/dir/aaa
>     similarity index 71%

Did you not follow your own recipe?  Maybe you inserted an extra space
or left off the 'n' in 'echo -en' when you ran this?  The number
should have been 66%.

>     rename from aaa
>     rename to dir/aaa
>     index bbd2b90..986ad36 100644
>     --- a/aaa
>     +++ b/dir/aaa
>     @@ -1,4 +1,3 @@
>       A
>       B
>     -C
>
>      that is the similarity index is 71% and it detects the rename.

At this point, if you actually run `git diff` you see the following:

$ git diff
$

i.e. nothing.  I suspect you gave `git diff` additional arguments but
didn't tell us.  Let's look at a few options:

$ git diff master~1 master
diff --git a/aaa b/aaa
deleted file mode 100644
index e69de29..0000000
diff --git a/dir/aaa b/dir/aaa
new file mode 100644
index 0000000..35d242b
--- /dev/null
+++ b/dir/aaa
@@ -0,0 +1,2 @@
+A
+B
$

So, on master, aaa was deleted, and dir/aaa was added.

$ git diff master~1 branch
diff --git a/aaa b/aaa
index e69de29..b1e6722 100644
--- a/aaa
+++ b/aaa
@@ -0,0 +1,3 @@
+A
+B
+C
$

On branch, aaa was modified.

$ git diff branch master
diff --git a/aaa b/dir/aaa
similarity index 66%
rename from aaa
rename to dir/aaa
index b1e6722..35d242b 100644
--- a/aaa
+++ b/dir/aaa
@@ -1,3 +1,2 @@
 A
 B
-C
$

So, only if you diff the endpoints of the two branches do you see a
rename; if you look from the merge base to either branch, there isn't
one.

> `git merge branch`, instead, gives
>
>     CONFLICT (modify/delete): aaa deleted in HEAD and modified in
>     branch.  Version branch of aaa left in tree.
>     Automatic merge failed; fix conflicts and then commit the result

Yes, this exactly matches what diff showed above -- on HEAD (master),
'aaa' was deleted, and on branch, 'aaa' was modified.

> Why it is that? I always supposed that the rename detection was the same
> for `git diff`, `git merge`. Reading the documentation I do not find any
> hint why `git diff` and `git merge` are behaving differently.

Hope that helps...
