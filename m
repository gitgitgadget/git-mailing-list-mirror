Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F33644DE
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941967; cv=pass; b=sMfOrIf/uQFEncqUYSqqznmepXzEwVB+5WeAbI2jp+WMgLhQ3WLJ8kPhMIdvBqFmrCw9bE6lx3SrCuc+G99snOxUs4PsNvRuOif/8aIeqYkC0/VfkU4JZvbyBqf/7W1fkfeA/1Pzd2JSOIcB6wwW3Ff8ek+rNT15ak+xffplD0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941967; c=relaxed/simple;
	bh=fkuDK1vwgUYmeyMFGWx2++iGfXy3+NjUjhYD62YixoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=A22zTtKty6X3oCBjKmtQ3GJ7xdAjF/w5VUjpzP9PHGlN8eFPrSD6bNyb6lyL9dU2unZ/dtMmwFmGVJjOT60LODZ2RVyRjOiVrXa+Cz5sFGLvOfGFY8gCDTTUZNwTOOPJjIBw56vY9ngQ9Fk24F+6aNBEiXaWz2FLAhKa2Pvp4eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqIaV3CR; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqIaV3CR"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6420c08f886so7755774d50.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 12:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768941964; cv=none;
        d=google.com; s=arc-20240605;
        b=SlV/rhMBS0zdl5UmjUaGssFIC1dioTVC8XXku5bpUm6RTJ9ZD/M4YhmEbT7j+6QnRd
         6VC0HbaCvtA+W9B1v9gM1MZnQ/mZBMJwKhn6XBZlC/4Wz5tDRe1F2nc5rZ9vJwz0t2T2
         8iD/lsXLYAjyducd19h4WIcTCUY3Npdt1i83+rjtwOyxqbD/X8vMSv7HM1C/hdRQokNJ
         RVAsOW2lTGpMLzkIeQHIzYwbypu3c4gGAoVFYzeYWALmFerq2MjR1aKTQL8JtT5DIusc
         MtBASacBdVcX7CPjtZcK1ChKG41irIFMQWmoyJqHckwnhsw59Dwpmiz9A51lyFeH2RbY
         hDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=fkuDK1vwgUYmeyMFGWx2++iGfXy3+NjUjhYD62YixoM=;
        fh=QnVQ3wfWHPhiZMoMSXPWuRxIZpGYqet0mF2rlxd0t4Q=;
        b=Vvy67vMFsxdJLqlmOiylPK92C49Syvn/XbSBIObCVJVCgOEtZ1gVGBahsfLJTZ6S30
         JunlLsqf5OglWboq4zvlSF4RkR1YpeBZ5oPG4UHIwl1LhZ5qEWsKdXugpzolQ1O7y3J6
         n/XZF+EAVb7ewH14qcPD5dMVCCsHgV4k/S6sa43ahHfZpFORAF6pHfePBGomv6dY8fk7
         I8MWT6azX1zwwLKp1iGGJ6e5siPFT1J3P7MvJl1B9zf7lBTVWGuVSypJ9cmEsxzLggti
         pnMSWL8gVzaQdCBC6MxqV2wXMq7rfStXshfS3oMlMyJ2Nty7risV1kJewdbkSamDfV2a
         YUlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941964; x=1769546764; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkuDK1vwgUYmeyMFGWx2++iGfXy3+NjUjhYD62YixoM=;
        b=MqIaV3CR1aT58R/OE+/MjeKYzVo5osKaM2P/6g34rxf3JSeYnCSAipXVaysrucesrs
         WQ+sCqRf9uRI3o+xDkLSat0IOYlZlCoXcZjVRXfVp9lypoIWHwfpZ3ovsNLJgnnw0nDW
         fq543KrDOzCkqwXFLDjN+8hZQBbww3ThJhv3BQwa3FZWlnGIAn2Mpx4QAzcva99psKs4
         oNdWA13SrfxdmUVjCKnsE3QSUKuHXHDRZTAfM/6KO6UKPl1TLQVZDzS/cFiUgXLyw/8H
         AAoJFOg0JboiBdWRCcbfRCzuqQ8hNSMBiKmflIE9HS95OCIR8W58CYc9nmrmk8bZAkNm
         OWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941964; x=1769546764;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkuDK1vwgUYmeyMFGWx2++iGfXy3+NjUjhYD62YixoM=;
        b=OeW4MsksYiQlAigpYpWTMXIfzuWcm0koz9QYxdmmXNgipi3c4p9xJ+VXW2n8s7m9P6
         YL+4HjI8HpSosiy3DYWS2Nxlpx3q2swT5qD315APoFxAVxJQYM9s3pMpuI/XLwsvk+0S
         oFBQn3mNzs9hln9xc104hd+wLChCBJsQnlgMxN5BzUhRYp+0/vNl+M9+crh08x0gM9sq
         ViRbzu2AH3cuo52cGybci4wz+d9C1qe2EHFa0n4/Z+52K+YzT94PBwdDG3NdDWlXw5f9
         KWLqQheQxRV1URDHX7/4cfk1PnzDhJc5iLGTEXyiigo32Ns91XpZG6oMUPPg7y6G7zFL
         JSDg==
