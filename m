Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854751F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJMB52 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:57:28 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44999 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJMB51 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:57:27 -0400
Received: by mail-ed1-f52.google.com with SMTP id z21-v6so12283836edb.11
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q5dhjUSPUHvVslXjX/zeXEkXkrfuiTrp/Jq+CpQtwgU=;
        b=YRLKzawJysHVm7WMHvhuAP2ySRATISYC5Lgl45A2SJx+2YQtBoUONYh1ar4tPMEOXs
         SAd/n+9S6EKh7vxsO4SuwGn0gN82GwkqDkcJHyThv877IiyMm5EihzLpYaz2HSg/eB4p
         YA8MTLoPtNub/jc8edkHbF3CPGx0tJcmnnmeq4Swv8orthONKLCWhrU9ulKcuyaAYiP7
         YF+i1d9yjz+5UefXE9hXmTwMW1KmadErRDPqn0hMbcatbJ/zHZ6lCMvcldleD966WkF3
         jaKkLJhfTbGRrnLnSY9bvoGLG/PDhZcAwgF55ZrwbDaOgwiSyy2AQxjlydPDdUMXTG86
         dZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q5dhjUSPUHvVslXjX/zeXEkXkrfuiTrp/Jq+CpQtwgU=;
        b=SV/yXO7+xrsxVbvwMHAPDK6oU7rL5nWINpHby4uxytIdLjj4liD0sz4yvJyR/6YM1V
         BQZTHcUbB3pAHlc+B0EE4z4YfnfGHrVF2b3zqSmZWQC3qixE4lUYW9SSpgr3R15avtMP
         1qYosforKZ8JaPAjvFRJq4imR7AQBY2/7ncL7fkGI71yrViq8ra0+YwdtPNCwrblCSod
         dhnsWmaFV/I89jApJHwX+iQPxHeE5i8MbpaudvBP38hhXsEENO7KxtqO+tNfu0Vh0UP+
         c6yowSEQRu4vp1/53/E+Rv8pOTvhHVTM8nUHXFOYUy6edvwAUzYknJmieR/VJfcLXA7q
         OU7g==
X-Gm-Message-State: ABuFfohvyNCXK5lWPlnruQ5Hm2TsYBMBdlg7j/MaSu8LLPOkwy0TLSmR
        PXjDgvykrMxP6nebQ7Rf5ukAUQ6Y0w08wOrVNRAFKw==
X-Google-Smtp-Source: ACcGV62d0yOprltM4W/YemdMwtJSn/gzzMN32Xc39FI67bHgtq5Mg4MJ4tgrf48b+AhCBwYJX7rXBKX1S/MbZ5b6+Ic=
X-Received: by 2002:aa7:d412:: with SMTP id z18-v6mr10803290edq.26.1539368619166;
 Fri, 12 Oct 2018 11:23:39 -0700 (PDT)
MIME-Version: 1.0
From:   Sergey Andreenko <andreenkosa@gmail.com>
Date:   Fri, 12 Oct 2018 11:23:28 -0700
Message-ID: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
Subject: issue: strange `git diff --numstat` behavior.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff =E2=80=93numstat FOLDER1 FOLDER2 works strange when run from a git
controlled folder.

The output shrinks some symbols in the diff file paths.



For example:

Create a folder and call git init, for example: `C:\test`.

              mkdir C:\test

              cd C:\test

              git init

Create two folders with to diff. For example: ` C:\diff`, `C:\base`
and put a file in them with a diff (for example `1.txt` with `1` in
base and `1.txt` with 2 in diff).

              mkdir C:\base

              mkdir C:\diff

              echo. 12>C:\base\1.txt

              echo 13>C:\diff\1.txt

Run git diff:

pushd C:\

git.exe diff --numstat "C:\diff" "C:\base"

Output will be:

1       1       "C:\\diff/1.txt" =3D> "C:\\base/1.txt"

Now move into C:\test and run it again:

pushd C:\test

git.exe diff --numstat "C:\diff" "C:\base"

1       1       "C:\\diff/1.txt" =3D> "C:\\base/1.txt"

Now create a folder in `C:\test`, for example `one`:

mkdir one

cd one

git.exe diff --numstat "C:\diff" "C:\base"



output will be:

              0       1       {iff =3D> ase}/1.txt

So (folder_name_length) symbols were cut from the path (=E2=80=9CC:\\d=E2=
=80=9D and =E2=80=9CC:\\b=E2=80=9D).



Is any way to avoid that? I have checked several git versions and they
all do the same.



Commands to repro:

mkdir C:\test

cd C:\test

git init

mkdir C:\base

mkdir C:\diff

echo. 12>C:\base\1.txt

echo 13>C:\diff\1.txt

pushd C:\

git.exe diff --numstat "C:\diff" "C:\base"

pushd C:\test

git.exe diff --numstat "C:\diff" "C:\base"

mkdir one

cd one

git.exe diff --numstat "C:\diff" "C:\base"



Best Regards,

Sergey Andrenko
