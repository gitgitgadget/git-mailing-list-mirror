Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3081FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 21:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbdJTVMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:12:06 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:48241 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdJTVMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:12:05 -0400
Received: by mail-qt0-f181.google.com with SMTP id f8so20081206qta.5
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2leO5EvONJvKHgFIniM5y3pHHSvx3IbBdJHCb3Jz2Tg=;
        b=q8uPuNO8AHNNEIxozBMi0qEBY4GspC21nFQIeDV091V6IPa3921XWG4JaZrbjsG7wv
         zSp4pkQuLoy+nPUiynojxL1ehWyAkDEpqVteznraxlCPV19lb98zkq9LREVw/pE5v9B7
         W3GQfq2ygwOoPfl9gvhrnJkjVWgWfEoI6W0ZsNJc7fQjp9XHt5r19foTBhZuXtewrrql
         ut6ET9TZ7xp5Pvzwa1lAxFfmGyl0GXZLesiHjguF6xNdGXepLzv/0QcKOC7ldh3+yagG
         Vsv2GcT9y0I0GvAgLBC9PQEc6N0VWAU2bCe8yw8eOlQxIVuX3jmPt1u4ETopz8heBm0g
         kLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2leO5EvONJvKHgFIniM5y3pHHSvx3IbBdJHCb3Jz2Tg=;
        b=l33XVu/BkgjrBMl5iJkSHMTjkVcfXut2znEKroDgfur4q9mpiD4S3kEOKiP77s332A
         XRj6WJSUdDEhXM0FzppvRcuHUWmXthF57UsKU1VxSKCCuEi5bSSTAZE/sf90XdVstKKB
         4zwX03tn/eOVaxqUIMKpzemfacHarUBKafUP3yAoJCFYkr1wq5yGCzPMmZLr0ok4Q4Jf
         C3KI5cKSlHAeaFxzMB2YoS/iy6LwHxvckEPQRedBQL6DeT5CZDpWN+bFU8cI+r5MLG6Y
         o1OUMAvNDdjCK9eRhVWE3b/Onrz08I9i7ieiIhih6M5D9zKtFZg0P/xJqqAHQYo7V//q
         Oi6A==
X-Gm-Message-State: AMCzsaWaMrTsJ/MpjwLei59JRI7nHH4TZ5/2TuDS/kZGfwAcIpx+ehbG
        5PD4ptY6VRoXymdLQUBbg9jPjbMnwsvoJXRDlDK4ceeRwX0=
X-Google-Smtp-Source: ABhQp+ToAne1IcRDjmjwOpzbAkYgnEqGqjG/DxpQbnhPIoAbrY2CbpMDaapX+KGbbRo3EGwUQzVQoUU8V2e6FqjPw2s=
X-Received: by 10.200.47.77 with SMTP id k13mr9011760qta.298.1508533924336;
 Fri, 20 Oct 2017 14:12:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 14:12:03 -0700 (PDT)
In-Reply-To: <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 14:12:03 -0700
Message-ID: <CAGZ79kYRq4OugvTfb2WNdk-M5DMAZC0JpJHqC1KSeJY2eNN1=Q@mail.gmail.com>
Subject: Re: [RFE] Add minimal universal release management capabilities to GIT
To:     nicolas.mailhot@laposte.net
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 3:40 AM,  <nicolas.mailhot@laposte.net> wrote:
> Hi,
>
> Git is a wonderful tool, which has transformed how software is created, a=
nd made code sharing and reuse, a lot easier (both between human and softwa=
re tools).
>
> Unfortunately Git is so good more and more developers start to procrastin=
ate on any activity that happens outside of GIT, starting with cutting rele=
ases. The meme "one only needs a git commit hash" is going strong, even inf=
ecting institutions like lwn and glibc (https://lwn.net/SubscriberLink/7364=
29/e5a8c8888cc85cc8/)

For release you would want to include more than just "the code" into
the hash, such as compiler versions, environment variables, the phase
of the moon, what have you, that may impact the release build.

> However, the properties that make a hash commit terrific at the local dev=
elopment level, also make it suboptimal as a release ID:
>
> =E2=80=93 hashes are not ordered. A human can not guess the sequencing of=
 two hashes, nor can a tool, without access to Git history. Just try to han=
dle "critical security problem in project X, introduced with version Y and =
fixed in Z" when all you have is some git hashes. hashing-only introduces s=
evere frictions when analysing deployment states.

