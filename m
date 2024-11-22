Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F017D341
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318301; cv=none; b=h/cG9GvLt66T9FMlKmIZmRX0tzbwpaiNHvWKI0Rh+SwgFMlGOJJ/55iqJ1tb7c56W064bIdEa1XbutRCnPmTMWJG6q0IjZOu8QO34IsFWmAzc45xFC0kiOC/uLioSQcc2pZLNNwHhHmj8Ciz3iqH3oXKYzOv+oKIZhCP5WlFxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318301; c=relaxed/simple;
	bh=qjeGP6Li21SADfJTOoQLWLnRO3PMTmcuAkYm9YfBLR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHxAgRgtUyVuoG0Q4nQZ54yoRCYrFzUDpD8E3oLOKdjOcmZEvLVA35x/YGySiYttnIzEgFHQmHVf2XIWsy1oUZlRWmRHf+aSrio7p61UmzC59VLqSQO2OqaQFvqmnJagYvRQ31++nMVViCrjUpmgiMSdBMSJWarzatd32gor/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0DWfm88; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0DWfm88"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7edb6879196so2144188a12.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732318299; x=1732923099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42GCzosLiQ2mHg92vYGDl2S4uYXGDZyt9f7nrTF3u3s=;
        b=S0DWfm88QY+3ce6vzT0dgpsf5/Y0gL5JNrbTt2t9BToYorvvy81oFWJwKPuVgUdKXb
         Tbs+PzHUX+BRa20FqXRyKH/sRu4ckJJ3CRUiH5JoDqbfAdDR+UbidDrFjwuCTE0u0GsY
         Dv4v8Txk2MPaXrMFRWL5jblX8yMXH8TjkSCCKqf7cMILlRqNI9V7Fta7Tc81H1NFZtdZ
         jCvcOerCBhzmWQLRBONBMdPygV21eY81Xh0ESSYVM2F3GI7L+dEkS4OnIlPwFwWfI3R9
         TpsOjiuXU7D7tvZQaTeZ5OUegyQQMQ8LCGAtdqLyawG059OiAt1qszAXqyszv/PoS8Ox
         +cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732318299; x=1732923099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42GCzosLiQ2mHg92vYGDl2S4uYXGDZyt9f7nrTF3u3s=;
        b=Up43pWOThhbsipJBNHQ7FyeZ/J0SrxMnwkGZAsrto8iQ4Mtrhf76UaZhFiAxoBO9rc
         tlir8sf4o6WTyjYonKNmcShThMBB5LyL8305fE/wU7cD5EQiy+k+csfzUWmJW+j75Ij4
         NAsvrujVli85jFc80IlLYrVBYpTexeCWU+/xtH2qVDoD+5ApBsqlDoMT/0UW3q8eNoip
         Wq/W7CjHqRpxGz6/aRDDp3P0avb8A4jpvDH2YjFDdtCHcmlyD5oZ65awKpWsNiMGx3Q9
         RB0nZdZ+wfhpJzaAErpQiVJ10oOYUFm9Ccz+RiBxwE1rW4DCJela7k7s2wyopvzM40mu
         ybfg==
X-Gm-Message-State: AOJu0YzQlu0LkR+qE7hsziWFrtMhbIi6XfsOYlJCEBNpkZZQuBosl+Qs
	PhbH09vhvML1vqPL1I+WvWtW5u3HVuiZH06/xxsGuzO865LEMiesO8sEEeYgwt+b5U9Oy3O+Pna
	ov4RM3ppZzCicdJTKtA24dWrvoWlmAHD2
X-Gm-Gg: ASbGncu735sK5FeyqF0HFD12udMor9lLyA7ixPIJpO6PDFLJsEETXCzDDkzfSk15lHT
	Q8X5Jn75ZlKfb3UbjSoj5Mc9QnvKz
