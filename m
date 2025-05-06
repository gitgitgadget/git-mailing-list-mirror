Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEE284673
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547696; cv=none; b=osSG5vfI4lz7152ltbubBqaRgnd0G+7QkOu5edy+/OtXlHOiBNtMnLBmACKyU47V1Tqk/mTRNbxoYUWjbt6hSMuviEtgFQPRttlu0ZhQuIixxi++24zu5E/ABbd7l4EQ8tVY0vSQcJ61uYTczHbLTPyz5r2s7ptdzy8dEUWiKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547696; c=relaxed/simple;
	bh=bIB46T4FS2j5b5sIGzTRG+8+1L3JgNOcH0G+25pUJ8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxKb6WFhbgTDtpWPE+73vyEi4h/yMumDaRt5KQX7prXNlXjybd8ErhS4N86Rbvc3+/z4rZ2Sa8Qe91Jgu5NamMpZQS8WWKd1jh//4+BKeGIOoxPyVe2Lt40/9XpWKHFtSLvaydCL6pFX+UB/Az/YdiVbKhf1vIdDxSFec/5/NAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f53e612fa1so780876d6.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547692; x=1747152492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sI+qCwI4RA+acYUJyQiR9U9OV58aF30qy0f88ZY3180=;
        b=G2vDU2B9Z97z2DezSpgsP+QjkfePM4XZnsqo6zsGiYue4u9dveUYXwS4ATKY26uFrk
         1qMPe0mEHiPxFXMBi5anm6HLhUJpu1sM1Klmr7ktyuWaLoXDpjDW4xSirYEngNuAjb7Z
         n9E50RJBO/8XGTT9rHilSY+mgzBC2D/ZBmOQv/Xh4AaRrutzHjvA6TKLu6l9//dXtkf1
         mBxk2aKrzIMVPl6/sML9VDgnzO5AjS/OynSQHtCCnLt2MbV2XRt+Evo0GyZMXy8JSXcG
         ++4rlqfBFlsKNIcE+ie7wH4EuJ3Ip8jWeptEZOjEu88yKPu3BGRrPsbg2gtZBCMtIHqC
         n+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXHYqQNvNRGaB4/tNR5q7QGoZW9UxrTOIdUYxeZjfsd2RxTnNYCjKjq3emiByPlxTbD1A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiN5Ot/Lg/sZfg5jy4Fq+t7d1TbVupGaRKSLQjW/I+mpEX3hux
	AkzLKNLuckh2PojlV/n2ri5iOn8VDyTwiOyPnK20vXtp/qjdiL30nF4nNRV/G2U6lj4dJvHLddj
	HpmLAFXul6te9womxheyYoH6sRFw6y6n2
X-Gm-Gg: ASbGnctfQbSmq6m+6scU6u9MSxyVQCtGwdAdkbg3xISsKeNqJ3MjtYKuIJun3ceQCb7
	b2yl7ckOkWpRYcX+kTe69Ie75U0Xgq40DlIgOdAhOHUz4vHEfdRgYsS8a75biJVpmkXMkSJJXf7
	IgdtQmNJVAufO2QED+d6PE
X-Google-Smtp-Source: AGHT+IGnlTsqxDa+VfC+n8ZDLPC3KYWPbeuhJp7ya+DJUX1W59zsrreuUvsSt2/iA9kbHaOnUw7PWRDYrFvwkfIgc2g=
X-Received: by 2002:a05:6214:2129:b0:6d8:e6be:50fc with SMTP id
 6a1803df08f44-6f5155e9fb7mr98139266d6.6.1746547692303; Tue, 06 May 2025
 09:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
 <20250505-pks-maintenance-missing-tasks-v4-4-141f4df906a1@pks.im> <CAP8UFD24jwKjP6XdD_SSv7ukgyqewCThMd-wQSRsDk00X7btiQ@mail.gmail.com>
In-Reply-To: <CAP8UFD24jwKjP6XdD_SSv7ukgyqewCThMd-wQSRsDk00X7btiQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 May 2025 12:08:00 -0400
X-Gm-Features: ATxdqUGsnL5zQmBQn676DOve84DHUGPObuZBjWaY7iE6-Z8ZITxzrMhfkDk2NRQ
Message-ID: <CAPig+cSCFZArGbAXe77H3__nUAt1BTwDRsM6V2emqaMvHdxVgg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] worktree: expose function to retrieve worktree names
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:23=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > +int get_worktree_names(struct repository *repo, struct strvec *out)
> > +{
> > +       worktrees_dir =3D repo_git_path(repo, "worktrees");
> > +       dir =3D opendir(worktrees_dir);
> > +       if (!dir) {
> > +               if (errno =3D=3D ENOENT) {
> > +                       ret =3D 0;
> > +                       goto out;
> > +               }
> > +
> > +               ret =3D -1;
> > +               goto out;
> > +       }
> > +
> > +       while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
> > +               strvec_push(out, d->d_name);
> > +
> > +       ret =3D 0;
> > +out:
> > +       if (dir)
> > +               closedir(dir);
> > +       free(worktrees_dir);
> > +       return ret;
> > +}
>
> Nit: this function seems to use "goto out" a bit too much for me. What
> about something like:
>
> int get_worktree_names(struct repository *repo, struct strvec *out)
> {
>     int ret =3D 0;
>     char *worktrees_dir =3D repo_git_path(repo, "worktrees");
>     DIR *dir =3D opendir(worktrees_dir);
>
>     if (dir) {
>         struct dirent *d;
>         while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL)
>             strvec_push(out, d->d_name);
>         closedir(dir);
>     } else {
>         if (errno !=3D ENOENT)
>             ret =3D -1;
>     }
>
>     free(worktrees_dir);
>     return ret;
> }

I had the same response and made a slightly more concise proposal[*],
though I'm not convinced that this function should exist at all.

[*]: https://lore.kernel.org/git/CAPig+cSDDbhGrym8j=3DPFKBCUxBQhZPzAHXGvKy-=
Z6POA4Ju3sw@mail.gmail.com/
