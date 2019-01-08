Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7B31F803
	for <e@80x24.org>; Tue,  8 Jan 2019 10:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAHKG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 05:06:29 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:46072 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfAHKG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 05:06:29 -0500
Received: by mail-io1-f53.google.com with SMTP id c2so2664983iom.12
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkFFJhPuxUiIYKZreAS9XmjRJ4Q+QmsUdtyAV1FA5ME=;
        b=H0vEctd/MMEWjqh52AjemWZfAqYnZ6/0WS8Bl1+HxbFrhB/43jUAj40MPVY5eQOZdH
         llvVoiJl/rNtylduXy3gRwTuGjOVeH8PNAZyey7d4Iry5Q3zNZ5kZNJMgHdADgTMBaZM
         FZ7szsNZWTNeLpZeha3i/6oxONjp7MC3NgGE5zPwRqimHEB+dEwikjdR23mGdcWiv17V
         9CqNKO2W0bkdIL2Yte8E0nle7QqP6qgYdRunQiSr1eA7HpZGZX4Y9dTB0QNgMotvmrtl
         FZdz/J1wVSHtJrdrd84Rz5o31H01bmKNbiZ67cEhe7FsqKwgNIGdY2t9UE5/5R6pDEtB
         taEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkFFJhPuxUiIYKZreAS9XmjRJ4Q+QmsUdtyAV1FA5ME=;
        b=BTBp6TeNnpQGI/R23KlTYv21+2to13EKNDuWF2QKETZTjbjsncwoubDFsSPcbSjcJX
         HBGC9d1jvFVDpUVDJYlPwpK+6lSJmgoRl4L+rV5Eq2KKWSu0v1mrMFKhI0I6K+2B/NG6
         uUyQUwLeEd1kitnefveLSIUAxa8OE3w5+SGETVEd3WhEB5ZtD8vUzbBcf2BahTUFRzME
         PdjI+aFm+uADyji0WRP9WTqpFWfu7fJS3+24/O9qKB0U3fVTv/MreKal4Q8ETPKEooTD
         /ltfQ6DtVn324IDgFt8l6A81CvbR4d4XIWxovrisE0tawDQ9G8o2E9D6iilymrtyZ1qZ
         A7/Q==
X-Gm-Message-State: AJcUukdz6GnC2wxKwveEaEorqSftPkGt17LUa8smS/t+Ofhi1YCTT/Fe
        /7pFMNbn9EL/ua2WLPFL5zEUkpDSDQtMLnlSAbG2gOK6
X-Google-Smtp-Source: ALg8bN6GKMIP3jplk7fx18qWvZkOPHPpGJEPCvpWEC4VkYTc0IQcjDZ6Bx6PGe+lvZuSwkxhWcuJBEqmSrO+xmRlvOY=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr638280iof.118.1546941988399;
 Tue, 08 Jan 2019 02:06:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
 <CACsJy8Atwp1nQbDaxYSNiDFmVmMG2h88w=dAZWU1SF6JQ18EEw@mail.gmail.com>
In-Reply-To: <CACsJy8Atwp1nQbDaxYSNiDFmVmMG2h88w=dAZWU1SF6JQ18EEw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 Jan 2019 17:06:02 +0700
Message-ID: <CACsJy8Bov1asw+_J_fbhKqigM==xNPi8itDGkhibkYVch4pvmQ@mail.gmail.com>
Subject: Re: `git reset` for delete + intent-to-add doesn't reset
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 4:44 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Jan 8, 2019 at 2:28 PM Anthony Sottile <asottile@umich.edu> wrote:
> >
> > ```
> > git --version
> > rm -rf t
> > git init t
> > cd t
> > touch a
> > git add a
> > git commit -m "add a"
> > git rm a
> > touch a
> > git add --intent-to-add a
> > git status --short
> > git reset -- a
>
> "git reset" without "-- a" does remove intent-to-add status.

No I'm wrong. But it was because I didn't follow your exact steps.

This is quite unique corner case. What happens is "git reset"
internally does "git diff --cached" basically to see what paths need
to update, then reset those paths and as a side effect, intent-to-add
status will be removed. But in this case, "a" in HEAD has empty
content, exactly the same content represented by an intent-to-add
entry. So "git diff --cached" decides there's no changes in "a", no
need to update it (so i-t-a status remains).

This can only happen if a file in HEAD is empty, which is quite
unlikely. This fix could be go through the index list the second time
just for resetting i-t-a status, but I'm not sure if it's worth doing.
-- 
Duy
