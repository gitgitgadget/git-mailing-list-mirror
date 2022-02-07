Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E84C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiBGHG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiBGGvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 01:51:37 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85322C043181
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 22:51:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8928174977;
        Mon,  7 Feb 2022 01:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Lc6nNWHLGSiv6nGppo9d54vlA
        7z1QHgvxDJO9L0qoJU=; b=rca8X1sajldqAZ7k9eJBFQ8ZvlxYNbl1PCmnczrKK
        q+iYk32o9aaaW2R2rEFWoA8lhockUKt0Val3IReoarDEVaV8TQSQy8+4aMBjAsTU
        T6htvXYN4f6YbzfGGUPSpxVh0GXzPzKpJNRO8+m7j1/l1dwDXSPOOfA0fxPkfqUA
        dU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A168C174976;
        Mon,  7 Feb 2022 01:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06002174975;
        Mon,  7 Feb 2022 01:51:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] clarify licensing terms for .git/hooks/*.sample files
Date:   Sun, 06 Feb 2022 22:51:30 -0800
Message-ID: <xmqqzgn3185p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6221F902-87E2-11EC-8DC0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a new repository is created by end-user, the template material
are copied from /usr/share/git-core/templates directory, including
sample hook scripts.

As the source code of Git itself is licensed under GPL-2.0, by
default, these come under the same license.  Some end-users may
worry that this might "contaminate" their project's licensing
status.

Let's add some text to clarify _our_ intention.

What is added is merely a draft for discussion.  The commit
references and author idents point at the right commits and people
whose input matters in today's contents of each file and we'll have
to contact them and have them agree what license they want to have
the current contents of the file under.

I am contemplating to relicense all my work under templates/hooks--*
under either MIT or BSD-3-Clause, but some sample hooks do not have
my input and the choice of course will be up to their authors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 cf. https://lore.kernel.org/git/xmqqbl07mrp3.fsf@gitster.g/

 templates/hooks--LICENSE | 256 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)
 create mode 100644 templates/hooks--LICENSE

diff --git a/templates/hooks--LICENSE b/templates/hooks--LICENSE
new file mode 100644
index 0000000000..f6834f312b
--- /dev/null
+++ b/templates/hooks--LICENSE
@@ -0,0 +1,256 @@
+The *.sample hook scripts installed in this repository have been
+copied from Git source code by "git init".  Because Git itself as a
+whole is licensed under the GPL-2.0 license [*1*], some people have
+raised concerns if these scripts somehow contaminate the contents
+developed by the end users and stored in their repository.
+
+While we, Git developers, are not your lawyers, we believe the
+presence of these sample hook scripts in your repository does not
+constitute "distribution" that makes the contents tracked in your
+repository governed also under the same license as ours, but it would
+be a good idea to clarify that
+
+ * We do not intend to spread the license of Git to your contents by
+   copying the sample hook scripts.
+
+ * These sample hook scripts may be under licenses other than GPL-2.0.
+
+The list below describes under which open-source license each sample
+hook script is licensed.
+
+----
+
+NEEDSWORK:
+
+Below are draft entries that do show correct commit object names that
+matter to, or contributors who write, the surviving contents of the
+file, but these people haven't been asked to do anything yet (hence
+they haven't responded yet, of course), so they do not show what the
+licensing status of these files will be at the end of this exercise
+yet.
+
+What I am hoping to achieve is to replace the text under each bullet
+point to document who the authors/copyright holders are of the file,
+and under what license the copy given to each end-user repository is
+usable by the end-user.  It would be more useful if the license chosen
+(which can be different per file) is more lenient than strict.
+
+----
+
+
+* applypatch-msg.sample
+
+    This sample hook script was written in 2005 by Junio C Hamano, who
+    hereby clarifies that the contents of these files, when used as a
+    hook script installed by "git init", or manually copied by the
+    user, is licensed under the MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version, will be asked to
+    endorse this clarification later.
+
+    Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
+    b849b954d22ee069b0edec1a12c78782ae1e629d (adjust for newer Git)
+
+
+* commit-msg.sample
+
+    This sample hook script was written in 2005 by Junio C Hamano, who
+    hereby clarifies that the contents of these files, when used as a
+    hook script installed by "git init", or manually copied by the
+    user, is licensed under the MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Ben Walton <bdwalton@gmail.com>
+    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
+
+    Paolo Bonzini <bonzini@gnu.org>
+    8089c85bcba89464b9b2a32fa948ed85eb367e70 (advice against 59f3e254)
+
+    Luben Tuikov <ltuikov@yahoo.com>
+    9a1ae9ab03abaffc977421f182997f3e735e7098 (make failure louder)
+
+    Andy Parkins <andyparkins@gmail.com>
+    59f3e254801648322b2d5cd073ca0cc5009aa2de (hint to auto-add -s)
+
+    Junio C Hamano <gitster@pobox.com>
+    89e2c5f17b901edf28a8bb778ece3f6c18bbb721 (initial version in 2005)
+
+
+* fsmonitor-watchman.sample
+
+    Alex Vandiver <alexmv@dropbox.com>
+    Ben Peart <benpeart@microsoft.com>
+    Kevin Willford <Kevin.Willford@microsoft.com>
+
+
+* post-update.sample
+
+    This sample hook script was written in 2005 by Junio C Hamano, who
+    hereby clarifies that the contents of these files, when used as a
+    hook script installed by "git init", or manually copied by the
+    user, is licensed under the MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Ben Walton <bdwalton@gmail.com>
+    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
+
+
+* pre-applypatch.sample
+
+    This sample hook script was written in 2005 by Junio C Hamano, who
+    hereby clarifies that the contents of these files, when used as a
+    hook script installed by "git init", or manually copied by the
+    user, is licensed under the MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
+    b849b954d22ee069b0edec1a12c78782ae1e629d (adjust for newer Git)
+
+
+* pre-commit.sample
+
+    Even though the history of this file dates back to 2005, the
+    current version contains no material from commits before 03e2b630
+    (Update sample pre-commit hook to use "diff --check", 2008-06-26),
+    which was written by Junio C Hamano, who hereby clarifies that the
+    contents of these files, when used as a hook script installed by
+    "git init", or manually copied by the user, is licensed under the
+    MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Jim Meyering <jim@meyering.net>
+    c646217e1366b0397552fad8c32acb47fbe8977d
+    f1e3156e627fa66714deea665c8f3585088b9695
+    c14daa4845ff2ec0d27807fa50f9fac1ca4d6462
+
+    Heiko Voigt <hvoigt@hvoigt.net>
+    d00e364de99d51bb76e437820e23cfa820417ec5 (non-ascii pathname check)
+
+    Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
+    c30eb852e281d55b04465b7814e00396893f74f3 (initial commit check)
+
+    Richard Hartmann <richih.mailinglist@gmail.com>
+    27b6e17a6d84a18861f05fd7c684ab443bf15244
+
+    Johan Herland <johan@herland.net>
+    af1748b31eb68643f1b8d9d918f43611cf96d257
+
+    brian m. carlson <sandals@crustytoothpaste.net>
+    03a7f388dafaee0aa084144efe7a8f9c151e5221
+
+    Lucius Hu <orctarorga@gmail.com>
+    81e3db42f3212a8e441e4ecee9a2928921cb9045
+
+
+* pre-merge-commit.sample
+
+    Michael J Gruber <git@grubix.eu>
+    6098817fd7f64209664c701df30096dc0f4fb876
+
+* prepare-commit-msg.sample
+
+    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
+    b22a3079466b72e8a8b76065d6c28efe7eea4b16 (clean-up)
+
+    Ben Walton <bdwalton@gmail.com>
+    502be959531b34e2d9283213b7bca51842639240
+    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
+
+    Alex Riesen <raa.lkml@gmail.com>
+    3015fa5846c19e79f99c1d6a49fd2510ed9291b8
+
+    Marcel Koeppen <git-dev@marzelpan.de>
+    4be1fe1b944e568f47efcb9d1beb8639f50b723f
+
+    Paolo Bonzini <bonzini@gnu.org>
+    8089c85bcba89464b9b2a32fa948ed85eb367e70 (initial version in 2008)
+
+* pre-push.sample
+
+    Denton Liu <liu.denton@gmail.com>
+    6a117da6e523a82115733682f4d3f59755897d5a
+    8c7e5059506c6840bfbd4dd8d1730784a5689719
+
+    W. Trevor King <wking@tremily.us>
+    1a947ba3a3eebea80be6a6d1000614884807bc8b (adjust behaviour to BCP)
+
+    Aaron Schrab <aaron@schrab.com>
+    87c86dd14abe8db7d00b0df5661ef8cf147a72a3 (initial version in 2013)
+
+
+* pre-rebase.sample
+
+    This sample hook script was written in 2006 by Junio C Hamano, who
+    hereby clarifies that the contents of these files, when used as a
+    hook script installed by "git init", or manually copied by the
+    user, is licensed under the MIT license [*2*].
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Ben Walton <bdwalton@gmail.com>
+    502be959531b34e2d9283213b7bca51842639240 (adjust for newer Git)
+    100e762a60a691a4978434f1cd5532e19cad39fc (adjust for newer Git)
+
+    Jonathan Nieder <jrnieder@gmail.com>
+    8db1ae57409b10ba48596198b329adba7fcb6b1a
+
+    Martin =C3=85gren <martin.agren@gmail.com>
+    7560f547e614244fe1d4648598d4facf7ed33a56 (phraso)
+
+* pre-receive.sample
+
+    Stefan Beller <stefanbeller@gmail.com>
+    77a9745d19b2b308c1ce97d18053322d1471bc4c (initial version)
+
+* push-to-checkout.sample
+
+    Adam Spiers <git@adamspiers.org>
+    e632c464d5dbbda72ae370ff6e9cbe31c01b0bb0 (initial version)
+
+* update.sample
+
+    Even though the history of this file dates back to 2006, the
+    current version contains no material from commits before a69aba6a
+    (UNIX reference time of 1970-01-01 00:00 is UTC timezone, not
+    local time zone, 2007-01-26), which was written by Andy Parkins.
+
+    Andy Parkins <andyparkins@gmail.com>
+    a69aba6af3e96f8021c194691a851e78febd70bf (base version)
+    829a686f1b50ba96cac2d88494fa339efe0c0862 (enhancement)
+
+    The following contributors, who may have made copyrightable change
+    that still remains in the current version will be asked to endorse
+    this clarification later.
+
+    Gerrit Pape <pape@smarden.org>
+    Alexandre Julliard <julliard@winehq.org>
+    Pavel Roskin <proski@gnu.org>
+    John Tapsell <johnflux@gmail.com>
+    Pierre Habouzit <madcoder@debian.org>
+    Heiko Voigt <hvoigt@hvoigt.net>
+    David Aguilar <davvid@gmail.com>
+    Martin Amdisen <martin.amdisen@praqma.com>
+    Lucius Hu <orctarorga@gmail.com>
+    Denton Liu <liu.denton@gmail.com>
+
+
+[References]
+
+*1* https://opensource.org/licenses/GPL-2.0
+
+*2* https://opensource.org/licenses/MIT
--=20
2.35.1-46-g38062e73e0

