Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26760259C92
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764456354; cv=none; b=il8fL+E+Vgnp8LEwIE98wNYkVcDkEyeiw1YKCIt3IKiZDjC7V2Fon8j+TGZwjZRtJzTBLLrW090sdasW7T2/410/lBDs1e6p0bMIgbAKn5XCbuXFordcoBYJEZrFA6N5qyTkI8PAEbzB2FR0YPUWnbIrCY6iwcUFPYh9IzS6fqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764456354; c=relaxed/simple;
	bh=61mUpVAPs3XIPxteu9QVU52dtZLPQXKdqaMep81q+xs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qaB0hnj797GJtKgj/fp3n3o+sgIbb0brDvyMqLKmGT7N/RQAkXCqqdPhRnwLJOqnK8tvQSS/y7uKfRO4iBr8eoNLeTMqz92YLEpMRH2pJtkCZQoGW/Wl6e4DDEBGlPb72VT6FRYrW0/40SeAocSfYnB63zIKIJk3G6ThuRZZVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1iqTroL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1iqTroL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-787d5555274so28389927b3.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764456352; x=1765061152; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61mUpVAPs3XIPxteu9QVU52dtZLPQXKdqaMep81q+xs=;
        b=C1iqTroLM02PIj+e86aCqDOSaq20nbjXNT4+PxpZ59cb2bmQXLpC1We1/GpGDpNbn1
         hRgsc6rRtiUOKtpUkz0aapddhoseg1j093YxTsCVfMDaPz5z1L8dPtjDCm6F0mvf/YML
         OHwApIsh7GdoTct0RT1/gHBgugF/oRXxvKbJDNQ1YUqzDZ231t97eErUh2z2DvpKooXe
         zSJCx5/DbY4MAlngXcAKX4nS8ehQyv/NOOPIfuVgsldrNmSqAkWxOEyJAClzR2T8Tf99
         71EiEYPRRPaMszxwyqZRjSXj7GRb7QJHzwZq1lqSSHTeRVAQyLeS1M3dl4a0wLQUajO3
         Gkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764456352; x=1765061152;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61mUpVAPs3XIPxteu9QVU52dtZLPQXKdqaMep81q+xs=;
        b=lcjVXkwVlIbMkJAvN/t2ch5zoLK/itxR4qg8JkXgE2gIAU66mMa0rssOizNkSSeQoy
         AvTbDZ1FbQcphWYYWZUz0/tlIDbpMD6i2vmix5dOjmhjeRLRYnMsBc1UzJSMvcIFftAY
         XY7pRKiyn9mNHTwHPpjf8zKipTsiC4QpXYp4x6OgkaFKQl8u93wkexNphcGcq2H+yf/Z
         RS6Si4eC7WQXW52TgBbCshIpNAuQOAl7rRZbsVBqyYpwvtIi5CwpRZHLQNaTs+nqjiPm
         rlSjj88ej1RxdSO00UNaKj3BZk9fp08a7jT7PaPrKlRzI7rwjyySuvumTyRll4YZoN72
         I6gg==
X-Gm-Message-State: AOJu0Yys6NRIvBXrtdlp0/BRQEXxqa4T6Xiu6DR8mNRA8d3gC/8raf7Z
	aEERs3FGbjx1JlyRk3WIonZnIxHlXOZ361dWwJQjOK3OqKHa22zhY48nFyay4V0O0aady5ZbAow
	DDJX+6udY9kWzyhm9kxqcUpNoVAAlRbdmyhO5
X-Gm-Gg: ASbGnctmEiCfPhuhmcpAIFACMLXwTgt2pHa29w6pNLsoV/qd3w+zkZOGfLbyAoXXq7q
	yvuSH9pyXldvYNsgxmlK8u+11y5olTDwu0l2ITtGQmv3zd67Q7G6CahMmbfgHswrK+8CO/OAQaC
	wL6FkvgMz5kCN6SHOy8+XUjKVhjdirfJv5gwOuXReTxaEHqT3mWCu25fT1AqbDCpd+QKAZzADWs
	ZA0K9zH7Q8OurTHiC6ifoXo7SjBn1SZfhw8zEbh5reAY4WXnzHBQZuVZsHWS0/BAyZjFtTpMai3
	ONjNBeMP0jK2Ns+uD8+1XkfLO3LkdB9hV5+zZeFMLYUC6W+CWxZGjw==
