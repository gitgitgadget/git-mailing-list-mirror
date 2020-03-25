Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CF9C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B337C2078A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWgTfrhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCYRJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:09:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38144 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYRJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 13:09:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5so3414151edq.5
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tn3mlHuIs2HW29nSEkW7W03WUAdjMUBxfyeUMDwVUXw=;
        b=qWgTfrhzfYOOdP0euZihsvVx6QyLZhXmqylfiAPocthd2Kyek0NvF7q07+BlvuYwzG
         riz3F7pCLo/alLpI0L6hdksKQh8rSzipe8mbp9e4QvnsimrZMysS57ibnPKVc/QQhZuH
         Iuot1A/VYD266nJkZeTSjlUNUPrpZTkINb2A4u0iJlir2sFIFsdyaZx0Cq/ordieDDvr
         ER7iu63aF1HZABZp32/vTiujpG5Yk6nu+W83Zt7H9c247lwYSxiFYCH/pXv3enQ80+nJ
         OnxRYHFWBmHIE4LdzJSAoRIuOkZwCzfeNbkvHiwzYYdMbcbRQLU/1axCGthmOIh6S6gD
         dc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tn3mlHuIs2HW29nSEkW7W03WUAdjMUBxfyeUMDwVUXw=;
        b=YIW26WWcv50OdX7ucaCNZ08OXSEyPH7iYlzPigXVZM4OjI0yq8oWmi2t8lu1NOxPVL
         VgdKOct2CdruXX3W+v3tFUxu2A5yq+kuZjb/Mxs6BR56rFy4kOneCbKXNIAYpaxsn0p3
         PBjCQCXubgJhL+CHINsHTXU5+AUjdNU/jAf7MqBe3zJ2+ysKDgot8b0fichLgwrdt8MD
         appyas8IRvjO0ntlCpHRNUwPzpUEtEedkE9wZOAaeQZKe+FHis53MF8vSTtzKZUyh6Dz
         FoniK/lOYGssXop8ow6k7IdLlxg23E8ErXN4h3YluKNtkdEGaSGlP/wwMh36bk/RKjyx
         LToA==
X-Gm-Message-State: ANhLgQ0s7Yw9XudiFaVx/E+eO1GFlxEJSta/F2zLN9bC7XCoP4edHCg0
        pev3ki40vDel2BYGcmB8DFnndL1HGiPlyOuLx6w=
X-Google-Smtp-Source: ADFU+vvHO0e3zSZsQk0AEP7C/87YZ/pKIKgFdJrUoUnmNZbIJPNEh0Bh3gCScC/b14AEhC8VGn7cJp/31yFj9c62r/c=
X-Received: by 2002:a17:906:3ec5:: with SMTP id d5mr4203485ejj.106.1585156192097;
 Wed, 25 Mar 2020 10:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
 <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com> <20200325163540.vdc7l72fke7yqryb@tb-raspi4>
In-Reply-To: <20200325163540.vdc7l72fke7yqryb@tb-raspi4>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <r0maikx02b@gmail.com>
Date:   Wed, 25 Mar 2020 18:09:40 +0100
Message-ID: <CANPdQvKbgisOQatrwcY66Asodxi__feaVOvoJe2j9qvHcrbZBQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?UTF-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 5:35 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> Thanks for working on this. I have 1 or 2 nits/questions, please see belo=
w.
>
> On Wed, Mar 25, 2020 at 01:45:10PM +0000, Andr=C3=A1s Kucsma via GitGitGa=
dget wrote:
> > From: Andras Kucsma <r0maikx02b@gmail.com>
> >
> > On Windows with git installed through cygwin, GIT_ASKPASS failed to run
>
> My understanding is, that git under cygwin needs this patch (so to say),
> but isn't it so, that even Git for Windows has the same issue ?
> The headline of the patch and the indicate so.

Git for Windows does not have this issue, because there
GIT_WINDOWS_NATIVE is defined, which is not true under Cygwin:
https://github.com/git/git/blob/274b9cc2/git-compat-util.h#L157-L165

You can see in start_command() that there are separate implementations
based on GIT_WINDOWS_NATIVE. The problematic code is in prepare_cmd,
which is not called in the branch where GIT_WINDOWS_NATIVE is defined:
https://github.com/git/git/blob/274b9cc2/run-command.c#L740

This means, that cygwin is running in the Unix-like branch of the
code, even though it supports backslashes in its paths.
