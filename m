Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5681F859
	for <e@80x24.org>; Sat, 10 Sep 2016 16:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbcIJQbl (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 12:31:41 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33620 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbcIJQbi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 12:31:38 -0400
Received: by mail-qk0-f182.google.com with SMTP id w204so107199258qka.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X24Nl1IVi7Tqrsdqe9GAuyMPgdhLQUYw7mw93zUtkRM=;
        b=XlRIfOYYzTAPsZY1rh6Vowg2gPqRlSWOLAfwycQ2d7csV9dre1xe0BWmYakenDcif0
         sy04m0S3V6Vuk+Gug/Kwxjoi8YAjnnrmdjIs97T3ox8s+vW90NDCVuUFQ5QeGvEnnXrl
         5W+uW5HaicGQEfTZjsRRLtYaFBcoUr6I3oOM5X8Hhe39bgjkflHf3wCuWtWJwlk//J7b
         Tar5XjSaM1EZUwcHXU1pVc1SHSKep1qWt4vbjgGug9XZvT/xvAdRbY9vjyjgGtLRXQDC
         2PDTdJmEknYoCI8NJyhUXOJ8vV/6aPMMQADyGRtlWBy6uQgo/hl+Bovu+SYYKYsZHbLN
         hp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X24Nl1IVi7Tqrsdqe9GAuyMPgdhLQUYw7mw93zUtkRM=;
        b=eT8OwdRLaIaiboG2O5W1vCQsv7+HavklosVz8rq1rseEHkJDJy/l1nEoJfWFZkLxQo
         /9vpVNgGGA9Y/Sd643db3SaBwdGQO1YwOr8qVRa430c1asvj6ODnuxkawI4WF+IHandx
         zAIsnYYJ5e1wtKOTKkfAh2oNAqitMxoiEp2Y7bJ+StNA0uhs/13Jp6F2Ko5Cvs3tH+fr
         kpEUv07cu5FiVhGTHhk7bwWDiXOumTdpHV4gxYyXYaVgEFOxLdnW8lmGZ8JzcUa9hcrE
         x1BhYHbn8xQr7Wtv8e9h6Mq+GH8MIJ3FKc9Ft4LlvWW1iRzxmU/VfrhNyMteKBVBXObL
         mYoA==
X-Gm-Message-State: AE9vXwPyWEjInV87oYpJmZSLlYKzTQKQXUXRbvRnRXgrjF6+5ewKGa/1hhii4KNiAvrWaMIC6RIZrgI3TsgyIw==
X-Received: by 10.55.187.196 with SMTP id l187mr9948628qkf.178.1473525097321;
 Sat, 10 Sep 2016 09:31:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.49.227 with HTTP; Sat, 10 Sep 2016 09:31:36 -0700 (PDT)
In-Reply-To: <a00fa147-291c-536c-35da-56f88221e0f8@gmail.com>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de> <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
 <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com> <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
 <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com> <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
 <a00fa147-291c-536c-35da-56f88221e0f8@gmail.com>
From:   john smith <wempwer@gmail.com>
Date:   Sat, 10 Sep 2016 18:31:36 +0200
Message-ID: <CAKmQUfagUP6xia5_KjQ=pdtBzU2DHpV0=F1FGCh0P1yWNY5Hfw@mail.gmail.com>
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/10/16, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> You would need post-checkout hook together with clean / smudge filters
> (though you could get by without smudge filter, at least in theory...).
> The `post-checkout` hook could run e.g. "git checkout -- '*.conf'"
> to force use of smudge filter, after checking that it was a change
> of branch ("git checkout <commit-ish>").  See githooks(5) for details
> (last, third parameter passed to hook script is 1, rather than 0).

Neat idea.  I could still have an advantage of filter as git status
wouldn't show that files are changed and there would be no merge
conflicts and additionally filters would run after every checkout even
if files stayed the same.  But are sure that `git checkout -- <FILE>'
actually forces checkout and runs smudge filter?  It doesn't work for
me neither with 2.9.0 nor 2.10.0.85.gcda1bbd.  For a minimal example,
let's say that I have this in .gitattributes:

a     filter=3Dtest-filter

And this in .git/config:

smudge =3D touch /tmp/SMUDGE_RUN && cat

And also have a tracked file named `a' in the repository. Now this
should create /tmp/SMUDGE_RUN:

git checkout  -- a

but it doesn't.

This also doesn't work:

git checkout -f -- a

But this does:

git checkout HEAD^ && git co -

> Unfortunately I don't see a way to query .gitattributes files to
> find out all patterns that match specific attribute; you would need
> to duplicate configuration:
>
>   .gitattributes:
>   *.conf filter=3Dtransform
>
>   .git/config
>   [filter "transform"]
>   	clean  =3D replace-with-placeholder %f
>   	smudge =3D expand-with-branchname %f
>
>   .git/hooks/post-checkout
>   #!/bin/sh
>
>   test "$3" -eq "1" && git checkout -- '*.conf'

It's a secondary issue, but - in my repository I only have one .conf
file on every branch with real definitions of machine-specific
variables and a number of various config files for various programs
such as bash/.bashrc or screen/.screenrc so in my case it would be:

  .gitattributes:
  bash/.basrc filter=3Dtransform
  git/.gitconfig filter=3Dtransform
  (...)

  .git/config
  [filter "transform"]
        clean  =3D replace-with-placeholder %f
        smudge =3D expand-with-branchname %f

  .git/hooks/post-checkout
  #!/bin/sh

  test "$3" -eq "1" && (
       git checkout -- bash/.bashrc &&
       git checkout -- git/.gitconfig
       (...)
       )

Of course a list of files in .git/hooks/post-checkout could be
generated at runtime from first column of .gitattributes.

--=20
<wempwer@gmail.com>
