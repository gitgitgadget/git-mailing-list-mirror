Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E268D211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 23:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeK3Kot (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 05:44:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55567 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbeK3Kot (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Nov 2018 05:44:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 170BF22DEF;
        Thu, 29 Nov 2018 18:37:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Nov 2018 18:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=O8FUFzrraQhe5FLFCkzS8qrZFSEjCHq/vLksJ+fui
        44=; b=wocjB++rmRv/pwA4NXeeme4x6cMbmMlJYe0lFuJBJWkijTuNiKd4YjUwb
        RJFWtmdOeO14GOC6MGfbUN/sXtkrqGDYB4U1JtcFgBar/O0mmZA1KjrlAJaQyDrc
        IhrMC/evpSWJhx+RTbcmfJRVjEOIGvbdla4ZL5PPAabPd3OWcnS7cF6WBBoRpOqo
        U66X45cMwa64GXGnyi8gJnhA70Qt5x88QDqe0OnMZOrxCFmXtRQwKKjCLGpY0sjc
        fXpxZuU8n/uwCt4pIXaiROIxPe7emBBVCqdXfsON7ltsNPyHH3iUZwxhvmBsPM1A
        inMIxwH8cz4lBP3M7DDQ/DkthWxyw==
X-ME-Sender: <xms:O3gAXI-UOZHqY0C3xEXQt7qwe0j9Fu1iiGQjUX8rfpcCggVpby8I-g>
X-ME-Proxy: <xmx:O3gAXDv5WTfQPfuirEx5wVSK2-VgDF6Ja-QfrHtenO2q90kQvbOxTA>
    <xmx:O3gAXIJhD0tJN2miXYiBTOiMvQD7JYaOvS_wLHRFmVU4S4HTJD7sqw>
    <xmx:O3gAXAmrwq-YtRWW4NtIvuKWEdKpEjzrnkToEbVOwv6sxWU_5jAjDw>
    <xmx:O3gAXJJYxhmt4Wk-dA70FJ2futb64wBpv1slcN0uqXcgi9XVyPgGfg>
    <xmx:O3gAXF6xFNZLhMh-Kg6nGXTGzuNrJBN0ocY9MSjxlZ_03eB3S42e8Q>
    <xmx:PHgAXBOHK9D3PRbVwHPMtXh1MDYQmD_tvPQ6z6Zgf-NfhjRRzdOMHg>
Received: from dfab.attlocal.net (162-234-7-32.lightspeed.sntcca.sbcglobal.net [162.234.7.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id E47D71030E;
        Thu, 29 Nov 2018 18:37:29 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and
 restore-files
From:   Dan Fabulich <dan@fabulich.com>
In-Reply-To: <87pnunxz5i.fsf@evledraar.gmail.com>
Date:   Thu, 29 Nov 2018 15:37:26 -0800
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com,
        Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD1074BC-3745-4B86-8BDA-497110130BAD@fabulich.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
 <87pnunxz5i.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assuming the great day has come to think about this, one thing I'd love =
to do is to unify the name of the index/stage/cache in command-line =
parameters and the documentation.

The index/stage/cache should have one canonical name, and the =
documentation should support that consistently. My taste is to call it =
the "stage," but references to --index, --keep-index, --no-index, etc. =
are all over the code, as well as legacy references to "--cached".

* You can 'git rm --cached myfile' but you can't 'git rm --staged =
myfile' or 'git rm --index myfile'.

* You can 'git diff --no-index' or you can 'git diff --cached' with 'git =
diff --staged' as a synonym, deprioritized in the documentation =
("--staged is a synonym of --cached"). But you can't 'git diff --index' =
or 'git diff --no-stage' or 'git diff --no-cache'.

* You can 'git stage' but 'git help stage' is only one line long, =
declaring that it's a synonym for 'git add'. 'add' appears in the 'git =
help' common commands, but not 'git stage'. There's no built-in 'git =
unstage', and certainly no appetite for 'git index' or 'git cache'.

* Not to mention all of the plumbing commands: checkout-index, =
diff-index, index-pack, merge-index, show-index, and update-index.

My understanding based on historical threads is that changes like this =
would be unwelcome, even just to add synonyms and standardize the =
documentation around "stage" as the term (leaving the plumbing commands =
alone), but if documentation+synonym patches are welcome here, I'd be =
very enthusiastic.

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

