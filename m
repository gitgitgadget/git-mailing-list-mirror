Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A695C11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160A6207FD
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcTA/ta7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgBUAmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:42:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40002 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgBUAmw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:42:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so512957otr.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DOCpG9sLPGkAM3JbeDVBYO+3OJm2aqHXt8VObPfPmGM=;
        b=AcTA/ta7bvK1MxDmafKfEBboutRfp6YeUMu3K3FZjMT/0vXx/3CiWpchP5VGbt1az4
         +6usrhA+BwE+RfFhFHwbSR+VQyxUt9S4t810ZGD6AeBzKSMv1lPiYAOucZNmra3C25Wj
         q3Mi0Zkn75Lq0/GTnYyJajBU+7284Kc+TYoJZS1Ix3iYstB1p7cl/Rgrk9bUMKRzwJjE
         LDUzvEEE166Ie6frRZPNZiKX0qssfEYPKbKYOyP6TI788uGGFanuLDvsuyAJ0u3ds7kA
         ov/2Pf02ersIhJUvCykfsOyuyGAD7rL32DVWhDdDkpX9PJJ+JvaH4RFcf0CxUKFaQGpJ
         f1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DOCpG9sLPGkAM3JbeDVBYO+3OJm2aqHXt8VObPfPmGM=;
        b=DEYpXiXZJ95XJ+NvM0QG6MutT4L9g1EMvPSysbOo7RYYO99iGGhLkgynWFCGQPPMY7
         prrX1sfc/2ev4K9JQEDKZpeVf77QNcCLfTTqhheGYwEaJsOzZVKWlCDTYIhSALr49S98
         1nOG1vuIN7Xqi6e9vUnVmvwkbhOr3bHnPHeibwPB6n9K7726iACP1WCdJlRCL/vQw8vN
         chiT1N4wawb89PwRW83EjxyDkifr9bZDnn0S9fUZfucwNqZlwgr1brxOh4IBPF/EJAZe
         rOOXQRI5uYN0ic4fUToTp+75rQPiuoskU5S9DoeNJljE/s5tV2wms0yWJ5jBBh65Riqn
         0F7A==
X-Gm-Message-State: APjAAAVetwc6RTmIPnYMrrOaPJ/qZGuHhB0uWDRnqQFb0EZ3N0V1C/7c
        HWTpcwxHZH5syS6EXVOyqFF7TQH+4Yg0Uz4zGOg=
X-Google-Smtp-Source: APXvYqy9MgadEIDzOV6lms4q08rzCRV5RGVTzXeIiq1vjRtf6lC3UosFXvgYMBDzopR/qq7S9agkGLquwnbbiZDJCO8=
X-Received: by 2002:a9d:6e0d:: with SMTP id e13mr11565071otr.316.1582245770244;
 Thu, 20 Feb 2020 16:42:50 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
 <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <xmqqo8ts99pp.fsf@gitster-ct.c.googlers.com> <BL0PR2101MB108926E052DA3B9072AF9F1C80130@BL0PR2101MB1089.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB108926E052DA3B9072AF9F1C80130@BL0PR2101MB1089.namprd21.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 Feb 2020 16:42:38 -0800
Message-ID: <CABPp-BFyfc=wTnHJgVSCPYqSMdGGb-_1w9OVX0XzOkaZF9UPng@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Thu, Feb 20, 2020 at 3:52 PM Adam Milazzo <Adam.Milazzo@microsoft.com> w=
rote:
>
> > Simply because that is how users would expect how the world works (iow,=
 model things after what they are already familiar with).
>
> This seems to be an avoidance of my actual arguments about 1) the purpose=
 of "git clean" and what behavior best matches it, and 2) the violation of =
