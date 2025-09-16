Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E927280A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054885; cv=none; b=t/58oKSzHD+c5DSMsl9UMVvHYrjJB7y9zwWlFVjt0mE+BFCGunlZZCY9EO+jhaiPLRcVykHOuUkT49U+rX39ZPGaVMWgiBgyd7+V9R2yaatKpM68eYBcQOcOaht9XDCzpTW0DfDTQ6Bc4xH2Rp6GOtRyG7GwK+tIqM24EQPeGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054885; c=relaxed/simple;
	bh=vfNocyox8XnrlfSYMUhFFhYW4Q2UMT6Br+oa/sx89z0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fdAVPIZrQ4x9Sue6yUdMb6QoAn0XazrqpXBFpH01DlGL6NFL4yF6VNULxaMkdvlxz0kscAzBX86zM+xVdLcJG5nlnJ3zAleqXsy9o169YVuPbg2eCI74hWv8jmmF8h2KjGF5/+s1aYAzJw86tgdm/IGMAaZgvT7hHFGZFNQkm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.178.32] ([94.139.29.72]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1M4sD3-1uzzxm1ocJ-00CekO for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:34:41
 +0200
Message-ID: <de49d686-73fa-4bb9-9ec6-b65d5432a30a@anselmschueler.com>
Date: Tue, 16 Sep 2025 22:34:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
To: git@vger.kernel.org
References: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
Content-Language: en-US, de-DE, en-GB
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
In-Reply-To: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AWSilR4HE8g4dKknF5gsYc9IbtqYLtR6hxkcIMUS2x4VEC1TnI5
 KwqL4xsVQI/1JcRzRiQXenyDGv9788GBzsKRBUj++g/fOT5Qi0c2WknxcR9tqjzUoafoRQE
 wNSSCu+YJi8+oGb8WG/3tZCp0gKXHCnFX3XddW78CI3Yrz+7tZ2UojjFnvq4HpZlUeOO4bG
 jaHXOPiy1jZM3QmhhOWMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+C39XTN/a8A=;MQ0XqMYcIKWdngTc+EBgKMDMu18
 Pbu+jpG8vykHsNgVm9UaZsYL4JrMSLp7aN0/rcbIYP8tV567tTCNXrcPzPVET0G3oUTCrZWHH
 21dO4/Hur82K8VpCP0aKukDau6Yod8j0HdvwtUjFynPS2R0Iu+DeSE2H1TCR3lOyGEFU63UNe
 Kv63v1gX4TvaMgOupj5S4bkyaUwSNg37UAQC257kDqdSfEfewQFSbYKgr+KjWJ7pHt6b60r5P
 Q7UEoLTBuhtHjzUwy4F3IK6vUxX57IZsYnvhYc8xD6mYgsGS3UzR9Ff5pU1i/0uLf6bJXaR27
 5B3wIMQtNx9wz3Knh2E4+g+Yci8fgGWlD5ujiduklOwhi/htup2+Ep8sm6S+SqEK4pzSKTYe/
 wrhLEPx2R7C8oLdBkvCZnmSdhyHTNQGRVWALFDcoRG/7zfdKQpOMoNUk4AO43T2yFnDE0LMsH
 MozWMFgMZkSZOavZNDsc+xJ2iC31Qm6nkjKgmvMgk1mXjOAG++aMANEHlAmAxBiOWuTTW7/R7
 O2DXx3S81a4Ine2jtQ4R+4G/2rsYLwXpy+GCPFp96gThkipb0odohTvzbFW/7ewizR2keftvu
 nJEaOSwf7/0gMSJWxzpPbWtQVXOwQOWJZe11iAHxpWj2OQoos7NJe3Vf7XdKLBmpIt0zDkBda
 8KjvRM/0Poqmds5u/6JZ/xVZzbCQZYdwbW1uLxdfAMdg8gBT4+5fs5+17NgRcaZG4v+Fite88
 QfJVEJzHufnFfKi4Gghdt3Y1XvP/X1qIS/uy++ZwGJE9sCUdi9LDKCnPWOsVbff1ceh1HsXUw
 mm+kKgwJ+s9TkcMIJ2mwJiDhXFFEniZih4cC5oC86EWfSgUa+N7c3+ER7uCbvzr+ucocz2WNv
 Igfi1Q5O9I4yNA9+HgvCqLWmsgZmO+5XFXF2/3dkS4WHl+BmmMIq7skLHTDF2Q9bwvcCfRArl
 AwQHAfPraNZl93Dmr3jVHbZF2RoiO58Te6FtIhbCN+cjMzK3TL4oz1TR0dODd5q79hsUlJ9/l
 mtZObWGWyrBK879Lfel0YR8WAZtH3AMw4B12M145hY+bQFamL206j2tVzoSCe/Q6RkN3TSyjg
 qRASpdvaMsmCgytnNM6c4tAIr640mvOvJRpAy99Go4tt1ClcMFfLFWFtZFeobkKr1bR5quSmn
 P4jexMs7DQBmhLDgYP/A4DX1WWw7H5twH18WzId9+1e7VlQPu8cfCCGnZyRxJs1gRlXMnH477
 dsewBw5g4m7i+VzI4uFH66FCV/vNxQzRcBZveZJs9rFB+sj8ZisOvmvi1O8W47NW/DH/cGDSL
 1+Ay5aPa+OJQtGurW5sPnC3pbGlQmomf7pV08+w2fdf+MEYl8Xa0dk49cia2WSUkBU+dpTHjT
 qI31R3lD+P4MqNcA+u3owKg3xgGJQG4LhFQJOG/nFBmakcJRqq1mfsei/jm8iEv+byqOEZS3j
 MSBQ+cLuEQP733qq0hR3KeXakz4IDQoiYnQyr1xYFyUwyPAlSKhd6Ju5MJiMSYxaNnGgAGFwp
 UZ03Vjd8c3gY8lg5JQ3zUur0ApdCfDc6cIiebctphZHjGOGJ/EPrc3PvTCEtqgAnugsy0j8uA
 EkfGqgL7/ExObQhdYsjMVfsEJnaXVY8xRF7pPG8zF6YvkIGeY4RIinB7/MjH+Tphpb8U+qk90
 M78oO6gJhdydnd25QD1ED8a4LegM8PppFhM9smIG2dvg4JWiumfetWXs+Qc4WltPMCwAio8+h
 JW2NYbnuK0W1h

Sorry for that. I apologise for the messed-up formatting. Let’s try that 
again.

—

After a new repository has been created, before a commit has been made, 
when files are staged, git-status suggests using git-rm to unstage files:

$ git status
[...]
No commits yet

Changes to be committed:
    (use "git rm --cached <file>..." to unstage)
[...]

After a commit has been made, git-status suggests using git-restore instead:

$ git status
[...]
Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
[...]

Why is this the case?


