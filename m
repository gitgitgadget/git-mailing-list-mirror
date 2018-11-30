Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0948F211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 00:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeK3LXp (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 06:23:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37981 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbeK3LXp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Nov 2018 06:23:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 595CF2432B;
        Thu, 29 Nov 2018 19:16:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 29 Nov 2018 19:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=NM60+O0+OjaetBgpMjbly7UYiBTfFhseQvpCwizxk
        Ik=; b=XQAXpf6PS4FzS0aT9fSavU9Z0LLVsbW1eeWa+5X3+OeRz/XIXIUpYK0Jq
        7zh+B0IsiC7oUXKaBSKqsiR46pGc5o04DV8LiQmVWxi6bSleedAr66SQPE+K6N3n
        0nt/PqhmOvqcLd+y+F5ptWpomVtS/Qr4rkAwzCLZ4Fh9c5mlLMJd2oYPr6g8NGVB
        QsvzQ6UBNJcOkaFO9Wb7PCLjTluxPXEAjWLYOEyU1t2BmXK5CZNZEU1kus4/OqG4
        8SkSV4KUBuNblu+QpwuDprMLeJb5fnNIp+0Xm9omMhY+15HBDFNIr5quaMpVx0o/
        iwhZebWOuAHwC8fxZgPuNkw/3NNTg==
X-ME-Sender: <xms:WIEAXJYNlIsA1F3s044LZteiNr4vlgHrQ0u_TNabWgJF6CBauKVv3g>
X-ME-Proxy: <xmx:WIEAXPoVK_L-Gv3XECz25OlLkHmnhe2az8qs5dkLVHhnF5VfsFbkgg>
    <xmx:WIEAXPAKemiYbX7LC6fWofrS1IXuE7g3aIIb_ipmBIgAU4Bsi17UPA>
    <xmx:WIEAXMYuN3KhDtLCPI-uObvfU093aNa995PIIGhe28W_AXlrJhgyAg>
    <xmx:WIEAXC5hH6thb8Mu7TSV47iRE8aYgCTn86gFiq8I1XZ9Jq7WcYiiSQ>
    <xmx:WIEAXNbetA0KVxdoIP9cT4k_a_dA8FqfkfbvVY0ZR6aHysZoHQ6EOQ>
    <xmx:WIEAXALQJLKs4TGuxzV3bRBg_9JwkVLyS-yeaiyVS2chCZYUsK243Q>
Received: from dfab.attlocal.net (162-234-7-32.lightspeed.sntcca.sbcglobal.net [162.234.7.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2863E40A1;
        Thu, 29 Nov 2018 19:16:22 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and
 restore-files
From:   Dan Fabulich <dan@fabulich.com>
In-Reply-To: <87pnunxz5i.fsf@evledraar.gmail.com>
Date:   Thu, 29 Nov 2018 16:16:18 -0800
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com,
        Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <340837B7-3004-44F7-9A30-BD3A26876D76@fabulich.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
 <87pnunxz5i.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other thoughts on a global UI rethink:

One of the most common complaints I hear about git is the conceptual =
difficulty required in undoing changes. https://ohshitgit.com/

> Git is hard: screwing up is easy, and figuring out how to fix your =
mistakes is fucking impossible. Git documentation has this chicken and =
egg problem where you can't search for how to get yourself out of a =
mess, unless you *already know the name of the thing you need to know =
about* in order to fix your problem.

A significant fraction of the top-voted questions on StackOverflow are =
about undoing changes. https://stackoverflow.com/questions/tagged/git

What if there were a 'git undo' command that could unify the answers to =
all of these questions?

git undo stage
git undo rm
git undo edit (checkout files from the stage)

git undo commit (prompt the user whether to revert or reset)
git undo reset
git undo checkout

git undo merge
git undo pull
git undo push (prompt the user whether to force push back to the past or =
whether to revert pushed commits)
git undo rebase

git undo undo

git undo clean
git undo delete-branch
git undo delete-stash

Some of these would be trivial effort, but a lot of them would require =
fundamental changes in the way git operates. (You can't undo a clean =
right now because the files are just destroyed.)

-Dan

> On Nov 29, 2018, at 3:05 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Thu, Nov 29 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>=20
>> v3 sees switch-branch go back to switch-branch (in v2 it was
>> checkout-branch). checkout-files is also renamed restore-files (v1 =
was
>> restore-paths). Hopefully we won't see another rename.
>>=20
>> I'll try to summarize the differences between the new commands and
>> 'git checkout' down here, but you're welcome to just head to 07/14 =
and
>> read the new man pages.
>>=20
>> 'git switch-branch'
>>=20
>> - does not "do nothing", you have to either switch branch, create a
>>  new branch, or detach. "git switch-branch" with no arguments is
>>  rejected.
>>=20
>> - implicit detaching is rejected. If you need to detach, you need to
>>  give --detach. Or stick to 'git checkout'.
>>=20
>> - -b/-B is renamed to -c/-C with long option names
>>=20
>> - of course does not accept pathspec
>>=20
>> 'git restore-files'
>>=20
>> - takes a ref from --from argument, not as a free ref. As a result,
>>  '--' is no longer needed. All non-option arguments are pathspec
>>=20
>> - pathspec is mandatory, you can't do "git restore-files" without any
>>  pathspec.
>>=20
>> - I just remember -p which is allowed to take no pathspec :( I'll fix
>>  it later.
>>=20
>> - Two more fancy features (the "git checkout --index" being the
>>  default mode and the backup log for accidental overwrites) are of
>>  course still missing. But they are coming.
>>=20
>> I did not go replace "detached HEAD" with "unnamed branch" (or "no
>> branch") everywhere because I think a unique term is still good to
>> refer to this concept. Or maybe "no branch" is good enough. I dunno.
>=20
> I finally tracked down
> =
https://redfin.engineering/two-commits-that-wrecked-the-user-experience-of=
-git-f0075b77eab1
> which I'd remembered reading and couldn't find again in these
> discussions. Re-reading it while one may not 100% agree with the
> author's opinion, it's an interesting rabbit hole.
>=20
> I also didn't know about EasyGit, or that Elijah Newren had written
> it. I haven't seen him chime in on this series, and would be =
interested
> to see what he thinks about it.
>=20
> Re the naming question in
> https://public-inbox.org/git/87o9abzv46.fsf@evledraar.gmail.com/ &
> seeing that eg-switch exists, I wonder if just s/switch-branch/switch/
> makes more sense.
>=20
> Assuming greenfield development (which we definitely don't have), I
> don't like the "restore-files" name, but the alternative that makes
> sense is "checkout". Then this "--from" argument could become "git
> checkout-tree <treeish> -- <pathspec>", and we'd have:
>=20
>    git switch <branchish>
>    git checkout <pathspec>
>    git checkout-tree <treeish> -- <pathspec>
>=20
> Or maybe that sucks, anyway what I was going to suggest is *if* others
> think that made sense as a "if we designed git today" endgame whether =
we
> could have an opt-in setting where you set e.g. core.uiVersion=3D3 (in
> anticipation of Git 3.0) and you'd get that behavior. There could be
> some other setting where core.uiVersion would use the old behavior (or
> with another setting, only warn) if we weren't connected to a =
terminal.
>=20
> I.e. I'm thinking of this as step #2 in a #3 step series. Where this =
is
> the fully backwards compatible UI improvement, but someone who'd
> e.g. use EasyGit or didn't have backwards compatibility concerns could
> enable step #3 and opt-in to a mode where we'd fixed a bunch of UI =
warts
> in a backwards-incompatible way.
>=20
> What would that mode look like? I'd to work on piling that on top of
> this :)

