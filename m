Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31926285CA2
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092689; cv=pass; b=mpxCA4SBF0zjo5455/sQBs2z3whXJ1g9AbZL7riwDxBl+QaWWuU3JVNWsOtAxN4jgIyG8FNASW1NJAmiif1Vlp7vF3DFudmvIHqpH7bxgac5C9DpfwrKwqk3RtXCkTO/TshIR0Ju0YGadh9DBigj91DH5XPbJIfn5tPICXi8iAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092689; c=relaxed/simple;
	bh=tT/XLyvq/6PdPb1ZVxzMx5/U2H1hFMJPWdXsq0Ywago=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JTHZYL0N6gSaySbDhSBObTtWz4lRTEW1IMRIuA1DApw7VE0sLmiPNhRvKaqfyaTs6QH1qEHe/fB8NEecFoseZLWIgdSuvE+ehLqFyB/RavDjrkexKtFSQOLdoXEI270JUizoN4AdRUsw6h+wowzZ0CcMgjhjZyi8iD8eUxgYsAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QveJshlh; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QveJshlh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caa57a41cdso6572165ad.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783092687; cv=none;
        d=google.com; s=arc-20260327;
        b=s96nl+/oJFRLJ/gv3vIIrH3ukJCbcAzsOV+4SwFuQm4p2GhjtCqPGhjbE3kcC9gsRm
         EDzXdvHwZO1IsLGZjr0dfSWLnSnkRcpYL9yCQ+2muNDF7qTGP2i7pxtGSzkGdhbM1zKs
         wqQkqPMr6DA4Fbb5zQsHu0+X2vixzSDY6dXBC36wszfFj2peG3o16l6zADMKofVxspau
         EdHT1/u7gMJdpSn03XhwqKv4hKprmTH2dhFLJu3gvdVybMcD/a0QXwpGnYEDyO9U1fFh
         XL52umg6iaLx+mpKEK76O7Bp6YmwwQKaO7LyMC5oD1EACdDSX/t/34N61J8j4AuZ8OpE
         6I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/hBVzrSbgh6v0/hR5gk4+l6whWKkrqKTKuEdwGbivU=;
        fh=S08nhb/nbOH8psHWhvXaCkC+N1AMCH6EWiVfYO4FT6U=;
        b=ZTO6iaNL90YKVbxXUG6Y0FWpVkd7H2sLFZ7wZsMbcIy5lc8j/QBvrA8VGSUfEL73io
         x4xKwHTuL39yzrpQ4MIPFs+xVsMoLEYVMo1RJayA89wiR8/ZeVwtw5jSqZkiqvbdSrCc
         TpHixI++TnLdILzd5IUkYPd/qht3aOnhZIBxtne3Tq+Lm2YOdYthm8MtWhtHt+PuNu9T
         uTvZx4vpzlhGHMNa2XizFUCs5VsQBlVZ/9y8a7e6TkJYtSDU/6pUhMy3Y4vXwDhKPBl6
         EDbvpqNArXKLR29df5LwiXehw0gWtpfS6dxrl+kOuVpJnxs73OymkQo4D8THxhDOrd+W
         lMlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783092687; x=1783697487; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/hBVzrSbgh6v0/hR5gk4+l6whWKkrqKTKuEdwGbivU=;
        b=QveJshlh15rOp2T3+X6GtL/8L1fp7Yo66d4BHt4MhdIMguhv5857DFB+/gK1RRzUhI
         c2AEWfXXvAGc1j7Lk3C1SbTSpDAvbo0jDIGl5gxaGlErMXBjQ/TxslrwDPaTxSI0vQsr
         YTnYh8XWeNRzB3LiknRhC5YX9V0ysV0q5tey1/lqFHEvthPipvYftmP0Fl+SkpdOAx3b
         FYhGylWNU/UBx+dPJIAEAQBELekYsKGmIvrB3LuWO2iR5x93DmDnpTeARq5m3jjK/GfU
         dY46bc7l6iq/kRfSX6uLZbJqNqnQDuszw4c+I0L8M0zoiguJrpqUpX1hMNuuLcBpQreP
         VVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783092687; x=1783697487;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/hBVzrSbgh6v0/hR5gk4+l6whWKkrqKTKuEdwGbivU=;
        b=g7x6uma08eocYoOk4BpIogXom69kvZsCjZLe9BPGSO3Y1ojYTSNYJ5aiIk+ATYtN2W
         d1geS//SOnwalxIJKj58tblscoFVXZzHvXanF7y1x79OgxMGAUyWvCo3GsyQwZudmXJe
         29E3oWJvhnEowK+b7vwiIckoNPqj6QtMcGzbaPDq0tFi5mTn4hzwrVFNGPE3d9H04BPy
         VKSpw2xOWbeb1Q6OeV/WPB/dy9/DcAVc9/Z+54/e4o5YCRA4nL1wC/Qt5HnaDAHYz6QB
         +argoPseXDkdlt0QQadUSG2y7a5+JFe7Bp8kPNe5ufQnecT4J5iAK3cgPw4Pfpk1dpXo
         KK3w==
