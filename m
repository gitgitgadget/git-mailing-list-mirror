Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0375201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756009AbdDRTMW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:12:22 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36433 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755225AbdDRTMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:12:20 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so1057189pge.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9ufzTvraSeOvir+h3u3ogkAIHEmgaRKxw++rxMBEHdU=;
        b=fyqx21UvASh9wBu3rTib9EoGy5oemQXPQwO1J/LwzdNg5HfHj1DIRnA+82texWxEkr
         aXi5zH8mFFEDd/EcWVlMJwFK2Y4XwfSMbOPGuK/P4psq6hKNpR5OtKy2slvO+ffmbANj
         BRTUC9oDAZcQt65joHT04alwolwXqsxWtBMyXx/ZCtzppthmZhwZ54ZL3PNmVcgx9bbM
         6/TqFvd+XsV8yuOQoPUJrOMTeHCBuDgtl+D4Qn6eC3XLX0jEm/M9fQpOwHI8J1VrVTg0
         b0QOm8N4MbJwZPvQKK+tr9F8sF5FxxgIlQYV8RlRi+lrmfq0pH1c9J2suAGQNpkj5lJZ
         /Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9ufzTvraSeOvir+h3u3ogkAIHEmgaRKxw++rxMBEHdU=;
        b=Iw6QFrzy1TZJv9f+OUTV7AH+8qbtkSLuSeXw2JGrx2FAFVw6/+d+c4DJzq6uJ1N7Mb
         xKRYLsx3GE/Zg7SdCH5n/ualIiImeCaJsIqaqPHKewsHiKvxkPN+W3YOjqoOJHweie+b
         nWHzuQjFs2QJJIvAufXN9Gy6rN573W2PeWj1s6abcyOGtdKlqGrbZ4wmhDG3jnvAs27D
         bWlES7tQtyR8LVphj8oyc+qsRcKnru7ISB4gb8IiJRzsU7jIml6pMyghaSGvH2V1lXwV
         JMXD6u4/YgFNHb8fnIo3B9q1AIceEuTFYxICqLbUC4eHtBhzAtES/5ZWYBVleuS1Axod
         rdBQ==
X-Gm-Message-State: AN3rC/4NpTnuW3Y0B3BFu2/V8fYBkFVZG06aTXHqgVHOugtyJ3RBRx8f
        EZe/ohhnzaOnDjcFYYfn03b91aWQDT7CiM4=
X-Received: by 10.99.44.140 with SMTP id s134mr19615520pgs.178.1492542734353;
 Tue, 18 Apr 2017 12:12:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 12:12:13 -0700 (PDT)
In-Reply-To: <CAGZ79kazh5+6vx87PVXUNgyJebO2m6pEkT1G8rSFvCmWQZdSuw@mail.gmail.com>
References: <605bb444-8d8c-7fea-d3b8-6f8414636d87@gmail.com> <CAGZ79kazh5+6vx87PVXUNgyJebO2m6pEkT1G8rSFvCmWQZdSuw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 12:12:13 -0700
Message-ID: <CAGZ79kZy1rBUaF1XbUOPUxDPzT1FwCp92jbbiO4RX3aiCoNkxQ@mail.gmail.com>
Subject: Fwd: Failed shallow submodule clone for fixed SHA1 falls back to
 checking out HEAD
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 6:04 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> this is using "git version 2.12.2.windows.2" on Windows / "git version 2.=
12.2-639-g584f897" on Linux.
>
> I have configured my superproject with .gitmodules saying
>
> ---8<---
> [submodule "src/funTest/resources/projects/external/jgnash"]
>        path =3D src/funTest/resources/projects/external/jgnash
>        url =3D https://github.com/ccavanaugh/jgnash.git
>        shallow =3D true
> ---8<---
>
> and configured the submodule to checkout commit 2aa4cce7d7fd46164030f2b4d=
244c4b89e77f722 [1]. When doing a fresh clone of my superproject via "git c=
lone --recursive" I get
>
> ---8<---
> error: Server does not allow request for unadvertised object 2aa4cce7d7fd=
46164030f2b4d244c4b89e77f722
> Fetched in submodule path 'src/funTest/resources/projects/external/jgnash=
', but it did not contain 2aa4cce7d7fd464030f2b4d244c4b89e77f722. Direct fe=
tching of that commit failed.
> ---8<---
>
> So far so good, it simply seems that GitHub does not support allowReachab=
leSHA1InWant [2].

Maybe the error message should say so: "Bug your host admin to enable
allowReachableSHA1InWant".

> The interesting bit is that my submodule checkout still ends up being sha=
llow, but poiting to HEAD:
>
> ---8<---
> $ cd src/funTest/resources/projects/external/jgnash
> $ git log
> commit 12036fffb6c620515edd96416363fd1749b5d003 (grafted, HEAD -> master,=
 origin/master, origin/HEAD)
> Author: Craig Cavanaugh <jgnash.devel@gmail.com>
> Date:   Tue Apr 18 05:33:06 2017 -0400
>
>     Fix typos
> ---8<---
>
> Wouldn't it make more sense to unshallow the submodule clone in this case=
 and checkout the configured commit 2aa4cce7d7fd46164030f2b4d244c4b89e77f72=
2 afterwards?

If I remember correctly the conclusion of the discussion at the time
was that people are more interested in "less data" rather than
"correct data" because otherwise you would not have asked for shallow.

> At least I'd be getting what I asked for in that case, even if at the cos=
t of additional network traffic. Because if I read [3] correctly, the comma=
nd line option belonging to "submodule.<name>.shallow" is called "--[no-]re=
commend-shallow", i.e. it's only a recommendation, to falling back to a ful=
l clone should be fine.

Heh, good point. Currently that option is more like a
"--[no-]follow-shallow-in-gitmodules" without second thought as the
"recommend" would elude to.

Thanks,
Stefan

>
> [1] https://github.com/ccavanaugh/jgnash/commit/2aa4cce7d7fd46164030f2b4d=
244c4b89e77f722
> [2] https://git-scm.com/docs/git-config#git-config-uploadpackallowReachab=
leSHA1InWant
> [3] https://git-scm.com/docs/git-submodule
>
> Regards,
> Sebastian
>
