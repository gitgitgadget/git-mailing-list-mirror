Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AF8C0B
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907960; cv=none; b=uJfTdw2ah5+T5i/Lgn3uBUgZyErvYF6s7qfuiaMiSMF62UTYF8ULOt+St3xEkV6GKq2l4v04/LwdxzdTX9afF/29Mf4ogknjtiwV7KTvrKgIRMOwNyMfr3OV/E0y7E72ST/7h3G0+OmRKVE8/Rd7hPTJ5fk/Eg651HU6OPfsMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907960; c=relaxed/simple;
	bh=NOfTS3brByEPZ8oObsTxrr6BYmku7PIvAds9ThQMvBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m72ds9aZCoX9vwouDqBUcZB3ruNg+RNMReDFshKIc78Oz5L1BQHDtl4r6T4kF3DBkMGH2ljqWtVrR3RrD+h59OCe9ZjLxPGmqBCxtCG2n83UXQA5l5gXn+tS/CCGWELr6mYVlOVqUmWvkPEmxfvlLlv818ZPhtkLPVs2/lBd9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvkWiAq3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvkWiAq3"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso2864267276.1
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723907957; x=1724512757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8lK/y8lZy2OLo9yxdbgA4AIiJJC83Pf86SN0hm8Me0=;
        b=NvkWiAq3kJAJ+ugx+Il+RRm4iiJq6IDnY6bD8n7yO4+0OkS1DOBRxpwVuJwYN5EUdb
         WZrVkSryzGwwl4c0hhhAFgVS87xkfdRdoCtV4/5XvJvxmKAXmD31knpDzEpM1tLVjx4P
         zgtPkgS0KA98kkZoSzdX/ib95XQq53YLewSZquK8vx8pcM3G+j/ECYN/sWP2i/WcL7XT
         SvuOOjZpUiCp0LQW6+iwwKuhtS+Ef+mg6ihmik2tgvVuuUBOMoW0k4vcvc6aS3Ld8gBq
         GBS7PlIXcUYzrE79dm1YzjuHdHn7Ahx3TRHSGZGAhMT3D81K1zj2AgXYX1HgaIXJyswc
         PJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723907957; x=1724512757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8lK/y8lZy2OLo9yxdbgA4AIiJJC83Pf86SN0hm8Me0=;
        b=DpjUs7bH52FPoXnnFzETUkMwcQaEXVQ6B63fa/eP7acz0R+rgrl/XIzMvB3++L9J0e
         g/jOU/tU3Ga62FkUKpdd8XK+Oo6Gul9R+FHdS0Dvqv6y8kF4R6ampvkZTHT75n+tVOID
         1zyCi8yIkiNBwrjXmQCZ1LgfF75q/Hc2d3blU2nDtX/MzKj0BZG61zke7rWKFd2y5PcH
         SbKm5oeR0TS4FSn3s5CzbFDqvOc/4XmLA2kcvRramHcCV7KMX3GL9/vi0WHqduS4ZIH1
         t48P3fzzDxTXwMBlHVVSutA7VkmPNfeOtInJ30fqf7w5mVKvDJzBaoW8vQzFx/XK3oo/
         zxlg==
X-Gm-Message-State: AOJu0YwrdWHf+E0gpnsZhoHRo5Ajx9BP6n8FDY7TzMMjVFy2c5JBIzFh
	mQCHWdP21/G3OweoTZExXQEuZ1vp5EHv0KOkJcoM/AOeDQI4z9BTKR5NNQlp9dDV2n3+gqAze3M
	0MABK+CQGDohSaGDr1TdAaH2PZAyAMMgj
X-Google-Smtp-Source: AGHT+IF5L31v88F60WiQ+u8eGWWDW7g4hSESGuN7sWt1VHXIzGYLCCsGYCzL5JydPB8HpkYH+LXjv8AWC9zYHVfDqGI=
X-Received: by 2002:a05:690c:6009:b0:6b0:cd9d:8f5c with SMTP id
 00721157ae682-6b1bb28f34emr71101797b3.29.1723907957440; Sat, 17 Aug 2024
 08:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
 <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com> <CAC1phyYpt+B42vLbJpi0RMBJUn8D5oknBDp9PQ+6kD2db1Np0g@mail.gmail.com>
 <CAC1phyY-cZ-jfM2-W=SVN61K5x2c3bG=Xz8jdrnqSHoLc1Av6Q@mail.gmail.com>
In-Reply-To: <CAC1phyY-cZ-jfM2-W=SVN61K5x2c3bG=Xz8jdrnqSHoLc1Av6Q@mail.gmail.com>
From: Zdenek Wagner <zdenek.wagner@gmail.com>
Date: Sat, 17 Aug 2024 17:18:51 +0200
Message-ID: <CAC1phyaA7e56DJGu5d=qj9WY0c1b4G=CVG-HtenBcffOE16ZyA@mail.gmail.com>
Subject: Re: git push does not work over https WebDAV
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 17. 8. 2024 v 10:33 odes=C3=ADlatel Zdenek Wagner
<zdenek.wagner@gmail.com> napsal:
>
> so 17. 8. 2024 v 10:14 odes=C3=ADlatel Zdenek Wagner
> <zdenek.wagner@gmail.com> napsal:
> >
> > so 17. 8. 2024 v 4:25 odes=C3=ADlatel <rsbecker@nexbridge.com> napsal:
> > >
> > > On Friday, August 16, 2024 9:11 PM, Zdenek Wagner wrote:
> > > >To: git@vger.kernel.org
> > > >What did you do before the bug happened? (Steps to reproduce your is=
sue) git
> > > >commit git push
> > > >
> > > >What did you expect to happen? (Expected behavior) The changes being=
 pushed to
