Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162515AC0
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5WdyDtR"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2768b78a9eso701478166b.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704219842; x=1704824642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p1zYSrXDb8iTmB/Sf2qmDvKYx2kciauKU+he49XAYk=;
        b=A5WdyDtR7CCuQU9C6o4Zjufv4mgctTa6ccynVA405Ibq84E3T9kukJV9ICO1L8me7A
         NbK6uYn2sK8kUYnLSzqvoZAkMrAhGE4v1MIT2inqO9QvgR8woZy0LcuNb7mvVOsqfO6D
         BsY9gSZQGlMyYmfTnKnhiiUgHHRjicbTiK7huGcJ/1SrhJX7Exmqb9ie/HRLUpPHdoTC
         fJ5xB8SxEUPmybypuPowNna+xljwm9iuqXSsebfKRdsfEhz7uuCNv3d/tquFXeDxDZfP
         DR7NWj3vAeBybiifajFtsRBFImrRgtRZ5ODZWD1kiR7t1fRUS2gBTm9rmDQNEO6JL54A
         4Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704219842; x=1704824642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p1zYSrXDb8iTmB/Sf2qmDvKYx2kciauKU+he49XAYk=;
        b=oRHr5yiltkiX7t0nxUWKJNUy0dGf17wr0bQePcOuZdUheYnYObMjbuICdujdJDm7nc
         sFGkwGYMm77PQ8lN2wskGbpbIeQ8sXx0DjejfZq7kOc3xWr5OqLK2f9Eu6Jm8da2KZJs
         DcUdXSZn+oWWs0T5oj4XHuN1Xyxj3sid/g3WLsxuYxfbJzejQ6T0YIuu3uxIcIckddic
         v/25+zS3x5YsiOh58Gn/cvD9B8khX7dVr77NHXo7ndxA1NZB4qGc0506lxalmsecmyDs
         3h47AOT8cMMMwpbnaHD/TpEV3X4v0VbyFsczrDxP/8aofWszVBSafYmUVIAMeaM3jXij
         Lxqw==
X-Gm-Message-State: AOJu0YxhWY4GCyfSinwjWFdYcNOPzgP73Gn5ZPz98wBTHxfAbF+A0k03
	/3guTjwf/9a6Y3VXK7Ovnal3ecZ75yFr3clvq9c=
X-Google-Smtp-Source: AGHT+IFVdy4yDnyenoBXLHz+wKSFua+wVEdH7Mj1DcrcJ8H9Z6iUMzgY7j3z1mEJEwExkvNiyYMVgI5rzmN56O+1iUU=
X-Received: by 2002:a17:906:5c2:b0:a23:701b:a160 with SMTP id
 t2-20020a17090605c200b00a23701ba160mr16847378ejt.38.1704219841934; Tue, 02
 Jan 2024 10:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6de00946-9c5a-4854-9e49-069a22f8a782@gmail.com>
In-Reply-To: <6de00946-9c5a-4854-9e49-069a22f8a782@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Jan 2024 19:23:49 +0100
Message-ID: <CAP8UFD3bSRCJgomOSYteJrvXEABwJFnhXu=0qg-ORq680N2j7A@mail.gmail.com>
Subject: Re: subtree split after deleting and re-running git-subtree add,
 fails with "fatal: cache for XXX already exists!"
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 1:58=E2=80=AFAM Eli Schwartz <eschwartz93@gmail.com=
> wrote:
>
> Originally reported in https://github.com/eli-schwartz/aurpublish/issues/=
30
>
>
> Given a subtree that gets messed up, some users might naturally
> gravitate towards deleting the subtree, and recreating it again via
> `git subtree add`. This can result in a difficult to solve situation.
> Any attempt to split it seems to produce failure.
>
> Reproducer:
>
> git init testme && cd testme
> mkdir foo
> touch foo/bar
> git add foo/bar
> git commit -m ...
> split_commit=3D$(git subtree split -P foo --rejoin)
> # Added dir 'foo'
> echo "${split_commit}"
> # 42517e4b9fe310a64be2a777ef08c91bd582b385
>
> git rm -r foo
> git commit -m deleted
> git subtree add --prefix foo "${split_commit}"
> # Added dir 'foo'
> git subtree split -P foo --rejoin
> # fatal: cache for 42517e4b9fe310a64be2a777ef08c91bd582b385 already exist=
s!
>
>
>
> The interesting thing here is that in git.git commit
> d2f0f819547de35ffc923fc963f806f1656eb2ca:
> "subtree: more consistent error propagation"
> the git-subtree program got a bit of a facelift w.r.t. proper error
> checking.
>
> In particular, in find_existing_splits, `cache_set $sub $sub` will fail
> here. But before that commit, the die did not propagate. It turns out
> that actually ignoring this was "fine" and resulted in successfully
> splitting (while also printing a "warning": back then, the word "fatal"
> did not appear anywhere in the message; now it does).

Thanks for reporting this issue! Unfortunately it looks like git
subtree is not very well maintained these days.

There is another thread where Zach FettersMoore proposed other fixes
in what look like a similar area:

https://lore.kernel.org/git/pull.1587.v6.git.1701442494319.gitgitgadget@gma=
il.com/

Maybe you could team up with Zach to review each other's fixes?
