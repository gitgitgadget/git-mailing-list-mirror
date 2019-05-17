Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83AA61F461
	for <e@80x24.org>; Fri, 17 May 2019 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEQQ4t (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 12:56:49 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:41359 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEQQ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 12:56:49 -0400
Received: by mail-ua1-f54.google.com with SMTP id s30so2933335uas.8
        for <git@vger.kernel.org>; Fri, 17 May 2019 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xb3tZCrgYxgKSXOazsD1miL5klYobl1eFX2CLGEK/ek=;
        b=tHsCtHyU17LI7vZUqGKyfOrZ2j+yOFCE4IKJkvujXFQ9kxeADQtt9RnaJUIisB7jlu
         2iJYcyYoxk2RBjtBNQL8gCbnIHp659izV87mnEZPmrVwyBb6SM03Oi4tv0lAtYeh2i7I
         No48T3ZZ4HvNgSvHvZ5DVJIux6etk4gm9V/1plAphupdQIBjN3v4iRV6fI1EB2fJwfaA
         9AbIo02YUIhNhIwLypLsowgs5+dYXl7NQahm4/6YiFj5Bgb0OmSZVJ88IF4RD56wVzZt
         bvjndLqXTosU2Z5F5uvD5Yu4IkpKff6zwZMXrGaKh/PLTxXwyH2g5/KQcuz8W4Jq9mKp
         2fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xb3tZCrgYxgKSXOazsD1miL5klYobl1eFX2CLGEK/ek=;
        b=OylQp+FSIHTfHEywJ++wHy5MhOpJnupYuSCzYjM+Ccc9mxeVdhFT6uATEDjTrm+j3S
         SUyG+ngXck9tN7vT9o2flpdr68c4NNTks0Y37q0zPhKNDn5k3ns5Mv1WBqUAenK6U1+D
         OAGQ8dt/7FL7veNkevdQvCEPjaj87nEoqOKFLNi3scpi8xJco3jjgiuy5NDr2GS9MPBP
         ncd2CE2UeYYlXVVlmHxJFlcIDbT/f1IqkTvxmH8bVAbEFebMgGjfdBNB9yf6QTdwmSun
         10tfwNM1/pXNoOixPaF5eg98blC2fmy+ArlBtJHnECY/A9eKCRBP57fCIijBttRmatqY
         fxgg==
X-Gm-Message-State: APjAAAVJj8b2VNQRQrkw5XlTS3Ie1WXb6XV9gTjANElNTO95FpH+Ay2v
        Skp5gRp2eCKvZY3MBPA/XKFsnGUYKOrU5+An4d5WAHgiTOo=
X-Google-Smtp-Source: APXvYqw1JneZboPJdgFH8f6jVRGRgYB7gHQSTE/8zHnK15aU5htyhV8h8OJu33Fjlltn9ue/Woz017keXRGNjUZT+Q0=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr24806262ual.95.1558112208222;
 Fri, 17 May 2019 09:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1=Op7qo3xVo3h=GJRxxw8q68ahtis-bAPa0eTD9eJeFF8TCg@mail.gmail.com>
In-Reply-To: <CAK1=Op7qo3xVo3h=GJRxxw8q68ahtis-bAPa0eTD9eJeFF8TCg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 May 2019 09:56:37 -0700
Message-ID: <CABPp-BFgTi728c+2vXA8Yxi103Hfsfov69GrJKXzYv-H_wwQ7g@mail.gmail.com>
Subject: Re: Resetting files during a merge causes loss of resetted change,
 invisible in commit logs.
To:     Thijs ter Horst <gmterhorst@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thijs,

On Fri, May 17, 2019 at 3:47 AM Thijs ter Horst <gmterhorst@gmail.com> wrote:
>
> Dear all,
>
> Disclaimer: I have never done a bug report / worked with mailing lists
> before, so if I'm doing things wrong I'd gladly hear.
>
> As the title describes, git can change files without logging the
> change. I'm not sure how to describe it shortly, so I've made a
> minimal reproduction at 'https://github.com/gmth/git_test', along with
> a shell script (git_debug.sh) that reproduces what I think is a
> problem. In that repo "text1.txt" changes back when according to
> commit logs it shouldnt have.
>
> I ran into this when I lost some changes in my codebase that I could
> not find in the commit logs, and a merge commit ('feature' into
> 'master') showed that that commit reverted a file to an earlier state,
> while that change was not visible in any commits in 'feature'. The
> cause in my case was probably that I accidentally clicked the
> "Discard" button on a file in SmartGit, but the shell script shows how
> to reproduce it with commandline git. Therefore I do not think this
> has to do with SmartGit.
>
> I am unsure if I'm allowed to attach the reproducing shell script to
> this email, so that's why I haven't (spam filters etc).

We tend to just like them inline, but no big deal.

Which part is unexpected for you?  Is it that the reset command will
reset a file to an older version (maybe there's something about the
reset documentation we need to improve?), that certain flags to the
log command didn't show you test1.txt (which flags?  perhaps we need
to improve the documentation on those flags?), or was it that you knew
the existing log flags wouldn't show you test1.txt based on their
documentation and you expected there to be some kind of flag for the
log command that would highlight this 'evil' merge where by 'evil' I
mean that it differs from an automatic-merge-and-accept-conflicts and
particularly in an area that's not conflicted (in which case
https://bugs.chromium.org/p/git/issues/detail?id=12 may be of interest
to you)?

Elijah
