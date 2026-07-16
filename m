Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27372618
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223076; cv=pass; b=ELSNUzNQ2355zdAlRF8CnUU+1x06bNleUvbnLH5QlszunRATQBqUnNFFzAbsHHfI8nT9zodh9RPf30OhhtKNyfJ8an7prGimmXd/9cEuKhpyfdBDk+1/L0usSMpkDcLANs9VteK8ybM2qoHUh2QOQ/qzlSP3gtxH7oYb4kTyvrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223076; c=relaxed/simple;
	bh=Tk4zWYSwnP47rwgxkw17VQdbO/1f9uGKX1KjootXdKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn+j/uqHGJDtmxtb0Rjfh2IRufEbVHxBXsXcQI/kn3CrSaPcLZvRDXopDT3UGG6dshHOS9TODdHyj7hJmsBhO6JmTlCysieABSxYwl2VXJf4WLvaUeulp7s+UEX7AtimJLM8fOdva0OXajM7fn19hEeDF844rkgfAtwmF0vhaLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1zTucxd; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1zTucxd"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-456395f4e7bso981235fac.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784223072; cv=none;
        d=google.com; s=arc-20260327;
        b=pk9p/+y1wi+AkOwliJGCIVdwLbGtbnm3NzNnq2mv/igRE7br8r9EbvL2I9h207W26K
         sCqjXgg9pIlqdxht0w7W4o4emU3DEiwQQGTGGNzEQs4IxC8igbWmjR/MJPOSkbZpqyw1
         76o40LkzRoP+laYeXQEsWDozR+mV2M5EMUE6Okx6w1tYxGwpwpcl1Pifz658S1kGiemU
         t3kA+RdyPaur02IeCHsAk8LCBxlyR8v+VE2GtmuGYQG5Em8AHYVbT4CctMJ9oZYQqIbV
         CTBdZ2XrCbgicb9c8muYtwbx4ocs1CBM7BJEXy/voqNS3IiZ7eBTx/72EV7GBnTUQZzX
         14Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tk4zWYSwnP47rwgxkw17VQdbO/1f9uGKX1KjootXdKE=;
        fh=hTWK4h3zIVXElVVWunI4Ig0H5awc1V6RnPBnBOmgRe0=;
        b=E6FZ6lDHhgmEmdKTKgQQ0UeGtRHn0pRqAjO2YVgeKjPHf2QCUCeP/71P3yIBrXdUpi
         EWXNg3z3WEWmNixG9oHYY4CTVkw0zYNl2y0HsiQtZ7KU1iDhuTLgWaLmU8EGuAjdDKEx
         dC6EzdJ2TBfspaZV3f64YuKadX4gxaI/Rrd+SZFxW+7QuzB22YzxS8mZRNcwrFY84JOo
         HAaPSnN3jbnOS/K0RG88j/UBaUwctdvWqjdhkMuQxgB7Z0zTb6D77ssee8GwNiSex9q0
         oD70jxnX0kqlHykoADMSINTXnkIDxuqZ3OZQ0rUbuQhO34uS4GRE3UnVd3a69EWoahFq
         9spA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223072; x=1784827872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tk4zWYSwnP47rwgxkw17VQdbO/1f9uGKX1KjootXdKE=;
        b=s1zTucxdrUIWElpiJfPYopVFQn8vBbGqkktn+MuFk7j4qE+Krt6ln7bfJYVYOlwf7x
         gT+NqsRYaee1ovZZ+p+cPlThoXTyQxeh/kRpkquhMO5AUxuFJHxrUNTXQ6OscXIKZ7di
         B/NHCh/ingu5sxjtj5MO++lDtrHBYBNR1wmAjrZOLA8icvoU7BNJX6IJL1KhSf5OGGUv
         tZ9g/EP7b+TkFar7V4cxgg7eptEfExQ1FG6gh2ziFJbN9f+hUjFwRH95KGM3PbMIgrsU
         iCQeE5/MUg0YtU12vSMBtiq7X8lUoxPBTXVuzyXlwMHK3EQqrttt6D8fKxZYizp4loZ7
         Lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223072; x=1784827872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tk4zWYSwnP47rwgxkw17VQdbO/1f9uGKX1KjootXdKE=;
        b=PTgRXb5kP7WvEb78mGEGDHxwYft3roW2F6oYqQj9A3inDcGKaji8qMbiW7xdBYZzXw
         BLvHjRaZICBeI2S0wGkhm6GggeqkQ8PSywnbyMDZGjaA781pJ0RjboKgJHyxnb/c58B3
         kf2J8PtVdSLLKl4IW9akrCSgMIPGEnfV6k0pXoOiEfDF37Qv1GEMuYKeUAKUE/arCmvt
         P+qe/hajQje/yIo1Mzsw8A8XB0idzI2oTodAcjL+e0kGww2cajrZnvlgJbqn68F//YRu
         T2NNT91RZD66n7WKRbvGjE+pa6XBxsFO+gFG6qj14ofidF4JGNMxxFwtBdmfIixWavhL
         +tBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWPuDpp2C4Uj14P8/OCZKJXQc8bFG5E5N3RzIMtjBtaHyEJ+OFg5yoOJp6bhix5gGfizg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVICJOaze3oE6Y1P9+UZLqNL8asdiQfbnQd3MVVn/d95i2Qq16
	4sWsktxtovLnqWcRNmEtVto4S06gKmo4J5AOmZY1ewpGbyCel9NvKeEv6op7gwfL8ZQaX2rti+A
	p1QeLP9HBNyLca4suxwZBaF5IT2Ak+PQ=
