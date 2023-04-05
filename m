Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A17FC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 07:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjDEHqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEHqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 03:46:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E82D50
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 00:46:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d3so13623700ybu.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680680807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Pk9cmbqFHIhXpdYXLfqcAwpSwFPNCayBglQpABZMtg=;
        b=cjln63bXtndKTHPGBZC1DLzRLjckEzRYY07tMi+bTb2xbGGa1x2I8Hz43KKBHLJYYz
         ky0Hs9Qd+F5XPir4CxZRQceLWucdSEIw6E3ygzz18GOgEkvQSm6y56/KqDP4VauI5Pnb
         s6Agg1gos9pPDWCsXq0RyWUWz3yRB51g7XSCc+NSsnn3q59SElg5HCQoruvotTRm82vS
         KwOcZcbqklHebM8a5KNF8D4pI0FmtzoZG6z7H+88d6JNvRmsSAO/cSZsLxWF/Hp4DAxF
         VY5CdPFkM9grH9fuYP957YmIKRIkh1DsPziEQu1k+BHMsilRfSVlySto8AQB9odSRAzN
         tGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Pk9cmbqFHIhXpdYXLfqcAwpSwFPNCayBglQpABZMtg=;
        b=sT7M6whd+D32eIaZPAPEETfw3toRzHDPL+4arqOD9grbcEvPyoSFZCaIAlUaY+yjNL
         xZQuhdwC4Zi1WL9PN5S2QqxzRFSgv9u1Ss4969sf0u034EKhQJKCs0+A64YaYu8i6Ip5
         lHM3okFwk8e0C//P7mwh4i97Q/+Tj2DG2POCj1+ZReCs1y85h8EHn9TDw96MGQqs+dkG
         62d2vO0tua3Vo1PUwOY8Q4iLi6pa3UUuEbE3qZ0yiYTOZePYb//Qk0uKWPZ/HTxgCiC9
         RSGVE29Kb7rZKS7RWwhblLeIfA0uau2gTZo4zB4a6SSyfFjrepHx+poYZVAbWdVH7ftN
         0CvQ==
X-Gm-Message-State: AAQBX9d1exkEpEAKMYBMrBVPPvN2VmjRWCNVLe8/btmFmVzr6ML/TiAw
        ls2wxfpd079AQrJguiGpItTZEhvaF9IEl2bhO68=
X-Google-Smtp-Source: AKy350biVp30xVBy92YJBbuOLlyg9cfeGAQi0jDPQ1zpcgTLvcp0x1y1mVGaabAf7iIL7ptgP6u3PEe5x+ib3HK/2OE=
X-Received: by 2002:a25:cb83:0:b0:b6a:5594:5936 with SMTP id
 b125-20020a25cb83000000b00b6a55945936mr3523972ybg.5.1680680807111; Wed, 05
 Apr 2023 00:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230331181229.15255-1-code@khaugsbakk.name> <cover.1680548650.git.code@khaugsbakk.name>
 <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
 <xmqqbkk44qbo.fsf@gitster.g>
In-Reply-To: <xmqqbkk44qbo.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 5 Apr 2023 15:46:45 +0800
Message-ID: <CAOLTT8QQABhiUsNiyDZj40yU2wu9RwkL=OANtLqzOrMioHMUZQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2=2F3=5D_doc=3A_interpret=2Dtrailers=3A_don=E2=80=99t_?=
        =?UTF-8?Q?use_deprecated_config?=
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        rybak.a.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C 05:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
> > [2]: =E2=80=9CAt the same time, in order to allow `git interpret-traile=
rs` to
> >    better simulate the behavior of `git command -s`,
> >    'trailer.<token>.cmd' will not automatically execute.=E2=80=9D
>
> This may be a question more for Zhening than for you, but is the
> above a typo for "git commit -s", not "command"?
>

Ah, indeed it was a typo.

> > +$ git config trailer.see.cmd "glog-ref"
> > +$ cat msg.txt | git interpret-trailers --trailer=3Dsee
>
> This is inherited from the original, but it is a poor practice to
> run "cat" on a single file and pipe the result to another command.
> Just redirect from the file into the downstream command instead,
> i.e.
>
>     $ git interpret-trailers <empty-msg.txt
>
> Perhaps we should do that as a preliminary clean-up before these
> updates?
