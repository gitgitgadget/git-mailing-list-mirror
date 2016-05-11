From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] worktree.c: add clear_worktree()
Date: Wed, 11 May 2016 02:36:37 -0400
Message-ID: <CAPig+cS-tb_hD3k2XsTioJrkzaB3FxSnrxM6JMq5-og1ADnoRg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141553.22967-1-pclouds@gmail.com>
	<20160510141553.22967-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 08:36:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0NlC-0006Wd-M6
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 08:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcEKGgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 02:36:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33183 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcEKGgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 02:36:38 -0400
Received: by mail-io0-f195.google.com with SMTP id x35so4526523ioi.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=A8PsMP3Rt3MQcKOsoPLEpPlBC0njoyED00BaTDoJeTo=;
        b=goM7Ym7acyEtWtsuarUIPs/i0tagaV4aD838feYZpKq7G8ZOeYgBi0Gx9yOG4KfkR6
         emNE8gW6PPi1dGC1hooB21AzHuDVFFIETE5git+pL8/fjfLDk2DrwOVmxFSSHHO+W2r9
         IbQcnvz5omyQh5sHFvivnqENR+Rakyfr/TGmGU6+5X5TbidFa1LpBczEyELVn7RlXcSG
         o1dWvRVxkjjLQ7Ho/UEGuWU0LN8fZG2t0WjtJPrLQoGaWp9CrLSWaBwqjtTTUu38sWGP
         1wHd56u4VM9+xCcsSSeqCR4n3BeC6hCf8ZNGLQNxpBxtd/zI8CzpRkJpeHETDplyoWHs
         iJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=A8PsMP3Rt3MQcKOsoPLEpPlBC0njoyED00BaTDoJeTo=;
        b=U55KFuzHnrkmVhERGukUV7Q1tJw/teS8it/1sjVyMiOMvID6mhXG0z7xKaMJruwoyz
         WFe8sVyRsUZgKjaLLqq7Fm9Suv1BvunMHsllLAV0/jV/7disPVrt9OgzG8XJF/sn4h7o
         55HzfbNZEdPWNoExq3JsNiJylcLgB4c2mtziYby0Cs4yX/c/X9FFwPWBr/Eqp7r9QOvS
         44kMqeCUAnNLqek+UNrdHWLAqPcuUARAmFNUsvXXAknMkF3pNDFIPZu12LT2r1cd6JaV
         GkBGytYSdrPGo7MzxQa3p5msndWovsPtiMI7l79uMQaDDBPTlA+2adO8dPQkB18i7eyB
         DAfg==
X-Gm-Message-State: AOPr4FXStBODTSPQH5THeurATsRRHy5rGctmMTgQKnUKlc81BrqD5VkvGOGBHfqvDC8kWrgMEGdcqpf7cdev+g==
X-Received: by 10.36.69.156 with SMTP id c28mr3239896itd.84.1462948597285;
 Tue, 10 May 2016 23:36:37 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 23:36:37 -0700 (PDT)
In-Reply-To: <20160510141553.22967-5-pclouds@gmail.com>
X-Google-Sender-Auth: bxGBY7-QPRFdTkArIIDz22R51mM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294230>

On Tue, May 10, 2016 at 10:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> The use case is keep some worktree and discard the rest of the worktr=
ee
> list.

So, you're saying that rather than a client freeing the entire
worktree list like this:

    free_worktrees(worktrees);

it might instead want to keep some element ('n') and free all others
plus the list itself, like this:

    struct worktree *keep =3D worktrees[n];
    struct worktree **p =3D worktrees;
    for (; *p; p++)
        if (*p !=3D keep)
            clear_worktree(*p);
    free(worktrees);

Is that correct?

If so, then doesn't this require the client to have far too intimate
knowledge of the internals of free_worktrees(). Or, was your idea that
the client would simply leak the 'worktrees' array after freeing the
unwanted elements?

In either case, a cleaner approach might be to provide a function for
copying a worktree element. Perhaps:

    struct worktree *copy_worktree(const struct worktree *);

or something?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> index f4a4f38..335c58f 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -5,14 +5,22 @@
>  #include "dir.h"
>  #include "wt-status.h"
>
> +void clear_worktree(struct worktree *wt)
> +{
> +       if (!wt)
> +               return;
> +       free(wt->path);
> +       free(wt->id);
> +       free(wt->head_ref);
> +       memset(wt, 0, sizeof(*wt));
> +}
> +
>  void free_worktrees(struct worktree **worktrees)
>  {
>         int i =3D 0;
>
>         for (i =3D 0; worktrees[i]; i++) {
> -               free(worktrees[i]->path);
> -               free(worktrees[i]->id);
> -               free(worktrees[i]->head_ref);
> +               clear_worktree(worktrees[i]);
>                 free(worktrees[i]);
>         }
>         free (worktrees);
> diff --git a/worktree.h b/worktree.h
> index 1394909..7430a4e 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -29,6 +29,11 @@ extern struct worktree **get_worktrees(void);
>   */
>  extern const char *get_worktree_git_dir(const struct worktree *wt);
>
> +/*
> + * Free up the memory for worktree
> + */
> +extern void clear_worktree(struct worktree *);
> +
>  /*
>   * Free up the memory for worktree(s)
>   */
> --
> 2.8.2.524.g6ff3d78
