Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EC2F2C
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889142; cv=none; b=s4pVWzEPHJMwWMCr7Kfd/TT69Yss3WYZm1rBfQEImgFRFxuDHmFErqA+UfshmZa3v7Fsr6RpiHEmLmVpcr7NwBJSSI2zU8C1U72x40LTcd+TZda/oGGH/axlV0VwKIRUqht+Gd0nnaAwAWPsMYVBcw0jmiQjGh/lvqjJ2THnsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889142; c=relaxed/simple;
	bh=5fSrl/EOEdS2stZFft9qrnmSb7aN/pNP5U0Gh1bDv/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KagNIESV2FplEGnP1gg6ims6LgQIgH0U08f6B6kklJcJKWCdICtI4zD/LWGWUlx5P5m2FGimj0MS303LmfI4Ry1pS52KvypdHIzVXU1r7Wi1cm4iwZ/uYxXt4plq4XHOj5KRjz2T2Wfu28AJGdHFJIv1G4QHTbpdDPqpgbyGWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwOfKGLL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwOfKGLL"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4679920a12.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710889140; x=1711493940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRSCLwy8n3ut1WrS2pnjIhgYYIO+7B/hzRXC0bi3crU=;
        b=AwOfKGLLZd7dzq/VnNswSZSdTDy6oOgcivIrSksNBC/7qhQEQkcij+64rSuHNPnDEp
         sD+6U2tcDHbX8me7rAsdQnXpqdgUAs6ncHU24y9q+tNLfMBkzthhM64KaSfHIOPRbiZt
         VT3Lp9yiyJGc5YTRDdy8M1Was2BfUODCO/gcpfDN1sN/3FKXEmMwKQqVoVQq0r9xbzDb
         jIrGj4tkJp1/A/rlbLBePVBiJbDO6GvITK0i9Faw0kgpY2zJYk/GIi3kTxCgQErgJFII
         k3MGFVNoVxrvjE6jPuqTRnFfTks7dA0At7eF268vaBZcvzzo0zXPKKqrUGh4vBQ3T/lo
         OUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889140; x=1711493940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRSCLwy8n3ut1WrS2pnjIhgYYIO+7B/hzRXC0bi3crU=;
        b=U6LdwaxtThjy66/33jgoBBHW0d53vztyl4nyzdly+DDVjCS2gQ7rtdLoIUopDJrWVq
         itBr4rNUyEifJfBYmdryc6rK8SO82BPE9BztHhDha67M3ffGVGqmB+oLD4CtnvmldoD+
         HdVKsA+ZDh0cQ2eN+ONRUJZqJmPlEUItGHJkLQ/OY6i0ILpMlTCOglAu3rT4C86gXHoa
         KBM5Z3PpdLfkNfOc3aF4t8OfeWCjrZZYw/VklwEZcuWElFRtAdIxDwrClz7M1UzyjTla
         rPY1wNAvMbDAlBENfbrML+ba6pjchDLqZQqdhrw5160AcnAFOlkEwhoJPzKvXSyRVu9E
         1Lug==
X-Gm-Message-State: AOJu0YxktTGIfbGmkopYXdSLfKLgIet9AXxYZ78NPnx5VMEosaLWe84/
	8Qpd5vaNo9W2cXex82tBt9uDF6E3IFQT2KmOVnmhuFVAp2baRRFh+xS7PYwdiXgzKgSifd0M342
	tdZQxviVGVWNen61jK/e4KPRa/Q3ARr7S
X-Google-Smtp-Source: AGHT+IF/Vm0Dj5z7iMlnNFBaPRKysU9xzgYsodeBwUjgwRORPwgxv72fBDf1rCWSQp5rfi/5F+ANSzbjy9fQBDuAX8g=
X-Received: by 2002:a05:6a20:af88:b0:1a3:6864:9b92 with SMTP id
 ds8-20020a056a20af8800b001a368649b92mr3810992pzb.33.1710889139838; Tue, 19
 Mar 2024 15:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319203244.799796-1-mb@x14.nl>
In-Reply-To: <20240319203244.799796-1-mb@x14.nl>
From: Justin Donnelly <justinrdonnelly@gmail.com>
Date: Tue, 19 Mar 2024 18:58:23 -0400
Message-ID: <CAGTqyRykxy2GJV6b4yavWnegbz0HwykaT7bExOXK4wENdoF+Qg@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: GIT_PS1_SHOWCONFLICTSTATE variable fix
To: "Michiel W. Beijen" <mb@x14.nl>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michiel,
This is my code, so I'm really glad somebody else finds it useful!


On Tue, Mar 19, 2024 at 4:33=E2=80=AFPM Michiel W. Beijen <mb@x14.nl> wrote=
:
>
> There are a few environment variables that can influence the output for
> the __git_ps1 macro in git-prompt.sh. All settings that are 'on/off'
> types such as GIT_PS1_SHOWUNTRACKEDFILES and GIT_PS1_SHOWDIRTYSTATE
> just take any value, and in the tests are tested with 'y', however
> GIT_PS1_SHOWCONFLICTSTATE must be set to 'yes' otherwise it will not
> work.

I had actually considered using set/unset (for the same reason as you
- consistency), but was advised to use a boolean flag.

See: https://marc.info/?l=3Dgit&m=3D165897458021238&w=3D2 and
https://marc.info/?l=3Dgit&m=3D165903017715652&w=3D2


>
> This commit changes that behaviour, and makes sure
> GIT_PS1_SHOWCONFLICTSTATE is consistent with these other parameters.
>
> Signed-off-by: Michiel W. Beijen <mb@x14.nl>
> ---
>  contrib/completion/git-prompt.sh | 6 +++---
>  t/t9903-bash-prompt.sh           | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-pr=
ompt.sh
> index 71f179cba3..fd6141e463 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -85,8 +85,8 @@
>  # by setting GIT_PS1_OMITSPARSESTATE.
>  #
>  # If you would like to see a notification on the prompt when there are
> -# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
> -# prompt will include "|CONFLICT".
> +# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to a nonempty
> +# value. The prompt will include "|CONFLICT".
>  #
>  # If you would like to see more information about the identity of
>  # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
> @@ -528,7 +528,7 @@ __git_ps1 ()
>         fi
>
>         local conflict=3D"" # state indicator for unresolved conflicts
> -       if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
> +       if [ -n "${GIT_PS1_SHOWCONFLICTSTATE-}" ] &&
>            [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
>                 conflict=3D"|CONFLICT"
>         fi
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index d667dda654..6479a0d898 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -769,7 +769,7 @@ test_expect_success 'prompt - conflict indicator' '
>         test_when_finished "git reset --hard HEAD~" &&
>         test_must_fail git stash apply &&
>         (
> -               GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +               GIT_PS1_SHOWCONFLICTSTATE=3Dy &&
>                 __git_ps1 >"$actual"
>         ) &&
>         test_cmp expected "$actual"
>
> base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
> --
> 2.43.0
>
