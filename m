Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA76105
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwNfmD5v"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e81761e43so1206561e87.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 22:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703660062; x=1704264862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNH7Bgn2R2yATj8snf84ZgzoEbcG6MyhywV8W8xOR08=;
        b=ZwNfmD5vcxV9fjGKC87jfvKzjYwY+lxO4IBoi1zuSrEZfXuZ30llK30u2qaAxgUObJ
         oQl2HibKmKoPsLsl73OUd4TAcQEabQ543HSkz63uafYTHFwORb9SKaRqA6uslQiOqgbT
         v1+HhvTIPoZyryYvxwdVcZl3nTpB2kpbPkgnDGQqssy+Kvkl+iUTte3j4yzOhA0mjjrE
         u4XHgzvxJ0TmB4uQZzyKSa81+yrg0XC1l9kTsfmXq0QYsXGIaanQjq482jix8U2E+kIc
         TZiSfsGxyJEqX8jZgzD+VuqNkigqM+F2cFnqK/SxyTmVdFaBXas3fWJSzLTGnrsiGWqF
         g3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703660062; x=1704264862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNH7Bgn2R2yATj8snf84ZgzoEbcG6MyhywV8W8xOR08=;
        b=AW1Gau472khlRIDhPYG/Bozp/Xxd8ty8y8eJkLu06H4gNqz2bP+M4ZtZSrDddOGQEB
         kzeUmDq/GcvqhAPpL8F3xyhzJzrYHuy+20pmgIW5yc71xE0yWl+K2qTtyO9TuNeslwyR
         lXQztFtdp6p6t/esYFV8BjbR1Ssb/voJoBoeWqEmp0vu+qTt72E4RzWGOOwuOn0Wufbd
         LrwunFyzhf8JCC19qS/B1ivogTagNqDbbRZjSDM0vUtA9vg//e82dCWf+s3M6nNvR7iS
         wHlP11cGG6MP3BlL2BlAMBx30DAHhiAQvPbQJ1ckqJz1t4rU/3xoLaUhwvsdCmL3eNt7
         v2pg==
X-Gm-Message-State: AOJu0Yyqsu8NUJP11WLkxYlr3QUjIh3KM8S6eCQrFwWHqNCRM5DxEDVU
	NBpT9+khyOR4QmSMD6Z9IUEwnwZfpX7NMgABuL0=
X-Google-Smtp-Source: AGHT+IFZoB/gygt3zGDXWmaqrC5TXT9yus0A5G8UvbUORWpRvpdLkHlWCGQH1Z8LpuxS4VfugYrnOVc4qZHXWG0fp2Q=
X-Received: by 2002:ac2:548b:0:b0:50e:36bc:747a with SMTP id
 t11-20020ac2548b000000b0050e36bc747amr3193186lfk.128.1703660061487; Tue, 26
 Dec 2023 22:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com> <xmqq8r5gfc3j.fsf@gitster.g>
In-Reply-To: <xmqq8r5gfc3j.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Dec 2023 22:54:11 -0800
Message-ID: <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Sebastian Thiel <sebastian.thiel@icloud.com>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 9:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > We have traditionally considered all ignored files to be expendable, bu=
t
> > users occasionally want ignored files that are not considered
> > expendable.  Add a design document covering how to split ignored files
> > into two types: 'trashable' (what all ignored files are currently
> > considered) and 'precious' (the new type of ignored file).
>
> The proposed syntax is a bit different from what I personally prefer
> (which is Phillip's [P14] or something like it), but I consider that
> the more valuable parts of this document is about how various
> commands ought to interact with precious paths, which shouldn't
> change regardless of the syntax.

I agree that syntax and command behavior are mostly separate issues,
but unfortunately they are not orthogonal.  In particular, syntax of
precious file specification is directly tied to fallback behavior for
older Git clients, and it might potentially affect backward
compatibility of non-cone-mode sparse-checkout syntax as well.

I think fallback behavior is of particular importance.  There are
precisely two choices in our design for how older Git versions can
treat precious files:
  * ignored-and-expendable
  * untracked-and-precious
If we pick syntax that causes older Git versions to treat precious
files as ignored-and-expendable, we risk deleting important files.
Alternatively, if we pick syntax that causes older Git versions to
treat precious files as untracked-and-precious, they won't be ignored
by e.g. git-status, and are easier to accidentally add with git-add.

I felt the "precious" bit was much more important than the "ignored"
bit of "precious" files, so I thought untracked-and-precious was a
better fallback.  However, to get that, we have to rule out lots of
the syntax proposals, such as Phillip's [P14].

Anyway, I'm open to alternative syntax, but we need to measure it
against the relevant criteria, which I believe are:
  (A) ease for users to understand, remember, and use
  (B) size of backward compatibility break with .gitignore syntax
  (C) appropriateness of implied fallback behavior for older Git
clients with precious files
  (D) room for additional extension in .gitignore files
  (E) potential affects on backward compatibility of non-cone
sparse-checkout syntax
We probably also need to agree on the relative importance of these
criteria; personally, I would probably order them from most important
to least as C, B, E, A, D.

Phillip's P14 is better for D, and perhaps a little better for B, but
I thought slightly worse for A, and much worse for C.  (I think
there's no significant relative difference for E between his proposed
syntax and mine.)

> Thanks for putting this together.
