Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A6173320
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973787; cv=none; b=DBBKkut68QiI0lGr9dhmVoX2GzQKZdPZMXvU7HGqKR2Uj02gArvzfMj9ZmPTwnufutsTSrb1bSzQZlm+Wt++QPGGiRyEjO2dSSvw3JEMHynOBEB7CFJr6fAeLYmgPy1A1cl/w3gCwllkJqF9iTpd70ByGDaq0j9K3a1kahocQWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973787; c=relaxed/simple;
	bh=fQL120b/O8JbGI6muwqpaBRUTxwbdaMEikvRGsgFIhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtrX43xUvigHpQHolRu2hFKk/2XvZJNTI7WWS+yNYu7jHTqvvhHjaqbG4ril+6JEA+JnZzYqJb79eOxBiOKAt2Z5KI3lEcsakog2DshyB0e1zZ3OxmJ9SxYFWEuZBB1TzxvqpJrIu1bp0xys8vIUFMochz+JyrQ+th9J30TmRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbd12cfd7aso9440506d6.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 23:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973784; x=1729578584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQL120b/O8JbGI6muwqpaBRUTxwbdaMEikvRGsgFIhk=;
        b=VsiTtuPmQdPLSDm2E8cfvAtf7ZGtAqp3FReGgyOCTvGJy9XqnSp4bgEy31go1J+SDt
         Zo8713gUMEACyKyTQ6Fu4v49W03InPhSrqK38xgVn5+AdV+Sh2/QaXdQN3PuDIRGzzHd
         35bbP86m6ECz3IJwPW13bSVtibiDbgvhtV6CUqpm8V8R0LyttpD+YckgSrwsUwIv+Q+f
         ep/osJPWHw2KcdQ8IwkSXrBqveXTrAXUvpzhd/AevFEd0Q4hn06qwAJZtO1UlxqZJ6bJ
         A/NkUXwafS6+ygLOfgiZqVW2cQdxCLCgx9nalaexGQEEhJNNdzhRban1oXiCUkTXBTIu
         yUvA==
X-Forwarded-Encrypted: i=1; AJvYcCUoMQuHc4+cUr7/vR5W1Zpl9eokXmrGLQGRjWXVc/B9YxbW4z/Y8Ao4ibO2chdmyytwgR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuAfYe/L69XQ5EcQ9oUh4NhaDGpo9wcxdfa2C+hklGdFxwQvJ
	ctpGfN7oNAt9gj9kE+VyN91eAMVfF2LcEVPLAMGa242p2U+EAwk+nnXcOKpv5mmEZ4UM6Mge6SG
	+lxY8H9j2aZ3bQ1g+QT/LbJ2jO8p0Mj2P
X-Google-Smtp-Source: AGHT+IEPHnx+gt8NgeQoFpHF8atY3qycCh1H5bSyTA3jGREJFcBC+c1r4E0ZdJAnMnVRk9TNvgEJOmEgmCHcp7M+nPc=
X-Received: by 2002:a05:6214:1c88:b0:6cb:2eb2:1fbe with SMTP id
 6a1803df08f44-6cbeff7324amr85811536d6.1.1728973783969; Mon, 14 Oct 2024
 23:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014131346.3556163-1-asedeno@mit.edu> <Zw23K4zPN9e+JyNA@nand.local>
 <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
In-Reply-To: <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 02:29:33 -0400
Message-ID: <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
To: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, sandals@crustytoothpaste.net, 
	asedeno@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 8:51=E2=80=AFPM Alejandro R. Sede=C3=B1o <asedeno@m=
it.edu> wrote:
> On Mon, Oct 14, 2024 at 8:28=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wro=
te:
> > On Mon, Oct 14, 2024 at 09:13:44AM -0400, Alejandro R. Sede=C3=B1o wrot=
e:
> > > This is presented as an alternative to the patch series from
> > > brian m. carlson that bumps the minimum version of libcurl
> > > to 7.61.0 [3].
> >
> > This conflicts with brian's series as you mention, so I haven't picked
> > this one up in 'seen' yet.
> >
> > Could you summarize why you think this series is a better approach than
> > what brian has posted? On its own, I do not understand the motivation.
>
> It's a question of preserving compatibility vs ratcheting up minimum
> requirements. Both have their merits. I sent in this patch set after
> seeing some mild pushback to brian's series, just to present an
> alternative. Maintaining compatibility with older versions can be a
> burden to the project, though I think given this patch series, it's
> not a very big one. Ratcheting up the minimum requirements can be a
> burden to users stuck on (or choosing to try and support) older
> platforms. At some point the burden on the project outweighs the
> desire to support those older platforms. Where that tipping point is
> is for the community to decide.

For reference, I'm the one who pushed back on brian's series. The
"push-back" subthread starts at [1].

[1]: https://lore.kernel.org/git/20241014132856.3558224-1-asedeno@mit.edu/T=
/#mc1180f00cf52de4e9bae334c2cd5abd9a160dbbe