X-Forwarded-Encrypted: i=1; AHgh+RpFOYipFQcTRO0b3OgvVo8C+i6Ofk8QaEFr76dvkG/Qq2NOlaLNlqrADqA8K3HjdX5yQoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7AljnfJiBUNt07pwgLs5/erf/rwNQ6+89V0SpHdQaHLwNCY8
	PEGG1gEDtNXgTOUIZUW7klaqYAmcdO/jtkO0yfXCi78aOI70QbcKzc/s1o5Kg9NTe+qk+3j+x6B
	Ibp8QYHTAJxsH5FBIxXFB5BIAYsYne3NdhmgfYoY=
X-Gm-Gg: AfdE7cnUfaPaAJUlNwrDHf8Gwdn088E9mpZ8vEhnAVC7A9YJo2hyzvQ0tLvaTMlGZQ7
	Ihav43PaPHo6OruycmBvTQvdt0+aEaCQRFwaviQx0rS0EQEKxuaMx8B2SZx2r3M7TjAXOVmoB5g
	Vw/EotBopsftV7zbHmb9rkfFwu/oCEAw18bcHbUld7RAw7Rj0CPqE5J6Hke92cVdUWQId5VHnzK
	GK2Z/5oU9Djk8HUGcUeMFtQpXKmmlUei9yV6x7wCx1uTE/PeZX05xN/hs2x42Ze7qYqSbMjxl6n
	mF9npuAA2n07qVvc2JF9mIBn+I/oUTz7ZLafQt2F8vTciLmKU0rd3BdBqU0tKWChIlCvPZKWeOF
	8mOZ1gRvDaBoygTBu+0hwYW7v5g==
X-Received: by 2002:a17:902:e749:b0:2c9:e69f:8b0f with SMTP id
 d9443c01a7336-2ca7e6cfca2mr116055365ad.17.1783092687192; Fri, 03 Jul 2026
 08:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akei64goQf3nFhX4@hikari> <ake8OAIyK-ELs-fU@fruit.crustytoothpaste.net>
In-Reply-To: <ake8OAIyK-ELs-fU@fruit.crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 3 Jul 2026 11:31:14 -0400
X-Gm-Features: AVVi8CfpgxLuDtjHjotvCP9ZEqhYVk-RFmjlCLPsCW4c4qZFm_TlGaQYCNJ8P6k
Message-ID: <CALnO6CCaAaVTDABQT9APasnhmvL3w_C1VKo3UYhgDt29OYPmFg@mail.gmail.com>
Subject: Re: Programmatically edit the git rebase sequence?
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Matthias Beyer <mail@beyermatthias.de>, 
	git@vger.kernel.org, neikos@neikos.email
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:46=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-07-03 at 12:02:33, Matthias Beyer wrote:
> > Is there a way I am not aware of to do that manual step programatically=
?
> > Something like
> >
> >     git rebase -i master --edit-commits=3D"$(git log master..mybranch -=
-diff-filter=3DM --format=3D"%H" -- "./subdir/*.rs")"
> >
> > would be convenient here, although I would understand if that is too
> > much clutter for the already very heavy git CLI interface :-)
>
> Yes, such a thing exists.  You want `GIT_SEQUENCE_EDITOR`, which is an
> `EDITOR`-like command that edits the rebase list in place.  So tools
> like `ed`, `ex`, `sed -i`, `perl -i`, or `ruby -i` would be useful here.
>
> So you might want something like this (untested):
>
>     GIT_SEQUENCE_EDITOR=3D"perl -pi -e 's/^pick ($(git log master..mybran=
ch --diff-filter=3DM --format=3D"%h" -- "./subdir/*.rs" | paste -d '\''|'\'=
' -s -))/edit \$1/'" \
>     git rebase -i master

Yep. Although, the last time I wrote a program that used
GIT_SEQUENCE_EDITOR, I had to deal with enough shell-nesting that it
was more convenient to make the editor program separate:

- git-split-topic [1] sets up a sequence editor with some interpolated
arguments that also re-invokes the original
- split-topic-editor [2] pre-processes the rebase script with ed

[1]: https://github.com/benknoble/Dotfiles/blob/ca48a09f783b78e038a41c5d60e=
e6b163337f580/links/bin/git-split-topic#L47-L53
[2]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/split-topi=
c-editor

See the comments in [1] for some weirdness in the invocation of the
sequence editor, where it gets "$@" appended to the command string
(meaning the last command in a chain might need to be written
specially).

And yes, I'm sure there's a few ways for things to go wrong with the
way some of the shell script variables are embedded into strings for
another shell to evaluate later; if I rewrote with Zsh, I could at
least use the ${(q)var} forms to perhaps handle that better=E2=80=A6

--=20
D. Ben Knoble
