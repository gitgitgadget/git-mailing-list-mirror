Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5591F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeCBUNL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:13:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35931 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932709AbeCBUNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:13:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id 188so5153924wme.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EZ+2nbkqC9uGntlI63GaPThaZEdxAavpkIEL4boJ80I=;
        b=vYoWSTUl7NP6DAPRlnbfZIdLA+TIku8K0bqPrafPMGbw1NCKUgeeJMHi1l3iktShc5
         hOOeyRA/vJuHApBZ6H8Ba+L5fmSExY7hYEMO3Dx4GzSrhq93qgxewBBpLhstCPuwNiXU
         8I4Fqyfj2qC7KmDVa1tGTijDZhv/jqyWecMK6ZktVpFJqNmKZ8qZ2xTsIaSnF/JDPn+q
         nZ0VyuIKZpB8axpaE/WMoZX4RKEvfSjk/v8liXREAmFU7ICXqOXaM0q+95pgzv+9yu3u
         CoUs0Dw/VfM1iroJbQriNQ0O2LM8+qT0FuoJtXW4u+wYIr/BInFtdRM6IlYBCweHHtU8
         ICYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EZ+2nbkqC9uGntlI63GaPThaZEdxAavpkIEL4boJ80I=;
        b=dnrW4yw/wIex48hQdQgvVPZdRFsZPuuXKPU0Ycyf7Ona6YsrehHFmFIt2vit7xUbDF
         ALNkklsTe+uRhG8GjYXFu2mJQHgV8KZgkrb92FEluY+v0X6DfxUE3JxKpsfQ4EqxBU3k
         86HlN9+tjmv2DG+a5tWrxwQcnvfXbJCs0B7HNuQVZndpKqZ3cdQVsqARAnvkFFo2iOPE
         lzqFFGaFWNVmAk0eAtMzzaBTpDg7n5GlhieEV8j46BHrXyezhBeMVeY4vhNb3oroxQ6C
         OVbgCKqrkJBxhxBTN8OCjGhHkJ7GB+uDJXy7igCPysAwiXO8Bldp+f0qXrkKeldjEhcn
         inxw==
X-Gm-Message-State: AElRT7Gg9zVdrbxSOQ87euiKK/4DU3M3eKAEOzMGW5M1TSSMcM8jsCW+
        9QIKwK/8ZdDyW7RhrQ2FgPSdaK9yaJHwyHswhSZF4Q==
X-Google-Smtp-Source: AG47ELvpPfnGiWy2eV9gH48tC72eYj3SexVn5ROpf02uAWjvDe2MlQ8zd6iKuzRiG/tfsrBKwhRIM4Sc43mTkHS+dHc=
X-Received: by 10.28.160.26 with SMTP id j26mr2299102wme.76.1520021588761;
 Fri, 02 Mar 2018 12:13:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.105.11 with HTTP; Fri, 2 Mar 2018 12:12:48 -0800 (PST)
In-Reply-To: <CAE5ih79z58jppHo6hNBuep+JTmjYP0cXGmtP2RZ5w2idauwSEA@mail.gmail.com>
References: <01020161d57a3c14-1177a79b-cc21-4d78-8bbd-b6650f7a6169-000000@eu-west-1.amazonses.com>
 <CAE5ih7-Uyk3fG3LXh2qnfEF1hV+n1wWexUcZ8SJ3=wKWgn4o6Q@mail.gmail.com>
 <CALdXDfcU0gApmfjRbxecGwEwDN1rP4PUqGhPmgbzTuhc3SiWBg@mail.gmail.com>
 <CAE5ih7-qTJbOYBnP=VPjTvriA9w_e-4DG472mVx-U=NoCRNObw@mail.gmail.com>
 <CALdXDfcdj+zqd=R2PXsZ0GhE=H+Q8UAr+8w8397_M8xH+5td+g@mail.gmail.com> <CAE5ih79z58jppHo6hNBuep+JTmjYP0cXGmtP2RZ5w2idauwSEA@mail.gmail.com>