It sounds to me as if you assume that if X, Y, Z were numbers (or
rather had some order), this can be easily deduced.
The output of git-describe ought to be sufficient for an ordering
scheme to rely on?
However the problem with deployments is that Y might be v1.8.0.1 and Z
might be v2.1.2.0 and X (that you are running) is v2.10.2.0.

> =E2=80=94 hashes are not ranked. You can not guess, looking at a hash, if=
 it corresponds to a project stability point, or is in a middle of a refact=
oring sequence, where things are expected to break. Evaluating every hash o=
f every project you use quickly becomes prohibitive, with the only possible=
 strategy being to just use the latest commit at a given time and pray (and=
 if you are lucky never never update afterwards unless you have lots of fix=
ing and testing time to waste).

That is up to the hash function. One could imagine a hash function
that generates bit patterns that you can use to obtain an order from.
SHA-1 that Git uses is not such a hash, but rather a supposedly secure
hash. One hash value looks like white noise, such that the entropy of
a SHA-1 object name can be estimated with 160 bits.

> =E2=80=93 commit mixing is broken by design.

In Git terms a repository is the whole universe.
If you want relationships between different projects, you need to
include these projects e.g. via subtree or submodules.
It scales even up to linux distributions (e.g.
https://github.com/gittup/gittup, includes nethack!)

> One can not adapt the user of a piece of code to changes in this piece of=
 code before those changes are committed in the first place. There will alw=
ays be moments where the latest commit of a project, is incompatible with t=
he latest commit of downsteam users of this project. It is not a problem in=
 developer environments and automated testers, where you want things to bre=
ak early and be fixed early. It is a huge problem when you follow the same =
early commit push strategy for actual production code, where failures are n=
ot just a red light in a build farm dashboard, but have real-world conseque=
nces. And the more interlinked git repositories you pile on one another, th=
e higher the probability is two commits won't work with one another with fa=
ilures cascading down

That is software engineering in general, I am not sure how Git relates
to this? Any change that you make (with or without utilizing Git) can
break the downstream world.

> =E2=80=93 commits are too granular. Even assuming one could build an auto=
mated regression farm powerful enough to build and test instantaneously eve=
ry commit, it is not possible to instantaneously push those rebuilds to eve=
ry instance where this code is deployed (even with infinite bandwidth, infi=
nite network reach and infinite network availability).

With infinite resources it would be possible, as the computers are
also infinitely fast. ;)

> Computers would be spending their time resetting to the latest build of o=
ne component or another, with no real work being done. So there will always=
 be a distance, between the latest commit in a git repo, and what is actual=
ly deployed. And we've seen bare hashes make evaluating this distance diffi=
cult
>
> =E2=80=93 commits are a bad inter-project synchronisation point. There ar=
e too many of them, they are not ranked, everyone is choosing a different c=
ommit to deploy, that effectively kills the network effects that helped mak=
ing traditional releases solid (because distributors used the same release =
state, and could share feedback and audit results).

There are different strategies. Relevant open source projects (kernel,
glibc, git) are pretty good at not breaking the downstream users with
every commit. So "no matter which version of X you use, it ought to
work fine".
If you want faster velocity, you have to couple the projects more
(submodules or a large repo including everything)

> One could mitigate those problems in a Git management overlay (and, indee=
d, many try). The problem of those overlays is that they have variable matu=
rity levels, make incompatible choices, cut corners, are not universal like=
 Git, making building anything on top of them of dubious value, with quick =
fallback to commit hashes, which *are* universal among Git repos. Release h=
andling and versioning really needs to happen in Git itself to be effective=
.

I am not convinced, yet. As said initially the release handling needs
to take more things into account (compiler version, hardware version
of the fleet, etc) which is usually not tracked in Git. Well you
could, but that is the job of the release management tool, no?

