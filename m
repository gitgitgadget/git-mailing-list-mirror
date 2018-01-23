Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532BD1F576
	for <e@80x24.org>; Tue, 23 Jan 2018 11:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeAWLwJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 06:52:09 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36970 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeAWLwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 06:52:08 -0500
Received: by mail-lf0-f52.google.com with SMTP id f3so263181lfe.4
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3iERquDJSlU9JL1tNpshij7CCM79plxceKxhIVpPlvg=;
        b=I5gIFZ/6kWXJP059AahfzlX6Ys6/zdSAz8FLI+6qeYE+Iczfk4I939q7A8o07XPzEW
         mYKSzMGN+FzfSU5fp0qAU7MY+MqXNR6eEe82/6iWOcxnpCxFnwUKinRgf82sT1v0g/B+
         fy+c8lBR4+3YhSYsGp4fIXNbtnP5M+zEgaL+/uus6x5JR35jVtvLxfoamts5MZbB+LvJ
         6+keOhja1XXchBcEMLJqATSg06u7pNuNe0yz7JaJbTRJ8G6Y3EZkiR31eY0PaTWpiQhP
         Ric6rUzcBaIK9dwJSGygNXREzc7Uk4lZenhGuwZ++M0iicVxEetjU2NJB7wdcyjJFbms
         OD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3iERquDJSlU9JL1tNpshij7CCM79plxceKxhIVpPlvg=;
        b=br8zh6mMG1+NE/d2jpzqw82vSv5dIQqqk/XJHEo+gKHHFiQAMUkYUF2lZjdsvJwPRS
         VqxQorHWVMkcqVAwwkM0+KNxboYEONZnNU9wuY72UVFIGfuJJwq0N4/fviZRP8oBoBN3
         XX3Dh/fGnVDEdDn1ENv4cf9c4kyNOuV5tBrCW5ne8WZYJQ2y31l7lkr63/siufbG7kjE
         t7QOkT8ObYlvka2di82cwP6UZgFSODS/bzVuWsBDfAcgMFLeJfdI2Gy6e12ifd5jiYWD
         214kw5GmokQNdMKhJoL4jGQ2U+sBxy7ONDUdUsgtMYwG1YwvP1ZQnr/SltjLTP2QVRAR
         QXlQ==
X-Gm-Message-State: AKwxytdP3ycoJebTqM69y8jV/KVJXgv/RtNlW8RnW36QQ5n5850vc2/o
        PQkx/irS6F7Dzt0s+vXQaDUYWpc3Ggoj44XlDZh/ycFzIts=
X-Google-Smtp-Source: AH8x224EJ1Z0M7KpLvZrKsAX+JDWb8eU+u47VozHnSkOLbbZFOZbxv52/YSfs1JdF/iLc4fD2u3D+UYzqRniDvN1g3U=
X-Received: by 10.25.228.13 with SMTP id b13mr1139874lfh.61.1516708327102;
 Tue, 23 Jan 2018 03:52:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.235.210 with HTTP; Tue, 23 Jan 2018 03:52:06 -0800 (PST)
In-Reply-To: <CAFAcib9FGfTe8C7TaOY91kzhUvxXtpx5Y8JMFkqxhRhLJeytxg@mail.gmail.com>
References: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
 <CABPp-BGYs9jo16OZR8NsL-eO9LwEttBxBspvp1-_JjuD2oBYbA@mail.gmail.com> <CAFAcib9FGfTe8C7TaOY91kzhUvxXtpx5Y8JMFkqxhRhLJeytxg@mail.gmail.com>
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Tue, 23 Jan 2018 11:52:06 +0000
Message-ID: <CA+WKDT3ZsObXc2ENV3gUXbMZU=McBJdiEpvk7y2OM0t+PrqZtQ@mail.gmail.com>
Subject: Re: git merge-tree: bug report and some feature requests
To:     Josh Bleecher Snyder <josharian@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 7:08 AM, Josh Bleecher Snyder
<josharian@gmail.com> wrote:
> Looking over your list above, at a minimum, libgit2 might not have a
> particularly good way to represent submodule/file or
> submodule/directory conflicts, because is-a-submodule is defined
> external to a git_index_entry.

libgit2 should detect submodule/file and submodule/directory
conflicts.

While, yes, some metadata about the submodule is located outside the
index, you can look at the mode to determine that this _is_ a
submodule.  You should be able to reliably detect submodule/file
conflicts because one will be a regular or executable file (mode
0100644 or 0100755), while the other entry at the same path will
be a gitlink (mode 0160000).

Similarly, submodule/directory conflict detection works just like
regular file/directory conflict detection.  If some path `foo` is
a submodule (or a regular file) then some path `foo/bar` existing
in the other side of the merge causes a conflict.

> Cataloging or special-casing all possible conflict types does seem
> unwise because of the sheer number of kinds of conflicts.
>
> But the alternative appears to be punting entirely, as libgit2 does,
> and merely providing something akin to three index entries.

Indeed, when I added merge to libgit2, we put the higher-level conflict
analysis into application code because there was not much interest in it
at the time.  I've been meaning to add this to `git_status` in libgit2,
but it's not been a high priority.

> This which
> leaves it unclear what exactly the conflict was, at which point any
> user (read: porcelain developer) will end up having to recreate some
> merge logic to figure out what went wrong. And if merge-tree starts
> doing rename detection, the user might then have to emulate that as
> well.

That's not a good idea.  Trying to figure out what merge did would be
painful at best, and likely impossible, since a rename conflict is
recorded in the main index without any way to piece it together.  eg:

100644 deadbeefdeadbeefdeadbeefdeadbeefdeadbeef 1       bar.c
100644 cafec4fecafec4fecafec4fecafec4fecafec4fe 2       bar.c
100644 c4cc188a892898e13927dc4a02e7f68814b874b2 1       foo.c
100644 71f5af150b25e3aaaad2d67ff46759311401036f 2       foo.c
100644 351cfbdd55d656edd2c5c995aae3caafb9ec11fa 3       rename1.c
100644 e407c7d138fb457674c3b114fcf47748169ab0c5 3       rename2.c

This is the main index that results when bar.c has a rename/edit
conflict, and foo.c also has a rename/edit conflict.  One was renamed
to rename1.c and the other to rename2.c.  Trying to determine which is
which _after the fact_ would be regrettable.  Especially since rename
detection is not static - you would need to know the thresholds that
were configured at the time merge was performed and try to replay
the rename detection with that.

libgit2 records a `NAME` section in the index that pairs the rename
detection decisions that it performed so that you can analyze them
and display them after the fact.

-ed
