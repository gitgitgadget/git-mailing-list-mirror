Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57A64D
	for <git@vger.kernel.org>; Sat, 18 May 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996746; cv=none; b=PWjUy6hRRycyBgWnuDpj8FZA9TCLMcK9T9sTkk9eOGQWjxdo+lbs8oJpwZCtUet2t15f0QIYskWEEusrZ7hC/xTAyu/Couk8C+f2oTIAkCqOmSBnBTVIYC1A5fEj0u7IkiFd3Gj3SGwNhKW1ZYCesz311YCitiBVbPo6iZA9AwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996746; c=relaxed/simple;
	bh=P/wy+1ypMXUyP5hs1uZnY7jUTl8lIoY6GSIx4wBi+zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYUV0GRfMerK3aFmVTaFQ/+gTRI51PgMbmtfKety5ur9Nxr1L063uQUsga9fKnQqnCmqucPYiy1lKW4Od5ld/qOLAYh1oeC9dXXI52f3t2sIGdWBcVdDw195FCCWnC2uMieMHhJwQvoaJHyY25n8Xu140dm0Ay5Eth+x8rUGl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOBF6V1n; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOBF6V1n"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e2025c3651so53470939f.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715996744; x=1716601544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jakA7ox7TUh3cVhk+Zu6W5Ywz+CLOz2eTtCOBcJpaaA=;
        b=ZOBF6V1n0/RuXFBJYUd6bWvC+YgcG+vXbezzRODgOv63WbMDa5q+nA6jq3F2pCWDCH
         0+QvIRJ0IJw9ZbvNAbVr/pMlJGY+jNdxHkb9+IGTfT+I7wBofBkE/WfJePcuxlfGe0Sq
         AhaIUzvq9xD0lBi/ha1sD+/rEduLEB9wBosH/zBPz4zWDIRgoUKdClyeRHojZETFqOVP
         JBTKSQXvW9KOD3DGLo8MFGTZvu55v9wQER/QVImkU1IVMeOr4DuOcA620cUsM21wlJX8
         dlCoQoYS0z1L8q1cQPU2r4cU+qhBRzVUrA03EM+f7Jcc/5J8BbY7iTcgHUkNP6NhiBWh
         4RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715996744; x=1716601544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jakA7ox7TUh3cVhk+Zu6W5Ywz+CLOz2eTtCOBcJpaaA=;
        b=vj9zH80WpVlBavfx5URbSBuTwtjoHuM9KMbM/TXEufY7JW0WnYM3CK2wMv6MznqEx4
         KAfGThy+nhL43ksdvWLjxO4rKOiP0S9+w7Ku9tuT1DSS9mG6m1/obQUKaOBL2qjMHeAP
         RfyIzbm+OTp3Xin7elUHEVpjVBwvLpI6i2CcG6Q0Ta3zKIC7GC8OiQsSJHwhmhFTsFvB
         yLQpM7IgzjSecLPGyiYM9qAtrGyN1GCst1pkPXMB8ETgH8f8cJdAo8VSMWmpisFX16OM
         NbF4fuOtY5bhY3w4LcMM7XlYNpw+xol80khvp9MIvLXN3Hisk7kWOBvnDEdgPrYnHuIj
         41pA==
X-Gm-Message-State: AOJu0YyUL4THnc7Mu1emF1YT06VrrVhdSpX80rIZK2uNNXeriakNjqIb
	+hIOkxDiC6JESQiWU2QfUqQIcywvmTDkKafB0GDp0NN3ty0OGFkjxjHAPSiUEhBVNHWd20oWmG+
	hfLYL7lHO84ZiYuY88e7bjblTwvaQO7G7
X-Google-Smtp-Source: AGHT+IGIw33OD48a7mHCVkG586r1M9m7vr1OHaXhnnKzu9rdSxioRxnHOMmbdDLoOMqt9FwAMv1LYgIEenKwN7mMU7s=
X-Received: by 2002:a5d:990c:0:b0:7e1:8282:d8a9 with SMTP id
 ca18e2360f4ac-7e1b521b69bmr2765796039f.17.1715996744162; Fri, 17 May 2024
 18:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee35f3b2-bf20-6fcc-2c71-38499aa592fe@gmx.de>
