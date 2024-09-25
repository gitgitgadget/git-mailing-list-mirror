Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA11552E0
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303434; cv=none; b=G3c8Zj5i0VWqnL/HU6VaFzG9e34Eh8xA7/PqVR1keMLWhhi5TcKXstpIedKwVmZm8p4YxOR9FpJQYF3VPUPU/ezi5VjROcb6KvXRp21W9Pi3Zudf4jbjp+PxbNMYxGtItTHDOjggOJ1VZQSxEsda6uknZfa2ZYYlqoupkrgay4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303434; c=relaxed/simple;
	bh=KtZ5MchffcK1QWaJoMMarkgT8fk6KKxSLuonrxWzEfE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MwlNaxIe80UR2Cii///R4O9NBL2rPqncN0rSkwPvsyznKuU3y+8j7k8/lP5RMlHrEJjaMVRTw+OfkM8N4tAIBKvPqxfHjHMXldJaOGCUKHGrBfUcd+cNCFwCuFRgMLLT7PmvmjfVQVO+UHZkd7gmcMp6TeEHHn8Sh0niUi5MSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.93.96] ([176.0.7.240]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MJWgK-1seFPw3baK-00McDR
 for <git@vger.kernel.org>; Thu, 26 Sep 2024 00:25:16 +0200
Message-ID: <ce9f0440-e724-4116-b63a-0e62c46c170d@anselmschueler.com>
Date: Thu, 26 Sep 2024 00:25:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: git@vger.kernel.org
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Confusing error message for git switch -d
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
X-Provags-ID: V03:K1:KXCyAD525pV02Unsb46wjcNqgVyLvLLNK0FNUZaIAXzMU7ZHr9x
 ggnBgXa3YkN7eoy0iaW/OBmuAaXThAss9vcvx+dBkq22jrel/hiRVUl+3KKLLNgCU1H0zp6
 R62sLw7YXnUbFHqzqI4VAJ1ugJ5I78fNTw4vP1KgWAIjXDw/JbSNPHEjrQDJxCUhTCWcXtv
 zdmsvc7rJPxVClHNfrFYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/7N6Atz9I0=;HQM6L/ykD5CAaMikJGEFMhY63ZI
 bn4XkH8ppRDLMF4Vv9yA7ETpWekR5crXqRRP5Y1AWvqSRKwLK4yEE6OrHl1UQ4Hd2+3TmSHZQ
 JDSQ9BPM06DC+oveQZWqdUMwTqPONigeiE0cZAwRoROckDTKs3GXG5wCmNVbJ00J9K5W1jwO0
 xZMGMTTfX95gDzKQtHPelVQxVgjX3mt5DtN3tHpuSbwZ+Eu2n3AE6VpUknzI/1HZw5E9BSTBq
 TTyTERJ1RS3G29uAag84GdFmU4uyxoQ51zrlD0PlYj/UNIFkKjOTbXgj09qT8ONdoPfsMFBHl
 nvmKt1bWgBwntpyY18QDs6pBwkvyN1fBMRW45nY1kg1PlPtoS7kE6giXuyPqCckNtycGKfBvP
 XDNEgxSKfJpNimDbs4CQchT7TWxwMc2W+aErgzhHt7DTgeA6wL7dYLPNBVpXFALHjLo0oaBmW
 BM1LjFGMhY6JMxUXpPA1TPgjju7B0B6+DeSNo+GWpcqlkzEi6SKvThq7lnmTNWYTZv12vlJOu
 qgzAIuL9NGeGViVXVJpa7ZmFysL8xv18oSi/DMym11HXOl/aK2pgzHQhhVTN+Jakvc69f4S+I
 7bPer118X1gZAFMXVsUGX3mipL6YlAO6MdbErX4j2rRW4RmHfGlWu/WGNgIPVx1oJ4hXrVYtx
 WmZ6wMTL7Uy+iyma1BQM1OzH290Ygx52c3mRSR1mkLlXYGtAVZ7SE0OIUn/LP3kviT9xrAu59
 Fe/N9nYsVhJ2jT4WyxQEmCfDdoVjMfLDw==

Hi,

I just ran into a confusing error message when using git switch -d, 
specifically in a clone of the CPython code repository.

I wanted to get the code for CPython 3.12, so I tried running git switch 
-d 3.12, expecting 3.12 to be a tag (which it wasn’t, and it was a 
remote branch).

Git produced this error message:

fatal: '--detach' cannot be used with '-b/-B/--orphan'

This is confusing since I didn’t pass any of these options.

I believe I have determined that this error message occurs when using 
git switch -d to switch to a remote branch that hasn’t yet had a local 
branch that tracks it created for it.

Why is Git producing this error specifically?
It also seems that, whatever the reason, a user probably doesn’t know, 
so a better error message might be a good idea.

To clarify, if I’d known that my assumption of it being a tag was wrong, 
I’d’ve still expected Git to act differently, specifically, it could’ve 
switched to the commit the branch is pointing to in detached HEAD mode 
(as it does when using -d with other branches).

Thanks
Anselm

PS: Are there no mailing list servers that support HTML messages? Why 
are they not allowed, even with plaintext fallback?

