Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA99220248
	for <e@80x24.org>; Mon,  8 Apr 2019 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDHJym (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 05:54:42 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37866 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHJym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 05:54:42 -0400
Received: by mail-qk1-f175.google.com with SMTP id c1so7548976qkk.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vY2ix+wN/T2O2tcImvNxPyqTBbz2ohuwMUp4VE5js8=;
        b=cKpMRzG5hWZsqJBh7xinbV0YDLBtZNgSCuL/getG5aUWrz5B1SsK5bKxEvJgVDC5LV
         eOXji+5sIq6uLz9jveJytLc3j2uZDAah7PVZIAciHbcKGfcDpfzJyZpclmYdgGnQsScp
         WGlnDwdsgh/gEXiLOoQTelA8z3gaId7Yuf5k1MzBDTV8Ej9nE9RvBe2cV1tfQBI2azJL
         8iJ3nDZ3WJuI19z/MPDYEy1BRfdXznxJfDxNT8jIuzGEdszFW4uXQPeIs8vVvoLeEkFs
         txXldyy+b4q87ciQOebi6aAE+wX8kPiybOD2TqipqO2ft+Zs7/Rjsfx5/GTXodrnomGY
         ZVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vY2ix+wN/T2O2tcImvNxPyqTBbz2ohuwMUp4VE5js8=;
        b=Np9rKS19wmhQR292bKJsdoSgQGEkqO3vuWx8r1fpTDlfY6GCu9mIBpmO+ktF5nUXNa
         P48zp9VCU05o3a8smlasHBMK5i4oXk7crQN1PZ7xWeO18v7x+wsCKml442l/0/Jq8HvH
         uC6TpC+XHC/PpyCBq91tp56BHF/XykMYFrER+OsONtfX6jEAcPoHjv9bfhkQo4pZ5Tua
         lMFlHHjs0Rsohezp0F2k6eHqLe+F21Fc1PNUr+EwDKV9BPy6pv47zDk38o8c5uDGKr7S
         /wH09yV/ENxisxCQwZdVHGwem1Cb3g4rPQvKfs0qE1TqTFDLVY+NWsWMDDysEmvZ6vHv
         SA3Q==
X-Gm-Message-State: APjAAAWPehEdVW2BZTEfkOKHB+snBi9tnlUuiaGFJyO/M3N0W68OkmXR
        Pxp4kmtsLLPlCSdKiCPqnog9Jw/lr99sNTxA5iM=
X-Google-Smtp-Source: APXvYqxuxWpgNBO6qJIJYVlpjGi6kh4+5y+ZPRp3Srgi991+oKI7d3FnGmP4yfvp9CB+xg4S8qInacJB0kxVSDsFgic=
X-Received: by 2002:ae9:f44a:: with SMTP id z10mr22214515qkl.223.1554717281427;
 Mon, 08 Apr 2019 02:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
 <8636mvng8n.fsf@gmail.com> <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Mon, 8 Apr 2019 11:54:29 +0200
Message-ID: <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
Subject: Re: "commit --author=..." does not work if global email and name is
 not set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 10:12 AM Junio C Hamano <gitster@pobox.com> wrote:
> You can still do
>
>  git -c user.name=me -c user.email=me@my.addre.ss commit ...
[...]
>   GIT_COMMITTER_NAME=me GIT_COMMITTER_EMAIL=me@my.addre.ss \
>   git commit --author=me ...
>
> even though it is not any shorter ;-).

There are a couple of problems with this approach:

1. it's long, as you mentioned
2. it's easy to make a mistake - misspell name or address
3. you need to remember the options/variable names ("-c", user.name
or GIT_COMMITER_NAME etc) - it's not user friendly

If you make a mistake you end up with two different identities in
history. Then e.g. searching for an author might not find all commits.


On Mon, Apr 8, 2019 at 8:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> Having slept on this a bit, I am of two minds here.
>
> It certainly is possible to change the rule to say that committer
> identity, when not set at all, takes the default from the author
> identity, if and only if the latter is explicitly given, and that
> would certainly make it work as Piotr wanted to.

Yes it would. But I understand your arguments too.

Maybe instead of changing how "--author" works, we could add
"--commiter" which works the same but for commiter, that is searches
for committer in history? Then I could do "git commit --commiter=me".

On the other hand this makes commiter somehow more important than
author. The "author" is more obvious to users I think. When both
author and commiter are the same, git shows the author only. In svn
(and I think also in mercurial) there is only "author".
So the first thought for users is "I should set the author", I
believe. At least it was like that for me. From this point of view, I
think the author should be more important. So I would prefer to be
able to use "git commit --author=me" and have it work, instead of
using "--commiter" which I believe is an implementation detail... I
don't want to set the commiter, I want to set the author of the
commit.

So another possibility: add "--user=me" which would set both(?) author
and commiter. I don't like that we would add another "idiom"
("author", "commiter", and now "user") but OTOH we already have
"user.name" and "user.email" configuration names.


> On Sat, Apr 6, 2019 at 8:25 PM Jakub Narebski <jnareb@gmail.com> wrote:
> > Better though is to focus on what you want, namely to prevent accidental
> > commits without specified author, instead of how you want to achieve it,
> > i.e. using --author to provide both author and committer identity (the
> > XY problem).  On that machine with "automatic test account" set up
> > pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
> > environment variable is not the "automatic test account".

I'm not sure if I follow you. I want to be able to make both "real
user" and "automatic test account user" commits from that machine. I
want to make sure that:
- automatic commits (scripts) use their own account
- real person making commit uses their own account

IMO the only way this can be achieved is by not having any default
account setup, so that both the scripts and the real users need to
specify it "by hand".


-- 
Piotr Krukowiecki
