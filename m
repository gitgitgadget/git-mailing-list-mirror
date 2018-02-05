Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3296D1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeBEOk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 09:40:29 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33119 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeBEOk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 09:40:28 -0500
Received: by mail-lf0-f50.google.com with SMTP id t139so42084223lff.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ZtSAgcxeccYPgb4A2kExDYbMOA8VkQHr84hyaxbj3s=;
        b=ki+GYyRPAH9+Xal5VVOgVQyxyqbytfE2/y3tMdbD3c6kGy7paeMArez/j7eL+5yQ+s
         /4rcztsFhvhqeCllNK3rk3X2y9d8cWZvX6Dd9U4vv9kuqm3qRaLjyJLVJbDIK9HNmvei
         S7flqBKsUzsaygsoSXycHgiJ/1emOat6N8K3uXO5U7RpeSDw1/Fezd1aK1cexqnJUVUi
         W5UP4lLa2i66WTy8iF/RVq1Qim1fyGUKZXeEzbhPi/8LQecGQYGvNGdsPSFi/e9NUMgc
         PZoTbCNd1FjC4KmQoBSApKBJPNdrjnpzs6CmUXtzGOEaWzSnvpD05nMhsX8CDqWQhDb0
         CFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ZtSAgcxeccYPgb4A2kExDYbMOA8VkQHr84hyaxbj3s=;
        b=tzIJSboriuvHz9aMUJWB/D10XWIL+PcrFIQunmSUhSMJMqWXBPIc+J1eiVqm+VFWPA
         c91RpbmkmuFM+TSkdM8QaXavQVNzLBbzHJ0c1E/nMGaZfkOTaMl/xxMc01AULJ3c9KOd
         Ql3ai+Xf3h2U6s67ABsPQye2xaWdg1p/5jXfdTTc4CengZoGxk5SSjd6QcFxd+N90beP
         VP5nokFX9IDh86SYmHDyqmAkLiFJ9dvmNyer1iv3WFHwr34B02CROsrs3FYg0/13UGD1
         xzcgQW1tn1LkROEcHFsV78LJ3YEhmdUgqsCTflBFEq76zWJM6pW3uGotUdIKDKip5GJF
         GS/g==
X-Gm-Message-State: AKwxytf+Algdw3PdyIbpBJGg87CYPBgb6wsuUytSPyUcjzRl23QeoFE9
        arnlQdxAAbhRg4VRVqXTYWalNHvjlbMmJgaLSvM=
X-Google-Smtp-Source: AH8x227eWoG/Y3P8MeSP+tcTQB411PAwz4IUbigU+nx9yEcHUKtXzdwZv87JC0DRlLgIkA4FlP4n+KxDXsWhblitK3Q=
X-Received: by 10.46.95.209 with SMTP id x78mr26586055lje.30.1517841626499;
 Mon, 05 Feb 2018 06:40:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.44.11 with HTTP; Mon, 5 Feb 2018 06:40:25 -0800 (PST)
In-Reply-To: <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
 <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
 <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
 <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com> <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
 <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com> <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Mon, 5 Feb 2018 09:40:25 -0500
