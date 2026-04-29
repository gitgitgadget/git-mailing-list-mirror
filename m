Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E42DAFD7
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504413; cv=none; b=stnzKclQRRQRO4eVLaUw9chQC3fYlD290L7SEyUqg/NWatLs4KPAxqv7f2RJO+uFnZZBPRP2OaxX1biu+GakEd9wG55aaoymHg7RISrPlSuKTqq48llcqTB9uvYXhDl0orE8iGHz/nzhplUt2K1XCqVP+isWERsawaYTyUeaLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504413; c=relaxed/simple;
	bh=Vh4hoDFDmwi1n8zbzwnv8OV0pXlaSkz4oDeSetjIUUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=awbo9gfJkUmBfncCWEXmKstmRvNqgtApAeglqBk7VcUxLmdA2OMjyZGsEo+7lH5WQ69LZLikZ0AUz6HouibuJs7Z3wW6nICIorcEYrBWlcVq57vjlEaBy19gjDH1rvIMWpoFZGn+dqcNIIWT2gNbZgn+ByTpyJP3uQ3pTwtfG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1N33ZD-1vMBVH2aA1-0186hW for
 <git@vger.kernel.org>; Thu, 30 Apr 2026 01:13:22 +0200
Message-ID: <0f3ef394-d96a-42f2-825d-53cb475a2363@anselmschueler.com>
Date: Thu, 30 Apr 2026 01:13:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Git maintenance fails without meaningful error message if any remote
 is no longer available
To: git@vger.kernel.org
Content-Language: en-US, de-DE
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K1ZLndb6a3Bl8etL6ppRUkBLR4KiRB9TPWIV7R/1NQ117YMwioc
 0x94hepmRAKiEUqg0FtF/hDkeeppKudNaLZx4Ih0Wt9057tYwbjQXiqnf0KSV70TImk5Ghf
 kCSGvzbfbIGAU6XyGOSBG3LyWzEj3kbPbxNWN7QMSM+hoZggMhrjQa9cayINHqt4KsjY1hV
 TebUEh11z9Djeq9hJ1Dsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SHS3iMhuyW0=;NKgz4pfYI7tzJJaxISNN49sqXUp
 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
 HzhsP97uVjzPrDhYr/gA=

I have a repo with multiple remotes, one of which no longer exists. When 
git-maintenance runs on it, it fails during the prefetch stage because 
that remote doesn’t exist anymore, and gives a mostly unhelpful error 
message:

$ git maintenance run --schedule=daily
ERROR: Repository not found.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
error: failed to prefetch remotes
error: task 'prefetch' failed

I think that
1. git-maintenance should report which remote it’s encountering an error on
2. git-maintenance should continue fetching other remotes even if one fails

Now, on my system, the systemd timers for git-maintenance use 
git-for-each-repo. Not sure if that’s upstream behaviour or something 
Nix/home-manager does. But if it is upstream behaviour, it would also be 
great to report the repo the error comes from, since I basically had to 
guess right now which repo was erroring. Luckily I have only three repos 
under maintenance so that was fine.

Let me know if you agree that this should be done. I would be open to 
writing a patch (no promises though)

Anselm

