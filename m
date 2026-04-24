Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EC30DEDC
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050771; cv=pass; b=utJHU/qXw1LtXVklwSCI3rXBSTBDevtZnYdrJQzkrMCbg+sHvqKllx50uTpT8k9w9JaGZjpPEslu7h12FQcpTSLh4BoeXHqejiitFRmc4Tr+RnRa2Xp+Tzu/JlPEmgH/Pdzf3za1ktn7Ds+FXVsmOEqcDMHMnKka96Ki9wBajS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050771; c=relaxed/simple;
	bh=My3vguTTSXXyTctjRji2R55Mhj9wwFu0zE+OItDzNdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJi9jel4tcNEwNyillliU/XqSiwxJTuMAZScCaEDW3QgFhI3EdYiHnAR1I4MO70hpZYK0dlzt9bzofZdWq1WaComB6krkvGymgqN0dmwSw5bN+1VFg+CkldYC2bn9ZmB8fIoLLNLYrHZdLF5KK5DBfBI4hss9GVyCd3Ij6Eg/Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZqUg2/W; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZqUg2/W"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8fba3f769so36913345ad.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 10:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777050769; cv=none;
        d=google.com; s=arc-20240605;
        b=aPYspZ9fAqYhGz/kfAQR8tfv99AzHH9ztK/4wd2D/xniZVOfk/kjDG6B9RmX8pv6sD
         jTZtIor/E4UTQ24wpACF1upNy/Z3QPcF2JVbiM0HwUSczLKbJqt3nYkPFqZNrZVbwcT6
         06zcVgsRoudHjlydozYErAiZoBD+pEOYwnv54bJGmg0AhDbWgdn/MEpbCt4fZC85MfON
         OnghxeAg6MGiO9ydEYJTkhb/9A+/3JN6iLw60JVTzCvjsxCj4kpQgwo0wV7c3Bm2WEwN
         cTqTyprOwPvMqlk1j7JUMrNBR3pOdBF3nc76zcPhNlNE8mx0O28xl2BkbNF37+DdFJdY
         Eh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8BMBugdY5f0NQ6yFqySFWox/czzyNxzxPX2e13Xjmgw=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=CvJC+7h8DFI6IUV1myeV6MvudCni1yhwKeWvnjxoV8H3yqmWm1m3BtS8kBAwjSimrX
         jjH1cSRsTpng+OuloKPC95QAkKMkCkRzxcNkCxiPiw4H8hIy4Qm1A7BJpUXYwjbYjDcU
         /f4BGz/aYN14SRx3df3QppyQX8D22USnxfJ02uIQMTdnIdPiAmCAQhKZbHULtLrfLan1
         y7ea9NCxYQQ0G3mD2qsUW+3K3tJJ5nIuzp3HZXYK/b8pku1VHnCsGWxRtTGvLFrQDC7S
         r0OyWkXTe4kG8gJnZynY81R+3qfLW7yhZvqZTN8epZh6YHF3xz4n9vCv8qfXjPiwxn1n
         IHSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050769; x=1777655569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BMBugdY5f0NQ6yFqySFWox/czzyNxzxPX2e13Xjmgw=;
        b=KZqUg2/WsKAJY0theBDu8vyU3piqQJk4+hQ085UpIRP3j95NDZy7YWcfrB03ie8OBC
         OmTIM/hQxGDOCHHV/RF/UM9BcS2QwRvFVuBdFLB9VxwXfM6PHcg9As6InqT2niwlxwFQ
         1+hsjQFN1v9osORLbN86zt22DZVutvCxWb+VBzHgKxVJ66jJJc/rQIyWwue+uj6aumO8
         C4BLKKmljZOnswYyE1XCzXfF17rkr1gqAXWNyI7iAewfe2uoEZ4kDYjLJ8LWd8yXBsgU
         s8rj3vB65EkTKFOrVogJSFpbWCcGQSyhGUilVgKJXJzEzYNbRXPNLWYcGVHZKws5HPpw
         0PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050769; x=1777655569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BMBugdY5f0NQ6yFqySFWox/czzyNxzxPX2e13Xjmgw=;
        b=nuft5Y+Vp/sxv9vPTlW4bPBAt8RhLtEA31bHQlct+9O/cysKX7EUl2R8T7bdzDRlUf
         vg5fsV8AA4SyYUyaf7+GTX0vNQtSkj4+7nkNI/0lVEd+WrxtX5zn7sEnqfCuO+mLfbHJ
         VGKhWu2la9dQzqxb3ZGm5S5uAV2htpNNBSVUF+flJ5TlnphV8WUkpyi3nBOLjyCPB4L5
         ZgMg/w0GVYUpUn/xJUuLCVKEsOs+ce2TnlEyC9fBZ/YWsmjMH5KcIXpTOBHcUsth77EX
         Zrhl1rnykIKaU/LUMBUlOrL8U+fwdEkc9hZm7Tbw4+ftMvotWSx6jIsmKOrfi2/M4mJm
         bC1g==