Message-ID: <CADfK3RV7qhh44kW-b+ageepmK3XYoV2917b1xmz7zP53wKYgAA@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Avery Pennarun <apenwarr@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 9:30 AM, Stephen R Guglielmo
<srguglielmo@gmail.com> wrote:
> On Wed, Jan 31, 2018 at 7:33 AM, Stephen R Guglielmo
> <srguglielmo@gmail.com> wrote:
>> On Tue, Jan 30, 2018 at 6:37 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>>> On Tue, Jan 30, 2018 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>> There has not been feedback for a while on this thread.
>>>>> I think that is because subtrees are not in anyone's hot
>>>>> interest area currently.
>>>>>
>>>>> This is definitely the right place to submit&discuss bugs.
>>>>> Looking through "git log --format="%ae %s" -S subtree",
>>>>> it seems as if Avery (apenwarr@gmail.com) was mostly
>>>>> interested in developing subtrees, though I think he has
>>>>> moved on. Originally it was invented by Junio, who is
>>>>> the active maintainer of the project in 68faf68938
>>>>> (A new merge stragety 'subtree'., 2007-02-15)
>>>>
>>>> Thanks for trying to help, but I have *NOTHING* to do with the "git
>>>> subtree" subcommand (and I personally have no interest in it).  What
>>>> I did was a subtree merge strategy (i.e. "git merge -s subtree"),
>>>> which is totally a different thing.
>>>>
>>>> David Greene offered to take it over in 2015, and then we saw some
>>>> activity by David Aguilar in 2016, but otherwise the subcommand from
>>>> contrib/ has pretty much been dormant these days.
>>>
>>> Strictly speaking, the 'git subtree' command does in fact use 'git
>>> merge -s subtree' under the covers, so Junio is at least partly
>>> responsible for giving me the idea :)
>>>
>>> I actually have never looked into how signed commits work and although
>>> I still use git-subtree occasionally (it hasn't needed any
>>> maintenance, for my simple use cases), I have never used it with
>>> signed commits.
>>>
>>> git-subtree maintains a cache that maps commit ids in the "original
>>> project" with their equivalents in the "merged project."  If there's
>>> something magic about how commit ids work with signed commits, I could
>>> imagine that causing the "no a valid object name" problems.  Or,
>>> git-subtree in --squash mode actually generates new commit objects
>>> using some magic of its own.  If it were to accidentally copy a
>>> signature into a commit that no longer matches the original, I imagine
>>> that new object might get rejected.
>>>
>>> Unfortunately I don't have time to look into it.  The git-subtree code
>>> is pretty straightforward, though, so if Stephen has an hour or two to
>>> look deeper it's probably possible to fix it up.  The tool is not
>>> actually as magical and difficult as it might seem at first glance :)
>>>
>>> Sorry I can't help more.
>>>
>>> Good luck,
>>>
>>> Avery
>>
>> Thanks all for the discussion/replies.
>>
>> We use subtrees extensively in our environment right now. The "sub"
>> repos (90+) are located on GitHub, while the "main/parent" repo is
>> provided by a vendor on website hosting infrastructure.
>>
>> I will take a look at:
>> git/Documentation/CodingGuidelines
>> git/Documentation/SubmittingPatches
>> git/contrib/subtree/
>>
>> Should I follow up in this thread with a patch (it might be a while)?
>>
>> Thanks!
>> Steve
>
> Hi all,
>
> It looks like I've found the cause of the issue. I have
> log.showsignature=true in my gitconfig. The toptree_for_commit()
> function calls `git log` and passes the output to `git commit-tree` in
> new_squash_commit(). Apparently commit-tree doesn't like GPG sigs.
>
> The fix was simple: --no-show-signature. However, I believe this was
> added in git v2.10.0, so it's not fully backwards compatible. I'm open
> to suggestions on a better fix if this is not acceptable.
>
> Thanks!
>
>
> https://github.com/srguglielmo/git/commit/822c8a45d049f86ea5c59c0b434303964e4e6f3d
>
>
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index cc033af73..dec085a23 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -475,7 +475,7 @@ squash_msg () {
>
>  toptree_for_commit () {
>         commit="$1"
> -       git log -1 --pretty=format:'%T' "$commit" -- || exit $?
> +       git log --no-show-signature -1 --pretty=format:'%T' "$commit"
> -- || exit $?
>  }
>
>  subtree_for_commit () {

Hey again,

Actually, to follow up on this, I added --no-show-signature to several
other locations. The above patch fixes the fatal, however the GPG sig
info is still included in the commit merge message for `subtree pull`.
This fixes that as well.

https://github.com/srguglielmo/git/commit/ebd2f628ddb960931aac5087c45a54b953976e99


diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index cc033af73..8126132dc 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -297,7 +297,7 @@ find_latest_squash () {
        main=
        sub=
        git log --grep="^git-subtree-dir: $dir/*\$" \
-               --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
+               --no-show-signature --pretty=format:'START
%H%n%s%n%n%b%nEND%n' HEAD |
        while read a b junk
        do
                debug "$a $b $junk"
@@ -341,7 +341,7 @@ find_existing_splits () {
        main=
        sub=
        git log --grep="^git-subtree-dir: $dir/*\$" \
-               --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+               --no-show-signature --pretty=format:'START
%H%n%s%n%n%b%nEND%n' $revs |
        while read a b junk
        do
                case "$a" in
@@ -382,7 +382,7 @@ copy_commit () {
        # We're going to set some environment vars here, so
        # do it in a subshell to get rid of them safely later
        debug copy_commit "{$1}" "{$2}" "{$3}"
-       git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
+       git log --no-show-signature -1
--pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
        (
                read GIT_AUTHOR_NAME
                read GIT_AUTHOR_EMAIL
@@ -462,8 +462,8 @@ squash_msg () {
                oldsub_short=$(git rev-parse --short "$oldsub")
                echo "Squashed '$dir/' changes from
$oldsub_short..$newsub_short"
                echo
-               git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
-               git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
+               git log --no-show-signature --pretty=tformat:'%h %s'
"$oldsub..$newsub"
+               git log --no-show-signature --pretty=tformat:'REVERT:
%h %s' "$newsub..$oldsub"
        else
                echo "Squashed '$dir/' content from commit $newsub_short"
        fi
