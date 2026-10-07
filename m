Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5E37F01B
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399255; cv=pass; b=c+88SXZpF4L08AMGsxwx2/fv3N7jCvl+08g0+1TU/Q1w5hbtxFbYbRJ4U4o5uXCzdg91fAqE4mrgow2arLKUqI0lGxOnyIhK9zIXQBzws8aQnrpqzb+KzFbjM1wuAnCDRu1gmJMUibl5gh1QNSOPaLrQknheMql0Wx+d3+G0QDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399255; c=relaxed/simple;
	bh=74e1NFhyZN8BKmDH17W9HUA9eb7/x7Iwf5OMJePrrYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udBcZBkIGB/iNcToEHVUNDzmMTZ0ceqT1+8YgsWRl143Cvxf5iQ+0H9iDQS88rd39Nnf/eSHCDSWbJkePllk0guyZKoLjpRr1abKcHaMM5JNjSeeC0VCNSL0n2pqjclNcE4VYhOJ9hOJXq0NYp2O46Jls6K1WwY3ekteHTyPnIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNuK2BpH; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNuK2BpH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d032846c95so19426735ad.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791399254; cv=none;
        d=google.com; s=arc-20260327;
        b=iCwZIl36vfyyBJ0yEjp88JwIjNGA21Gh8wzggAIsWtISbdzCmGHmz4axfc8Aq8AjHy
         U1a0gTQNj+JUhk6bETdfflXOc6OYpHcIi2w7lS5fbKgN0DJeJW2veLnod6JWRFQckM42
         2qLq5Sm+jSxpo/9mtZVNCUqFq7jCo28Di3OK4YLqBG3mbKctDzS0L8Q00kBnSWkWDOWe
         0t9zptho/YJFnRZSMIZzq7nCEhikXSEENlpFjjX3x7kHrPdvWpQmBi3Ag4YWaL1h7qZq
         F4uGd2SGtOH5qRcniEIb5SdBvMtaw7h+ZgiF9NwpIjASX1oEAS7FVhuOlyW8kxD5ZHQO
         pQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74e1NFhyZN8BKmDH17W9HUA9eb7/x7Iwf5OMJePrrYc=;
        fh=/mYkHfH0vJLaChE33D7D896C0kjD0T1yFyfto5V6d0E=;
        b=fA4gEOgHfq4GHDKzN5LseuImqXs4mVu/13wdwhsKBBA0xR5YXzcOTWmtihKxcsN84a
         lMffXspW48M/1IAyIfR1YVMtw2GQsLtw3XVIhNJzMK9QuA9rgHXUDe3Dpna5iGfRf47P
         58gx45uSSGymBiJtxAPFrkJBLhCQWrZTEOF7hNftud9oDSJf5x6VTRO5cKci74gL9D6Q
         MyGWTMvCjy4b3iLpjCl71Jq1t0PAkGFsr9xKtB3Vdi4NgihodRnHBLx+Anil2g1q0HI6
         JmUe9aJfJHnoXHjkRRO5ZqErGiByCPER3ONtZQ7suIH0chWQX0kWIU6etjieZWZ4Ilpy
         0iJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791399254; x=1792004054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74e1NFhyZN8BKmDH17W9HUA9eb7/x7Iwf5OMJePrrYc=;
        b=YNuK2BpH2b5RlEdQb9IDSWKMeoXOc+x/hYIdREfH7IemAv1VZ8e7C1SJdZTiNSxAaJ
         IHqNuf02MafE4xXh32zjtxKuIfUqQsuXlXImaaGmuJOcCM/EmIpPU50DG2CjhKZYI9NM
         8N2ytVT6/1JmlR8cqcISjHwIaQKgFw0p7scMrZKYl7oYboFmqDrE3aQ43tEPB2GxEy/0
         937SauOf/x/WKO3umh7O2rMFj07VBC7TYCek7nTfxUH/ComPCJ4TIrqAIRIg/KLk8v6z
         JZn2g6NMFnZzxkZfmMPYTMKDkNsbO0+UHGGO4dlXWUZdj0Z19WXg6WG/Xr024iLurvhh
         CKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791399254; x=1792004054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74e1NFhyZN8BKmDH17W9HUA9eb7/x7Iwf5OMJePrrYc=;
        b=HuxhLMl+3u1OyiOUTFDDfVCb5FO2/K+gH6IezwoFy0rZltZFcoCYaxG/msq32wLPeo
         A1GGQbElwjaLI80Ojt97E06DAtPNiFFRyJISodbltNv5m/u0deS0X2Dzj64Jp9YVqVIL
         TEzsN3jXG+0KRediHnz/oNl4H9ceEgWoeE1XY/u4xFTvjC0b88x4MTa3yzifnSq1OQzr
         NXu6+fe/kvIF4Kdcz4pcThDGIbqZ4emx+QNpGTpVhRl/zg2cg6fPWvF57Pkt/1DOVGVB
         ia6wJDtA9DWjE85FcSnhBZiBDF2aaBPyj2Smj4kmFVodajs0AC9OYgocnCw21CxpybAP
         O92g==
