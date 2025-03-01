Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA421487D1
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844614; cv=none; b=FMtXYOPK84ABN7XGIjCQLVImMb4rA2E3XxlIMW/yfGzz9kXTN0YYlonJC707WhqUnyyltvaAJEp/yJJaaim4B9LfASW/1Lc7Y8soHnX/GmD+NtD7AOR7dIsa45WstJiDYMhppoL3QojidOJYgwM6vAuR5HkOLOeRpDn8bwk/f3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844614; c=relaxed/simple;
	bh=kVzDS6GkbPNzJcsP614Lrnki6JfHQsPmOflpTCQrwoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N2qCrQULj+j4ANvVdxF57RXpyzONLY3TltuGiLhsKPSd4lVwN08p2VOnOk4TS0H2oK63ZkFoASgt/PJBduXiCXleSErtDPJhGQeUWFY2yBBQMx9jdL8mAXe8nSIaH4g5NiT/WqNXgbyfQuq3eBwbmRc54XjqUTkyXuwXXfaJpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=S/z9jgeS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="S/z9jgeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740844609; x=1741449409; i=l.s.r@web.de;
	bh=JSux5AnkjEqEJejKszVHxIHW34nNWt3LwO6zrV1+80I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S/z9jgeS9Lqfr87P2f5WH40LRpyAWednF65Agzu91ccWfX9bsyc9vmmzI7SRps+2
	 x6fjKG2EEDtDDVp1IhlPPu2B3+cSsiB7OenzsdzZTO+PvCAup/19a46udQ2u1nCiJ
	 +YsmEvV7gALO0NPDbyPIV+z8sGn/SWfOUenwI1AT2G+9RrL+kwL4Ck0IMVtTphE8R
	 dodYsAGeIZNVuJKb7cqJN0vnp77F0H/LHAFTBkfPiWC7xv48OUIwtG7fi240oirmB
	 yuMjuewjmbuf6dToqGVR+v7of+AwnSIc8XBh1jc7C4pao/xo22LUC7fDA8UUwfj0j
	 uGgn2UV70Tl7AE2XWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.81]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1tROjl0kGK-00qgf9; Sat, 01
 Mar 2025 16:56:49 +0100
