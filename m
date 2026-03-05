Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747D274B44
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694896; cv=pass; b=k00AHF3JRRblNyrs3xjX9dkMNF4TeRsHWWCXpwv7jLFa/TtKfDqVMEKE1BEFBQ+J3L5puywZF8wTGTBIqkavhQym/zaL85Dhfe+1F2+LIUBqoPirDJ+H9eF2WkRbuFb50vGZS6J/jLeU0eXl4T3M+fIvpDdeyPQSJ7Z+JrO0jpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694896; c=relaxed/simple;
	bh=lauwtClkcoEMqmNcGvDPODlpDOyrOWiyFX0QeANrDSY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kSVRsVelF4HpFEx4y0NK1LxISLJBfBBZRVYN1DYPcAw6PeuoBERC/W2AtCGOmIVY2txEPjK8mHQ9ZP6AbGCW6aaszmjw4hhgjFUKX3mE98/rgqMicSWS/RjPB8OgiIj+rWiCdRCJ0L+nFYndYPV3MaOeuQz9irMTFoam9JR9UqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyYBc4lA; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyYBc4lA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-660bdba9390so3530446a12.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 23:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772694893; cv=none;
        d=google.com; s=arc-20240605;
        b=PWv8ZGLKTIQecQXJp93NVYxyGIh5zUuXSgBnvNo88KcFtgACUkX6PM82QVdAdt5c5k
         fnyQ00kSAW89NaMdy4zHhKKs+J+Ix8634AGFnBxAHDEFoWjVmE5U0UtwieDUc7x4ZpH/
         1p7Y99rejnlITpkWRwbcnnfpGUAXTwQ47nUvw/Mtb4/UJZrZzZpdYEC9rNSNt8Q5ZdMJ
         0nNFWBt5KSYf7P9T2asCFqviY4COAPMvn6+Z4pQpDHWC0wxEbzpVtien3XEu2w39wmh5
         5jx5KwnPsj3ldbL11Q5ee3JVGXMwq4at7HKExwlnfXtlGzIT+nefyGB8ziiDmoUr44Lp
         VBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=wNok0bnAJAMolo0ZE0K6tAKffSXCeLgiJuyTGjS3fUg=;
        fh=BuW9i8pcHqMLkQXv+ndvaIANn5EyFbPqLAWkY6rS8cQ=;
        b=cXnUE8yFABvyn1QIx+zDTzUEC4tdsKAom6HVtdEYwsjA0od0+3C6WN9LWtczY+x/OH
         jibvrZxy6ejrZ2LNeFX4/u470Lm7Z2PvQ/OUg1Xp9cxTHl/jxo6R6p4QphVX+vcyvInd
         CKEQ0/UhROt6QtklySogMhnrR/Papui5lCnERUPX9VqU2pjOB4vELIB1jSkWzmjzBGwh
         JYLnrVNWfBGgb+0ZtPleKifhyszdnSYShxn/JqTQkuq5OACCMYXAPKa8Xp6Z8UQQ3EXC
         /K3GLmRF7I+MjKVXtjW35G3ODzTo83eYk8qSNOQ2WkQOnP2fvv0VdIZi5l6Boajr0TJu
         ztMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772694893; x=1773299693; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNok0bnAJAMolo0ZE0K6tAKffSXCeLgiJuyTGjS3fUg=;
        b=MyYBc4lAHXRzfTF8ntN5r2ue313fIDAaBUFwFiuzzzqOnY7kIKR43ByU8T82c3Lfjm
         3Up/fmFt4Hu1U8I1WWrGBbljE8Rrqox+tyvXTDJEq9LS6xwsoCRr9yOHy6zOhsZwwEVc
         qsot8tomchx9zJQdtwnSPmbmmOQM3H5LzidZ4b5xPNPJtOsQ8ryyVKNoEzX18du2TBY4
         R5z/265zdafnjpD5oeU7fOgUX29ot3h8ckFobuax5v02YUULELZjdQKj5CFCPM0dtreD
         tOoy94stKMLwZyAXjzhYXbmiWL7WZoTiN7iUVW1I3A40D7aJHIMc4ZRi/BOkUu8Cclgy
         NgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772694893; x=1773299693;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNok0bnAJAMolo0ZE0K6tAKffSXCeLgiJuyTGjS3fUg=;
        b=KKuR4WWOKov0aBA59//sBVE9OvVdodS3siGc66cXxyEC7KB9BF+2y9IsXPmw1gxhuy
         2S6ZA6yLPgK28ZJ0cQzy027hMk6Ch3ZpbMQo1OY6M0DlPa7/w74GrS3ntPlDWwkTqm6Q
         +Tjac8Xc4ROwK4tVUoqJxkLXmCWMv+JZbeKvWqn0IHA5vNmWPk5lhUkkWWomOGYiks9d
         OAI95owbDB9gC4U5gwAzQWPiaj477b/LhHJtxQRXBoaWwXLcxXZQecDOKkC++N1JiDUI
         EXPe9ShLmUkwf82N7WID82OarYXWfbsRFCcA9+cBbQ+TfZbOFX395W4nf7HpXzoiWuhm
         B+sQ==
X-Gm-Message-State: AOJu0YytwNA1VCnUOLH7LvsasrYIKR4uuMY9jVPUFlsmxoPBYO6kyCJu
	LjeciTku4DPICqlhz1V9gqnhBpYtcpXSDs/wuwctSrYr6wRkoge9ZihQa1eimeatYnenlToJKpj
	HhazmG/7baq4he9yQz51u8r8TRseRoursRg==
X-Gm-Gg: ATEYQzwtD1tBGJw1MVtYUxuARk+Gt5Pz8RpwSU86Ymrx6LxmgordF+03LcsqL6RIrYS
	kNIoHlVNeG77/zTZsW06ifT2gbRCnKTlCe2aW9o6mAf2Hjzkj6sifU+JFhEh76nfgor3purNb/K
	OQd0ScRkKh682aJqff/tWUdHYg8iToZiyt1emm7VRTlbgIRq+PY/kLrzVArcxMLTooT5fv1pKTd
	uLyBGywU78F2NixDkvfiKsSoACC/pm5x7TSCgsgF+PzJRU41gulv5JunkH0IAABee5Bp3q6m3ZS
	i4i94IsG
X-Received: by 2002:a05:6402:34c9:b0:65b:a2b5:5320 with SMTP id
 4fb4d7f45d1cf-660f04cf8a5mr2417792a12.26.1772694892712; Wed, 04 Mar 2026
 23:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Norbert Kiesel <nkiesel@gmail.com>
Date: Wed, 4 Mar 2026 23:14:41 -0800
X-Gm-Features: AaiRm53WxIp__0_xA87tx1uGC4MVfwKoYzdil1p70na5uBoehhlGWx-Jz6h8Krk
Message-ID: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
Subject: Feature request: support listing worktrees sorted by creation time
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I have multiple repos with more than 20 worktrees, and sometimes
forget the name of a recently added worktree. Therefore it would
really be nice if I could use something like =E2=80=98git worktree list
=E2=80=94created=E2=80=99 to list them by their creation timestamp. Is that=
 something
that makes sense to you as well? I could also create a pull request
for this if you would like it.

Best,
  Norbert