X-Gm-Message-State: AOJu0Yyz1CzS7pLWj1ZwKu4Qbhl4jxFZac/MSRr6SxooL3Jp9Bja+vZY
	UXQXIPRf+p9SQG+keS+4oojpxhrUcex+FbpXYLUUDLpgUTQmlPcRGNpuLikPnHHD1jE7E/a2Yeq
	kgCy+dEUX71V8qCNZPTwvwa9JErTIOOBw4+rC
X-Gm-Gg: AZuq6aImAsWkImQlxSzWeX1rjLm79SpIr0prXHucmZ87E2+RZ0mLH4egLyDzbNV4h83
	5HKMw3cl23G7OV5mGjfzuhzaS3cFmS5AqJsiK2e7J9ajBjvSrJay5crtX7d7imyRWwjjmgBPszj
	i9Mo9JOstvhETte5jqWOoTsOZuED6MdHOZA8zX7xIJHmueENx3e7Cp36PR7Pg9Ip6Yvlfx46tc0
	OwxpWwDZ3S6HrMuD9nB1DKN7+JhVvap4sWvmKWh2i0un5XDveO2N/Aod6kJkipgdiGx+wAYSFH5
	37LT
X-Received: by 2002:a05:690e:138b:b0:649:422e:a68d with SMTP id
 956f58d0204a3-649422ea842mr1311798d50.69.1768941963770; Tue, 20 Jan 2026
 12:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFOYHZDnXQOcDmzwf1WRpZpNRAs-R2YOBh3ru0mr0ffrMLB=9Q@mail.gmail.com>
In-Reply-To: <CAFOYHZDnXQOcDmzwf1WRpZpNRAs-R2YOBh3ru0mr0ffrMLB=9Q@mail.gmail.com>
From: Chris Packham <judge.packham@gmail.com>
Date: Wed, 21 Jan 2026 09:45:51 +1300
X-Gm-Features: AZwV_Qh6awBKyVFd4ERnfRyYDVOV01vTDtY5vVCvsiSVLwjF2J9Bu4ZkglPokeo
Message-ID: <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>
Subject: Detecting source of a push in a pre-receive hook
To: GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Git,

At $dayjob we're moving from a mix of plain git repositories on a
server accessed via ssh with a secondary Gerrit server tacked on the
side for code review to using the Gerrit server as the primary source
of truth.

So that people don't have to update origin.url for all their local
repositories, we're using the Gerrit replication plugin to keep the
old server in sync (and will likely do so for the foreseeable future).
We have installed a pre-receive hook for the migrated repositories on
the old server that rejects pushes from anyone except the user that
the replication runs as.

For various reasons we also have a CI system that pushes some things
(mostly tags but some automated merge commits as well) that runs as
the same user. We'd really like to be able to have the pre-receive
hook reject pushes from the CI system but allow them from the Gerrit
server. Does the pre-receive hook have any way of knowing the source
of a push operation?

Thanks,
Chris
