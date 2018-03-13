Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DAE1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeCMOcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 10:32:09 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32801 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeCMOcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 10:32:08 -0400
Received: by mail-lf0-f49.google.com with SMTP id x205-v6so10852878lfa.0
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=91IyS22SNEJhoAHJ2Oyx97hWqEY/JpqeGhclDHXvqgc=;
        b=FnEbDTWey1xRZ/5/Ffg7puix3L66jtcSFGX7ZovGAw+TfPsWJF1s9ur5tGIrKHYCWI
         ar3/9RTu01hBtU44I/Jzgkva6juNWpwV6UfcrUt/Wng09SM+cvJFKS0U/Rk+z/Z75YK0
         i295BufDbSs6ZbbWlGmQLEa63iL15+DFufC1139ulZTEhX7ZsYzPWWwS6IgQPW4rVtaP
         kb9wxyzXTh2YOwpjlWkrgqTI3d2/5CCM7vFd3BQLnphnL/79/9iZ7HmjAFXltnqAWsqV
         6WHo8maa8rGa5PMmzeqBZU3DIaK6VqYd80Rza5yhdy6ppIwgS0Cc0ZI137UlD++GILcl
         fbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=91IyS22SNEJhoAHJ2Oyx97hWqEY/JpqeGhclDHXvqgc=;
        b=uNyFvKUSvusz81JPnn/Vxi0ot+UQDLL2NrT9Vp92J8pLpWaa4DRN4PPRW6jL6i+vFe
         IoejrCtC9p81caxZyOEMpy0OXY8UDA0o5brgS6wRI7Acyv0CoSAa8az5JbxAGlE/8rvP
         OB7X07URkGL/QhkLpcKo7AFDk6UAC0+UufgZlBF6YQjssOGfI13l1wSD/XBDKRCbBtc/
         JX3XOvRSDiPdaibSFSVcPdPea2rH9Cv7gtYyx1VjYkNOm9I5QwS/UgfA+/EzT3aLsowI
         WKPQrDKVd4wyQ34SUo9II7C976edjJq/X2MSYMyOYKD1wWHW+zmyYBZe363i0IKyE4Mw
         dQiw==
X-Gm-Message-State: AElRT7Gk2ZI/1ksBnFR05o1LtLHP+avNXC9U0wicG3ZTBoMmuVgFx4rR
        YxQOeVpy+j1gBMAjrD7mk8aiZwMZWqJ0tGatQSXk1Q==
X-Google-Smtp-Source: AG47ELt/do3cs/7xwbqMAPllC4vRh7SLuWutLvcgRnLndiVoGVfrpvu8XApjCnGYWEjMS0qiJXiNDmqIJ6aDgn+d+YM=
X-Received: by 10.46.117.12 with SMTP id q12mr663218ljc.65.1520951526925; Tue,
 13 Mar 2018 07:32:06 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Tue, 13 Mar 2018 07:32:06 -0700 (PDT)
In-Reply-To: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
References: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 13 Mar 2018 09:32:06 -0500
X-Google-Sender-Auth: IE0PoOw3_V7mHy8L0N2REypE3_Q
Message-ID: <CAHd499CKneW5FoeOCgfv4uzvuOVsV-c5FKH_MgDDEgSsJJ7PTg@mail.gmail.com>
Subject: Re: Rename of file is causing changes to be lost
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 10:01 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I'm on Windows and core.ignorecase is set to 'true' when I clone/init
> a repository. I've got a branch where I started making changes to a
> file AND renamed it only to change its case. The changes I've made
> were significant enough that git no longer detects a rename, instead
> the files show up as "D" and "A" in git status (deleted then added).
> To correct this, I do an interactive rebase to add an additional
> commit before the first one to rename the file without changing it,
> and *then* allow the second commit to change the file. The goal is
> that rebase should detect the rename and automatically move the
> changes in the (now) second commit to the newly named file. Here's a
> MCVE (treat this as a script):
>
> #/bin/bash
> git init testgitrepo
> cd testgitrepo/
> git config core.ignorecase true # This is set by Windows for me, but
> hopefully will allow this to repro on linux. Didn't test linux though.
> echo "first change" > foo.txt
> git add . && git commit -m 'first change'
> git checkout -b topic
> echo "second change" > foo.txt
> git mv foo.txt FOO.txt
> git add . && git commit -m 'second change'
> git rebase -i master # Move line 1 to line 2, and put "x false" in line 1
> git mv foo.txt FOO.txt && git commit -m 'rename foo'
> git rebase --continue
> git mergetool
>
> After the rebase continue, you will get a conflict like so:
>
> error: could not apply 527d208... second change
>
> When you have resolved this problem, run "git rebase --continue".
> If you prefer to skip this patch, run "git rebase --skip" instead.
> To check out the original branch and stop rebasing, run "git rebase --abort".
>
> Could not apply 527d208... second change
> CONFLICT (rename/delete): foo.txt deleted in 527d208... second change
> and renamed to FOO.txt in HEAD. Version HEAD of FOO.txt left in tree.
>
> The last command, `git mergetool` runs, giving you the option to pick
> the Created (left) or Deleted (right) version of the file:
>
> Left: The file is created, but selecting this erases the changes from
> the "added" version on the remote (which is topic). Basically the
> rename of only case confused git, and we lost the changes on the
> remote version of the file
> Right: File is deleted. Changes are still lost.
>
> The ideal outcome is that the changes from the "added" version of the
> file in the 2nd commit get carried over to the "renamed" version of
> the file, which when you compare the two are named exactly the same
> after the 1st commit is introduced. How can I solve this issue?

I wanted to bump this and see if anyone would have a spare few minutes
to help me out with this. I know it's a needlessly complex situation,
but I'd really love to know how to resolve the specific issue, or
perhaps learn a better way to approach this in the future if I'm
shooting myself in the foot here.

Thanks again.