X-Gm-Gg: AfdE7cnClnOMzHQODaDsUoTqWp1O3bG0uFcIab3vao2gHlhEKc/O2QU3IP67msgtysL
	zn46Gps2/0g6eJVuuMRZXp/IDmzC0Lvk0w3WOvTjr+DNaIm4tSOO7/SxJF3BIn8UcBnoaMRFrlj
	fiBUgmDmcf5f6M5iIyyaLFQL5Xo5OE4thzuOr5oog0DVOg8zv8GTEOC2C/mzu2WTNZB6cgowQly
	2oZxeNT+pHxEVebFLj+XwTSRGFIwRlIpJqbTnFrqdceULE7PeuuzW9Am2wyLB4qpOAYP6mp/uN7
	LMbRncHAScZrooJ8ZpmAymOI4sLYwNVVdevAWWZg/cm5PzjkZxVal5VuJMCf7ZZVc+/gtWcLQRB
	wvf7s
X-Received: by 2002:a05:6870:f628:b0:449:e9b6:8164 with SMTP id
 586e51a60fabf-4562b724b5fmr5564109fac.30.1784223071977; Thu, 16 Jul 2026
 10:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
 <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com> <xmqq8q7aj3b0.fsf@gitster.g>
In-Reply-To: <xmqq8q7aj3b0.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 16 Jul 2026 10:31:00 -0700
X-Gm-Features: AUfX_mzDXjPIs5UNbfLim4GH2rkkhukqy7Ln6P1SzHl24aB2_IkCywRQBEppCc0
Message-ID: <CAC2QwmKRp90hmBAckug9PPvvD53Pi53q5csZhi15LRhzdQasQg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] [RFC] diff: add diff.<driver>.process for external
 hunk providers
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 9:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > A "Which features consult the diff process" section in gitattributes(5)=
 lays
> > out, per feature, why each does or does not consult the process (patch
> > output, blame, summary formats, and the -L line-range view do; pickaxe =
-G,
> > patch-id, merge, range-diff, --check, and --raw do not, with reasons).
> > Combined diffs (--cc) remain on the builtin algorithm and are noted as
> > future work.
> >
> > Changes since v4:
>
> This round does not play well with the mm/line-log-limited-ops
> topic, unfortunately, it seems.

Ah, thanks for the heads up and apologies for the hiccup. I will
rebase this series on top of mm/line-log-limited-ops and make
sure the two topics function together correctly.
