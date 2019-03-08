Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AA620248
	for <e@80x24.org>; Fri,  8 Mar 2019 15:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfCHPkv (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:40:51 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:44210 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHPku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:40:50 -0500
Received: by mail-vs1-f52.google.com with SMTP id r201so6892427vsc.11
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQhGFqDbHrwNbBr4cdkDfaomzqtXH50HRnVYV1b1nx4=;
        b=pR6zZIX7DUo5Da2cx9uyRQWhNMDnhcN87oGHA28ZlMjff+5YJMxktfbF1bcK5z9+y5
         OE7ZVXrxmOIkHxUgrvmb3RKcnOISUFlh3UmDArTp7kAUqZCBkM1DBH+ZrIhO1NXrN7Fs
         FA6sNbxAQh4eLfC4TRyuv8aDj2tyqjWoAhKRqdBp2bK5pvYGr+e3a+KHlFwnUn7XYU0C
         qAqWGIPVTWLJ84NYCplIHuhrzaYiHjOXxkPJpRkbQ8pFogk64C29qOfw+w9jmxV0WECW
         a+Nlj/DIV+6rv0O0IfNyGhJeHdp6BVJxdeVzOgk4cT1XqITrvJPbwiFH9y6zb2QH20Y+
         h1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQhGFqDbHrwNbBr4cdkDfaomzqtXH50HRnVYV1b1nx4=;
        b=Bs5nJ00OvsYByl/bhYfRmJ+LWtVK/V1cJW36qxqApPgtystjRYlnTTZvT0nCpI+F6P
         ZJoILdb0SSMsegSJUp/kzBSn+Yy2/lVFY4KVJftti5N6lS2/oq16QPmpW9/j8ZuHRmFw
         McFPYzElcKGFLmNUpBRzPHUlrV83f74k5uLw158+BeVZRIvKlo+AGPo/ibdRJdESsbAG
         LG68wrlwRnt/EQuFEPsOsKPGta+ItY/EsGdygDUr4ksj7MFijgxlF841ATSSidjbtcOT
         4+lxDH5PkUuB22FtzDiotM3cIGva/h6qWsh+WbO5TuXntchNvzCyiyJHE1LeEkyRlQ2Q
         Z9aQ==
X-Gm-Message-State: APjAAAW0ejFSu4kiiRFzL4G8gGXBwu8mleEiGIUWDN9vPX29nOwpkrAE
        O4b6nnoyOZe+LRd53y5hhnMftT7HI0BR80hJd5o=
X-Google-Smtp-Source: APXvYqzZcjZP/Fkm22a9Q2NmhPdFA9fY5EarL3Bj253FUkohU67tgC2fIHc1opKD/D3Caec41hkpByQpGWfu7y5ephk=
X-Received: by 2002:a67:fa46:: with SMTP id j6mr10242041vsq.117.1552059648938;
 Fri, 08 Mar 2019 07:40:48 -0800 (PST)
MIME-Version: 1.0
References: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
In-Reply-To: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Mar 2019 07:40:36 -0800
Message-ID: <CABPp-BF0PcdwpJR3NteCmQw0QhN3E0UAi22FvmjUc6SBr=UB_A@mail.gmail.com>
Subject: Re: fast-import on existing branches
To:     Norbert Nemec <Norbert.Nemec@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Norbert,

On Fri, Mar 8, 2019 at 2:51 AM Norbert Nemec
<Norbert.Nemec@microsoft.com> wrote:
>
> Hi there,
>
> I've struggled for quite some time to sort out documented, intended and a=
ctual behavior of git fast-import. Unless I'm completely mistaken, it seems=
 to be a straightforward bug, but if that is the case, I am really surprise=
d why nobody else has stumbled over it before:
>
> I managed to use fast-import for a chain of commits onto a new branch int=
o an empty repository.
> I managed to use fast-import to create a new branch starting from an exis=
ting parent using the 'from' command as documented.
>
> What I failed to do is to add commits on top of an existing branch in a n=
ew fast-import stream. As it seems, the variant of using 'commit' without '=
from' only works on branches that were created within the same fast-import =
stream!
>
> The different approaches I tried (each with new fast-import stream on exi=
sting repo with existing branch)
> * 'commit' without 'from'
> -> Error: "Not updating <branch> (new tip <hash> does not contain <hash>)
> And indeed looking into the repo afterwards, a new commit exists without =
any parent.
> * 'commit' with 'from' both naming the same branch
> -> Error: "Can't create a branch from itself"
> The only workarounds that I could find are to either explicitly looking u=
p the top commit on the target branch and hand that to fast-import or creat=
e a temporary branch with a different name.

I would have just used "from <sha1>" where <sha1> is something I look
up from the current branch I want to update.  But, re-looking at the
docs, it appears git-fast-import.txt covers this already with a
possibly easier syntax:

"""
The special case of restarting an incremental import from the
current branch value should be written as:
----
        from refs/heads/branch^0
----
The `^0` suffix is necessary as fast-import does not permit a branch to
start from itself, and the branch is created in memory before the
`from` command is even read from the input.  Adding `^0` will force
fast-import to resolve the commit through Git's revision parsing library,
rather than its internal branch table, thereby loading in the
existing value of the branch.
"""

Perhaps try that?

> Looking through the code of fast-import.c, I can indeed lookup_branch and=
 new_branch only deal with internal data structures and the only point were=
 read_ref is called to actually read existing branches from the repo is in =
update_branch to check whether the parent was set correctly. What is missin=
g is a call to read_ref in either lookup_branch or new_branch (probably bot=
h have to be reworked in some way to handle this cleanly). From all I can s=
ee a fix should be fairly straightforward to implement, but I am really not=
 sure whether I have the full picture on this.
>
> (I found all of this struggling with git-p4.py which appears to contains =
a complex and not fully correct mechanism to determine the 'initalParent' t=
hat appears to implement just such a workaround.)
>
> I would be grateful for any input on this issue! Greetings,
> Norbert

Hope that helps,
Elijah