X-Gm-Message-State: AFq9FYIgOGMXZVIpNAN4faIBPMUccwb6v84cQmk0ZRqjfsluopyP/97I
	QpYwbHSBigiwJijdlzznWndkeBAj2UR34j7MCHyqMxvI8vnjyD3ty2JrzOL2MaNtCPKw7kT+LKu
	Qu8Ih1lRbnF9vItoKKNLXshUIAVTGbbroO2Zo
X-Gm-Gg: AYBFou2O0DV/PPAmjlKpawF4mTcoC0KZwq5xzA0tSAcqGN5BmBshwh3Fe95thhKvuXF
	mceXeCfiZqD7LYwEJdJNuu4s8N3EX2Nwoekn1z5yEdn5mbtM2uyJhXIsHpBSdPwFa2rP5KxAjuC
	gSgOHd+hevrS2x3qvoSGxu54YV6PNJsez8OdnJgEg0qKfdbQfLI+VeclOyjxkEazJ/uTED0rAxc
	5pX0mgozq9hK9HOOq6Wjz2TtJ+Lj3f5TVk4/h2Mj3IBO4avmQICdR4o+yKUoQtRk7wyxU/xSHXo
	jIpuxcvm19gV3fW2yYbVo5ZA6PV5Iakh42L8E4MJjiPzCPs1ELi3bz6F+bIUXFFPYRZEhHTyYKW
	oAI0z45ClRzjiB1obFQe+/42JV2z7J/n0mTrD2x5+KcnpC7YiOCO6DcNx+4GEnQ9crvtdE+2Efe
	Gigg+Qa+QXrwl8nvq//p9YZIRk/UezUA==
X-Received: by 2002:a17:902:c949:b0:2dd:c170:2d4d with SMTP id
 d9443c01a7336-2e6003bd6f8mr34600305ad.24.1791399253541; Wed, 07 Oct 2026
 11:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
In-Reply-To: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Oct 2026 14:54:02 -0400
X-Gm-Features: AclHuK-dmqeiSDBmfHPUJSicjI8i1U3fGj5LPVgHP-8jOxiwp7qteJpbOMF0Vus
Message-ID: <CALnO6CCTbWLn2rO9ASr+5K07vqkaWCx+H8NsCxaAMgHUYR=z5g@mail.gmail.com>
Subject: Re: git non-intrusive clone
To: Luca Di Carlo <luca@dicarlo.email>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I may have misunderstood, but=E2=80=A6

On Wed, Oct 7, 2026 at 4:40=E2=80=AFAM Luca Di Carlo <luca@dicarlo.email> w=
rote:
>
> Hey everyone,
> I am reading more and more blog posts about job interviews that require t=
he people to git clone a malicious repo with commands executed using git ho=
oks.

I don't think a _clone_ can ship and enable hooks on its own. (I know
of at least one npm package that wants to install Git hooks when you
run "npm i"/"npm ci", though=E2=80=A6 turn on "ignore-scripts" for that.) T=
hat
is, you should be very careful executing anything from a cloned
repository you don't trust, but I don't think a clone can ship
executable hooks in a meaningful way.

What *can* get you is an archive that includes ".git/", since it can
contain hooks that Git will execute (modulo safe.directory, I think,
but that typically doesn't apply in these situations). So: also be
careful extracting arbitrary archives!

Maybe you had other security flaw in mind, or maybe someone else can
tell me how we fix this beyond "tell folks to be careful" (which I
agree doesn't scale well).

--=20
D. Ben Knoble
