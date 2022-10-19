Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA854C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 18:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJSSxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJSSxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 14:53:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2454196B57
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 11:53:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CCB013E25A;
        Wed, 19 Oct 2022 14:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pax06JCyVtOp
        hlpBs0KcD3nr4kxRApQBlnjaAXFqCxY=; b=f/3qNSyEKFcMzxCs2a0ylYCDusi+
        JUv3haYrifkxnmiMwTHx0DNyFW3iQtw2zMvquM8ysov13jvehbkxNwEVM/mwouLt
        kK3oHZmf1qKX9i88zRIEN3bGq/ojlgbcJ4R3ZdwOyeKFI+GJgbXrFFDsA9JKTOaF
        lSzvfAtEWibxLyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13A1C13E259;
        Wed, 19 Oct 2022 14:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7898013E256;
        Wed, 19 Oct 2022 14:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
        <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
Date:   Wed, 19 Oct 2022 11:53:18 -0700
In-Reply-To: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com> (Julia
        Ramer via GitGitGadget's message of "Wed, 19 Oct 2022 01:16:00 +0000")
Message-ID: <xmqqa65rr6g1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C524C56-4FDF-11ED-9F93-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Ramer <gitprplr@gmail.com>
>
> With the recent turnover on the git-security list, questions came up ho=
w
> things are usually run. Rather than answering questions individually,
> extend Git's existing documentation about security vulnerabilities to
> describe the git-security mailing list, how things are run on that list=
,
> and what to expect throughout the process from the time a security bug
> is reported all the way to the time when a fix is released.
>
> Signed-off-by: Julia Ramer <gitprplr@gmail.com>
> ---

Thanks for an update that is excellently written.

I had only some minor points and random thoughts while reading it.
I do not know if all of them need to result in further changes to
the document, though.

 + The 'stakeholders' are explained twice in a bit different terms.
   The former (owners of products affected by vulnerabilities)
   description is more broad than the latter and would be more
   appropriate in general.  Perhaps dropping the latter would give
   us more clarity?

 - Would a reader, who has "stake" in the healty and secure Git, be
   helped if we spell out that they are welcome to ask joining the
   security list and how?  It feels a bit too obvious after reading
   "anybody may contact", which is both the right way to self
   nominate for the membership and the natural thing I expect such a
   reader would do, so we may not need to.

 + The packager whose release artifacts can be exchanged among
   security list participants under embargo is not limited to Git
   for Windows, even though we've only seen exchanges between
   Victoria and Veronica this cycle for that particular
   distribution.

 - The world is not limited to only Windows, mac and Linux.  Windows
   is not all that special.

 + The project maintainer is special in only two ways (tagging and
   producing release tarballs); in all the other contexts, treat him
   just like any other contributors.

 - There may be ways to improve on the lack of formal process to
   record decisions (e.g. a capable project secretary can notice
   that stakeholders agreed on a proposed release date, and send a
   separate message summarizing only that fact so that it would not
   be missed by casual bystanders), but that is something we should
   work on elsewhere, not as part of the effort to document the
   current practice.

 - I wonder if we want to record the name that is used to refer to
   the "private repository controlled by the project" on the
   security mailing list somewhere in the documentation.  If you are
   a stakeholder, being on the mailing list *and* having access to
   that repository are two things we need to make sure you have to
   partcipate in the coordinated embargoed releases.

 + Usually the fixes affect 'maint' and its tip is pointed by one of
   the tags for the security update release, and 'master' is updated
   to contain 'maint', but on the 'master' track there is no tag for
   the security update.  Other integration branches like 'next' and
   'seen' are also updated to contain the fix.

 + The "How we coordinate embargoed releases" section looked a bit
   odd to appear this late in the document.  Shouldn't it be moved
   way higher, even before we start talking about the security list?
   After all, the security mailing list is a means to the end that
   the section talks about (i.e. we sometimes need embargoed release
   process working behind closed doors).

Here is a patch that summarises some of the above on top of your
patch.  I only tried to address the bullet items with "+" in front
in the above list.


 .../howto/coordinate-embargoed-releases.txt        | 52 ++++++++++++----=
------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git c/Documentation/howto/coordinate-embargoed-releases.txt w/Docu=
mentation/howto/coordinate-embargoed-releases.txt
index a01398c82b..80af5de297 100644
--- c/Documentation/howto/coordinate-embargoed-releases.txt
+++ w/Documentation/howto/coordinate-embargoed-releases.txt
@@ -3,6 +3,15 @@ Abstract: When a vulnerability is reported, we follow th=
ese guidelines to
  assess the vulnerability, create and review a fix, and coordinate embar=
goed
  security releases.
=20
+How we coordinate embargoed releases
+------------------------------------
+
+To protect Git users from critical vulnerabilities, we do not just relea=
se
+fixed versions like regular maintenance releases. Instead, we coordinate
+releases with packagers, keeping the fixes under an embargo until the re=
lease
+date. That way, users will have a chance to upgrade on that date, no mat=
ter
+what Operating System or distribution they run.
+
 The `git-security` mailing list
 -------------------------------
=20
@@ -50,10 +59,11 @@ A bug's life: Typical timeline
=20
 - A bug is reported to the `git-security` mailing list.
=20
-- Within a couple of days, someone from the core Git team responds with =
an
-  initial assessment of the bug=E2=80=99s severity.
+- Within a couple of days, someone from the core Git team, including
+  the Git maintainer, responds with an initial assessment of the
+  bug=E2=80=99s severity.
=20
-- Other core developers - including the Git maintainer - chime in.
+- Other core developers chime in.
=20
 - After discussion, if consensus is reached that the bug is not critical=
 enough
   to warrant any embargo, the reporter is redirected to the public Git m=
ailing
@@ -74,9 +84,11 @@ A bug's life: Typical timeline
   the patches are ready, the Git maintainer, and others determine a rele=
ase date
   as well as the release trains that are serviced. The decision regardin=
g which
   versions need a backported fix is based on input from the reporter, th=
e
-  contributor who worked on the patches, and from stakeholders (e.g. ope=
rators
+  contributor who worked on the patches, and from stakeholders.   Operat=
ors
   of hosting sites who may want to analyze whether the given bug is expl=
oited
-  via any of the repositories they host).
+  via any of the repositories they host, and binary packagers who want t=
o
+  make sure their product gets patched adequately against the vulnerabil=
ity,
+  for example, may want to give their input at this stage.
=20
 - While the Git community does its best to accommodate the specific time=
line
   requests of the various binary packagers, the nature of the issue may =
preclude
@@ -90,18 +102,19 @@ A bug's life: Typical timeline
 - The tags are created by the Git maintainer and pushed to the same
   repositories.
=20
-- The Git for Windows, Git for macOS, BSD, Debian, etc maintainers prepa=
res the
+- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers prep=
ares the
   corresponding release artifacts, based on the tags created that have b=
een
   prepared by the Git maintainer.
=20
-- Git for Windows release artifacts are made available under embargo to
-  stakeholders via a mail to the `git-security` list.
+- The release artifacts prepared by various binary packagers can be
+  made available to stakeholders under embargo via a mail to the
+  `git-security` list.
=20
 - Less than a week before the release, a mail with the relevant informat=
ion is
   sent to <distros@vs.openwall.org> (see below), a list used to pre-anno=
unce
   embargoed releases of open source projects to the stakeholders of all =
major
-  Linux distributions. This includes a Git bundle of the tagged version(=
s), but
-  no further specifics of the vulnerability.
+  distributions of Linux as well as other OSes. This includes a Git bund=
le
+  of the tagged version(s), but no further specifics of the vulnerabilit=
y.
=20
 - Public communication is then prepared in advance of the release date. =
This
   includes blog posts and mails to the Git and Git for Windows mailing l=
ists.
@@ -117,8 +130,8 @@ A bug's life: Typical timeline
 - Git for Windows release is then announced via a mail to the public Git=
 and
   Git for Windows mailing lists as well as via a tweet.
=20
-- Ditto for Linux distribution packagers: their releases are announced v=
ia
-  their preferred channels.
+- Ditto for distribution packagers for Linux and other platforms:
+  their releases are announced via their preferred channels.
=20
 - A mail to <oss-security@lists.openwall.org> (see below for details) is=
 sent
   as a follow-up to the <distros@vs.openwall.org> one, describing the
@@ -127,17 +140,8 @@ A bug's life: Typical timeline
 Note: The Git project makes no guarantees about timelines, but aims to k=
eep
 embargoes reasonably short in the interest of keeping Git's users safe.
=20
-How we coordinate embargoed releases
-------------------------------------
-
-To protect Git users from critical vulnerabilities, we do not just relea=
se
-fixed versions like regular maintenance releases. Instead, we coordinate
-releases with packagers, keeping the fixes under an embargo until the re=
lease
-date. That way, users will have a chance to upgrade on that date, no mat=
ter
-what Operating System or distribution they run.
-
-Open a Security Advisory draft
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Opening a Security Advisory draft
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 The first step is to https://github.com/git/git/security/advisories/new[=
open
 an advisory]. Technically, this is not necessary. However, it is the mos=
t
@@ -239,4 +243,4 @@ it goes to <developer>.
=20
 Thanks,
 <name>
-....
\ No newline at end of file
+....
