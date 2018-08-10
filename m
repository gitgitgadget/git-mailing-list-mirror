Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181351F404
	for <e@80x24.org>; Fri, 10 Aug 2018 10:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeHJMsZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 08:48:25 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41598 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHJMsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 08:48:25 -0400
Received: by mail-lf1-f54.google.com with SMTP id v22-v6so6198590lfe.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 03:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dx3fyypyAb+jDG/C1iqGnNYff9MBYKoGttqd9M0AsIo=;
        b=PAbAKLusOQBMuCTmkXPzkpiEct+TlKI4mb25flUMTj2N9/5SOZjRrIxiriLkqVs8sI
         QJH7uxwGDQKuSr7dWvBPm4T4rsHRclOm6nhW2fiafzkbuTJ0JWxZhug/2SlKEiI3AySX
         yitx5gx5ui1tF7fxFgCao7w3jqmggzUBXiBgHPuSATJeBAcOxs9FPXBVsCDa4d3cVfZ9
         IZ6YFrAl0DrF+zWBzm+0R0D0vmhxVDlGguv0KQkYcLG81YU3fqOdcET1BThHBbcu6DwF
         tpEM7fY1JQFvXTDY7IC3OhCeyHB5JZ6lUk0bebeaVSr5ycNjte70BxwoDeRqva5UPpFm
         PqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dx3fyypyAb+jDG/C1iqGnNYff9MBYKoGttqd9M0AsIo=;
        b=tJlTo5x0+hteULFDwntBEAy3gkqxeZGTmdHzZAcaL3DGNB7VH0eHLSpn3s5dK31y7U
         c1fdNYgmXDQ5pu52cVffcl5/TdMKJQaM81OxV3z+F88nxtZZihA8Kh4RzNAaS6rjqQKA
         jJaVJEkyJxpjSTneohDvCsX8/zwwBVCxz3dnRMnPCMmZdzbyxCKpI2IE425rqrS5BS5O
         PKVy/8cmz56OsUeXWUK/LaRJuqXLrAxxlKZVEPOW56oASvLcp+3YbGWliNiPWu6zvspT
         vioqb3eK1+7kl3QUPlSST9juiac+7T8s2isbCfblrEozRiu7CzvjIweAfqg8lqOk4J/Y
         ufyg==
X-Gm-Message-State: AOUpUlH3Xq72pZXsGaHB+ARi60qLkj8EZ/l588OHlu2ultvK1ESrwEth
        AGOGqWE41r8c2WWZRdqoOXmXLODZxU9jXHjirkA=
X-Google-Smtp-Source: AA+uWPxeXPaCAdtRS+k47SBediTGgHfCWhiJERfXERX0Vsm9GgefKmHGOEAoibZN/zFk9+xwqiU/sqxzuxJ9jKMTPwI=
X-Received: by 2002:a19:6308:: with SMTP id x8-v6mr4245086lfb.104.1533896349734;
 Fri, 10 Aug 2018 03:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:3bd2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 03:19:08
 -0700 (PDT)
In-Reply-To: <20180810011249.GA82458@aiede.svl.corp.google.com>
References: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
 <20180809195845.GE32376@sigill.intra.peff.net> <20180810011249.GA82458@aiede.svl.corp.google.com>
From:   Bartosz Konikiewicz <izdwuut@gmail.com>
Date:   Fri, 10 Aug 2018 12:19:08 +0200
Message-ID: <CAAdU=LuXh6jo+pDPE-tisd_SoMhGjGL6kvm6X91Qsz1-XYD0wA@mail.gmail.com>
Subject: Re: What's the use case for committing both the freshly created file
 and it's exclusion in .gitignore?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 August 2018 at 21:58, Jeff King <peff@peff.net> wrote:
> If you are asking as a more general case: why do we not complain about
> .gitignore for files the index already knows about, then I think that is
> useful. It lets you override the .gitignore _once_ when adding the file
> initially, and then you don't have to deal with it again (and keep in
> mind that the pattern excluding it may be broad, like "*.o", or even
> just "*", so simply deleting it from the .gitignore is not an option).

This totally makes sense to me. Thanks for your explaination!

On 10 August 2018 at 03:12, Jonathan Nieder <jrnieder@gmail.com> wrote:
> "git help gitignore" has some notes about this.

Thanks! I wasn't aware of this. For some peculiar reason it didn't
strike me that the most appropriate place to look for
.gitignore-related stuff is - lo and behold - .gitignore manual page.
I was looking for clarification on 'git add' page, which I didn't find
informative enough in that aspect.

> If you have ideas
> about moments in interactive use where we could print some messages to
> make the behavior less surprising, that would be very welcome.

Sure I do! I have came up with two ideas which I believe that can be combined:

1.
>            staged     unstaged path
>   1:    unchanged        +1/-0 .gitignore !
>   2:        +0/-0      nothing excluded.txt
>
> ! Not ignoring yet untracked files.
>
> *** Commands ***
>   1: status       2: update       3: revert       4: add untracked
>   5: patch        6: diff         7: quit         8: help
> What now>

Here I propose to add an exclamation mark next to a .gitignore file
and reference it below. I am also thinking about marking files that
.gitignore affects. I think that any special character would be
appropriate. If I may only suggest, I wouldn't choose an asterisk (*)
because it's already used when a '2: update' option is chosen.

2.
>            staged     unstaged path
>   1:    unchanged        +1/-0 .gitignore
>   2:        +0/-0      nothing excluded.txt
>
> *** Commands ***
>   1: status       2: update       3: revert       4: add untracked
>   5: patch        6: diff         7: quit         8: help
> What now> q
> You are about to add new files that are excluded in .gitignore. Confirm y/n?
> What now>y
> Bye.

Here I ask the user to confirm that he is about to stage yet untracked
files. Then I cheer him up with Git built-in courtesy.
