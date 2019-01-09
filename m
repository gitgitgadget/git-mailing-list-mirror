Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF9F211B5
	for <e@80x24.org>; Wed,  9 Jan 2019 23:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfAIXNQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 18:13:16 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37725 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIXNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 18:13:16 -0500
Received: by mail-ed1-f50.google.com with SMTP id h15so8699068edb.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 15:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfo7Qj/RadRsNKnVgI8vUMvmqr/9i7iJ0buJHl34RRc=;
        b=uSArsJQ65HXnVURY/3vyQbocp2flAwtgkH7AGgfSli15z1nu6PkJ1cVhW8qn96cH7c
         1vf3YHXdZabZxUsM2uTCfNtfo0Bom5VtaetVB4LdpMLkQeIHlT260d7f2Kv77mTd4WCD
         +3YBawszETKSKm1Zk/ChcAO853BhNaMq/DJXGWvPvxofxnhB2T6QEtCSHVVG6lS/EaoX
         yart49+LTlQNEpvUQSzjSHmR73Dak2/A3s9kXKmdc5dWjMFceQrReemR4z/eRX4WZcmq
         dpiNo/ZxV2dAN4SLZijRz307llyA9dWVzOYk1ZpDV0kqzWaC0o75g/7abVuR0Ops0IPP
         cEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfo7Qj/RadRsNKnVgI8vUMvmqr/9i7iJ0buJHl34RRc=;
        b=gmqlxf8GeQQ5FVBIL2YUVA5P7zhayuCd4/63L2zkTfa/uJiLbYZXHHOnjqV2eJ+vze
         dR45Mckaan8X2BHh4uU0k7eu9WlKVdY27rPY22LYNS25AHZYwWoeSZFsJLPcXlrOXJ9g
         cBZLCt21+jS7bPklGJFBWaYBeT34B2tyXFgwHeriGpySts0VefUINNCWIKEomNIqCMke
         FY28Q5AkOQKwRQfwhKiUA3M8f75pTy/o/O8Wl6bX4ZtVopmkagO91xPyUfjJshQexFXv
         DqISM3kZN29e/4oPwU0/CR2l+dNUY+yPMvqb/j+pYnL8Q1tZADJ9Fmj01fE1/H+tuEqf
         BSow==
X-Gm-Message-State: AJcUukcIUdtXw+FM7sFQRRMlVmw7ZNs1BAfGgE9uJwgg0hHdA3ByDsN5
        yr1gIGUhycC2aMMtUlPuouieXbVCD61JdhtYbF9rT4OA5YHwlw==
X-Google-Smtp-Source: ALg8bN560XOoA7Fg9u8Zt0abmfx3KwU4OliHzHLdEkyB5z54nKiA3hsFzU+9iV+XRC44Tmf9EWK3aqN6NN55hX01GIA=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr7488327edy.231.1547075593847;
 Wed, 09 Jan 2019 15:13:13 -0800 (PST)
MIME-Version: 1.0
References: <df37313acafdb4bb74c71e476e5acab10248b1a2.camel@novalis.org>
In-Reply-To: <df37313acafdb4bb74c71e476e5acab10248b1a2.camel@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 15:13:02 -0800
Message-ID: <CAGZ79kbfmxPKZBzRpH2T=WHBjbzORiAyiFPFbPD0R+fQW7XuXg@mail.gmail.com>
Subject: Re: Submodule log bug
To:     David Turner <novalis@novalis.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 2:14 PM David Turner <novalis@novalis.org> wrote:
>
> When a submodule is renamed, git log gives incorrect output:
>
> commit 350ebece9bce8d9c495f9a51e6f5529749c5c3cc (HEAD -> master)
> Author:
> David Turner <novalis@novalis.org>
> Date:   Wed Jan 2 17:09:56 2019 -0500
>
>     move
>
> diff --git a/.gitmodules b/.gitmodules
> index da1a767..f4baf2a 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -1,3 +1,3 @@
> -[submodule "mymod"]
> -       path = mymod
> +[submodule "morx"]
> +       path = morx
>         url = ../sub
> Submodule mymod 86da4a4...86da4a4 (commits not present)
>
> ^-- I expect this last line to tell me that the submodule has been
> renamed, rather than that it has changed SHA to the same SHA.

Trying to reproduce this myself, it seems to work:

    $ git mv supertest-3/ supertest-3-moved
    $ git commit -m test
    $ git show
commit 463ce75588378a8c5c0ba1fd427cd02c87e2078a (HEAD -> master)
Author: Stefan Beller <sbeller@google.com>
Date:   Wed Jan 9 14:31:09 2019 -0800

    test

diff --git a/.gitmodules b/.gitmodules
index bf393d9..80e7d91 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,3 @@
 [submodule "supertest-3"]
-       path = supertest-3
+       path = supertest-3-moved
        url = https://github.com/stefanbeller/supertest-3
diff --git a/supertest-3 b/supertest-3-moved
similarity index 100%
rename from supertest-3
rename to supertest-3-moved

The difference is that I did not rename the submodule
name, which is crucial, as that determines the superprojects
access to the submodules. (The sed command in the
demo causes the name to change)
But this doesn't seem to be the issue of this bug report.

The core issue is whether --submodule=log is given,
as that will also produce the line
    $ git show --submodule=log
    [...]
Submodule supertest-3 636b587...636b587 (commits not present)

I think to fix this, we'd want to pipe struct diff_filepair *p
from run_diff_cmd through builtin_diff to
show_submodule_summary and show_submodule_inline_diff
which both use show_submodule_header, which could
check for a rename of the submodule via
p->status == DIFF_STATUS_RENAMED
and then act appropriately.

Stefan