X-Google-Smtp-Source: AGHT+IEBYTN8JVKfoy7wJPE8uWZsLzz2xGyoIzIyxxBOe7YOLo/+NY9DoydrbsRHjRDWqC10GnAVijxj/9HWyor27U0=
X-Received: by 2002:a17:90b:3c4a:b0:2ea:7755:a0f9 with SMTP id
 98e67ed59e1d1-2eb0e881fbdmr4906761a91.32.1732318298731; Fri, 22 Nov 2024
 15:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
 <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com> <CAC1phyYpt+B42vLbJpi0RMBJUn8D5oknBDp9PQ+6kD2db1Np0g@mail.gmail.com>
 <CAC1phyY-cZ-jfM2-W=SVN61K5x2c3bG=Xz8jdrnqSHoLc1Av6Q@mail.gmail.com> <CAC1phyaA7e56DJGu5d=qj9WY0c1b4G=CVG-HtenBcffOE16ZyA@mail.gmail.com>
In-Reply-To: <CAC1phyaA7e56DJGu5d=qj9WY0c1b4G=CVG-HtenBcffOE16ZyA@mail.gmail.com>
From: Zdenek Wagner <zdenek.wagner@gmail.com>
Date: Sat, 23 Nov 2024 00:31:12 +0100
Message-ID: <CAC1phyb17XxCNLmm7ngd9zBuaEZGEAR9yxqzL5QYUza6B-7MhA@mail.gmail.com>
Subject: Re: git push does not work over https WebDAV
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am writing again concerning nonworking credentials again. Since
Fedora 39 is now beyond the end of support, I have just upgraded one
of my computers to Fedora 41. Git has never been used there thus I hav
installed it and the version is:

$ git --version
git version 2.47.0

Instead of .netrc I decided to use a credentials helper

$ git config --global credential.helper store

I did fresh "git clone". Git asked the credentials and clone
succeeded. This is the log from the Apache server:

