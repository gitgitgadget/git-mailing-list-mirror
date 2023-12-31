Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992D10E2
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680a06cc763so9249326d6.1
        for <git@vger.kernel.org>; Sat, 30 Dec 2023 20:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703995742; x=1704600542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXR+UFPPzJ2ozGOv/zNoBDncuXcN9ZVYshYz/Wc9ulA=;
        b=I3nWPgOO08nA9M6gsDFTZ+RMReWH6rO6OBN3O1i63ZB6mvWY0Zuurzi9GAeg+zJszr
         x9MZFuLPPjbMpmeuPgE9bZZPSmCVbSIkZuGyIudYNQM38K60EdMa7RkS3pbSsEiVGKPe
         DzgyZX3i993FKxcZEnsBwlkyYSuErYm9ExeC67zyh0uLtC0Y3bYFZuzuhbSN4BnC5mDe
         q6g4Um/uozd9JSY18XZMTzQjTT2fB9ms7VUOLBArHvoh8LewCj8C1QD6piyzyI0xq6qq
         nzV12walimV8ItWs9WFu7NUAFypZPiWKf1DEoTShkNY17bKmgzlk8GL+sthuAxvLYfFf
         nNWQ==
X-Gm-Message-State: AOJu0YwR0F0NcVZUCgN5Q0qTETHAVHXU3/OXyvg06UXAOGNXfsulspIJ
	dVrbH81NSaUram9ftTQ9vwVjcxVEIY1qM2IvbZo=
X-Google-Smtp-Source: AGHT+IGwYjjACJnbudlzspvQLvwdVC2eG+Y4P93qgq4QA+ow+8EVjBOBWQL2oPVAS9V1ixFeGoHTGWertXX5jO8r4k4=
X-Received: by 2002:a05:6214:62a:b0:67a:a394:e20c with SMTP id
 a10-20020a056214062a00b0067aa394e20cmr23672410qvx.38.1703995742067; Sat, 30
 Dec 2023 20:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229120319.3797-1-soekkle@freenet.de>
In-Reply-To: <20231229120319.3797-1-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 30 Dec 2023 23:08:51 -0500
Message-ID: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
Subject: Re: [PATCH 0/1 v2] Replace SID with domain/username on Windows
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 7:03=E2=80=AFAM S=C3=B6ren Krecker <soekkle@freenet=
.de> wrote:
> Improve error message on windows systems, if owner of reposotory and curr=
ent user are not equal.
>
> Old Message:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/source/=
repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
>         'S-1-5-21-571067702-4104414259-3379520149-500'
> but the current user is:
>         'S-1-5-21-571067702-4104414259-3379520149-1001'
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory C:/Users/test/source/rep=
os/git
> '''
>
> New Massage:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/source/=
repos/git'
> 'C:/Users/soren/source/repos/git' is owned by:
>         'DESKTOP-L78JVA6/Administrator'
> but the current user is:
>         'DESKTOP-L78JVA6/test'
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory C:/Users/test/source/rep=
os/git
> '''
>
> I hope that I have succeeded in addressing all the points raised.

Thanks, this explanation does an excellent job of helping reviewers
understand why the patch is desirable.

It's also important that people digging through the project history in
the future also understand the reason for this change, so it's very
valuable for the explanation to be part of the commit message of the
patch itself, not just in the cover letter (which doesn't become part
of the permanent project history). Therefore, can you reroll once
again, placing this explanation in the commit message of the patch
itself? Doing so should help the patch get accepted into the project.

That's as much as I can add. Hopefully, one or more Windows folks will
chime in regarding the actual patch content (whether it's acceptable
as-is or needs some tweaks).

Thanks.
