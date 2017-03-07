Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856FC1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 17:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbdCGRaO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 12:30:14 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36283 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932896AbdCGRaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 12:30:10 -0500
Received: by mail-pf0-f171.google.com with SMTP id o126so3074929pfb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P14npgjDZmVcFHC3rDfQiTnu7O6yyQG02YeJt3sa1eU=;
        b=cTQgjm3zBP+8shd62cPWiSlYKcbkHOZHXfnXSEpNfxXCQu3GTczjOgLJ3Vkfamt3yD
         hLN++HGtLeWMIRM1eR9lSolTdHmIZGEboX4beJsGKp/7MlVjDYrqt6lR/Dk8/qojPPW6
         jf64rrepu7JkKIOHxqQkdeVDtna0o6KprKx5AlxE8mmcqLAjH3llY6gaJtB4YP38OiwI
         gPZ97P4oXqnScAh1vj+7H80k9BNuQWeu5LVumz391OESeuS1dr3lO1Da5IiYGte+U9F3
         FeHkUMM7qZuVl6GqIRS5Ntd0JH2tNZRTd4qrdBdjCX0Ng4wX6sUHUunL8UKRmm0lQte6
         jrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P14npgjDZmVcFHC3rDfQiTnu7O6yyQG02YeJt3sa1eU=;
        b=LhT1ScJBF/uBXGVGo6J1n/wxwFL4bxrsoeFmYeB+HRnmri31RJ7bq3ZwgFeokD4YR1
         mwXw7JW9XbIg9zFV4PwQwu3lWVZSkUALpJ35iJiTsB9v7kQX6/L7vWWj/Xl89du2Mglm
         xXCZFqRR4lVF4JCXp/1E8R6MCG1FjY6Vv52ZWPI5FnalN1iaNQZTKqz9+avLpScqKo6s
         PrK2yMf9+/b0wXr8sFYVX+r34xU5lEmCJZ8+d9naU3OwBZjgoA+AoYGd8u1qzoCrtAU4
         2YjW+3zPrc6bIu8fUsQzo3iGSAJEoup+RnAXNJir/tbA3ZDUOGMpRFR/riqn4Ai5g2WR
         Nccw==
X-Gm-Message-State: AMke39n6snN82bTzDlkDc51atudfZ+jjJN1FuFR9EtBJcMWQp2+sN/sXFKxbFY4o/oH1TpT/j4An8ZYGiBjyHh1V
X-Received: by 10.98.198.78 with SMTP id m75mr1591519pfg.160.1488907269233;
 Tue, 07 Mar 2017 09:21:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 09:21:08 -0800 (PST)
In-Reply-To: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
References: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 09:21:08 -0800
Message-ID: <CAGZ79kaYi1OLuOKvbCmDrMCq0fZnO2Ry7JML=Puwmx6TTtEYog@mail.gmail.com>
Subject: Re: [PATCH] t*: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 8:10 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Hi,
> I'm Prathamesh Chavan. As a part of my micropraoject I have been working on
> "Avoid pipes for git related commands in test suites".

Thanks for working on that microproject!

> I tried sending the
> patch, but it got blocked since the mail contained more than 100 000
> characters.

Yeah, even the github UI seems to have trouble with that commit.
(A bit slow, not showing the full content, but rather I needed to click
on "load diff" for tests files 7000+)

This is a lot of change (in terms of lines) for a micro project. :)
I'd have two competing advices:
* keep it micro first, e.g. just convert one file,
  send to list, wait for reviewers feedback and incorporate that
  (optional step after having done the full development cycle:
  convert all the other files; each as its own patch)
* split up this one patch into multiple patches, e.g. one
  file per patch, then send a patch series.

The outcome will be the same, but in the first you get feedback
quicker, such that hopefully you only need to touch the rest of
files after the first file just once.


> Hence I'll like to attach the link to my branch 'micro-proj', where I did the
> required changes.
>
> https://github.com/pratham-pc/git/tree/micro-proj

While I did look at that, not everyone here in the git community
does so. (Also for getting your change in, Junio seems to strongly prefer
patches on list instead of e.g. fetching and cherry-picking from your
github)

When looking at the content, the conversion seems a bit mechanical
(which is fine for a micro project), such as:
...
- test "$(git show --pretty=format:%s | head -n 1)" = "one"
+ test "$(git show --pretty=format:%s >out && head -n 1 <out)" = "one"
...

specifically for the "head" command I don't think it makes a
difference in correctness whether you pipe the file into the tool
or give the filename, i.e.  "head -n 1 out" would work just as fine.

There is a difference in readability, though. For consistency I'd
suggest to drop the "<", as the numbers might support:

$ cd t
$ git grep head |wc -l
# This also counts other occurrences of the string,
# not just the invocation of the head tool
2871
$ git grep head |grep "<" |wc -l
# same here
58

Another aspect might be performance at scale as the "<" will
let the shell open the file and pipe the content via stdin to the
head tool, whereas when giving a filename the head tool needs
to open the file. Both times the file doesn't need to be read completely,
but "head -n 1" can close the file handle early in the game.
I dunno.

Thanks,
Stefan

>
> Thanks.