From:   Nuno Subtil <subtil@gmail.com>
Date:   Fri, 2 Mar 2018 12:12:48 -0800
Message-ID: <CALdXDfcDG5WJf5ONyXss7hey_WJBj4BhuaaOPQC5=Sz1RNvQVA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Fix depot path stripping
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, that's where we left off. I owe you better testing of the
clientspec-side path remapping case, which I hope to get to soon. Will
get back to you as soon as I can.

Thanks,
Nuno


On Fri, Mar 2, 2018 at 2:09 AM, Luke Diamand <luke@diamand.org> wrote:
> On 27 February 2018 at 19:00, Nuno Subtil <subtil@gmail.com> wrote:
>> I originally thought this had been designed such that the p4 client spec
>> determines the paths, which would make sense. However, git-p4 still ignores
>> the local path mappings in the client spec when syncing p4 depot paths
>> w/--use-client-spec. Effectively, it looks as though --use-client-spec
>> always implies --keep-paths, which didn't seem to me like what was intended.
>>
>> For the use case I'm dealing with (syncing a p4 path but ignoring some
>> directories inside it), there seems to be no way today to generate a git
>> tree rooted at the p4 path location instead of the root of the depot, which
>> looks like a bug to me. I don't really understand the overall design well
>> enough to tell whether the bug lies in stripRepoPath or somewhere else, to
>> be honest, but that's where I saw the inconsistency manifest itself.
>
> I replied but managed to drop git-users off the thread. So trying again!
>
> The behavior is a touch surprising, but I _think_ it's correct.
>
> With --use-client-spec enabled, paths in the git repot get mapped as
> if you had used the file mapping in the client spec, using "p4 where".
>
> So, for example, if you have a client spec which looks like:
>    //depot/... //my_client_spec/...
>
> then you're going to get the full repo structure, even if you only
> clone a subdirectory.
>
> e.g. if you clone //depot/a/b/c then with "--use-client-spec" enabled,
> you will get a/b/c in your git repo, and with it not enabled, you will
> just get c/.
>
> If instead your client spec looks like:
>   //depot/a/b/... //my_client_spec/...
>
> then you should only get c/d. (And a quick test confirms that).
>
> I think Nuno's original question comes from wanting to map some files
> into place which the clientspec mapping emulation in git-p4 was
> possibly not handling - if we can get a test case for that (or an
> example) then we can see if it's just that the client mapping code
> that Pete put in is insufficient, or if there's some other way around.
> Or if indeed I'm wrong, and there's a bug! There may be some weird
> corner-cases where it might do the wrong thing.
>
> Thanks,
> Luke
>
>
>>
>> Nuno
>>
>>
>> On Tue, Feb 27, 2018 at 3:12 AM, Luke Diamand <luke@diamand.org> wrote:
>>>
>>> On 27 February 2018 at 08:43, Nuno Subtil <subtil@gmail.com> wrote:
>>> > The issue is that passing in --use-client-spec will always cause git-p4
>>> > to
>>> > preserve the full depot path in the working tree that it creates, even
>>> > when
>>> > --keep-path is not used.
>>> >
>>> > The repro case is fairly simple: cloning a given p4 path that is nested
>>> > 2 or
>>> > more levels below the depot root will have different results with and
>>> > without --use-client-spec (even when the client spec is just a
>>> > straightforward map of the entire depot).
>>> >
>>> > E.g., 'git p4 clone //p4depot/path/to/some/project/...' will create a
>>> > working tree rooted at project. However, 'git p4 clone --use-client-spec
>>> > //p4depot/path/to/some/project/...' will create a working tree rooted at
>>> > the
>>> > root of the depot.
>>>
>>> I think it _might_ be by design.
>>>
>>> At least, the test ./t9809-git-p4-client-view.sh seems to fail for me
>>> with your change, although I haven't investigated what's going on:
>>>
>>> $ ./t9809-git-p4-client-view.sh
>>> ...
>>> ...
>>> Doing initial import of //depot/dir1/ from revision #head into
>>> refs/remotes/p4/master
>>> ./t9809-git-p4-client-view.sh: 10: eval: cannot create dir1/file13:
>>> Directory nonexistent
>>> not ok 23 - subdir clone, submit add
>>>
>>> I think originally the logic came from this change:
>>>
>>>    21ef5df43 git p4: make branch detection work with --use-client-spec
>>>
>>> which was fixing what seems like the same problem but with branch
>>> detection enabled.
>>>
>>>
>>> >
>>> > Thanks,
>>> > Nuno
>>> >
>>> >
>>> > On Tue, Feb 27, 2018 at 12:10 AM, Luke Diamand <luke@diamand.org> wrote:
>>> >>
>>> >> On 27 February 2018 at 04:16, Nuno Subtil <subtil@gmail.com> wrote:
>>> >> > When useClientSpec=true, stripping of P4 depot paths doesn't happen
>>> >> > correctly on sync. Modifies stripRepoPath to handle this case better.
>>> >>
>>> >> Can you give an example of how this shows up? I could quickly write a
>>> >> test case for this if I knew what was going on.
>>> >>
>>> >> Thanks
>>> >> Luke
>>> >>
>>> >>
>>> >> >
>>> >> > Signed-off-by: Nuno Subtil <subtil@gmail.com>
>>> >> > ---
>>> >> >  git-p4.py | 12 +++++++++---
>>> >> >  1 file changed, 9 insertions(+), 3 deletions(-)
>>> >> >
>>> >> > diff --git a/git-p4.py b/git-p4.py
>>> >> > index 7bb9cadc69738..3df95d0fd1d83 100755
>>> >> > --- a/git-p4.py
>>> >> > +++ b/git-p4.py
>>> >> > @@ -2480,7 +2480,7 @@ def stripRepoPath(self, path, prefixes):
>>> >> >                      if path.startswith(b + "/"):
>>> >> >                          path = path[len(b)+1:]
>>> >> >
>>> >> > -        elif self.keepRepoPath:
>>> >> > +        if self.keepRepoPath:
>>> >> >              # Preserve everything in relative path name except
>>> >> > leading
>>> >> >              # //depot/; just look at first prefix as they all should
>>> >> >              # be in the same depot.
>>> >> > @@ -2490,6 +2490,12 @@ def stripRepoPath(self, path, prefixes):
>>> >> >
>>> >> >          else:
>>> >> >              for p in prefixes:
>>> >> > +               if self.useClientSpec and not self.keepRepoPath:
>>> >> > +                    # when useClientSpec is false, the prefix will
>>> >> > contain the depot name but the path will not
>>> >> > +                    # extract the depot name and add it to the path
>>> >> > so
>>> >> > the match below will do the right thing
>>> >> > +                    depot = re.sub("^(//[^/]+/).*", r'\1', p)
>>> >> > +                    path = depot + path
>>> >> > +
>>> >> >                  if p4PathStartsWith(path, p):
>>> >> >                      path = path[len(p):]
>>> >> >                      break
>>> >> > @@ -2526,8 +2532,8 @@ def splitFilesIntoBranches(self, commit):
>>> >> >              # go in a p4 client
>>> >> >              if self.useClientSpec:
>>> >> >                  relPath = self.clientSpecDirs.map_in_client(path)
>>> >> > -            else:
>>> >> > -                relPath = self.stripRepoPath(path, self.depotPaths)
>>> >> > +
>>> >> > +            relPath = self.stripRepoPath(path, self.depotPaths)
>>> >> >
>>> >> >              for branch in self.knownBranches.keys():
>>> >> >                  # add a trailing slash so that a commit into
>>> >> > qt/4.2foo
>>> >> >
>>> >> > --
>>> >> > https://github.com/git/git/pull/463
>>> >
>>> >
>>
>>