X-Gm-Message-State: AOJu0YzQMiUTq/ErrJlSDNYxrOSOOo+g2lVBtaqvztjkr3lcqPVBUvY6
	ldqFo63TaYSOcGNFRH5lHie0VbjnQRo73zG7B8iRh2Yc3Qd65Mwrty/4AmnNc0NGe1XsOhFIpdA
	W0uIlup6kFkrFyUkNfzIC3iCWeaIziQdxKBZm
X-Gm-Gg: AeBDietbJBIdLNPN+BKv7T90j+ZGugvNnmHhi5dvwFGL1NleWqVxsICwKZ1e9jwyjQb
	KYBFG21eY3+O2cTM1PjemG/D5dTk0FB5QngeVF+mA4SDao4RprDiBqWmzJJTEZqVwD8fOwRzUwj
	8MMhU2mPiVqtKhKiIkXVYszVpRpXhpk+KtAu9ovdWFOWfFOV9t9U3OgWEm7HNCE0JIKNn4SbHe3
	krTEh5ju25ISNRXzwq85DN3Eu4J9WxtAucASQsYGrJrX91FziYO+3CapBn95exTYg6rkmO0NVfY
	WZIye73pd7t41JINOXZ3rN8CW8L1tSoPjJdngQoutPmtgU0li+HMPTyA5R05ba4WmywV2ZQNpHz
	ce1nM3bMDsyITnbg=
X-Received: by 2002:a17:902:bf41:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2b5f9f5c1c5mr247237765ad.25.1777050769376; Fri, 24 Apr 2026
 10:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 24 Apr 2026 13:12:36 -0400
X-Gm-Features: AQROBzCAWrfJqEK-xM7JysXZ35Qf8X3C3XRLcy7E6UQpPrMxFABBoUAFU-whi5I
Message-ID: <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:08=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a --fetch option to git checkout and git switch, plus a
> checkout.autoFetch config to enable it by default. When set and the
> start-point argument names a configured remote (either bare, like
> "origin", or prefixed, like "origin/foo"), fetch that remote before
> resolving the ref. Aborts the checkout if the fetch fails.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     checkout: add --fetch to fetch remote before resolving start-point
>
>     A workflow I run several times a day looks like:
>
>     git fetch origin
>     git checkout -b new_branch origin/some-branch
>
>
>     The first command exists purely to make the second one see an up-to-d=
ate
>     view of the remote. If I forget it, origin/some-branch points at a st=
ale
>     commit, and I end up creating a local branch from the wrong starting
>     point.

When you realize this, "git pull --rebase" should help correct it.

>
>     This series teaches git checkout (and git switch) a new --fetch flag
>     that folds the two steps into one:
>
>     git checkout --fetch -b new_branch origin/some-branch
>
>
>     When the start-point argument names a configured remote =E2=80=94 eit=
her bare
>     (origin, which resolves to the remote's default branch) or in / form =
=E2=80=94
>     git fetch is run before the start-point is resolved. If the fetch fai=
ls,
>     the checkout aborts and no local branch is created.
>
>     A new checkout.autoFetch config option enables the same behavior by
>     default, for users who always want it.

I could certainly see this being convenient. (I don't have any comment
on the code at this time.)
