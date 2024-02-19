Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64727481B5
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371418; cv=none; b=O0Ioq6bTcTYL+n72U+1vfGr4LBlusPkP73vbGuaIhaZuM+9GBc4GMCNEyJSWTsT9kCHeCTHiZhXASV1aoNm3oexfrO79NNLxcpdKvO6Hx15qKDVCYq6MNQjZ38M5CrXILk3PHNb+HWAgjcbHxdgXIdaigO2rKi7eJFLdH4QN9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371418; c=relaxed/simple;
	bh=ywFYFtpeDxGAuly333WKUcr5IE/r4U+PK5Z9Y9iqCug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikM7M2kxosyhF8b9yGZInwzfnTPksBGyxmWDGyO5JUqj6xEP/DnV4tzY3uIYKr7L9kkZ0MpBd0MXWUjzIoUbVTx8C1VtUS4dp2dtGOu9PHyuAWGJDfVoP+zz9RNBRJ2OLbDiqPDNNMblAB8VywQw9CYXcCj6zjkpZ9k9NdRpK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f283daa21so34033626d6.0
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 11:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708371415; x=1708976215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywFYFtpeDxGAuly333WKUcr5IE/r4U+PK5Z9Y9iqCug=;
        b=BgGyrAUbqHYVS6oL/Se7PQ47yfpTnuR8UmpzpnFiMRyLCX0fSLg8V5Rj8AARJGwPAd
         mwP1wvlVF7/Kw3EARP77j3jLWt3Q1pVnd5F3iQA2MbUmRTG7MRLhesf70xF55fd1ntYt
         AUMjQ6tJbrcJVLjlSbMk3tadDfO9CIYP2Y91yijW0jG9igmRqoW9pJyCuxVT1X1QZXdW
         MlpYyoHUKAFLaFFQLCwcFwIbQ340upI4o55LJt9L3sX5PW75rCtQMdB3Fsk+jhrbODdT
         ywjIIoSb6drwsocrOxWYg0iBnoULz7SoSGA2Pf2S1/AcCVcFaHFP2s/qyD0T3cU8o7uS
         u2Vg==
X-Gm-Message-State: AOJu0YxF20EffrK9SUV3NP9H6q2pZbsRrc1KbOGPApcPIV2jDAPGFlOI
	f1w6K3oCrFVP2XABnX0WL3I3iDccPrUjSoZf18m//6LXR2gSXY53zoP6cGM37z9GjFAISEnaROz
	G6sI5sEcSN6ecwwB8ub86g7pT/D0=
X-Google-Smtp-Source: AGHT+IEZY2LZQZ0VBA6I3GnErpyDuKWeEFjOvDxQBBnExVWQY+Tr949o6GXbrI8ZRctvTS/VSjIpUx0pv4InmcqfSMk=
X-Received: by 2002:a05:6214:3114:b0:68f:4b44:e393 with SMTP id
 ks20-20020a056214311400b0068f4b44e393mr10806205qvb.28.1708371415187; Mon, 19
 Feb 2024 11:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
In-Reply-To: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 19 Feb 2024 14:36:42 -0500
Message-ID: <CAPig+cSOsGAizKJdeX9Qb45LqsKOzpEO+1Pxhd2e205ndeHngg@mail.gmail.com>
Subject: Re: [GSOC][RFC PATCH 0/1] microproject: use test_path_is_* functions
 in test scripts
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:22=E2=80=AFPM Vincenzo Mezzela
<vincenzo.mezzela@gmail.com> wrote:
> Would you like to see something like
> '''
> test_path_is_missing file1 &&
> test_path_is_file file2 &&
> test_path_is_missing file3 &&
> test_path_is_file file5
> '''
> changed into
> '''
> test_path_is_file file2 &&
> test_path_is_file file5 &&
> test_path_is_missing file3 &&
> test_path_is_missing file1
> '''
> where all the test_path_is_file are grouped before and followed by all
> the test_path_is_missing (or the other way around) to enhance
> readability of the code?

Generally speaking, no, reviewers would not want to see such a change
because "enhanced readability" is often quite subjective. More
importantly, though, reviewers would especially not want this done in
the same patch which changes `test -blah` to `test_path_foo` because
it make it harder for the reviewer to associate and verify each `test
-blah` to `test_path_foo` replacement in the final result with the
source statement in the original file. It's much easier for a reviewer
to validate old against new when there is an obvious one-to-one
correspondence.
