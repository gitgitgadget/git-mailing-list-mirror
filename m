Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B876D1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeB0LMV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:12:21 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43645 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeB0LMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:12:20 -0500
Received: by mail-ot0-f196.google.com with SMTP id m22so3391294otf.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 03:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T7tRmzhb/msZNyLJOPsPrIlPF0AqYuwmUtDyvaZO2Zs=;
        b=VYpx4VUQ7XSnoiH1OgWRueEjizxo2wIw2naKfm/kimummhzncFeQfOR8iPxH0UYVO5
         AMlrSAy1K66DNOQcSEsdSbJdUqwKypB/zEnm0q4RBw4zY6EWhFGLeRzt2L8/wjqV3CRj
         jGmsFtPhaYejEVjL78G5xWtzmLpG2xIIE78+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T7tRmzhb/msZNyLJOPsPrIlPF0AqYuwmUtDyvaZO2Zs=;
        b=DghxlOWe4OQCe6NeHvF3go361jPGzZGYaJqjl51sZaMyymGgVfHfPqxbhnPh7/9teW
         VDgWeGdb8RfwFxfXKFB8PEDTbiNDixAcQrKXlMYlN+/Y368OUrGy3NU2Jja5qfFEXkPs
         UgW1JbGqXQBUO1THFrcnbcF7TdAUOr/KjHuZtxy9PpqLRiLO2pYp6hHJVA9Pl1kWe8M9
         VAvn/T2OSGZMmbbG4t26z26C0KkC4hLj3pDfIgDERUTk6ViSbGdsw4mGvsnWyLT5XxuG
         zbuWPUbCZBz10BtW7VUQhN+MRWT1KEALtbl6DhkMeCCFhG/2fFhH7ghlA0Xs7kyCTw9V
         u8mA==
X-Gm-Message-State: APf1xPAqqD/SqwXarU28taaEboOrxQB+bYQ0SDg5OwLU2QxD1EWfhzmw
        3kpDH4egEWc3VEE26d36lbPg4qjVfoSQPUBkkaZkNg==
X-Google-Smtp-Source: AG47ELtLQxY60wgmZqwxm/RLU+xWFONmyUbZg3M8H/ESkJ6+/dRKYuHWOeGEttHHWU5buXSlN1tqEOdR78Q5hxlq0A0=
X-Received: by 10.157.14.5 with SMTP id c5mr10634525otc.314.1519729939256;
 Tue, 27 Feb 2018 03:12:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.52.146 with HTTP; Tue, 27 Feb 2018 03:12:18 -0800 (PST)
In-Reply-To: <CALdXDfcU0gApmfjRbxecGwEwDN1rP4PUqGhPmgbzTuhc3SiWBg@mail.gmail.com>
References: <01020161d57a3c14-1177a79b-cc21-4d78-8bbd-b6650f7a6169-000000@eu-west-1.amazonses.com>
 <CAE5ih7-Uyk3fG3LXh2qnfEF1hV+n1wWexUcZ8SJ3=wKWgn4o6Q@mail.gmail.com> <CALdXDfcU0gApmfjRbxecGwEwDN1rP4PUqGhPmgbzTuhc3SiWBg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 27 Feb 2018 11:12:18 +0000
Message-ID: <CAE5ih7-qTJbOYBnP=VPjTvriA9w_e-4DG472mVx-U=NoCRNObw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Fix depot path stripping
To:     Nuno Subtil <subtil@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 February 2018 at 08:43, Nuno Subtil <subtil@gmail.com> wrote:
> The issue is that passing in --use-client-spec will always cause git-p4 to
> preserve the full depot path in the working tree that it creates, even when
> --keep-path is not used.
>
> The repro case is fairly simple: cloning a given p4 path that is nested 2 or
> more levels below the depot root will have different results with and
> without --use-client-spec (even when the client spec is just a
> straightforward map of the entire depot).
>
> E.g., 'git p4 clone //p4depot/path/to/some/project/...' will create a
> working tree rooted at project. However, 'git p4 clone --use-client-spec
> //p4depot/path/to/some/project/...' will create a working tree rooted at the
> root of the depot.

I think it _might_ be by design.

At least, the test ./t9809-git-p4-client-view.sh seems to fail for me
with your change, although I haven't investigated what's going on:

$ ./t9809-git-p4-client-view.sh
...
...
Doing initial import of //depot/dir1/ from revision #head into
refs/remotes/p4/master
./t9809-git-p4-client-view.sh: 10: eval: cannot create dir1/file13:
Directory nonexistent
not ok 23 - subdir clone, submit add

I think originally the logic came from this change:

   21ef5df43 git p4: make branch detection work with --use-client-spec

which was fixing what seems like the same problem but with branch
detection enabled.


>
> Thanks,
> Nuno
>
>
> On Tue, Feb 27, 2018 at 12:10 AM, Luke Diamand <luke@diamand.org> wrote:
>>
>> On 27 February 2018 at 04:16, Nuno Subtil <subtil@gmail.com> wrote:
>> > When useClientSpec=true, stripping of P4 depot paths doesn't happen
>> > correctly on sync. Modifies stripRepoPath to handle this case better.
>>
>> Can you give an example of how this shows up? I could quickly write a
>> test case for this if I knew what was going on.
>>
>> Thanks
>> Luke
>>
>>
>> >
>> > Signed-off-by: Nuno Subtil <subtil@gmail.com>
>> > ---
>> >  git-p4.py | 12 +++++++++---
>> >  1 file changed, 9 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/git-p4.py b/git-p4.py
>> > index 7bb9cadc69738..3df95d0fd1d83 100755
>> > --- a/git-p4.py
>> > +++ b/git-p4.py
>> > @@ -2480,7 +2480,7 @@ def stripRepoPath(self, path, prefixes):
>> >                      if path.startswith(b + "/"):
>> >                          path = path[len(b)+1:]
>> >
>> > -        elif self.keepRepoPath:
>> > +        if self.keepRepoPath:
>> >              # Preserve everything in relative path name except leading
>> >              # //depot/; just look at first prefix as they all should
>> >              # be in the same depot.
>> > @@ -2490,6 +2490,12 @@ def stripRepoPath(self, path, prefixes):
>> >
>> >          else:
>> >              for p in prefixes:
>> > +               if self.useClientSpec and not self.keepRepoPath:
>> > +                    # when useClientSpec is false, the prefix will
>> > contain the depot name but the path will not
>> > +                    # extract the depot name and add it to the path so
>> > the match below will do the right thing
>> > +                    depot = re.sub("^(//[^/]+/).*", r'\1', p)
>> > +                    path = depot + path
>> > +
>> >                  if p4PathStartsWith(path, p):
>> >                      path = path[len(p):]
>> >                      break
>> > @@ -2526,8 +2532,8 @@ def splitFilesIntoBranches(self, commit):
>> >              # go in a p4 client
>> >              if self.useClientSpec:
>> >                  relPath = self.clientSpecDirs.map_in_client(path)
>> > -            else:
>> > -                relPath = self.stripRepoPath(path, self.depotPaths)
>> > +
>> > +            relPath = self.stripRepoPath(path, self.depotPaths)
>> >
>> >              for branch in self.knownBranches.keys():
>> >                  # add a trailing slash so that a commit into qt/4.2foo
>> >
>> > --
>> > https://github.com/git/git/pull/463
>
>
