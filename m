Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C32C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiIXWGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXWGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 18:06:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D53DBEF
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:06:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o2so5379263lfc.10
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SPehJnFIVEBJS5C83H61SPr4nyQr4gJWiC22ZYA7kBg=;
        b=Eey26ZWZldZMYLRU/95cvaAxty9DH1oRnuWpgbmCOhg5+OtY3/GkL8Yn84GsO0iaru
         LQqREm5saIa0YfP3hY4tKvVn/8wHvjvvAhIpLZ1HeOS9PQsU/LaKUBWCGFtjbIyLCkV2
         9Rh1MNT2YBNTBtpySOPzYeVsHUMJNEcVvnxGejGmsTPMjvTvvkto/qF8cUH5Uh1lfmmZ
         wScpct1tm2kL75R4o7veXgbEUN4bSraDxFEIE+YjAwCvoP0pTnJtwVXB90lZF8I3a7Pr
         pn+A/Pu2y/mjLCrQLvPq8JmBRy590okNJSUHnb9sj+1KEOEgMdRBtbRFzqeqnGJAXITX
         VGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SPehJnFIVEBJS5C83H61SPr4nyQr4gJWiC22ZYA7kBg=;
        b=t0T90TUvwh5VKYxse6oJommPXxc7DMFdYP0k4qA+Nny98QkClusKGLwvXHTVldBq1T
         E32BCExzPlQ/pOB9K2GhR1JZhvbVnvZp0Z1OX2csHawfwgwKl4x884tjJdWQ4Ui71LgJ
         X6gSIkyQEM07U3yLwTM9Vyu7X3RCT0orsdBWf0zlGcPXlSdqS8CO7eIqsrrOVWRR0qoe
         4E+44p/Z2/jyubRSw3bMsK4T4gG4RRzEMz2VID8mXFKEr2ItL6zYlXlVleCnLic2mFlU
         6tuCBhKwmAOInOPG41xm/CSoteqT9eOFJSbXrP0ZsFA/AwUjQwlMf2+ovLX/1C2lPZnr
         AqbQ==
X-Gm-Message-State: ACrzQf2PJc7oE/1hASipcBhBpWzN5N4m7C5A+VJ8gqaDoHaxyh9NWF7M
        jsHw7kDUkBmNCP8wGS5ArLvz8SxrW8tIWObIC9DNx40YmvoVZQ==
X-Google-Smtp-Source: AMsMyM5DrbAi4im00EAv5WVDfMXzfKnkHGHm82+SlI37GCb6kVNTg6gN7jlZWSIrbrZvJHOxfQq6OBpAYlo8aVNEKWQ=
X-Received: by 2002:ac2:4c4b:0:b0:49e:939d:69dd with SMTP id
 o11-20020ac24c4b000000b0049e939d69ddmr6303815lfk.516.1664057173845; Sat, 24
 Sep 2022 15:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220924033708.2409170-1-tmz@pobox.com>
In-Reply-To: <20220924033708.2409170-1-tmz@pobox.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Sep 2022 15:06:02 -0700
Message-ID: <CABPp-BHPYa4Lzj0Kt-q+qyA+qpo3BLkoMoQOo7sPNoo-0RTxKA@mail.gmail.com>
Subject: Re: [filter-repo PATCH] fix links to git-fast-import
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 8:37 PM Todd Zullinger <tmz@pobox.com> wrote:
>
> The name of the html and man page for `git-fast-import` is missing the
> `git-` prefix.  Add it where appropriate.

Thanks for noticing and reporting.

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> Hi Elijah,
>
> I noticed the link to git-fast-import.html in git-filter-repo.html was
> missing the `git-` prefix.  The man page similarly lacked it when
> referencing it.
>
>  html/git-filter-repo.html | 2 +-
>  man1/git-filter-repo.1    | 2 +-

Neither of these files are tracked; both are auto-generated.  I do
stuff them into the "docs" branch so people can grab them...but
they'll just be wiped out and overwritten the next time I build the
docs.  So, either the documentation source file is wrong, or the build
process is.

>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/html/git-filter-repo.html b/html/git-filter-repo.html
> index 3143fd9..5119fa2 100644
> --- a/html/git-filter-repo.html
> +++ b/html/git-filter-repo.html
> @@ -2167,7 +2167,7 @@ that filter-repo uses bytestrings (see
>  instead of strings.</p></div>
>  <div class=3D"paragraph"><p>There are four callbacks that allow you to o=
perate directly on raw
>  objects that contain data that&#8217;s easy to write in
> -<a href=3D"fast-import.html">fast-import(1)</a> format:</p></div>
> +<a href=3D"git-fast-import.html">git-fast-import(1)</a> format:</p></div=
>
>  <div class=3D"listingblock">
>  <div class=3D"content">
>  <pre><code>--blob-callback
> diff --git a/man1/git-filter-repo.1 b/man1/git-filter-repo.1
> index 188fd2a..9f9bbfc 100644
> --- a/man1/git-filter-repo.1
> +++ b/man1/git-filter-repo.1
> @@ -1512,7 +1512,7 @@ def foo_callback(foo):
>  .sp
>  Thus, you just need to make sure your \fIBODY\fR modifies and returns \f=
Ifoo\fR appropriately\&. One important thing to note for all callbacks is t=
hat filter\-repo uses bytestrings (see \m[blue]\fBhttps://docs\&.python\&.o=
rg/3/library/stdtypes\&.html#bytes\fR\m[]) everywhere instead of strings\&.
>  .sp
> -There are four callbacks that allow you to operate directly on raw objec=
ts that contain data that\(cqs easy to write in \fBfast-import\fR(1) format=
:
> +There are four callbacks that allow you to operate directly on raw objec=
ts that contain data that\(cqs easy to write in \fBgit-fast-import\fR(1) fo=
rmat:
>  .sp
>  .if n \{\
>  .RS 4
> --
> 2.38.0.rc1

Is the real problem that in this text from Documentation/git-filter-repo.tx=
t:

    There are four callbacks that allow you to operate directly on raw
    objects that contain data that's easy to write in
    linkgit:fast-import[1] format:

that there should be a "git-" on the last line?
