Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640017BB1C
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841885; cv=none; b=JJxIuzqCqwfLu39gxaOEylfwKtDiUL2ruUEb0NT6Pdg5jKMrhViaTEcMNguuJaJFReX8wXq/plEdZrPj69lM9J0IKe3X79ukUphpd7omvJfWV5Acml0gYPOkyR6qaYN1XAx2uJoNvjqjPqGoXR0geBRsEplVCUmQfjfC2a25Ld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841885; c=relaxed/simple;
	bh=l4FSPvv08YWeA9V8VwJR1RZMz/vPGTDEhlvMX8vvgFo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueCjtNoqhRQCY+2BealQl49tFkzQv8nBfgMWJCSivhlWhikqMmPVuOvW9brjzgv7D6S11+NZT5Hc5+O32RZnpA9+iEecg2u2sKe7O8e4cYmYixoQNfCe5Eyfflkg13BOfBTqBvSCkVhBq8k/8pb43C1eEQboEolERtBmt31Tm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Wt+4ZcWf; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Wt+4ZcWf"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso113276239f.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841883; x=1727446683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rBMydUTmTPATFbYvNMK22F9QNiikPMh4AhgwJiYvxQ=;
        b=Wt+4ZcWfHamILUjz4e6H3639sfMyyEcOvcXpnvHLdRG7d+J42zKL7mzapznbL84ibS
         7xBrB2OYDzBNvDEYL/MEfw6jShMC88CfbikHR+TME4DI606jAzDMgx5ksLtHcrYPaNjH
         1BPzKbo8JzCysCSHgXN1dQVabYPrlRw6Ant7zxMIuaJ1Mz3bTBYuhuuDlCBBeFTY3Xt6
         qxavwtp6Dp1W+YJI/n0Hb9Sz2T3ff3cgwYcrj7lGadml3oCld2GamFF+v7OWQuPNPmup
         u9JBl3oSqfY2nTosryKqSDcWQ6dYhrAEAF3d8tq5h2rrAkW127x4AqA0TShHJsPjtKYN
         yAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841883; x=1727446683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rBMydUTmTPATFbYvNMK22F9QNiikPMh4AhgwJiYvxQ=;
        b=XwXkaCLRnGVBl5D8rnPOR193yk4Psbbpf2nxo3eP7OwPNT9B1u4csf40Q+49yNqXH/
         JD35/dgvQoCQydi+Li9B/v5u1re4HoRS2/Pzz2SoyIWIZ9/WRaRAuI5jfRMdOcaFDta9
         40swkPdfaUC3FcrRN5+nTX0IZCl7PSF8yvQgdRhkrfcqbblkgl8zdBCu7AuCN7rGaA/S
         7bac71ttDnMNUqCxpHtqNdpE8HNaS/++L87i37TNfZcQGleFHMfR+mlYM4lifYXlDhmb
         Pfcf3XXIcrAkApp8gDK3U5rh8KQYOqgIz/oMAK1LspMIAtAiHNTeZgpl+STVPtpUl7gf
         ARYA==
X-Gm-Message-State: AOJu0YyA/NTw/9z8QILc63KkIBsGe05aL7Fup+TBWgqC3nuhEm1Jz9ny
	KdY9eJVrbLKBejO04LQnzNEIdtbyFZuc2i1s/NHaEZZV44Mp70/zj9THrjcJVwc3L7iYciWztkL
	erx0YEQ==
X-Google-Smtp-Source: AGHT+IEtlLq7HZbwqDbLJ3V0vSizEOl4OkrybqX7oewmHfuBu9Sdyqol9hCGX75g+IDjIDN1WiwfjA==
X-Received: by 2002:a05:6602:6b86:b0:82c:d794:4695 with SMTP id ca18e2360f4ac-8320b29648fmr248931539f.7.1726841882739;
        Fri, 20 Sep 2024 07:18:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d49338889sm388850039f.38.2024.09.20.07.18.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:18:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:17:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 02/11] Top-level lib/ directory
Message-ID: <Zu2EF2bELvzC4f9s@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Top-level lib/ directory
========================

(moderator: Patrick, notetaker: brian)

* Patrick: Difficult to find stuff (README, etc); top-level directory is
  cluttered
* J6t: Clarifies that this is the C and H files
* Emily: Originally the plan was to move libified files into lib once
  libified
* Jonathan:
   * Discussion has been present on the list before (in Git 2.0
     discussion)
   * Bikehedding on the list (more difficult to blame)
   * Differences of opinion about lib and include and naming
   * Blame problems, but this is an opportunity to fix that
   * Heart of it: has nonzero costs, needs to have enough benefit to
     offset it
* Elijah: git apply doesn't handle directory rename
* Patrick: Bikeshedding not a problem; can be handled
* brian: Not really hearing an objection
* Peff: Not a problem for him, but not a really big objection
* Kyle: Not sure the value here
* Jonathan: I really love what Patrick said about "I can handle
  bikeshedding", I think it's great if you can guide a discussion
  on-list toward a decision on what we want for source layout, how we
  structure code, etc. Exciting!
* Taylor: improves things, makes it more maintainable/discoverable, but
  takes time away from other things like security/performance bugs.
  Should be done with a healthy balance.
