Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F02C18C
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194441; cv=none; b=HfyNdHR7frLqzwx7Q06pL7GIs0fUKDqjPIZVpeNJW9sv1GWZ2vweuTILFskzTJHLcVvnhj5zcctX1X9mq+4wh0Sb6fp87fJCg8L3ZAreW3u2Hb9f9ZBL3ENKcuLTnV4pd1gDKonwcjUca5HQ/VutM+hdEq85BjckWAyPCcbDBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194441; c=relaxed/simple;
	bh=w5d4t7oftpLl8/zymJn5yT6rwdc33cpJYTxknI57LqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=op2mzLNl4ZqVXF3Vx0bqip44BBpA0xJY4pzwnEdbOOZxGFfJnEJ1gSsmYTNHkho8RIjsyi3w2e4rQFBybs8fF/6aq0n8xX0Cb4+lQshyDpSV6Ol9aMU5Fpigw4S1amKdCe+1Wsx/pWP6QQV3kRi19H4Q57+xevkJzZSrEX4fEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Tn35J0Kt; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Tn35J0Kt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728194437; x=1728453637;
	bh=JAK2cJ0zGUUvPexhMUisObROlvm0iAmBnX/PBTKfPfM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Tn35J0KtQyKPf92W2vk3mXHxKAs/OIQOsFd8Hpj9OMvt7BgbhSKJIaHZXJD4dCzkj
	 XADHCIm5Epr3gHrIityxJolUcGZL5/b3yCB02YBEy3/5eJBdYEJwWOHh6vpdi5vjsO
	 WXOv2DdGLSabJwgYQD6wRWepN9lq39Z93NgGQzBkJoTWoQjhRYP+Or5VqA46f8NZeq
	 5KhY5L8QjEi0u0TT0fwAkGCSI1XjlkHb9AtEA022MU6Jq/5+KEozUODHMcLwszeJlO
	 Osd4sE/0oczLRllPiQvouiNvmV5YBbteqKBPDHAog7rehMoZC6fesA0G0fx0SZBZar
	 zkVazLg90hjiw==
Date: Sun, 06 Oct 2024 06:00:30 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 0/4] Link worktrees with relative paths
Message-ID: <20241006060017.171788-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 3e7ed3801c27987ca07125afe234170ee8cccb77
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------20e06bb2b324d5ebd4a27f68cd4edd0a46a2d0fcf8eb55f0e159bf43dae5e597"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------20e06bb2b324d5ebd4a27f68cd4edd0a46a2d0fcf8eb55f0e159bf43dae5e597
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 0/4] Link worktrees with relative paths
Date: Sun,  6 Oct 2024 01:00:13 -0500
Message-ID: <20241006060017.171788-1-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
Reply-To: 20241006045847.159937-1-cdwhite3@pm.me
MIME-Version: 1.0

This is a resubmission attempt to try to fix the damaged
patch noted in previous discussions.

Thanks!

Caleb White (4):
  worktree: refactor infer_backlink() to use *strbuf
  worktree: link worktrees with relative paths
  worktree: sync worktree paths after gitdir move
  worktree: prevent null pointer dereference

 builtin/worktree.c           |  17 +--
 setup.c                      |   2 +-
 t/t2408-worktree-relative.sh |  39 ++++++
 worktree.c                   | 235 +++++++++++++++++++++++++++--------
 worktree.h                   |  10 ++
 5 files changed, 240 insertions(+), 63 deletions(-)
 create mode 100755 t/t2408-worktree-relative.sh

-- 
2.46.2


--------20e06bb2b324d5ebd4a27f68cd4edd0a46a2d0fcf8eb55f0e159bf43dae5e597
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAid+CRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAClbAf/VSZ1eVBHed3EEbOXdDJD9QsSVBwLHepWn5vN7K7SacuzXFTF
5wqsCJS3cBZR+JvrdulLFjJdkKSlsiL/bRrygqdGzpXr7sqv0AcK/mXSmOxm
Hv3hf+uDVAX0PRvqa4fkUpUM74f3T8VB/OtXco1Ij/lWtGzr+5RYwX/VDVsl
TWVAKGdp65MOG74cAqfw6vTzWhk7Owir5qLokH1pnkVCVd8U0HWfPF3PvxxY
oRkmtOUim4R8aTGkcHzwC1pHWEMdp+0T/gyLpwwoSoupp7DiVZa6VEdh4/iz
RqE8RvzbJIos0P8Zd2rru85vnJqCsryK9mHuz5kS1M/3l3drI5FOkQ==
=wLLc
-----END PGP SIGNATURE-----


--------20e06bb2b324d5ebd4a27f68cd4edd0a46a2d0fcf8eb55f0e159bf43dae5e597--