147.231.140.224 - - [22/Nov/2024:22:26:06 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 401 381
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 59
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/c5/122ca0644641aef7dd53b0b095448eb8ff742f
HTTP/1.1" 200 178
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/43/fceaedb60d21f93ca7a7908c903ee6007a30eb
HTTP/1.1" 200 55
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/c6/a50eb96661043d3fea556cd3bc724300b48a30
HTTP/1.1" 200 142
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/5e/f9e1d8cff78c122b41f587903b4c64be9369a9
HTTP/1.1" 200 179
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/c3/712bb92eb9f7918484e90e5b21b28c28726e61
HTTP/1.1" 200 141
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/d8/7980603a97b6156c8e9af88efe736926fe3878
HTTP/1.1" 200 55
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/c8/69d749522329ac3df7a012cf4a33ca5759df54
HTTP/1.1" 200 141
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/8e/39f776d5b81af2b1399b5c31875a05d368f44a
HTTP/1.1" 200 55
147.231.140.224 - zw [22/Nov/2024:22:26:31 +0100] "GET
/git/kraviny.git/objects/cf/26b368c4cb7d92b941e6e67a669ba3ccfe292e
HTTP/1.1" 200 136

You can see that git/curl requests service=3Dgit-upload-pack without
credentials, the server responds with 401, git then repeats the
request with the credentials, the user name is visible in the log.
Afterwards I have verified that the credentials are stored in
~/.git-credentials. I made a small change, committed it and pushed.
Git did not ask the credentials and "git push" failed. This is the
Apache log:

147.231.140.224 - - [22/Nov/2024:22:29:25 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
147.231.140.224 - zw [22/Nov/2024:22:29:25 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 59
147.231.140.224 - zw [22/Nov/2024:22:29:25 +0100] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
147.231.140.224 - - [22/Nov/2024:22:29:25 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381
147.231.140.224 - "" [22/Nov/2024:22:29:25 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381

You see that service=3Dgit-receive-pack is requested without credential
and after receiving 401 it is repeated and the right user name is
visible in the log. Then the PROPFIND method is used without
credentials and after receiving 401 from the server git tries again
but with an empty user name. It is the very same behaviour as I
noticed when .netrc was used (see one of my porevious mails).

I have deleted .git-credentials and tried "git push" again. Git asked
the credentials but faile in the very same way:

147.231.140.224 - - [23/Nov/2024:00:23:41 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
147.231.140.224 - zw [23/Nov/2024:00:24:08 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 59
147.231.140.224 - zw [23/Nov/2024:00:24:08 +0100] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
147.231.140.224 - - [23/Nov/2024:00:24:08 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381
147.231.140.224 - "" [23/Nov/2024:00:24:08 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381

Finally I have removed the [credentials] section from ~/.gitconfig,
tried to push again and the error is the same:

147.231.140.224 - - [23/Nov/2024:00:26:40 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 381
147.231.140.224 - zw [23/Nov/2024:00:26:57 +0100] "GET
/git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 59
147.231.140.224 - zw [23/Nov/2024:00:26:57 +0100] "GET
/git/kraviny.git/HEAD HTTP/1.1" 200 23
147.231.140.224 - - [23/Nov/2024:00:26:57 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381
147.231.140.224 - "" [23/Nov/2024:00:26:57 +0100] "PROPFIND
/git/kraviny.git/ HTTP/1.1" 401 381

Thus it is now clear that it has nothing to do with .netrc and
credentials helpers but for some reason an empty user name is supplied
when curl is used with the PROPFIND request method. The log does not
say whether a password is supplied.


Zden=C4=9Bk Wagner
https://www.zdenek-wagner.eu/

so 17. 8. 2024 v 17:18 odes=C3=ADlatel Zdenek Wagner
<zdenek.wagner@gmail.com> napsal:
>
> so 17. 8. 2024 v 10:33 odes=C3=ADlatel Zdenek Wagner
> <zdenek.wagner@gmail.com> napsal:
> >
> > so 17. 8. 2024 v 10:14 odes=C3=ADlatel Zdenek Wagner
> > <zdenek.wagner@gmail.com> napsal:
> > >
> > > so 17. 8. 2024 v 4:25 odes=C3=ADlatel <rsbecker@nexbridge.com> napsal=
:
> > > >
> > > > On Friday, August 16, 2024 9:11 PM, Zdenek Wagner wrote:
> > > > >To: git@vger.kernel.org
> > > > >What did you do before the bug happened? (Steps to reproduce your =
issue) git
> > > > >commit git push
> > > > >
> > > > >What did you expect to happen? (Expected behavior) The changes bei=
ng pushed to
> > > > >the repo via https WebDAV
> > > > >
> > > > >What happened instead? (Actual behavior) $ git push
> > > > >error: Cannot access URL
> > > > >https://userfiles.math-gnostics.eu/git/mg-software.git/, return co=
de
> > > > >22
> > > > >fatal: git-http-push failed
> > > > >error: failed to push some refs to
> > > > >'https://userfiles.math-gnostics.eu/git/mg-software.git'
> > > > >
> > > > >The credentials are in ~/.netrc, git clone and git pull works fine=
 on all my repos on
> > > > >the same server, git push returns the same error
> > > > >
> > > > >Apache error log reports successfull access with the GET method (c=
lone, pull) but
> > > > >"user not found" for the PROPFIND method
> > > > >
> > > > >What's different between what you expected and what actually happe=
ned?
> > > > >git push does not work at all
> > > > >
> > > > >Anything else you want to add:
> > > > >It is apparently an issue of git which is not OS specific, I have =
the same behaviour in
> > > > >Fedora 39 and Mac OSX, both having git 2.46.0. Everything works fi=
ne with git
> > > > >2.44.0 and earlier. I have
> > > > >temporarily solved my problem by downgrading git in Fedora 39. I h=
ave not trid
> > > > >2.45.0.
> > > > >
> > > > >Please review the rest of the bug report below.
> > > > >You can delete any lines you don't wish to share.
> > > > >
> > > > >
> > > > >[System Info]
> > > > >git version:
> > > > >git version 2.46.0
> > > > >cpu: x86_64
> > > > >no commit associated with this build
> > > > >sizeof-long: 8
> > > > >sizeof-size_t: 8
> > > > >shell-path: /bin/sh
> > > > >feature: fsmonitor--daemon
> > > > >libcurl: 8.9.1
> > > > >zlib: 1.3.1
> > > > >uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:5=
6:10 PDT
> > > > >2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64 compiler =
info:
> > > > >clang: 14.0.0 (clang-1400.0.29.202) libc info: no libc information=
 available $SHELL
> > > > >(typically, interactive shell): /bin/bash
> > > > >
> > > > >Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC =
Mon
> > > > >Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux
> > > > >
> > > > >
> > > > >[Enabled Hooks]
> > > >
> > > > Does your .curlrc specify --netrc or -n? Those appear to be require=
d to specify the
> > > > Use of .netrc in curl.
> > > >
> > > > --Randall
> > > >
> > > I do not have .curlrc on my computers, it was never needed. First I
> > > thought that my working tree was damaged or that one repo was damaged
> > > thus I tried a fresh clone of another repo, cimmitted a change and
> > > tried to push. The result was the same. It found .netrc for git clone
> > > but not for git push, see the lines from access_log. After 401 the
> > > same object is requested with the user name and the password with
> > > status 200. This works for GET (clone and pull) but fails with
> > > PROPFIND. It tries the access without credentials. the server respond=
s
> > > with status 401, git requests PROPFIND again but with an empty user
> > > name and server sends 401 again. At that moment git push reports erro=
r
> > > 22. Git 2.44.0 and earlier fills correctly the user name and password
> > > thus after PROPFIND I see PUT  and MOVE with the correct name. The
> > > lines from the failing git push after successful git clone (without
> > > .curlrc) are below:
> > >
> > > 78.80.16.189 - zw [16/Aug/2024:16:08:58 +0200] "GET /cgit/ HTTP/1.1" =
200 20890
> > > 78.80.16.189 - - [16/Aug/2024:16:09:35 +0200] "GET
> > > /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 401 38=
1
> > > 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> > > /git/kraviny.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 -
> > > 78.80.16.189 - zw [16/Aug/2024:16:09:35 +0200] "GET
> > > /git/kraviny.git/HEAD HTTP/1.1" 200 23
> > > 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "GET
> > > /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 401 3=
81
> > > 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> > > /git/kraviny.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 -
> > > 78.80.16.189 - zw [16/Aug/2024:16:10:42 +0200] "GET
> > > /git/kraviny.git/HEAD HTTP/1.1" 200 23
> > > 78.80.16.189 - - [16/Aug/2024:16:10:42 +0200] "PROPFIND
> > > /git/kraviny.git/ HTTP/1.1" 401 381
> > > 78.80.16.189 - "" [16/Aug/2024:16:10:42 +0200] "PROPFIND
> > > /git/kraviny.git/ HTTP/1.1" 401 381
> > >
> > > And this is successful git push after downgrade:
> > >
> > > ... (lines deleted, I have too many branches and tags)
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/tags/matrix-library-0.1.0 HTTP/1.1" 200 41
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PROPFIND
> > > /git/mg-software.git/refs/heads/ HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PROPFIND
> > > /git/mg-software.git/refs/heads/ HTTP/1.1" 207 3425
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/master HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/master HTTP/1.1" 200 41
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 401
> > > 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/input-flat-ext-branch HTTP/1.1" 200 4=
1
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "GET
> > > /git/mg-software.git/refs/heads/smps-crossfilter HTTP/1.1" 200 41
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "PUT
> > > /git/mg-software.git/info/refs HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "PUT
> > > /git/mg-software.git/info/refs HTTP/1.1" 204 -
> > > 37.48.21.228 - - [17/Aug/2024:00:51:34 +0200] "UNLOCK
> > > /git/mg-software.git/info/refs HTTP/1.1" 401 381
> > > 37.48.21.228 - zw [17/Aug/2024:00:51:34 +0200] "UNLOCK
> > > /git/mg-software.git/info/refs HTTP/1.1" 204 -
> > >
> > > The majority of my repos are private, authorisation is needed even fo=
r
> > > clone and pull.
> > >
> > > Zden=C4=9Bk Wagner
> > > https://www.zdenek-wagner.eu/
> >
> > Just a note, I found a computer with git 2.45.2 in Fedora 39 and git
> > push works, it finds .netrc without .curlrc.
> >
> > Zden=C4=9Bk Wagner
> > https://www.zdenek-wagner.eu/
>
> I have done a few experiments. If I use curl itself from a command
> line and .curlrc does not exist, it reports 401 when accessing the
> resources which require authentication. If I create .curlrc with
> --netrc, I can access authenticated resources from a command line and
> curl takes the credentials from .netrc. However, even with .curlrc I
> still get error 22 from git push. I tried the curl library in the D
> language (dlang.org). It ignores .curlrc and .netrc, thus
> authenticated resources return 401 unless I specify the credentials in
> the programs. Thus it seems to me that it is not libcurl which honours
> .curlrc and .netrc but the CLI. It seems to me that git itself should
> do it as it did up to 2.45.2 for git clone/pull/push.
>
> Zden=C4=9Bk Wagner
> https://www.zdenek-wagner.eu/
