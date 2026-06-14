Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DE3148B4
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424839; cv=pass; b=slw1Vae6cvBNstG8nEwSpqfhG4SLGuT++ORS34deH9AwNAaK4C2TN4pqYapBM5yZXyxXOaRDkFPzSAKBCkOjYPXTtn8fh2On7srqnHMj9hs2KmmWXebyf1EvO2CNfWJ1jSDJnAhQVzgWCx6YfkZk7opbMGxqqhlk19DWtcrU3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424839; c=relaxed/simple;
	bh=LPO/77q42Oi15NUE89hW3M5YTjQDVcCC03nNMXZNUfs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sOI8FQ8Ltur9oEHYAkOAXMMoFlhn5ZAtQRrWyou7muaRrBxUE3olh5lTfAwS0fb7+Em8kB/YBZDmHSUELqJdJdh25RIHc4uSbN47l6DsKbx5BF7bB4+pnEKTyVHeyBoEFTfZ1fFg/gvq8gaxT9MLUZRTdnfcLHkMBmrG1Y+WiHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQdaD5ts; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQdaD5ts"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304fb780deaso2456600eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 01:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781424836; cv=none;
        d=google.com; s=arc-20240605;
        b=CR3f1NDg4z/7A35YqOuAubOL8vpU0zHruSJq/YIXqXBMbDGPSFHOQ3pXoU278zVrhl
         GDtbw3VIvYaiZPm3zhaFlPL0Ky+wicvySd6EptwpeHz4VyhPcs488/uvCQWIvsFLDibI
         4wVFLXt6C3mNJ9k1y5xcBMmbjff9FVJhavbAEautKAKn3tul/HxyfaHz9ezPRuB2d6EU
         ONT9nazgk3mJO8c5dddaLkBguU1ogyySOxIr4o6G9R3GlqSuFR4CEoRgtrAhE6SNRjl8
         CmgZZS2oqbixvObzdnbotbY7Kf8089AmakSkpvJJzXKwYiPOgCKd56OYDz/C5aGy0Rct
         p61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FEknCS7EA+dWB+llV3z8Y0LxY+4+Syc27LchQVhTB7Q=;
        fh=6QCqgN2KpYPeaxTelaKThntUOelJ07XCmJlP/wmeTQI=;
        b=hrsBSBlDR6qAwzX94yDhx8g4jXTlmvOLHFB27GVGrYIMC06cOjha9thpIfdbnBUnB4
         IUkM/czgqYDH7w88NtsTLH70zKPalOHid6lTLbqVw+752JGbgIQOPTvQ0/x12P3KrxK/
         7XtqX+hjVg6dnv+DHX/GVUOHYwuDczGyYZC05T+FbVukn03gtQWCjtPx0CanY8LkX0vd
         w8h5FYijTPWhio8fG7Sydy7oyzyzqubB+bCNKXtN7XXTY1ja4NSfihrMI8ylJdihe8oQ
         PfDuJ4Op00i8aWRnZdYDLQuZlNuQs9ThAziR1USZzf9iB4ud9+ZE/b0TRXqvXUeQ3TMP
         HaAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781424836; x=1782029636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEknCS7EA+dWB+llV3z8Y0LxY+4+Syc27LchQVhTB7Q=;
        b=GQdaD5tsp6JrJf4RkQCDkDznU0AZ592/LtabLV+yVbyLUcqeEdaza5M3jif5UFItva
         i9vIJthfqNwDrqiokpcZnTb7FqK8miwO9PO7oJHtF7LgVGysHWkZwKx9aS3wgq+pOcqu
         h3Jac9a52gXZ7kFUQX6ZH3Acbf5JuW/o/TAv7k4z99Z/7hwfpjJLZuGg7hnOahA0GQ80
         KONUhvrUyAVoRhOpV+qNb/FuRd7bktzZisXsPoO92/2dz05ET+UrYaLZ64mZIim0lFLF
         JfbIq8A+wJzCEsvXFQ9+dcWMlpQJmcExX0pzEeuo+cVEBRJFd122zbRxKKlIX5f1n8xU
         RpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781424836; x=1782029636;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEknCS7EA+dWB+llV3z8Y0LxY+4+Syc27LchQVhTB7Q=;
        b=kV0UrBzmnkPW5l0DU7bA+IUpjquRHjjlO3cNhh9Yfh59ppOifX8YDSKCQLeBoI4Dha
         xk3w67i0V7/TEnp34A3/vqt4OQLj/LHQssysFIQ/4LdH5lD6WfiTyCbwS+F4jhI0+5uP
         nHxhyx7QbnCmvXT/0Te3S72LCsESxY61DufNRgh/72xA2+Fyqw6hU4R4XORi3U6ja5nX
         IuXFZ+4abLXrsSOqNA3Y0vu99zODzzEoCH5WGqi/A0sE+/qGrjw6PVKwZ+mePyyFm/WI
         OpS0Bxxdfvw2yKbnMDvtGxDsCHwLoxjWAgAuPLUAxCgkBw4YlkmxB4w1GV/P8kx54w7Q
         Ib/Q==