Message-ID: <70bab132-1107-4946-8ef9-24c6b0f9d193@web.de>
Date: Sat, 1 Mar 2025 16:56:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: Null pointer dereference vulnerability in commit.c
To: H Z <shiyuyuranzh@gmail.com>, git@vger.kernel.org
References: <CAAJd+fZUEo15C29KSk61-P+7x=bjhgQ5iDTdbqV++NY4+iGchA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAAJd+fZUEo15C29KSk61-P+7x=bjhgQ5iDTdbqV++NY4+iGchA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MYL/AHEbna+UT/OKjlmRYySifT69wolkJpBiufz7/7L0CikxCsQ
 jNF+iBnbSiBmlnj+UXsOU+6XN/biwNAFmxNiCg5wq8euc+KMEgS+I7CXFRlJEcRVdeYhnOq
 F3PWZ1kRDXTonEAU+8j/cHKIWdXhOFaiDG48uC7kAhFX/P0SUFvk7gq8qZ12lJYBHyaQBHm
 MU9RQ3XN0W91B+ZlAdUhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:afPSHtikPTc=;cSOlsddAYLmujznrFa7nQugOnQB
 v96Pw7A13z0wAhc21zFhDoWR8Rz1zr4xhzr6MxToMmvTyz0KDXjIGVu4IY+5cSjAC08XZPQrn
 OF7aO8FRzQJZX30ojxn6lEh8cMUXWoGx6taA9jS/lgJo3UVsol6BMEORnTygClTvsJTsdjbKx
 LuTQpkWmMSsqdVhiPj16sVy2SqdTouHLbe/GUBbG1MvATzpeR2VKHwFMRhP8TVrgySl1JaGAT
 iuGxFbxV+ESI5SO9e/vXkwz44n/kQ+255PsURyGwWL8tdvmMV/cJifqUDYMdR7os3weji7qUr
 mDV+5iHOL5CyOhaCnjT8pwrXKG+e/vzk0jEQWSqQIjOHB7UVSmIctNdYqO/wjz1uDhngVYpdS
 o8f6/AZz6fyzUs10kiaIAZ1EfS3KL1ZQAgttSrHm40r38hBdyrG4CiofmXs579U3nt9kA1G88
 XVWoKMVCdJqiZySSHJzlKyPvv2YytnjMzsrfwvNuxbwYpaleQab7qTxuRnot01ArYWLvtJV8B
 uJv1jq81KU6jYsnusQOo+fJXLFKbtsO6GMcipKfu8CyyzZNq/twyYi2W/MhbVGqt7/AEkArNr
 1u+x7J6x4jMGoqh5ptVeYpJSMQvO8q6o7g2u+IVkvxXzCxMf2TPjqf4p+H6L9WCEzx0lvOLbw
 Yw9nYyy/ir403I7PwyV2es13T9vTM4OLXDb4DP6+LQhd/1vkcDicO/K/lQMYtFjGOgITwYSYy
 Saa8StSmH5qJJDMNB+tvRQALH2VJvog3+LZ0N4lYkv7VUyAYwa//93gsl2YhDpSeoS+zlCAQR
 jeNhIaSG4jIRkp0y4BDxevdLrgHsbDuFwJLRMkxjnLiM/I1ArlHOUNOy3VIY4L4Wa3KLvMcC5
 u4xrxkcdDwHJjck9Queq6c0R8o1G3tDyD6lqkirJ7PAKf7MF2QV66e74Tpu5YBh7M6Vx1nO6B
 SgU919zljfLC51HCZ1FQScseHQH5lLdym2fYIyv61gCqKpFmaIeEumC8vsiIE+r7lji4escG3
 sgA9n48SYbctcpGXssneUr825tefEU4kcZX0fJEB2vXoRBhEXI2d22IxhMtQ6u4Lr31LDhcuO
 7rJJ7OPttwp/LQTd3grBCWhiQ7d0fKONeAWW5udrWoqhpwKjo7AE6F8zUjlAwrVvtJwskh+dk
 yI/IiVhkLhliJ8CHpSS4elX/mHDmdtRn3UQ1fBrokzngAGz0tBUd4RigJDHqY9TBzpjGmOn9L
 KjIUz5xlaDY5Ghl/u2PY5w0+Grmfx1qsc2ebTWb3526N/iP6p4mn+JZ5QugPFUXNUny5GYpaE
 Yv3BpyuKwrMHn+Gm84JLrxRQ+LwVvrX3daTpn+utnI/1iJeYo382z0mWDcupPKpQtcmIcWZf6
 LD/1Lv8vBdJTDCZZvPs2rqM5nmDk/FzPPuRmiuZG81DXsGeHKdtWTHPMbK

Am 01.03.25 um 08:33 schrieb H Z:
> Hi, I am a static analysis tool developer, and I have found a
> potential null pointer dereference bug in commit.c and would like to
> report it to the maintainers. This vulnerability has the potential to
> cause unexpected application behavior, crashes. Can you please help me
> check it? Thank you for your effort and patience!
>
> Below is the execution sequence of the program that may produce the
> null pointer dereference bug.
>
> First, in the file commit.c, the function pop_commit may assign item
> to NULL at line 806 if the conditional judgement is false.

True.

> Second, in file commit.c, function pop_most_recent_commit calls
> function pop_commit at line 748, which may cause variable ret to be
> assigned NULL.

Technically true, but not quite.  I understand that this is effectively
a trap for analysis tools, unfortunately.  pop_commit() handles empty
commit_lists, while pop_most_recent_commit() doesn't, despite its
similar name.  All three callers of the latter make sure to pass only
pointers to non-NULL commit_lists, so we're actually safe.

> Finally, ret is dereferenced on line 749, leading to a null pointer
> dereference vulnerability.
>
> However, in the file merge-ort.c, the function merge_ort_internal
> calls the function pop_commit on line 5176, and then makes a judgement
> on whether the return value of pop_commit is NULL or not on line 5177,
> which suggests that it is indeed possible for pop_commit to return
> NULL.

True.

Most callers of pop_commit() check for NULL, so that function could
stop checking as well, to slightly increase efficiency and simplicity.
We would "just" have to audit every caller and make sure they are all
ready for that.  The only ones that need modifying seem to be in
pack-bitmap-write.c and revision.c.  Is it worth it?  Not sure.

Ren=C3=A9

