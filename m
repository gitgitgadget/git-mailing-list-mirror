Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF112253E4
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123204; cv=none; b=JtFEKhHD/rWEqe6yHTpvkcl2ItKciW5yEUSzGTO5lnDPdq1pEAjlH43EgNAmIGjKusFtmd8CYUAH30sZBDu2Xcdz8TVcESU0JKQKRX/lo6VhF+ic45UzK3EErZbYEBd8ZQbA0hYIUsWJMh0/b03sKi7JHUneK7+WLjgQzu1P2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123204; c=relaxed/simple;
	bh=BiXDR2gbnBlCC2BnVOPpeI8sn0GPwoeM15An7SAY9Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ+xJGKzDOBIA64Sa4nR2VnzM0lkFH9j1vMzIa0BCCt6ol3pdOz8fqaj4W4ftXGB2UQUVCU5KHhDODSWo3itbOMZnN67ULKC16bKLb1Z9UrZwH7GTAy51GjSvdQGDnnY9+tIAVDNQr5eAadehWbN3beIXDN3E+m5iMJsfI67xnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C04VK7Jp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C04VK7Jp"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so1081219666b.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758123201; x=1758728001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RmjkkEoXb0ZfiE9Twrb0qVGWcJgI6k7WdQj6w9r+Vg=;
        b=C04VK7Jp+ndwJUklWRduT5RxFHSmzO15yIhxhEEj1ehnS2QIWCNRPK2A/WhV3XhHDN
         /DAV5Hj2T/xfoj8T4/uubaJljP9T00jTKRiO2fyG2Yy3/sTKN1MeRp6BWG+UYK9xlbzF
         Gxp3gcsFZA8WxeQ21Ak4noo6tejdn5Bs2Sa1dqJwQU0e34d3RVitNvItpWuWj2cJZKFj
         AXp59Sxnbq+ujpzS2VaHgQ3VyjX9d7qZBww7gTIRaw56y4bMfIqXTd62ypVed1TLtmcC
         +VaVVxLXPf8O2qAKWbBb+vsvnZZYb3C/ePC0dUb+V+xNzL9K/mGu7285Vbctnw1v5Juo
         v8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123201; x=1758728001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RmjkkEoXb0ZfiE9Twrb0qVGWcJgI6k7WdQj6w9r+Vg=;
        b=YikpFfALT9SGPN7Vpn71KPTfBqv/WxR84watUNEWo4zNKyNuKxQgKLR5tnH3bMDZBu
         3CNtB1y85YR5LKpmlumZacfjguDh37sukxFpZ3PKlratYdus1NNejPCs6bI63R7IKKgx
         v++7Cn6tiChkR5vyMAxzsWRldLZHOibMyCA3OKI9BntM8NZ7OmKsJnHPu9T3m1E/hafa
         Vi5pMFKdWZuR/v+VxuYKaFH8TnOk39RNSs8bOAc66clVsYqxTQtcNsRr4QIZAH8wMW+M
         v8BUIh1O8ikh86u8+yiaptVmzSuF+Kw/VfBZbdQ5SdIc2mFrhpnbj0yyQSk5YCVNzUF0
         wXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL8y4ddK29cxNWVcnk7AEPdI84gJKjzDiXIYbuV+NlbmHMN0WhYOkt5F7nHdUWNxuKsfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUAt7EGd9eodEckg7FaEbXAnvHtyUcZmyL83vJ9cpo+BMqqL4
	rsf+/zW5N8VKexyRZU17lA0Y/Bkh9JJKUGpQewdPgZAuCkEmZCohDdRPubaOs19PCtg6s9PMzcj
	7hvGsxNWHdeNpG2quXmH3W+Udny8ZeFS0CgKZAfY=
X-Gm-Gg: ASbGncsj4eJYCKN03Q+G8MlOpJ7hoWfbs+Lx63HyzUwLB44Y9Xmp9HPtxY/kn2A+35A
	vetGp6+9JHO1mZeTOu/f+Se1H8PRn1IbKUS3FPlEILDLY8j9GVaTkwUZ5DnCZI8u0O9Zpao5Aqy
	qVRi5vOsbWg8QU57UhVCVTP9PbN3SDiB7dcJkISMl74yo/iUOPTFHOwh2jK9W/i0AvF1vb0yJ7T
	Ed3MhsoVrN8DZpaNark/8cYHF76nL4Y8iwdVC9ApA==