X-Gm-Message-State: AOJu0YyRom6RaBzEA4Fcger320QBRQ3dMlzAdCFYdMhH3MooaGxhjTO0
	mMwqy6Ff8hQwdOpH2jJcjnZOyIzOHw+BqtsFXBXh2tFbk5S/ysn1jTZiEj/ZTeIj3rKw+sK0GkH
	eMhGVeHqOetiC1STeRVmivYT3uLr6DTY=
X-Gm-Gg: Acq92OHT/nF8euk6XyC7bIkaJ/vshDNhLGtsBW8LeivMxUhpUdH92B+XY4sA99GyLsq
	5oZAQ97y4pKDIVKEgvh3Q3wrq8iZ5RUotSTdfRkaCEAyly//cIPxB9M9msmA0SumjZ2ww3X5R55
	8G1prt1+uM1RA6uxtnV7Y9MNg7o5UwIWMomJDdiADni94aL6hPt+Azs3WLAD7J8jEgA/VhqekW8
	7gEaJWPSc3tVX3cTWEs6zSIqTsYZZ7PnnmnUHWsnX6m8CydSEzfi7pj3ojqLPRERVsbSJdm1nIF
	lNT07LggFYoTRMpvPg==
X-Received: by 2002:a05:7300:2d2c:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-3081ff78752mr5346367eec.8.1781424835799; Sun, 14 Jun 2026
 01:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hadrien Loge <hadrien.loge@gmail.com>
Date: Sun, 14 Jun 2026 10:13:53 +0200
X-Gm-Features: AVVi8Cc7w9XR4lr-z4MLeT3YUkdURQFLCL6X_6zqzEOqonMqsuEi98cpM0Vg6zA
Message-ID: <CADeHOfx3O9KpORQdLmvb0BPhaHUGmtxoyDEqySNQY_d6+ia7VA@mail.gmail.com>
Subject: Re: [PATCH] clone: accept DEPTH env var as fallback for --depth
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com, 
	hadean-eon-dev@proton.me, Hadrien Loge <hadrien.loge@gmail.com>, m@lfurio.us
Content-Type: text/plain; charset="UTF-8"

> So say someone has this set in their environment and then they run a
script that clones a repository and runs `git describe`.  That no longer
works and the script fails because it assumed that it had history.

That is insightful but that I fail to see how that makes `git` less capable.
As Junio pointed there already other ENV vars that do _less_ useful stuff

As to breakage, this is mostly for packaging in clean chroots.
If a "history" feature is asked, obviously you skip setting this.

And yes the packages need network to build because they
are mostly user generated. For example applying patches
to other repos, before building tar archives.

I also fail to see how that would affect existing flows at all?

> because shallow fetches are _extremely_ expensive to serve

That seems like an unrelated issue to my patch yet is also interesting
as to why that would be the case. I might actually want to dig into.
Because to me, I was saving electrons, at least on my end.
And saving time to other packagers.

Thanks for the thoughtful reply. I hope this patch can still be considered
Hade