In-Reply-To: <ee35f3b2-bf20-6fcc-2c71-38499aa592fe@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 May 2024 18:45:32 -0700
Message-ID: <CABPp-BHv7K3gQ4+ZgOTFHUyhNm7dVa4wtzy_gtNHKNcyFYqr_g@mail.gmail.com>
Subject: Re: Replaying merges
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes!

On Fri, May 17, 2024 at 5:35=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> I took the suggestion to heart that you explained a couple of times to me=
:
> To replay merge commits (including their merge conflict resolutions) by
> using the _remerged_ commit as merge base, the original merge commit as
> merge head, and the newly-created merge (with conflicts and all) as HEAD.
>
> I noodled on this idea a bit until I got it into a usable shape that I
> applied to great effect when working on the recent embargoed releases.
>
> Here it is, the script [*1*] that I used (basically replacing all the
> `merge -C` instances in the rebase script with `replay-merge.sh`):
>
<snip>
> For the most part, this worked beautifully.

Cool to see someone try it out.

> However. The devil lies in the detail.

Yup, but details rather than detail.  ;-)

<snip>
> The biggest complication being the scenario... when a merge
> conflict had been addressed in the original merge commit, but in the
> replayed merge there is no conflict. In such a scenario, this script _wil=
l
> create not one, but two merge conflicts, nested ones_!

Only if merge.conflictStyle=3D"diff3"; if merge.conflictStyle=3D"merge",
then there will be no nested conflict (since the nested conflict comes
from the fact that the base version had a conflict itself).

This is one of the issues I noted in my write up a couple years ago:
https://github.com/newren/git/blob/replay/replay-design-notes.txt#L315-L316

Further, it can get worse, since in the current code the inner
conflict from the base merge could be an already arbitrarily nested
merge conflict with N levels (due to recursive merging allowing
arbitrary nested of merge conflicts), giving us an overall nesting of
N+1 merge conflicts rather than just the 2 you assumed.  That's ugly
enough, but we also need to worry about ensuring the conflict markers
from different merges get different conflict marker lengths, which
presents an extra challenge since the outer merge here is not part of
the original recursive merge.

In addition to these challenges, there's some other ones:
  * What about when the remerged commit and the newly-created merge
have the "same" conflict.  Does it actually look the "same" to the
diff machinery so that it can resolve the conflict away to how the
original merge resolved?  (Answer: not with a naive merge of these
three commits; we need to do some extra tweaking.  I'm actually
suprised you said this basic idea worked given this particular
problem.)
  * What about conflicts with binary files?  Or non-textual conflicts
of other types like modify/delete or rename/rename?

> I still do think that your idea has merit, but I fear that it won't ever
> be as easy as performing multiple three-way merges in succession.

I totally agree we need to do more than the simple merge of those
three "commits"; I have ideas for this that address some of the
challenges over at
https://github.com/newren/git/blob/replay/replay-design-notes.txt#L264-L341

> To address the observed problem, the code will always have to be aware of
> unresolved conflicts in the provided merge base, so that it can handle
> them appropriately, and not treat them as plain text, so that no nested
> conflicts need to be created.

I agree we need to handle conflicts specially -- not only in the
provided merge base ('R' in my document) but also in the new merge of
the two parents (what you labelled HEAD and I labelled 'N').

> Unfortunately, I did not document properly in what precise circumstances
> those nested conflicts were generated (I was kind of busy trying to
> coordinate everything around the security bug-fix releases), but I hope t=
o
> find some time soon to do so, and to turn them into a set of test cases
> that we can play with.

Yeah, we'll also need to add testcases for some of the other issues I
point out in that document.

I'm looking forward to my situation changing soon and hopefully
getting more time to work on things like this...