X-Google-Smtp-Source: AGHT+IHRFM2NZSmgmftfUM+xSLJtixzaPS9Bw0Ut73PZdbLwGNzqTdt1HKj/yRFm+tuAhNgW7zBm1D4xaw+j4ordEKs=
X-Received: by 2002:a17:907:3c87:b0:b04:7705:70d6 with SMTP id
 a640c23a62f3a-b1bbfa2c996mr279468166b.36.1758123200645; Wed, 17 Sep 2025
 08:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
 <CALnO6CCz6dFX1Est0hhCbvaepBvG4+rpYQRQ2bP5vAQVmaY=OA@mail.gmail.com> <xmqqqzw5i8fv.fsf@gitster.g>
In-Reply-To: <xmqqqzw5i8fv.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 17 Sep 2025 11:33:08 -0400
X-Gm-Features: AS18NWBWFJKIFqeDe_puZEXspBkOHUQRCMa1q-5GUSiJ1y9Sl49Vq6Oa5_8dnBA
Message-ID: <CALnO6CAZHy58X_6T5KR9zUa0TrJvbM8BLZj+is8pB9=fogvr3Q@mail.gmail.com>
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > ... " the following
> > does work in a non-unborn repo to move "newfile" from "untracked" to
> > "staged" and back again:
> >
> >     echo >newfile && git add newfile
> >     git restore --staged newfile
> >
> > So we don't need "rm --cached" to
> >
> >> remove <file>
> >> from there [the index] without losing or clobbering the <file> in the =
working
> >> tree
>
> Now I think about it more, I wonder if "restore --staged" is
> misleading and confusing to new users?
>
> When you teach "git restore" what would you tell them?
>
> NAME
>        git-restore - Restore working tree files
>
> is how "git restore --help" starts.  It is primarily a tool to let
> you repair messed up files in your working tree by copying out of a
> known good version from somewhere, be it from the index or from an
> existing commit.
>
> But the instruction used to recover from unwanted "git add" to
> update the index with modified contents does NOT want to destroy
> your files in the working tree.  You want to repair only the index
> without touching your working tree files, because you added modified
> contents that were not ready to be "staged".  Hence "git restore" is
> used with "--staged" option to tell it to do what it was *not*
> primarily designed to do, i.e. only touch the index without doing
> its usual "Restore working tree files" job.
>
> But there is a lot more appropriate command whose primary focus is
> about the index.  "git reset <file>" would grab the contents for the
> <file> in HEAD and replace the index entry for <file> with it, which
> is exactly how you would move the "Changes to be committed" files to
> "Changes not staged for commit" status.
>
> So I think use of "git restore --staged" in the instruction is
> wrong, and it should be replaced with "git reset" instead.

As we have in git(1)

   Reset, restore and revert
       There are three commands with similar names: git reset, git restore =
and
       git revert.

       =E2=80=A2   git-revert(1) is about making a new commit that reverts =
the changes
           made by other commits.

       =E2=80=A2   git-restore(1) is about restoring files in the working t=
ree from
           either the index or another commit. This command does not update=
 your
           branch. The command can also be used to restore files in the ind=
ex
           from another commit.

       =E2=80=A2   git-reset(1) is about updating your branch, moving the t=
ip in order
           to add or remove commits from the branch. This operation changes=
 the
           commit history.

           git reset can also be used to restore the index, overlapping wit=
h git
           restore.

that already mentions the overlap, I'm inclined to keep "restore
--staged" as a simpler "I'm _restoring_ this file in the index to a
different version." (But my personal "unstage" alias has been "reset
HEAD --" for a long time=E2=80=A6) The Examples in git-restore(1) also ment=
ion
the reset connection.

> > (But the point about having nowhere to restore from stands!)
>
> Yes, and the point about having nowhere to reset from stands for the
> state on an unborn branch.  That one needs "rm --cached".

Perhaps more germane to Anselm=E2=80=94I'm still confused that "restore
--staged" can't cope with unborn branches. Sure, there's no "place to
restore from." But the user experience of having 2 different commands
depending on this one state is a bit messy, I think. Wouldn't it be
nice if one command did the right thing (kicking a newly-added file
out of the staging area back to being untracked) in all situations?

IOW, I think "rm --cached" works whether unborn or not=E2=80=94so shouldn't
"restore --staged", too? As I think I saw in a separate reply, plenty
of commands treat the unborn branch as having an empty tree as the
parent. It seems that if "restore --staged" did so, we could unify the
help here and simplify things for the user.

--=20
D. Ben Knoble