X-Google-Smtp-Source: AGHT+IEylPtZNtqIIPxoaCMmVImfw9M/0aImTOWT1/LCNwZVp2QlybNIbWHV80tF0a2vXQPIQ5a1lvnH/pmf9lc351U=
X-Received: by 2002:a05:690c:338c:b0:786:3ee8:66cb with SMTP id
 00721157ae682-78ab6e2d96fmr181549397b3.30.1764456351995; Sat, 29 Nov 2025
 14:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 30 Nov 2025 11:45:40 +1300
X-Gm-Features: AWmQ_bn30n1vBd0wr3-B0oLt4ljg1IbZce89Yf2TckvArNTOglOMy7XQ6bdsDj4
Message-ID: <CANrWfmTjexptaqxD7b5zAh=gueQh_PC-YXdFmrJ+VLRUi-a_VA@mail.gmail.com>
Subject: `--max-depth` produces no output when <path> is '.' or ends with slash
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir --parents -- './repo/1/2/3/4/5/6'
cd './repo'
git init '.'
echo '1' >'./1/2/3/4/5/6/7'; git add './1/2/3/4/5/6/7'; git commit
--message="$((++number))"
echo '2' >'./1/2/3/4/5/6/7'; git add './1/2/3/4/5/6/7'; git commit
--message="$((++number))"

git diff 'HEAD~1' HEAD -- '.'
git diff --max-depth=6 'HEAD~1' HEAD -- '.'
git diff --max-depth=7 'HEAD~1' HEAD -- '.' # wrong, should produce some output
git diff --max-depth=100 'HEAD~1' HEAD -- '.' # wrong, should produce
some output
git diff --max-depth=-1 'HEAD~1' HEAD -- '.'

git diff 'HEAD~1' HEAD -- './'
git diff --max-depth=6 'HEAD~1' HEAD -- './'
git diff --max-depth=7 'HEAD~1' HEAD -- './' # wrong, should produce some output
git diff --max-depth=100 'HEAD~1' HEAD -- './' # wrong, should produce
some output
git diff --max-depth=-1 'HEAD~1' HEAD -- './'

git diff 'HEAD~1' HEAD -- './1'
git diff --max-depth=5 'HEAD~1' HEAD -- './1'
git diff --max-depth=6 'HEAD~1' HEAD -- './1'

git diff 'HEAD~1' HEAD -- './1/'
git diff --max-depth=5 'HEAD~1' HEAD -- './1/'
git diff --max-depth=6 'HEAD~1' HEAD -- './1/' # wrong, should produce
some output
git diff --max-depth=100 'HEAD~1' HEAD -- './1/' # wrong, should
produce some output
git diff --max-depth=-1 'HEAD~1' HEAD -- './1/'

git diff 'HEAD~1' HEAD -- './1/2'
git diff --max-depth=4 'HEAD~1' HEAD -- './1/2'
git diff --max-depth=5 'HEAD~1' HEAD -- './1/2'

git diff 'HEAD~1' HEAD -- './1/2/'
git diff --max-depth=4 'HEAD~1' HEAD -- './1/2/'
git diff --max-depth=5 'HEAD~1' HEAD -- './1/2/' # wrong, should
produce some output
git diff --max-depth=100 'HEAD~1' HEAD -- './1/2/' # wrong, should
produce some output
git diff --max-depth=-1 'HEAD~1' HEAD -- './1/2/'


What did you expect to happen? (Expected behavior)

Using `--max-depth=nonnegative_number` with '.' and
'./path_ending_in_slash/' should produce same output as with
'./path_not_ending_in_slash' instead of producing no output.


What happened instead? (Actual behavior)

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0.windows.1
cpu: x86_64
built from commit: 2912d8e9b8253723974b7baf1c890273b1a1c5bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.17.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
