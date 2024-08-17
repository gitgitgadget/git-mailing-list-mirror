Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9E881E
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887505; cv=none; b=C4/cFHEKJdc3LTn8xeZILoXOW4ErM5I15KPLK8982LIxs8ZxKi6vMcKNlD9EPcW9G1zkBy1NFHRCyO7iBJOacJsSypVsopzdSAYBC591FRD+DPMngkGe4gytUrZsHk10GB29C0ZPIqXGHz1apk9HkZIrG6849i9VGKHEQcdkJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887505; c=relaxed/simple;
	bh=rLJOMI1LK9TlijrGb/5oejrQdc/IbSdEpadLGYzsEd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQJfl9VISun8i52cFlp88M48uc7k9py2hLQN+JiPb6L3F+OEaaWVx78UlwglSIcYiyBom5kwmNQoNJARrWDiGU/lWrLzq6mipSPY6IhA8bc2WooDASvzTvnZAVTTPGmx/BKlXsOdTe+XB8BYteMD83zqrJkBzHHdhSXJ68O6KCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf8a662467so3032826d6.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723887502; x=1724492302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5+HEbhu2WqSldVrZZWzhPFhDUNX5RsgMEb54dxd1UY=;
        b=JAPWSIuNTbcqWaz/46fuI7fa9NE4/g1MSAgGAy0sTduOCQgweS5R7sFCrs6X1tq97F
         J8fILUYUk3j+wcCiXRIPrJgFvY+YQsLVlMxLc+FQTLZuu0GDP+uFM7H394Kb0VpH7piI
         Qk7ZdI5Hhcr9UJPY7jaADzlp3DcSfv9bwa5IGU90kbYby519H2YDbp8Km9UIlL76gPuO
         Teo1VlNLS+apZzn1OThezU3PrNKXKwhWIa+9c/q4uxfZcNX65nDyTL5Ws36JcZ7fbmSC
         R4M1n/vIn5wSTPrsuPJsXjOHR60n6xoV1jvf24qan+1uv8lPmYB8/CffCOmS2zTU92qG
         4Ffg==
X-Gm-Message-State: AOJu0Yy0SwronAZh8jyPcL3kJ++giCXSN6depQ/wOfhTcjuizanDieRB
	wOkW10P7v28f1uo6bIsQrzaOdm2zi2sJXzn5ZWDomRPYfZ+NGgO1OWr3YYDjLtUo9NOo/fzxhKn
	lCTCnMlhk/9dqGiqAbhFGbKNvbD0=
X-Google-Smtp-Source: AGHT+IHGFfaodGHUQqQy9e6ZkTbv6e4Sx1YAOdl7h09Tle6PGR6cYFpGhwY9zrKx7IyPG2H+iiFNTklCRV5qN92x6o4=
X-Received: by 2002:a05:6214:4986:b0:6bf:6b6e:d148 with SMTP id
 6a1803df08f44-6bf7ce65d0dmr79241316d6.41.1723887502464; Sat, 17 Aug 2024
 02:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com> <3a41ad889cc33a1fc0414b8f14af6438b49c88ee.1723886761.git.gitgitgadget@gmail.com>
In-Reply-To: <3a41ad889cc33a1fc0414b8f14af6438b49c88ee.1723886761.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 17 Aug 2024 05:38:10 -0400
Message-ID: <CAPig+cQVHVoDFD484dxu2gOuvzVHj9-78pyTnCo2-uy6=N5P-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] git-prompt: add some missing quotes
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, 
	"Avi Halachmi (:avih)" <avihpit@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:26=E2=80=AFAM Avi Halachmi (:avih) via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
> The issues which this commit fixes are unlikely to be broken
> in real life, but the fixes improve correctness, and would prevent
> bugs in some uncommon cases, such as weird IFS values.
>
> Listing some portability guideline here for future reference.

s/guideline/guidelines/

> I'm leaving it to someone else to decide whether to include
> it in the file itself, place is as a new file, or not.

perhaps: s/is as/it as/

> "Simple command" (POSIX term) is assignment[s] and/or command [args].
> Examples:
>   foo=3Dbar         # one assignment
>   foo=3D$bar x=3Dy    # two assignments
>   foo bar         # command, no assignments
>   x=3D123 foo bar   # one assignment and a command
>
> The assignments part is not IFS-split or glob-expanded.
>
> The command+args part does get IFS field split and glob expanded,
> but only at unquoted expanded/substituted parts.
>
> In the command+args part, expanded/substituted values must be quoted.
> (the commands here are "[" and "local"):
>   Good: [ "$mode" =3D yes ]; local s=3D"*" x=3D"$y" e=3D"$?" z=3D"$(cmd .=
..)"
>   Bad:  [ $mode =3D yes ];   local s=3D*   x=3D$y   e=3D$?   z=3D$(cmd...=
)

This new explanation in v3 is a helpful addition.

> The arguments to "local" do look like assignments, but they're not
> the assignment part of a simple command. they're at the command part.

either: s/they're/They're/
or: s/. they're/; they're/

I doubt that any of the above extremely minor commit message botches
is worth a reroll.
