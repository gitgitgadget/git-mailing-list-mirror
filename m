Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A581F404
	for <e@80x24.org>; Mon,  5 Feb 2018 14:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeBEOaW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 09:30:22 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:43876 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBEOaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 09:30:20 -0500
Received: by mail-lf0-f54.google.com with SMTP id o89so42007098lfg.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f1SWBVzK98nZb73RzMoOyaOTQbTMSlFDM6b+HJbKS8A=;
        b=U1H3Vus3E9MiSTTKNq/FBVj8629WFQyK/1tiTTCyMPCvLw90eqznbsevXze7m2Unhh
         Py6no6Lv4VKusZlUIUQ/W6Juu2NLk6T4NFUSZ8tUII5ZDwBDLGn3L4+DAl1Miy8Gx2is
         ZWUQll+cup89KMOoMZ3e9NsYgGTdb4b3HfqRJKKMKHwPKhngVsOPPhv2igiuTCbUBG0w
         fWPhG5rcB+wJPBpF96DYgVpSxAw1UJVpTrnHIUL0we7Gx6KKqjc5u2Pu65l1uHzg0WQb
         U1NueaqbWVTH9QnLJijcxFUsWzmaj4CijeCpYb5PXq4Oo3LaZmGMEZBYLCnucNKh/ONZ
         WklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f1SWBVzK98nZb73RzMoOyaOTQbTMSlFDM6b+HJbKS8A=;
        b=jXDoCQ6znD35O8CBKEdBtuwIM6mWjF2wonUq2sNWgr0C8rZFLRq87ac8jytoMFCjuL
         lNUx92g6l5epu8q1m4j7FlGChwFXfhzuT8PfQp7Nj/0GYi2XEZoX+4xPdxH0e/TH+Pif
         n7P4DQqrEpGB88sUZN8KbShwTmhgHG1+X+xay4AknlI4jPF58giav4G/jCgjBYD37Wy3
         KERq+eZbaQ7/nslhA6UQhc22FHU7abuVsxicZI8SkWhUi6cWswH776i0jzD6oYrhxfZd
         ObXHvQyci21WNjDoplQzJT+EgZ1CL6+7SjoHqfTuwJ2pf+2YSd5WE/93STmVk95o/nIi
         A08A==
X-Gm-Message-State: AKwxytfNzPTCMUS7x2DmAytGF9P9ltDlRv/zAYVGPcpwTeN7McGIICa9
        40f1SNkbdzajM4jtTD3EkMmJMIvQKByWzgvZvJva6bM5
X-Google-Smtp-Source: AH8x226YTRy3+kuv4EYbZjbbaJ9QFGiaIWQwo5dZmfYP+2XvD0omyrQDb7UF5CUuqDNYxixKxQB+Eo08fOoBfftyDZ4=
X-Received: by 10.46.62.24 with SMTP id l24mr20501893lja.25.1517841018906;
 Mon, 05 Feb 2018 06:30:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.44.11 with HTTP; Mon, 5 Feb 2018 06:30:18 -0800 (PST)
In-Reply-To: <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
 <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
 <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
 <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com> <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
 <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Mon, 5 Feb 2018 09:30:18 -0500
Message-ID: <CADfK3RWAcb0m+m_U51JLA9tNyru_7XEsfy55i5EUsKh98jGFtA@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Avery Pennarun <apenwarr@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 7:33 AM, Stephen R Guglielmo
<srguglielmo@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 6:37 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>> On Tue, Jan 30, 2018 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>> There has not been feedback for a while on this thread.
>>>> I think that is because subtrees are not in anyone's hot
>>>> interest area currently.
>>>>
>>>> This is definitely the right place to submit&discuss bugs.
>>>> Looking through "git log --format="%ae %s" -S subtree",
>>>> it seems as if Avery (apenwarr@gmail.com) was mostly
>>>> interested in developing subtrees, though I think he has
>>>> moved on. Originally it was invented by Junio, who is
>>>> the active maintainer of the project in 68faf68938
>>>> (A new merge stragety 'subtree'., 2007-02-15)
>>>
>>> Thanks for trying to help, but I have *NOTHING* to do with the "git
>>> subtree" subcommand (and I personally have no interest in it).  What
>>> I did was a subtree merge strategy (i.e. "git merge -s subtree"),
>>> which is totally a different thing.
>>>
>>> David Greene offered to take it over in 2015, and then we saw some
>>> activity by David Aguilar in 2016, but otherwise the subcommand from
>>> contrib/ has pretty much been dormant these days.
>>
>> Strictly speaking, the 'git subtree' command does in fact use 'git
>> merge -s subtree' under the covers, so Junio is at least partly
>> responsible for giving me the idea :)
>>
>> I actually have never looked into how signed commits work and although
>> I still use git-subtree occasionally (it hasn't needed any
>> maintenance, for my simple use cases), I have never used it with
>> signed commits.
>>
>> git-subtree maintains a cache that maps commit ids in the "original
>> project" with their equivalents in the "merged project."  If there's
>> something magic about how commit ids work with signed commits, I could
>> imagine that causing the "no a valid object name" problems.  Or,
>> git-subtree in --squash mode actually generates new commit objects
>> using some magic of its own.  If it were to accidentally copy a
>> signature into a commit that no longer matches the original, I imagine
>> that new object might get rejected.
>>
>> Unfortunately I don't have time to look into it.  The git-subtree code
>> is pretty straightforward, though, so if Stephen has an hour or two to
>> look deeper it's probably possible to fix it up.  The tool is not
>> actually as magical and difficult as it might seem at first glance :)
>>
>> Sorry I can't help more.
>>
>> Good luck,
>>
>> Avery
>
> Thanks all for the discussion/replies.
>
> We use subtrees extensively in our environment right now. The "sub"
> repos (90+) are located on GitHub, while the "main/parent" repo is
> provided by a vendor on website hosting infrastructure.
>
> I will take a look at:
> git/Documentation/CodingGuidelines
> git/Documentation/SubmittingPatches
> git/contrib/subtree/
>
> Should I follow up in this thread with a patch (it might be a while)?
>
> Thanks!
> Steve

Hi all,

It looks like I've found the cause of the issue. I have
log.showsignature=true in my gitconfig. The toptree_for_commit()
function calls `git log` and passes the output to `git commit-tree` in
new_squash_commit(). Apparently commit-tree doesn't like GPG sigs.

The fix was simple: --no-show-signature. However, I believe this was
added in git v2.10.0, so it's not fully backwards compatible. I'm open
to suggestions on a better fix if this is not acceptable.

Thanks!


https://github.com/srguglielmo/git/commit/822c8a45d049f86ea5c59c0b434303964e4e6f3d



diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index cc033af73..dec085a23 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -475,7 +475,7 @@ squash_msg () {

 toptree_for_commit () {
        commit="$1"
-       git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+       git log --no-show-signature -1 --pretty=format:'%T' "$commit"
-- || exit $?
 }

 subtree_for_commit () {
