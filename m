Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293F3F8893
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855687; cv=none; b=ZK4GvzgTDNL1zfELYeCNYPz8sn3EqiyVCDtzOZG/hjcdynL83w/VJhVwAvkVWjJun2Tg7bxIfpqNipaEc7S0GRP5B7m2bLbDpONqHv2nExVqJiAtnjhmVkif71Yt2Jt9svCO7wuk1cM6JYest41pvcfORmiiRmRi1t+WKABsn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855687; c=relaxed/simple;
	bh=tk+Rbv8ojOHx+J52XFUR4ePyXCz15Lxfc/ZwGmqaC0o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4ekRS3kZsdknb/EOcyDAFqHvTsYjyP9FrjESdUKuIruOrxOl1idv3Yzq7SuG/NZzIOQSOCLUtrJTZGerIebWH1kj7YOS1IeR663A8+xP3dkyPKaHsRTGlL1QoXiVeZe9OYH52BQQ2lsQ16oXBP+oaJ82GdY/UHvzGUuztZD5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=RXuTCZjg; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="RXuTCZjg"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6888LJCT009336-6888LJCV009336
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 8 Sep 2026 11:21:20 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x3r4x-007AYs-Tf;
	Tue, 08 Sep 2026 11:21:19 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 11:21:19 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 2c12ebb0;
	Tue, 8 Sep 2026 08:21:19 +0000 (UTC)
Date: Tue, 8 Sep 2026 11:21:19 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Paul DE TEMMERMAN <p2trman@gmail.com>
CC: <git@vger.kernel.org>
Subject: Re: [bug] git worktree add deletes my entire directory
Message-ID: <20260908082119.lw3hN%taahol@utu.fi>
In-Reply-To: <CAN=ULkdkRqnt_TP_pawiuuhod-_XVU=uDovYNMjbgQQ2jXQVpQ@mail.gmail.com>
References: <CAN=ULkdkRqnt_TP_pawiuuhod-_XVU=uDovYNMjbgQQ2jXQVpQ@mail.gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gYWhwaBQkGKA8FCQEERgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=eWuTpdvuwe4etoAofYIG9BiwCnFzfE1tPlJv/FhWX/w=;
 b=RXuTCZjgrYw4qXNROSdyTTyv6HVg7aWIibiLfp9F92hdhBKFhbeBTylYyAS+cum6cOVUxwf7icTs
	kkak0S9UnzoCUKsGoF06kC4PWRr7x46XHDaSH4AGHQmdWoJaNYPaL+iJVJ9vHYI0nLM2YQBM6Zo2
	FRjWM5XMq410uUSXxYvAYWAQJwI2p8exMCqbZvvBVMyha1pFJW4lmCpDpyQEg9qXqf6xQHnTBPzV
	doykjkInRpPbcxGKZqhE0NHZzj9Q69khhVNrEv4jsWO7O2RctjeCZVzqsHiQWy2sUW5VzK0nlsfu
	85ZGOVLt6Zh7xqQggNnoS1m0hBt71ENuC2kamQ==

Paul DE TEMMERMAN <p2trman@gmail.com> wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git init
> touch a.txt
> git add .
> git commit -m "Initial commit"
> git worktree add "" HEAD
> 
> What did you expect to happen? (Expected behavior)
> fail and not delete my workspace
> 
> What happened instead? (Actual behavior)
> failed and deleted my workspace (including the .git directory)
> 
> What's different between what you expected and what actually happened?
> Git deleted my entire workspace and the .git directory.
> 
> Anything else you want to add:
> No
> 

Thanks.  The issue is being worked on, and the fix is already queued to be
merged to 'master'.

Links:
  <https://github.com/git-for-windows/git/issues/6346>
  <https://lore.kernel.org/git/20260825180350.2099-1-l.s.r@web.de/T/>

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.55.0.windows.5
> cpu: x86_64
> built from commit: 32c4f7689275d233577576630e1ac5b7eb354eb0
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> rust: disabled
> feature: fsmonitor--daemon
> gettext: enabled
> libcurl: 8.21.0
> OpenSSL: OpenSSL 3.5.7 9 Jun 2026
> zlib: 1.3.2
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Windows 10.0 26200
> compiler info: gnuc: 16.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
> 
> 
> [Enabled Hooks]
> not run from a git repository - no hooks to show