> Please please please add release handling and versioning capabilities to =
Git itself. Without it some enthusiastic Git adopters are on a fast traject=
ory to unmanageable hash soup states, even if they are not realising it yet=
, because the deleterious side effects of giving up on releases only get cl=
ear with time.
>
> Here is what such capabilities could look like (people on this list can p=
robably invent something better, I don't care as long as something exists).
>
> 1. "release versions" are first class objects that can be attached to a c=
ommit (not just freestyle tags that look like versions, but may be somethin=
g else entirely). Tools can identify release IDs reliably.

git tags ?

> 2. "release versions" have strong format constrains, that allow humans an=
d tools to deduce their ordering without needing access to something else (=
full git history or project-specific conventions). The usual string of numb=
ers separated by dots is probably simple and universal enough (if you start=
 to allow letters people will try to use clever schemes like alpha or roman=
 numerals, that break automation). There needs to be at least two numbers i=
n the string to allow tracking patchlevels.

git tags are pretty open ended in their naming. the strictness would
need to be enforced by the given requirement of the environment. (Some
want to have just one integer number going up; others want patch
levels, i.e. 4 ints; yet others want dates?)

> 3. several such objects can be attached to a commit (a project may wish t=
o promote a minor release to major one after it passes QA, versionning hist=
ory should not be lost).

Multiple git tags can be attached to the same commit. You can even tag
a tag or tag a blob.


> 4. absent human intervention the release state of a repo is initialised a=
t 0.0, for its first commit (tools can rely on at least one release existin=
g in a repo).

An initial repo doesn't have tags, which comes close to 0.

>
> 5. a command, such as "git release", allow a human with control of the re=
po to set an explicit release version to a commit. Git enforces ordering (r=
efuses versions lower than the latest repo version in git history). The mos=
t minor number of the explicit release is necessarily zero.
>
> 6. a command, such as "git release" without argument, allows a human to r=
equest setting of a minor patchlevel release version for the current commit=
. The computed version is:
>    "last release version in git history except most minor number"
>  + "."
>  + "number of commits in history since this version"
> (patchlevel versioning is predictable and decentralized, credits to Willy=
 Tarreau for the idea)
>
> 7. a command, such as "git release bump", allows a human to request setti=
ng of a new non-patchlevel release version. The computed version is
>    "last release version in git history except most minor number, increme=
nting the remaining most minor number"
>  + "."
>  + "0"
>
> 8. a command, such as "git release promote", allows a human to request se=
tting a new more major release version. The computed version is
>    "last release version in git history except most minor number, increme=
nting the next-to-remaining-most-minor-and-non-zero number, and resetting t=
he remaining-most-minor-and-non-zero number to zero"
>  + "."
>  + "0"

This sounds fairly specific to an environment that you are in, maybe
write git-release for your environment and then open source it. The
world will love it (assuming they have the same environment and
needs).


> 9. a command, such as "git release cut", creates a release archive, named=
 reponame-releaseversion.tar.xz, with a reponame-releaseversion root direct=
ory, a reponame-releaseversion/VERSION file containing releaseversion (so a=
utomation like makefiles can synchronize itself with the release version st=
ate), removing git metadata (.git tree) from the result. If the current com=
mit has several release objects attached the highest one in ordering is cho=
sen. If the current commit is lacking a release object a new minor patchlev=
el release version is autogenerated. Archive compression format can be over=
ridden in repo config.

git -archive comes to mind, doing a subset here.

> 10. a command, such as "git release translate", outputs the commit hash a=
ssociated to the version given in argument if it exists, the version associ=
ated to the commit hash given in argument if it exists, the version associa=
ted to the current commit without argument. If it is translating commit has=
hes with no version it outputs the various versions that could be computed =
for this hash by git release, git release bump, git release promote. This i=
s necessary to bridge developer-oriented tools, that will continue to talk =
in commit hashes, and release/distribution/security-audit oriented tools, t=
hat want to manipulate release versions
>
> 11. when no releasing has been done in a repo for some time (I'd suggest =
3 months to balance freshness with churn, it can be user-overidable in repo=
 config), git reminds its human masters at the next commit events they shou=
ld think about stabilizing state and cutting a release.

This is all process specific to your environment. Consider e.g. the
C++ standard committee tracking the C++ Standard in Git .
https://isocpp.org/std/the-committee
They make a release every 10 years or such, so 3 month is off!  Other
examples could be made for 3 month to be way too long.

> So nothing terribly complex, just a lot a small helpers to make releasing=
 easier, less tedious, and cheaper for developers, that formalize, automate=
, and make easier existing practices of mature software projects, making th=
em accessible to smaller projects. They would make releasing more predictab=
le and reliable for people deploying the code, and easier to consume by hig=
her-level cross-project management tools. That would transform the deployme=
nt stage of software just like Git already transformed early code writing a=
nd autotest stages.

Integrating with CI and release is definitely important, but Git
itself has no idea about the requirements and environments of the
project specifics, hence it is not developed a lot on that front.
For example the contribution process to git (as well as Linux) is done
via email and partially pull requests. These workflows have pretty
good integration in Git via "format-patch" and "request-pull". There
may be other workflows that are not as nicely integrated as they did
not come to mind to the Git developers.

Thanks,
Stefan


>
> Best regards,
>
> --
> Nicolas Mailhot
>
