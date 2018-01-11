Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701F11F406
	for <e@80x24.org>; Thu, 11 Jan 2018 11:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeAKLGn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 06:06:43 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38769 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932285AbeAKLGm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 06:06:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id t67so1948128pgc.5
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FcP65d9vJgYNml1KWv3nM8syt9rcUVSfs7IlUQGTMds=;
        b=KQ5ees88deEBED3DBRoY+4kjUHzN5ydcKdC5Bxo7skIUsX40xPKjPRwWqdAbsuFm3O
         ISzSA3GAVo38QluIxp9z3W766CFg5g5cSiY/k7aWH6m9hfktb8fkXSOUYa8yBrQK/ZJV
         017mRPwCoSrC7KYZa8cbM6wSQa8u+Xb5v36/Al+0dU+bzePSNapfM61llZM91BiH/Wyw
         UNHJXoxM2KChnI5aE7Op0XN+TK3hpZx6Tasc562c8tSzr8iva3Y2mI7zmKBvpzkuDnMU
         sX1g5LFsO4/mnyHQxFMUqS//8JPoBwuKxGa2nIy3p07xQUCaABHLR1iulbD3B9cwyz9O
         jwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FcP65d9vJgYNml1KWv3nM8syt9rcUVSfs7IlUQGTMds=;
        b=NDwVK3clT61JknNwhw2biHIR5nT/xW4pFuqDTcbB+16tZR/+sk87KIVAwRBO3uYTGZ
         Eca1YCmiFGs+EsHI0/JLQOnIjTgbDVFzWZknivN9+seUlKA59i5s/uiCXerA5zWmkYXK
         h1E2U8Jlq/4hvchpm/vuOTpu7cp/2FBFS0u684G+6kWDkvyj4bXSZdcaJm/10K8Qcu0R
         WkpUWtObk8mqjaCKvGSi/YfMyQZ3kQoRepvVEq2ONGZgQe26fDNggZV/9v24doXG8UPR
         H/wO866Sgn4TG6pvPlibqIz+hBuq28GuYWdQ7dlTzvZTuH6cjkIKq4M+aDkIGJafNHwE
         53rw==
X-Gm-Message-State: AKGB3mJ1y4Tmj5VtIXCKHWumM9C1qcjmn0rDCPoCG5BvIuEcc84rOHGB
        7T04Y48bwt6OllvtxrjYX172HGaDTWp7UJfvYMU=
X-Google-Smtp-Source: ACJfBosqkOaO9DcVDTu4ehHHqBEN58eDpcWrSpdjMMn9HnEWge/SP8HmCufOk6yYkW7vGwklSy1ONzu86Uyn9+jtV24=
X-Received: by 10.98.31.72 with SMTP id f69mr15212123pff.196.1515668802297;
 Thu, 11 Jan 2018 03:06:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.183.106 with HTTP; Thu, 11 Jan 2018 03:06:11 -0800 (PST)
In-Reply-To: <CAGZ79kbUL6UBBB-wL+BxBdbomt+sxa66VVSYBxxBt6JVfPVfKA@mail.gmail.com>
References: <20180110110643.21465-1-pclouds@gmail.com> <CAGZ79kbUL6UBBB-wL+BxBdbomt+sxa66VVSYBxxBt6JVfPVfKA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Jan 2018 18:06:11 +0700
Message-ID: <CACsJy8CgzrSu7bZYQAPOK=P+CWK2vjTS3=biBBP6uZGe5ZoSMw@mail.gmail.com>
Subject: Re: [PATCH/RFC] add--interactive: ignore all internal submodule changes
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 2:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jan 10, 2018 at 3:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> For 'add -i' and 'add -p' the only action we can take on a dirty
>> submodule entry (from the superproject perspective) is its SHA-1. The
>> content changes inside do not matter, at least until interactive add has
>> --recurse-submodules or something.
>>
>> Ignore all dirty changes to reduce the questions 'add -i' and 'add -p'
>> throw at the user when submodules are dirty.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  $DAYJOB started to use submodules and this annoys me so much when I
>>  use 'git add -p'. I'm neither very familiar with add--interactive nor
>>  submodules code but this seems to work. Hopefully it's a correct
>>  change.
>
> I would think this fixes your problem and it looks correct.
>
> However I wonder about some subtle detail:
> the "dirty" setting will ignore anything inside the submodule, and
> only pay attention to the delta in gitlinks between HEAD and index.

Wait, why does diff-files, the command about worktree and index, look
at HEAD? Testing, testing... no I think it still works as expected

> ~/w/git/temp/z $ git ls-files  --stage foo
160000 41521690bee4b76ad108a403b79415f8591a5592 0       foo
> ~/w/git/temp/z $ git -C foo rev-parse HEAD
3bc15b2e78ec3a5c5ea27715f20adaa2669446b1
> ~/w/git/temp/z $ ../git diff --ignore-submodules=3Ddirty foo
diff --git a/foo b/foo
index 4152169..3bc15b2 160000
--- a/foo
+++ b/foo
@@ -1 +1 @@
-Subproject commit 41521690bee4b76ad108a403b79415f8591a5592
+Subproject commit 3bc15b2e78ec3a5c5ea27715f20adaa2669446b1
> ~/w/git/temp/z $ ../git diff-files --ignore-submodules=3Ddirty foo
:160000 160000 41521690bee4b76ad108a403b79415f8591a5592
0000000000000000000000000000000000000000 M      foo

If I reset foo/.git/HEAD back to 4152169... then diff-files
--ignore..=3Ddirty returns empty. So I think it does check submodule's
HEAD.

> Maybe we'd want to have a mode "dirty-except-submodule-HEAD",
> which would ignore all submodule worktree changes, but if its HEAD
> is different than the gitlink in the superproject index or HEAD, such tha=
t
> checking out a different revision inside the submodule is not lost
> when staging things in the superproject for a new commit?
--=20
Duy
