Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988D13A26F
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215339; cv=none; b=Wnz2Sg5qFEqavW067Y1Vzb5zMoOTnCvxG8S5w1OditgxKKE4OG/EqgqS0vVOVp3Dtzor37ZoBhwJpud+mM7nSJwt+QiIv8qdjpQn3M+O1Jtk9s+yGzxuWX6rwg+kD5Rp8McYKloe5foEJPYiQztdGzJuht901r0s81ODc2NvF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215339; c=relaxed/simple;
	bh=TQpNq8VejhJj4lLJIla9Q5JXLv7X686NSKCg43hPeos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp6+ZErh7xeyBm6Rm4shz7LiypxgMaWil+qf3PZCepQf8rhhlTNyKDHXaJ48IkyhufmH2bLq5rNEIfcLpAxGvlBlKU0H7Wo3WyyAcHzrMsnIO7T8TGqAlTeOArHYgVGKUO3z4vM/bCvmnN/pB8io/wde6YwiG4iHavs0GiFzN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e03618fc78bso1955756276.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 14:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215337; x=1720820137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIrxJfqrsK5aFkhPfxrn5XaDAitPre3ubr8Kf4LCitU=;
        b=PJGZV33euJvmJoQ2WAUM4MQQrFGOsu5GiPvQvizkbc8TfjSzFZWkzpsyzLnjM/P3QE
         MaLMB0lxHQ8tWc9wz5GLOJ9qsLn8gSrGLP763WwEUWvnnfXMuSYsg6cqt/cl8VrHiyVI
         sH9nnLdDFriNAbtG4n4mEGsvCbkhE577fhijm2JqUs2Zq2wd4yyqRcHKDNPATC/akdmQ
         sKrV7ch8vpxtgZYL2mxfTtyYq4fL6UME4kZHFo97aYB0fmty+lhrK2upWbda4G559E7f
         QWkvcXPizdGIthuTUseJ4mViS1SqQcjgaOPAnYIPaOzkpxd9OxzSb7i593LdqTBA5lFw
         uZFw==
X-Gm-Message-State: AOJu0Ywm138TCRA3KrczNcEv3lFlewxYpngQFLpu1r3l74ucazyrOoTi
	/50wqitZyr8J3T0MWEhpYOwMfYjyHJmCjUYXC0qi681MTFYOXC318P6p5UN226PUmtJFquIbBOl
	gnRqBsz6OahpsyNxS6NbinJpkcgU=
X-Google-Smtp-Source: AGHT+IEt6VNvXzot+Z+HLEgaigZfNmTcxKE7hyshsRAJsAC8USyWNnLy9aVZHNF4pnbAnpcZvk3+xcGL+oIJbhOP/qw=
X-Received: by 2002:a25:c70e:0:b0:e03:abdc:f2a0 with SMTP id
 3f1490d57ef6-e03c1a05b56mr5714239276.60.1720215336783; Fri, 05 Jul 2024
 14:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m0h6d3pphu.fsf@epic96565.epic.com>
In-Reply-To: <m0h6d3pphu.fsf@epic96565.epic.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Jul 2024 17:35:25 -0400
Message-ID: <CAPig+cTpxXNwy8MYWjcDTa5QPoq5Mod3_LZ=+F16-gF5QVbrkg@mail.gmail.com>
Subject: Re: Should commit-msg hook receive the washed message?
To: Sean Allred <allred.sean@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc:+peff +philip]

On Fri, Jul 5, 2024 at 4:12=E2=80=AFPM Sean Allred <allred.sean@gmail.com> =
wrote:
> From githooks.txt:
> > This hook is invoked by linkgit:git-commit[1] and
> > linkgit:git-merge[1], and can be bypassed with the `--no-verify`
> > option. It takes a single parameter, the name of the file that holds
> > the proposed commit log message. Exiting with a non-zero status causes
> > the command to abort.
>
> Of course the actual 'proposed commit log message' doesn't include the
> comments included when running a commit, e.g.
>
>     git -c commit.status=3Dtrue commit
>
> but the execution of the `commit-msg` happens before `cleanup_message`
> is called on COMMIT_EDITMSG.
>
> This seems like a bug to me; is there something I'm missing? I would
> propose adding a call to `cleanup_message` (with the appropriate
> arguments) inside `prepare_to_commit` right before `commit-msg` is
> invoked.

The idea of calling cleanup_message() has been discussed before[1]. My
takeaway from reading that message is that calling cleanup_message()
unconditionally before invoking the hook could potentially throw away
information that the hook might want to consult. It's possible to
imagine a workflow in which a specialized comment is inserted in a
commit message to control/augment behavior of the hook in some
fashion.

The idea you proposed in a different thread[2] of exposing
cleanup_message() functionality as a user-facing utility which a hook
can call on an as-needed basis may make more sense(?).

[1]: https://lore.kernel.org/git/693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail=
.com/
[2]: https://lore.kernel.org/git/m034onpng4.fsf@epic96565.epic.com/
