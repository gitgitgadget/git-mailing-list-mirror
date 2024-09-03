Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5C1EC01E
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403709; cv=none; b=oDbkruXRIHaIYBY3Jik1qM6b7NwWw0aShRDl4KKJrleRMWqlrQkCS8D1H5UK1ScaUKShyF+soqVwFFR0tM7L8BKX/VVMZ4pqqcGPTNZw7gN4/s6QFG3lWcBzK4/zSw0DgKpvBQJocjFtaoZFtzNG3O3KGm1hUqlqNYU08Blh30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403709; c=relaxed/simple;
	bh=ZKtBI+lrFhKqaOk2NwIp1SHtGbLhVKwsvzZ+sqbcueU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FSrNaUV3YxP8irjJxhIRDas6b8MGV+KgZZvywEq7dC5fNgGj5av7324VF/6W4m/HpZSCt4r5Vonq7S7CAEnXK2PP2fP39Hib3oZtn5p3fmT65I4MM0aMnnvUijSQgiHxMIBhmdfdVJVWGffMuH3Dy6m7NxoVLbWOyzEFZ7tmHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3TJC+cn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3TJC+cn"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a16c53d3cso260416266b.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403706; x=1726008506; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKtBI+lrFhKqaOk2NwIp1SHtGbLhVKwsvzZ+sqbcueU=;
        b=G3TJC+cn9HUBnyi1j1nXlL0WqURsSbf/xtQLBGj8GGBxhWRqeX8jqrYmtB8INVeMhr
         oGc3QmCePPZGIpv4Wr4mmkxU5Krn/U00FMC9WnFb6ZDeMa9QBpz/r1re6MjyiCxyJn5E
         lcA0/Vj9+t56OBFCy0f1MIrlsbr0pFmrP4I3+eFyhzthAytwokQTORYTMhsOvdsc75Gy
         RZQhByvldu7YW2RdRUngfL6IqnRLbHBaTqMMGbbQh9PZgxAiGmqW/kIG+o1ZM+VnPwVQ
         kq2lRDDJu+yp9TUHhMZajeNBunik3I/Wg/Y4fIMg1PHxv+wkfQNuRDbNZiri6VKP0UBT
         M2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403706; x=1726008506;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKtBI+lrFhKqaOk2NwIp1SHtGbLhVKwsvzZ+sqbcueU=;
        b=jHYdEB1kzDr6GeNZiR15NPsMS0nL49LjkdNrUNco119kALWFBxZ4cBbOKnyy6QouVt
         T7sxlXm3xGq6+y0fRhs4Te1LQ63pQSuheJB6chPAeF2ujQP3E0XM0I1XCnMlWhWgFuPf
         5bYn3Pebeoz+fxv1JSanpIQdPbxASwBNqH2IRgQwHWjXjV2zPoeyVMR77WrR9XM3ozRk
         zcc5hOAcasH5bE4UxKzdkJ4orYhwgMg7CtrjWjWReTffUIXmCAmgIoTGh/rgTyfjTd2Q
         Y8ZFEquyi57JdUOiwDhpRlpwTfpVXR4VMw289wPItl5uUqRKuNBRuY9PsrjA8i6v1hnL
         /FPA==
X-Gm-Message-State: AOJu0YxyuRj0Um3qxcqoftcfSFFZJKNkLeraKRLdD9exA9dTzJ2x6JZ8
	Kh6wyTx1fCK7feuscRaw4/8iJsX1u7aHr+bs1Dav73MGTBXYyMgQS7XbpgNF3ZuuzI4ebZgdxjP
	IYrgtgplBRpLp5ghcJivZhXybnw99iAyl
X-Google-Smtp-Source: AGHT+IHYu3QKloo33tcs0/3fxoqeHDoqLiYVnozNbB91HwyLDwu7/Kn/+3Q26TNYTEXFZaTt1NjSrm5hD6v+tv8zbSQ=
X-Received: by 2002:a17:907:8694:b0:a86:a1db:7aed with SMTP id
 a640c23a62f3a-a897f8364d2mr1466250866b.22.1725403706019; Tue, 03 Sep 2024
 15:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 10:48:15 +1200
Message-ID: <CANrWfmS3ja=-7PWHESJVYX2YGQbCkX8-xbAgghgoNZZDpwKUoQ@mail.gmail.com>
Subject: `git remote set-url <remote> <newurl> [<oldurl>]` fails to set first
 url when multiple urls are selected
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server1' './server2' './server3' './server4'
'./server5' './server6' './client';
git -C './client' init './repo'
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote add server 'file://'"$(realpath
'./server1/repo.git')"
git -C './client/repo' config set --local --append 'remote.server.url'
'file://'"$(realpath './server2/repo.git')"
git -C './client/repo' config set --local --append
'remote.server.pushurl' 'file://'"$(realpath './server3/repo.git')"
git -C './client/repo' config set --local --append
'remote.server.pushurl' 'file://'"$(realpath './server4/repo.git')"
git -C './client/repo' config set --local --append
'url.scheme1://authority1/path1/.insteadOf' 'file://'"$(realpath
'./')"'/'
git -C './client/repo' config set --local --append
'url.scheme2://authority2/path2/.pushInsteadOf' 'file://'"$(realpath
'./')"'/'
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote get-url server
git -C './client/repo' remote get-url --all server
git -C './client/repo' remote get-url --push server
git -C './client/repo' remote get-url --push --all server

git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')"
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')" 'server'
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')" 'server2'
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')"
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')" 'server'
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')" 'server4'
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' remote get-url server
git -C './client/repo' remote get-url --all server
git -C './client/repo' remote get-url --push server
git -C './client/repo' remote get-url --push --all server

What did you expect to happen? (Expected behavior)

https://git-scm.com/docs/git-remote says:
if <oldurl> is given, sets first URL for remote <name> that matches
regex <oldurl> to <newurl>.
if no <oldurl> is given, sets first URL to <newurl>.
so these commands should not fail:
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')"
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')" 'server'
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')"
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')" 'server'

What happened instead? (Actual behavior)

these commands fail:
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')"
git -C './client/repo' remote set-url server 'file://'"$(realpath
'./server5/repo.git')" 'server'
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')"
git -C './client/repo' remote set-url server --push
'file://'"$(realpath './server6/repo.git')" 'server'

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
