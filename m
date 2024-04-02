Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858D14B07B
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078468; cv=none; b=Sn/5HBdpHOrNK9CTnFg5IHjFg9nPKxDsUUPVb4vpXVtrKaCI66+VsCYJCOiUwxlQa1EbvH19Qvs+MKy+1+afynfE8svFPuyXGD1eMjkFn2j8coju4MbpUphCROqjkj8Q04WhRlhx/FejfB8h/BhZy7w7NlAi+hJKY+11kkAIUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078468; c=relaxed/simple;
	bh=nBBeD8Pp+h+wuFURBVG6am1EIMt+YzF32aj6XdV1aq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTk+Ns0N8ROjOjWit+ujq5dsf9Bld3H2kmNW2zGe9Cg13POCbeLQbAjrD58D8sewfWyZy+o+e4GVQryIpY7w48z0I3ajk1lRVRmr1jDHnUjz6ph0yyA/El98vOUOBHkGf+NQNAc5ULaojTQKHow+siyXcWo2/LZ8hX2JjHhQ0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4783964353dso1858466137.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078465; x=1712683265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnFWcBjRhS1gFC3H6nnGomUDDBLMJv3SPosmKEQzciM=;
        b=FTd26erknUy+j+STrRD4Je5vh+FC78nMu4d3h1lSJ0uaSQjG6pbZrvyDu8VYCnyqYy
         L3eY99YOl/GRc/pP0iNoqBg2wicP+Qt8curc3FgwirM+O48qz7ciyEYBtBDqljHP3P//
         6MjkQfB54DwG6gnQrPQkqf6n024xbKWzSYSrpJLJMOvRP3yzGYvdDQ6Q7+AhBL5H//eu
         VkFivDWYVDxp/kxrqKztHLcs8eTH+868cQrcFo6UhXJ9+2HGUpERoQpROcGBvODfNg1I
         nQgz0aFXhnepRT/qZxOwisI6dcm4fVbpNPH65DobxszSjqGc/p9oHdz7QJ1cm6Q0BbwD
         AyhA==
X-Forwarded-Encrypted: i=1; AJvYcCUopGHTbBcx/nx1stprUsoPVw3SmagoEz7qJcc2U52faqvysPziwYAjsAsp740AHxiHvW5//wx8XMJU+3/P8IRMsIDx
X-Gm-Message-State: AOJu0YzAmR2CcwaZBq3fTM3VWtm8qBwiNXXJPUIIRZfeFenTt12fvQA7
	WN77l2omm8P0OIOBeb7nwAGf3Y6uFfZbGg/XpUzVOh2eJRGC9mqXcvC+nZ5V3B91PnIXiSwGhAS
	8Dzuy2rUUfYc9pe+Ryh4llIl9998=
X-Google-Smtp-Source: AGHT+IF/bTWYUPnT9G57xaLFmZdXlvAnvLX5DNKbmDVLfnpKEEfH6M4uYD/aFGxtiX/8QVSewpNB1LhVfjfXluIZ6vo=
X-Received: by 2002:a05:6102:22dc:b0:478:4960:c7e2 with SMTP id
 a28-20020a05610222dc00b004784960c7e2mr500870vsh.3.1712078464886; Tue, 02 Apr
 2024 10:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
 <ZgvmoSOPs6FG4jGZ@tanuki>
In-Reply-To: <ZgvmoSOPs6FG4jGZ@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Apr 2024 13:20:53 -0400
Message-ID: <CAPig+cRtzbv57=k7ti0YcsRR05gz4v_gExgwi6qCtT6f0i2oKA@mail.gmail.com>
Subject: Re: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
To: Patrick Steinhardt <ps@pks.im>
Cc: Aishwarya Narayanan <aishnana.03@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> I assume two things happened:
>
>   - Your patch may have changed line endings. Please make sure that your
>     editor writes Unix-style line endings ("\n"), only.
>
>   - You seem to have changed indentation from four spaces to two spaces.

Micro correction: Documentation/CodingGuidelines says this:

    We use tabs to indent, and interpret tabs as taking up
    to 8 spaces.
