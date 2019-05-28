Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362631F462
	for <e@80x24.org>; Tue, 28 May 2019 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfE1S0s (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:26:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47048 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfE1S0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:26:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id m15so3849429ljg.13
        for <git@vger.kernel.org>; Tue, 28 May 2019 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=jqAa69ubPKZw6mssT55DkRcidEwMqdYjbvGhi2BMKeU=;
        b=gYy1POND57OEXb8weBl3fa1P7kKnOPZMh5IgACaZMaxU/E9vgg/E3se9INVbHjQ3Je
         L4E4OyjpOWBhUZ8fTT1B1swo6tOg15W/kAXSz7FicepRZslmrNolUNKQMiAhEewVaiSE
         ChFxrvDCKWtlsziJoEFmDbRjJs6HCuHEKde4bvLtkpnfw3CFraCGJyWJL9lwiN9aky+r
         PMhq1ZzZLCpAQcdMIuYCdR7L5/tC9M9xCyHK8PZYLcdDs2Kxj2Fwpgoyqeb6WBz62+IM
         jJQxpsU6QgptYZxRGc50Z0nB1DdNB/Ebzv6wRMP6g5ikl8UJniy/AY3m22xwLJb9yyE8
         fBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=jqAa69ubPKZw6mssT55DkRcidEwMqdYjbvGhi2BMKeU=;
        b=GwQ9i32FXbwHtMfA5P0njPtyiPzFBVQL4KtXkBqK9ddTY60xtQn47wQ5KvKfqZKCe6
         OosXeODPfzd7FWqCuHQYNYzwHMeSf7NiRdBxm/zRUn7myP9RtYNAqT2mkiHRvsHqYFgy
         o6LBA54lRsQu3fAnzL86zWtrzkAzuBwfjYA2eAxvvW0hjyiVCgHTcBhEUkgGo/R3f9sd
         p1KzA7v49CLDRDilqILgYijp/DUxbako+EEqxOupSgUjnfCMOprMonsUxcLt5hVMEs0g
         ufuCFD+5kqNhEs3kWVmXe9o3D0ttF8sQyVCju8SaOxfAsCSiknkAfd8Q2quZzt35hs6i
         JZAg==
X-Gm-Message-State: APjAAAUdITB/baiMumxLfa3mUpIcg2Q7gZ4OZQajkNSyN3lt+UkSWdZ+
        H3JLLEU1EhHjusAGxLWW73v/JL07NmiM+0wSDaNbUuC5
X-Google-Smtp-Source: APXvYqyEXc4ESjsBVy5wHHST3XEOfgnPhqzGyhJ38awrxijmodexK+KROUfssmrOqy72djKYWmCOpE1YI7QppNPWA2Q=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr51850649lji.57.1559068006040;
 Tue, 28 May 2019 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
 <87ftp3lqvw.fsf@igel.home> <CAHd499BQO8E99Y4=T9V6xXDuDyHdqMJ_sQM4DTraAxLzKf+Z-Q@mail.gmail.com>
In-Reply-To: <CAHd499BQO8E99Y4=T9V6xXDuDyHdqMJ_sQM4DTraAxLzKf+Z-Q@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 28 May 2019 13:26:34 -0500
X-Google-Sender-Auth: 9gkbnxBt6qZ9BSgVjCRq5mECGgY
Message-ID: <CAHd499CZnhzw+sKM_Nx4_SvUT5YWaLWr9SmBKCkOcH4=wSdaqA@mail.gmail.com>
Subject: Re: Need help merging unrelated histories
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 8:35 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> On Fri, May 24, 2019 at 12:11 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Mai 24 2019, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> >
> > > Can anyone provide some advice on how to properly restructure this
> > > repository to create some ancestry, as if all along a `master` existed
> > > and all release branches were based on this in a linear fashion?
> >
> > How about using git replace --graft, then git filter-branch to make it
> > permanent?
>
> I unfortunately have little-to-no experience with low level plumbing
> commands. Could you provide an example of a series of commands to run?
> It will help me to figure out how to do it on my own for my specific
> use case. Thanks in advance.

Toyed around with it a bit, and tried with the script below. There
were no errors, but I noticed that it erased my `.gitattributes` file
on master that I committed before performing the graft. Why did it
remove the file? I assume I'm not doing this correctly. Please advise.
Thank you.

```sh
#!/usr/bin/env bash
set -ex

if [[ ! -d Native_SDK.git ]]; then
    git clone --bare git@github.com:powervr-graphics/Native_SDK.git
else
    cd Native_SDK.git
    git fetch
    cd -
fi

rm -rf test_repo
git clone Native_SDK.git test_repo
cd test_repo

git checkout -f --orphan new_master
echo '* text=auto' > .gitattributes
git add .gitattributes
git commit -m 'Add gitattributes file'

c=$(git log --oneline origin/3.4 | tail -1 | cut -d ' ' -f 1)
git replace --graft $c new_master
git filter-branch HEAD..origin/3.4
git merge --no-edit --no-ff origin/3.4
```
