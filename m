Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11E920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbdASUDU (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:03:20 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35275 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbdASUDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:03:18 -0500
Received: by mail-io0-f173.google.com with SMTP id j18so46633416ioe.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cti5IkxrABJx//RSrf0Ms+5LJccCS2oY4E3/EWR1Bqc=;
        b=AJqB3eZ5srFuGhCI5G1PkplFJ6FFvdVUO32K/ACv+Ix1JDFSiergiSwbKcfMcXclKd
         IG+hEeFkxkaAQfaS9D1syg4F1xtxlu+qjmFKvGD0Z3BPTA+ypcHoXjUzAZc97esJ9ayh
         GZxDvA4ZnRDeavsNt3ZBNkAaGvXAs7783MD6+RA/tS0Y1AiaR9ZVxfINPlaz+gsObJON
         9r6jJGLZ16GkEEln9j2Q4Iuo3sb+E56l79Ze0aCVv/MLFGed3Iw0gD+m7YEjwaBb9yro
         WNrGZFsoRFgrXpLOP81OudqT6MRGXjudYHARGQvsnv8n+iOMEi1EiacSRM96X4hG8hJP
         4pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cti5IkxrABJx//RSrf0Ms+5LJccCS2oY4E3/EWR1Bqc=;
        b=FyOd1wJB7akevKGQfZ9itmIAVFN8n/Pe64VzA86vj97DcB5WoN4rOTJzNk4JXOvRL2
         AqdE17toPIVJjM/gBp/AKO8jmuxzI46aB/ZrtjbXq+6sinnGHkSn865cOHrUcfghOxlJ
         QPVxX9vJs2QzfYZ59dr+XA3kMnooBOxGYtKtAR1ImimfKnm55eRmnDleUVuBwWYKO7Me
         gLqKA5fZtuldzQDb4VyWB1VuzFC0TWe4qiTnTuNjSOk9ZOU7miS7G+KSjy936nj0Eidm
         fFba74vG350XeyL8Avi0sy+KGgO8WPOMhfyeKCFonZlUk95FAjMzN4Zs+YEfaRRhyL2I
         RClg==
X-Gm-Message-State: AIkVDXIcCO7cAzNRxQ2OOGr5EYQh2GoidlcsR7aqxspq8yrpE30G/OlMJy+Xg/wcaKG4HPsoW+ioUhufSOxLbj9B
X-Received: by 10.107.37.148 with SMTP id l142mr9470325iol.159.1484856193208;
 Thu, 19 Jan 2017 12:03:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 19 Jan 2017 12:03:12 -0800 (PST)
In-Reply-To: <CACsJy8BHgc8o+SydeiVnqaZRCbkJEWVzqDZM4sgey04ZLtG3tQ@mail.gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com> <CAGZ79ka+zkr83tSkg_kJWoN1u3fgu1O3u1-7USEoSM1tj-53vA@mail.gmail.com>
 <CACsJy8BHgc8o+SydeiVnqaZRCbkJEWVzqDZM4sgey04ZLtG3tQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jan 2017 12:03:12 -0800
Message-ID: <CAGZ79kYy2q9ZMt8r7MdysuNOu84bY7uSUTGJXVxA1nnP-ZJW0Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Per-worktree config file support
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Max Kirillov <max@max630.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 4:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 11, 2017 at 12:01 AM, Stefan Beller <sbeller@google.com> wrot=
e:
>> On Tue, Jan 10, 2017 at 3:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> Let's get this rolling again. To refresh your memory because it's half
>>> a year since v4 [1], this is about letting each worktree in multi
>>> worktree setup has their own config settings. The most prominent ones
>>> are core.worktree, used by submodules, and core.sparseCheckout.
>>
>> Thanks for getting this rolling again.
>>
>>>
>>> This time I'm not touching submodules at all. I'm leaving it in the
>>> good hands of "submodule people". All I'm providing is mechanism. How
>>> you use it is up to you. So the series benefits sparse checkout users
>>> only.
>>
>> As one of the "submodule people", I have no complaints here.
>>
>>>
>>> Not much has changed from v4, except that the migration to new config
>>> layout is done automatically _update_ a config variable with "git
>>> config --worktree".
>>>
>>> I think this one is more or less ready. I have an RFC follow-up patch
>>> about core.bare, but that could be handled separately.
>>
>> I have read through the series and think the design is sound for worktre=
es
>> (though I have little knowledge about them).
>
> Submodules and multi worktrees start to look very similar, the more I
> think about it. Well, except that multi worktree does not separate odb
> and config files, maybe.

Similar to worktrees submodules can appear and disappear without
affecting the project/main tree. (though the mechanism is different,
for submodules, you'd checkout a version that doesn't have the submodule,
whereas for worktrees the user explicitely says: "I don't want to see this
worktree any more")

> And we have already seen both have a need to
> share code (like the moving .git dir operation). I suspect I'll learn
> more about submodules along the way, and you worktrees ;-)

I sure hope so.

>
>> Now even further:
>>
>> So to build on top of this series, I'd like to make submodules usable
>> with worktrees (i.e. shared object store, only clone/fetch once and
>> all worktrees
>> benefit from it), the big question is how to get the underlying data
>> model right.
>>
>> Would a submodule go into the superprojects
>>
>>     .git/worktrees/<worktree-name>/modules/<submodule-name>/
>>
>> or rather
>>
>>     .git/modules<submodule-name>/worktrees/<worktree-name>
>>
>> Or both (one of them being a gitlink file pointing at the other?)
>>
>> I have not made up my mind, as I haven't laid out all cases that are
>> relevant here.
>
> I would go with a conservative step first, keep submodules
> per-worktree. After it's sorted out. You can change the layout (e.g.
> as a config extension). The latter probably has some complication (but
> yeah sharing would be a big plus).

The sharing is what we are asked for as it would "make
submodules usable" (compared to the repo tool, which
doesn't have object sharing AFAIK). ;)

Currently I am leaning to put the worktree directory first and the
submodules within, i.e.

.git/worktrees/<worktree-name>/modules/<submodule-name>/

but in that directory, we'd only have the per-worktree
specific stuff, the object store would live with the superprojects
main worktree, i.e. at .git/modules/<submodule-name> we'd have
the main git dir for the submodule.

Thanks,
Stefan

> --
> Duy