the general principle that if a tool invoked programmatically can fail, the=
n there should be a reasonable way for users to avoid the failure if possib=
le. But my response is:
>
> First, there is no obvious choice for what other tool to model "git clean=
" on, even assuming that it should be so modeled. This goes back to the pur=
pose of "git clean". Is it just a recursive delete? Or it bringing the dire=
ctory tree back to a certain state? I'd argue the latter, and if we want po=
int to existing tools I'd point to rsync, which has no problem deleting fil=
es from read-only directories if it's needed to bring a directory tree to t=
he desired state. It doesn't even give a warning about it.

I'm very sympathetic to the fact that "git clean" behavior might not
be optimal or even well defined[1][2][3].  I've recently done work in
the area, including even changing the existing behavior of some
commands, based on arguments about what should be correct behavior.
Some of that work languished for a year and a half, despite fixing
known bugs, because there were edge cases where I couldn't tell what
correct behavior was and no one else seemed to be able to answer
either.

[1] https://lore.kernel.org/git/20190917163504.14566-1-newren@gmail.com/
[2] https://lore.kernel.org/git/pull.676.v5.git.git.1576790906.gitgitgadget=
@gmail.com/
[3] https://lore.kernel.org/git/pull.692.v3.git.git.1579206117.gitgitgadget=
@gmail.com/

If you want to do something similar, I think you need to provide good
rationale for not only what you are trying to achieve, but explain the
edge cases and how to address probable future similar requests in a
way that make sense to someone who might try to implement it.  If I
were to try to implement your suggestion, I'm saying that your
descriptions are not at all clear to me in terms of how I should
handle edge cases and future related improvements that folks ask for,
not even if this is implemented as a new option.

For example, you talk about bringing the directory tree back to a
certain state -- does that mean git clean should also run 'git reset
--hard'?  I need a more precise model/description...

> Second, I doubt anybody here actually knows (i.e. has data demonstrating)=
 that users expect 'git clean' to behave like 'rm'. Also, I am a user, and =
it is not what _I_ expect. (And since some people here seem keen to dismiss=
 what I say based on an assumption of ignorance, I've been programming for =
30 years, using GNU/Linux, BSD, and other UNIX-like systems for almost 20 y=
ears, and using various source control systems for about as long. Not that =
that should carry any intrinsic weight in this discussion.)
>
> Comparing to "rm" again, there is an easy way for users of "rm" to avoid =
the error. Simply replace "rm -rf X" with "chmod -R u+w X; rm -rf X". What =
is the comparable workaround with "git clean"? There is none that I'm aware=
 of, and that's perhaps the main reason why it would be useful for "git cle=
an" to be able to handle it. If there is a reasonable workaround, what is i=
t? The best simple workarounds I've been able to come up with are:
>
> * For "git clean -fd": git status -s -uall | grep -E '^\?\?.*/$' | cut -c=
 4- | xargs -r chmod -R u+w; git clean -fd
> * For "git clean -fdx": git status -s -uall --ignored | grep -E '^\?\?.*/=
$' | cut -c 4- | xargs -r chmod -R u+w; git clean -fdx
> * For "git clean -fX": ??
> * For "git clean -f": ??

For every single case, why not just "chmod -R u+w $toplevel_dir"
followed by the git clean command in question, much like you did with
rm?

> These are not reliable because there are various conditions where they fa=
il (including ours), so I'm not sure they are viable approaches except in c=
ertain special cases. It's possible to handle all the possibilities with cu=
stom scripting, but the workarounds would become quite complex.
>
> So I ask again, if "git clean" won't have any option to handle it like rs=
ync does, what is the workaround that can be placed in a script to get the =
same behavior? And if there is no reasonable workaround, perhaps it is a us=
eful feature to have "git clean" try a little harder to delete the files, o=
r have an option to do so?

I think the single simple recursive chmod I mentioned above is a
reasonable workaround.

But since you are bringing up rsync as a comparison point...rsync also
affects ACLs, xattrs, devices and other special files, etc.  So, how
much harder is a little harder?  Is there a good mental model for that
being the right amount of harder, or do we just keep extending it
every time the command fails to clean something that users think we
could have wiped out?


Hope that helps,
Elijah