> > > >the repo via https WebDAV
> > > >
> > > >What happened instead? (Actual behavior) $ git push
> > > >error: Cannot access URL
> > > >https://userfiles.math-gnostics.eu/git/mg-software.git/, return code
> > > >22
> > > >fatal: git-http-push failed
> > > >error: failed to push some refs to
> > > >'https://userfiles.math-gnostics.eu/git/mg-software.git'
> > > >
> > > >The credentials are in ~/.netrc, git clone and git pull works fine o=
n all my repos on
> > > >the same server, git push returns the same error
> > > >
> > > >Apache error log reports successfull access with the GET method (clo=
ne, pull) but
> > > >"user not found" for the PROPFIND method
> > > >
> > > >What's different between what you expected and what actually happene=
d?
> > > >git push does not work at all
> > > >
> > > >Anything else you want to add:
> > > >It is apparently an issue of git which is not OS specific, I have th=
e same behaviour in
> > > >Fedora 39 and Mac OSX, both having git 2.46.0. Everything works fine=
 with git
> > > >2.44.0 and earlier. I have
> > > >temporarily solved my problem by downgrading git in Fedora 39. I hav=
e not trid
> > > >2.45.0.
> > > >
> > > >Please review the rest of the bug report below.
> > > >You can delete any lines you don't wish to share.
> > > >
> > > >
> > > >[System Info]
> > > >git version:
> > > >git version 2.46.0
> > > >cpu: x86_64
> > > >no commit associated with this build
> > > >sizeof-long: 8
> > > >sizeof-size_t: 8
> > > >shell-path: /bin/sh
> > > >feature: fsmonitor--daemon
> > > >libcurl: 8.9.1
> > > >zlib: 1.3.1
> > > >uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:=
10 PDT
> > > >2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64 compiler in=
fo:
> > > >clang: 14.0.0 (clang-1400.0.29.202) libc info: no libc information a=
vailable $SHELL
> > > >(typically, interactive shell): /bin/bash
> > > >
> > > >Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mo=
n
> > > >Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux
> > > >
> > > >
> > > >[Enabled Hooks]
> > >
> > > Does your .curlrc specify --netrc or -n? Those appear to be required =
to specify the
> > > Use of .netrc in curl.
> > >
> > > --Randall
> > >
> > I do not have .curlrc on my computers, it was never needed. First I
> > thought that my working tree was damaged or that one repo was damaged
> > thus I tried a fresh clone of another repo, cimmitted a change and
> > tried to push. The result was the same. It found .netrc for git clone
> > but not for git push, see the lines from access_log. After 401 the
> > same object is requested with the user name and the password with
> > status 200. This works for GET (clone and pull) but fails with
> > PROPFIND. It tries the access without credentials. the server responds
> > with status 401, git requests PROPFIND again but with an empty user
> > name and server sends 401 again. At that moment git push reports error
> > 22. Git 2.44.0 and earlier fills correctly the user name and password
> > thus after PROPFIND I see PUT  and MOVE with the correct name. The
> > lines from the failing git push after successful git clone (without
> > .curlrc) are below:
> >
> > 78.80.16.189 - zw [16/Aug/2024:16:08:58 +0200] "GET /cgit/ HTTP/1.1" 20=
0 20890
> > 78.80.16.189 - - [16/Aug/2024:16:09:35 +0200] "GET
> > /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 401 381
> > 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> > /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 -
> > 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> > /git/kraviny.git/HEAD HTTP/1.1" 200 23
> > 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "GET
> > /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
> > 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> > /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 -
> > 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> > /git/kraviny.git/HEAD HTTP/1.1" 200 23
> > 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "PROPFIND
> > /git/kraviny.git/ HTTP/1.1" 401 381
> > 78.80.16.189 - "" [16/Aug/2024:16:10:42 +0200] "PROPFIND
> > /git/kraviny.git/ HTTP/1.1" 401 381
> >
> > And this is successful git push after downgrade:
> >
> > ... (lines deleted, I have too many branches and tags)
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 200 41
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PROPFIND
> > /git/mg-software.git/refs/heads/ HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PROPFIND
> > /git/mg-software.git/refs/heads/ HTTP/1.1" 207 3425
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/master HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/master HTTP/1.1" 200 41
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 401
> > 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 200 41
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 200 41
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PUT
> > /git/mg-software.git/info/refs HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PUT
> > /git/mg-software.git/info/refs HTTP/1.1" 204 -
> > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "UNLOCK
> > /git/mg-software.git/info/refs HTTP/1.1" 401 381
> > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "UNLOCK
> > /git/mg-software.git/info/refs HTTP/1.1" 204 -
> >
> > The majority of my repos are private, authorisation is needed even for
> > clone and pull.
> >
> > Zden=C4=9Bk Wagner
> > https://www.zdenek-wagner.eu/
>
> Just a note, I found a computer with git 2.45.2 in Fedora 39 and git
> push works, it finds .netrc without .curlrc.
>
> Zden=C4=9Bk Wagner
> https://www.zdenek-wagner.eu/

I have done a few experiments. If I use curl itself from a command
line and .curlrc does not exist, it reports 401 when accessing the
resources which require authentication. If I create .curlrc with
--netrc, I can access authenticated resources from a command line and
curl takes the credentials from .netrc. However, even with .curlrc I
still get error 22 from git push. I tried the curl library in the D
language (dlang.org). It ignores .curlrc and .netrc, thus
authenticated resources return 401 unless I specify the credentials in
the programs. Thus it seems to me that it is not libcurl which honours
.curlrc and .netrc but the CLI. It seems to me that git itself should
do it as it did up to 2.45.2 for git clone/pull/push.

Zden=C4=9Bk Wagner
https://www.zdenek-wagner.eu/
