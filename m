Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808565;
	b=gmItq6+wDfH7nPqsB4xGs4OqE38VkwIs7+8WoY8IwFUxxulKxSuizGLjBQYp+RS4+uLD
	 GukZ4LBiXA4Zyha3YV1j8L68WpT44+3GX+0I++ILI7yLRDydpvFIWB8M8ACz0x4cC5y95
	 MaokcSdeowXaKz7f1StHQwI/tlryC7sRnLuCft/3zcFOmCDXgMqUMBDchHXJRsUcaEtzt
	 gw/xqT9DjoKkplbcxOPRI4rhHDX6TAV81/jZKxiPZL/vMG/MbxqrLZEZV5YQPpV575Ep+
	 3M5YkyYF6nzoMhEvW17aXS/SRbpPcQvh6yLseeUfUxncwjwnn1Vk7a2TAS54B8DO+1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808565;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=jPIYePqiSQTclD0jbsmRmgNgDcIE6jI+p13RAuM5Qeo=;
	b=T4aeJMzCMtXfROJEyVEv1uJHKaScmlDJjXcP7wvZj62zFKQMbapIblzgfq+N9uAeh0Ju
	 o00sAvReLCNnKffXsaMEbQt5Z4NPsA2d+76fUxkGsHcjj0haJTHUVOkz7mVtWoOAmeURY
	 qvVYx8fsJ2Kd/OvjUddZVn72ZOnfCp5SENHaG/i1oMa7jRVYHVqwUhC4tlU7aCMYEcrUs
	 zW8Q6c1Iym4ylN1rCjUaepom4QLjRwcL9qDNpg0hujFtng2P4RZuGjAFBI0A1KEDaxbkZ
	 8jB1jrpBbt4r5rfh5IHBgkHgixfOVXh8sAfakIqceg9mcw4XiJQrHxGQvI4/38/VQyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=vmW1pWSv;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCE606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BCE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=vmW1pWSv
DKIM2-Signature:  i=1; m=1; t=1795808562;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:IpvGGNe00yTeYhoCbSyRJzJ7CTu8
   BCYmjA/CM5maHpUGMCCqlcJWO/Bx1mzxtQOdWiRNDwhJxQccosPDWuvv7cd3W8Qu4rUqys4PG/L
   e3LoB6xMajKMbW135i9sJp9BJW2phANkLx35BJVXf6EjI9LF9vVejMdb1+ALFjxJcCY+wILLmd2
   tnzG7W2dlpH01656RTHEc0gnd7Gkrd9w+BUZRiMAao4dUWoNYMNDPUQdHZC5sEcjnSYmp8dTeKA
   W4YdJ6c/GO5lLcK803T7mKL+b4VFzo61RhieWwEEU/HYnFrhTB+ffyjMCWpoXSuhGXS5PnQGAVJ
   /XBRgYt6QSt0xQ==;
Message-Instance:  m=1;
 h=sha256:
   9lH+u3W6C8yrzipniAk2M61sNkWAMEaIZG6013tQj3c=:
   UCCzjMY8Hm9WItAyiY4HbWCpKbU63tZNcjEMnaAhCT4=,
  sha512:
   4xxoSQFfOSICKHJfUlDnZelOQbEj7c4Sugg0eqMqndxfXQznEqLbkchEtlWQEHUvDykUHnpyu7hz2Qe9d6lHrA==:
   mzD1cIOMlpTWVGvRQ/OkdjEHHyCTJAw5eYUjN80/9ydOzNWLrOOv2lE/bhm3UFPs0R6F7+c7foo58GfFBk62Ig==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795808561; x=1796413361; i=tboegi@web.de;
	bh=jPIYePqiSQTclD0jbsmRmgNgDcIE6jI+p13RAuM5Qeo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vmW1pWSvyDWD/VAQcTxnXYO3QZ2lhvkTb5eRFA+awVzZlkl0GhGQaseHm3YVFPoI
	 A+8fW2UYlB4FnoP71Dl/UspSxkrSrVzlesuqAIZW7vq69doBke/9Msz9OcsR3wxDg
	 ABBEuEJtaNiZCkeeLlhy5d1z5T8voe3OofofrAwIYmGjwSKIGKZa8m6OEcmYG8NE9
	 F8lzhSVdEvnMajVob7mT2gaOhg8Pa/4dH5hgYjybl/v4P/4+QwHtKf1ARPzBoe78n
	 Cjc4GD21EeasGB14Amg0iogTCuvOIqi0xiVakZyTS4A0oBvEJnrXHXPznaiBzyp5U
	 aXTeHS39c/CZIorrbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgzaT-1y95DQ2on7-00bj4u; Fri, 27
 Nov 2026 20:42:41 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH/RESEND v6 0/2] read-cache: do not trust a size change when conversion is active
Date: Fri, 27 Nov 2026 20:42:33 +0100
Message-ID: <20261127194233.10069-1-tboegi@web.de>
X-Mailer: git-send-email 2.56.0.236.g7e34d8174d
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2JnNPZc9V3un5iidOiKSJUTambtmGmDIE/xfaHIgzAI0cJlKFsb
 45jX3nYk4VwJFhfm0Xl5GyA2+seicvyswQLKDd6QvWRIR8mc+aWKbQstwH0iG5jTCpHgWjp
 l1COS6ULMlPxWkXeYyPUc7D4D/xBlMRXH5IxM5CpnqnE43BjfXXEKi/SRYIlsTAlrjI7ljn
 Zl6kmEJ/UCBJjxFP5/34A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VHrUtzOrGjA=;MORF5ZbqlDTmrpd8x2RF8w5+aNu
 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
 rgXIMdE216Lsh/x

From: Torsten B=C3=B6gershausen <tboegi@web.de>

This patch series was stalled, it seems.
As agreed in the coooking thread:
Lets try to move things forward, here comes my simplified summary:

When `git status` is run, git runs a lstat() on all files that are
tracked.
When all relevant fields of "struct stat" are the same
as recorded in the index, the file is unchanged.

a) If mtime is changed, git must check if the file contents give
   the same blob (hash value) in the index.
b) If mtime is close to mtime of the index file itself,
   we can not trust ctime and the check is done as well (racy)
c) And there is a "shortcut":
   When a file has a different size on disk compared to what is recorded
   in the index, it -must- have a different content.
   However, ever since line ending conversions (CRLF -> LF) and input filt=
ers
   had been introduced, this assumption is no longer true.
   The file on disk must be converted
   (into the content that the next commit will have in the next commit)
   and re-hashed.
   And this is what the patch series is about.
   The short cut (different size -> different content)
   is removed for regular files.
   It is kept for for links, they don't undergo a conversion.

Patch 1 does the basic work and adds test cases.
Patch 2 optimizes and updates the comments in read-cache.c

Comments welcome.

Curtis Allen Smith (1):
  read-cache: do not trust a size change when conversion is active

Torsten B=C3=B6gershausen (1):
  read-cache: optimize file size change when conversion is active

 read-cache.c    | 17 ++++++++---------
 t/t0020-crlf.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 9 deletions(-)

=2D-=20
2.56.0.236.g7e34d8174d

