Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485039022E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992149; cv=pass; b=l2ACOSGQPmq6uv08VZ4zTg4IRx7qiXmelUDqbcNXUE1mjJmprhEPYXUQsjjGsXh0+iORmwU4k+bk985HYaAVqfiab54sv+HKxBoys1ByRL20cDyQPI2IknRjIdNd4NNARiJv6byeG4QM9t9Mw/Lq9yvxETm3vBkcOBoC8RrYfQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992149; c=relaxed/simple;
	bh=M+jGs+G7SZXI+BOVRn0kMgFKd+OgmbhjGnoib2exGhE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K3X68vsSoyJe573k35F0+F0P/BRhFrOaxFYcIQExOLKvMPiL8qxrKm9P4TqY+27cxizT3V+xhD0ps982E1XA14qSqXsZj4EW+63tEboKWrXM3TJquoG5QeP8mNsah4M3ooPk7CEdu5mQRojd4x83nSs4Me3C6SoyUZ8feXjWk00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoY1kLjY; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoY1kLjY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso56521545e9.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992146; cv=none;
        d=google.com; s=arc-20240605;
        b=FzMY3enCTq1yHDO58MJZaz0IxpGDc9kZ48AhjNxKHfxoUfScK3QNtpdrcUm2o4gpp8
         /CyV3RDbNA2++5IqiSIkutmGs24MPZfloSdvJmcuYAeWfEcBuvSeIfKzIFCRXjrcdPke
         mpfy2+tnU0AlWxJnbtT8MSpye+7HXUGeH1GwQc0rpYPv7O6/N+PQwxwYrH2li3hE6+WD
         Ic71Y7LAAoa4gjNR8u6LaMZrDAmiyGBQenoQvLiJjRF3sbEtm26CTLkqinQs3IflNCiX
         ANCPvTvVmo6Z1R5SMylukMmevGXHMU7VxxA+c9QceujqCpivbyOkGJPU3RoV6X9CGoSn
         0cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=M+jGs+G7SZXI+BOVRn0kMgFKd+OgmbhjGnoib2exGhE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=H2AzzD+UzUKvi3qFItQ4bUe7K8Z3vmRLp9ftXKE5TOu/w/JoNaIIUJFJUwUWh8vFRr
         DzFzQENpBxjdA01rivRbWcKQwFtsKedPbVHRxA6eVjvfVuEDGDjdIW18XI6q976wK8ZU
         9BF4THq+o03iL8x6muSXJhcJnPz+uLx8OqlI7KF0HmlFUkvhRxnGWui22ShRm3GiItZt
         ny6VavHuvMfYBQ/W6N0yZjY82Np2Gos9zdRqG7YgBQRdrzfJXec5NFCxtlON1CKZ2fqV
         b0ufhj6S5vKz0KFqJAYHMfVWtAMrk3yqitj8DZudIpnqYixlRUbNrPjD0UK9J9+XdUhR
         brAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992146; x=1775596946; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+jGs+G7SZXI+BOVRn0kMgFKd+OgmbhjGnoib2exGhE=;
        b=qoY1kLjYDx5SuKj4fiatACkMJmoiaUabN9HS8JUYhevDCdZY1ecUb+x4aNxBBuosOR
         XY7XT4QX9oo9k0JllzHQ9zi/DDC0lkplZmx7fHM8yrT+iMaLd5hblT18CAV7CN0Jw73r
         nL4D0KRCg9pVPARNpEF//dThbkgYCPGmPeQcLF7KNV+cp5ppn5fYStI8UkFr5O1qAMwG
         5DrNkBszrve9bTrun8iIZTmLBx4fQoCNheRptvp/ixO2OjFOUEJNrcyW/seisWtxhUPD
         zPpD66XWYsCzrvP3Yua19UqJkfZwvcEZLIttB/63R2NmNsVhdYsl2SmXN0QLrrcL1ceC
         N7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992146; x=1775596946;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+jGs+G7SZXI+BOVRn0kMgFKd+OgmbhjGnoib2exGhE=;
        b=FOWvhQ2SNutPnhp/CX7EDDOL8tH3Dr0nZ86m6x4AUL97fhQrL9ZgocRu5nRN8BN6VB
         oPUud274koi2/w2PmKgCZerOOdiU7elsCV4xSdXfYbMNLz46LUssl87zDkpu9YUUuRmD
         Gn4ucyhXbVVLR16+rT7iRAwwx2NgfvxleAWMBhc0J5pdVpVCBUbbOzdCpK5xAJ5MbdFa
         Gi0QnlGFAMVIuU/EPaM86lwzKli3aabqmVhMgZq0PThzk+pz1p0DaGsmLV5J+7R+EgOD
         +TIyyR7W4yRG7g+1ME8YqRIudRkxJjn7rY0JNRuFMcVHR6nuvRxZ2v9TNmBCoY4VkF9M
         Xtgg==
X-Gm-Message-State: AOJu0YyMozmIxZSDySGdQ0kxe5eHcWyhWVw1UMh/7w4EcZ6/XG4TRq7w
	F1FLmc3RWfvD+RLqrNG+aBYTiNSlF9ZOsEAPKSKW4yZ2XRW2mjcF+zXkYy3qaAzQFAqTAIVPZ6x
	4Wx80fRCjt2HmPAz/I2x4/nrrFPOF+DjNWJt0CKs=
X-Gm-Gg: ATEYQzz6XZqlUU6akXJ1yGzQgGcMxqzQqX5tOxIe0QBOuA2QOcC7oMLHoHtpE6IWmGW
	clLFPl85b2QlK7745m4lp2hn/Tlk5RcRGBZEfOW2ZG+D4cp68be4NRFLQ7Xn4ioVJgfj/WnTN8E
	M6cK1u7Ff6nIw+Ez22NTqM17Onlzq3L54Yrv8OQcUQMZacJe2QyKrqake82I5GPmoPOt0UVfpMC
	c4xwAQ43uqMzO9TNVv/7nUkh7Fk7fgEJy7rWLGhLbAgx7tv3rsVbWWo3HtAtKaJtQGSoE0/gFbb
	AvXM8/FRPVI2wCp5yevn8N/BUt5Cz3aVqhJk3yZ7mlpgdB1majsRPnV6hPS4CTWWTUBo49f1+eV
	EeXCWTjLoajjlt8JyRJVbNsZwZS854u+YofVv8oJw1w==
X-Received: by 2002:a05:6000:310a:b0:43c:f40f:6c91 with SMTP id
 ffacd0b85a97d-43d15047eecmr2009584f8f.10.1774992146154; Tue, 31 Mar 2026
 14:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Mills <alexander.d.mills@gmail.com>
Date: Tue, 31 Mar 2026 16:22:14 -0500
X-Gm-Features: AQROBzAm--68yYpocSlX-JGgT-aTSzNPdws7sLntN7SFMjzl57TDYvpUCNj36R0
Message-ID: <CA+KyZp7KK74em6ad70kEd1xv9tLcK3vkC6momv4+2H_gyNrW1g@mail.gmail.com>
Subject: please tell code agents
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had code agents do destructive git operations:

"The files are untracked =E2=80=94 I'll use git clean to clear them (safe
alternative to rm)"

Please email claude code, antigravity, codex, etc and tell them that
this command should be blacklisted.

Your job as git people is to prevent destructive ops happening out
there, please.

-alex

--=20
Alexander D. Mills
Mobile phone (737) 281-4824
https://linkedin.com/in/alexanderdmills
