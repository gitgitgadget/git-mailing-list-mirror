Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072631F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeA3WCO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:02:14 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33428 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeA3WCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:02:13 -0500
Received: by mail-yw0-f179.google.com with SMTP id x24so5970272ywj.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=09GSCUiu0P5pgCgcO/6d2y6xtK4BDW3kYJ4JOFLu5bo=;
        b=KfdxVsl+Dq9bSyi3sS96LEDD8y5wCLxFPz+Bue4e/U5RJmxWvADIoIs8E0/cBiAgcR
         P5iH++5iO9KGy7k5CFGm2HUSkyH80yO/PjZG0xwBthQd+U1Qbbd5IjO3a/IPahMs4R9S
         +SIB2IC59L/wVjymQixWHjkvWljQpWM/5/+f1R7BXJoMS49NwSHgjCvMKsXusa4ngUvo
         6etZ800z7k2b0V2pjLHZ5rL8mbu953CGgxTTyoabcSRZtI/oIarCL6AKjEXCGidV0w0a
         n7deC1uvhpbrOUTdHx+0HdrDQWVh3NC2tDLTUYfFumLwGpX3gAKjTM1bIsLZ9W3YadZv
         Ec5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=09GSCUiu0P5pgCgcO/6d2y6xtK4BDW3kYJ4JOFLu5bo=;
        b=JvTE0M2cprLFWX292Z7+cZ/2g0d6J4GYE+fhuOfHQHN84ZXQQ1PAEoYddeqUJJX+Og
         n2kHpIVR50oADbDrAuLgQttd/VtgooWG/4fqQwA8O+T9RimTj3jTsdhpT0tJL4wylQPX
         iPGLzogkcScjRg0jKAfuy1f1aaotSYd1TeM5Qs5bnddpC1Npma8wHDFpVaAUQHSoSxOh
         bEPoSj11GgqJEN5zEclNCJgRm/oA2SJfFudm4PpylRcIASh58m1E2yrbQhCXEmfqPJa8
         H5RuluRMCKkg3eYeE/XkV1OcBMPqFacy4sBbIbTkAGPFWxkb+GqYaM6Si2FKcj0mn0HI
         1RDw==
X-Gm-Message-State: AKwxytcQjx1BA7bF5K3jWw0A1tyvARjOvS/wP7x/JKkHMZUp155ROpdY
        WWaL29mfhPzFGQafKywB3T9h7lvt6JW/ffKvfzwNhg==
X-Google-Smtp-Source: AH8x224aCe3tAWPKwXKK3LfpFpwdteJhaAdEmFH1KV7XO+Doi/AQ5GCfT8CQeoYQ08bOSiGdhO+wpCtCnKY3B0pwZ84=
X-Received: by 10.129.156.134 with SMTP id t128mr20585756ywg.108.1517349732621;
 Tue, 30 Jan 2018 14:02:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 14:02:12 -0800 (PST)
In-Reply-To: <DDD544204D3240408540BFCC028E06882F12F237@FRCRPVV9EX5MSX.ww931.my-it-solutions.net>
References: <DDD544204D3240408540BFCC028E06882F12F237@FRCRPVV9EX5MSX.ww931.my-it-solutions.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 14:02:12 -0800
Message-ID: <CAGZ79kab9oeZq4BJNBPaXA_uso3WQh_FBSE807E=ftBKvujsXQ@mail.gmail.com>
Subject: Re: 2.15.1 - merge with submodule output issue
To:     "FIGADERE, LAURENT" <laurent.figadere@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 7:42 AM, FIGADERE, LAURENT
<laurent.figadere@atos.net> wrote:
> Dear git,
>
> I use since few weeks now git 2.15.1.
>
> I did few trials but please find here my outputs.
>
> To reproduce:
> Use a top module git which include a submodule
> First step: from a work area, I changed selected version of submodule in =
master branch.
> Then git add + git commit + git push
> =EF=83=A8       A new commit on master branch has been published on my or=
igin repository with the version v1.2 of submodule
>
> Second step: in my second workarea, I created a user branch mybranch, the=
n selected another release of submodule
> I added the update and then commit in mybranch.
> =EF=83=A8       A new commit with release v2.0 of submodule is in my last=
 SHA1 of mybranch
>
> Last step: in the second workarea, in mybranch, I first run =E2=80=98git =
fetch=E2=80=99 and then =E2=80=98git merge origin/master=E2=80=99
> I got a CONFLICT message of course due to the 2 different versions of sub=
module.
> Here the message:
> warning: Failed to merge submodule submodule (commits don't follow merge-=
base)
> Auto-merging submodule
> CONFLICT (submodule): Merge conflict in submodule
> Automatic merge failed; fix conflicts and then commit the result.
>
> Now I thought that the command =E2=80=98git submodule=E2=80=99 provided a=
n output with both versions of modules (local and remote).
> But this is not the case in my environment:
> [15:20:10] $ git submodule status
> U0000000000000000000000000000000000000000 submodule
>
> And when I run the mergetool command I have this output:
> [14:54:41] $ git mergetool
> Merging:
> submodule
> Submodule merge conflict for 'submodule':
>   {local}: submodule commit 08f86f2404d9f8f616262971a3127e69f39f9d11
>   {remote}: submodule commit b3dd6fde4f02258b88ad0b2dba6474c126b499f7
> Use (l)ocal or (r)emote, or (a)bort?
>
> So, it means it=E2=80=99s not usefull to determine which version has to b=
e selected.
> Is it a bug or perhaps I make something wrong?

It's not a bug, but the real feature has not been implemented yet.
