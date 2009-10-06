From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "reword"
Date: Tue, 06 Oct 2009 10:25:36 +0200
Message-ID: <4ACAFF00.60704@gmail.com>
References: <4ACA1BD1.6050905@gmail.com> <4ACAACAB.3020707@gmail.com> <4ACAEBBA.9000806@gmail.com> <4ACAF515.2060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 10:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv5SW-00071X-Mo
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 10:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbZJFI0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 04:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbZJFI0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 04:26:16 -0400
Received: from mail-ew0-f217.google.com ([209.85.219.217]:42309 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbZJFI0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 04:26:15 -0400
Received: by ewy17 with SMTP id 17so3635646ewy.39
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QKt/cGgX7KMSe8v84BM5Lqpw0oQfiiEiROwTnqGtqrg=;
        b=ALh/R/1cqbvLs02N+ksgHM3hE7w2PUi9kMyuYo30EXvyzpoR89mEliK361xUXNi9iE
         9vgHK33pGqlZnnjG2DgwUbVIZ2FvB2N+yNzzFlbZYJWSwUeFdN3bqF3C7TO7jMLIcTyF
         YTOECS21LbnHzq8aCp1ZaiZH6MTjAEo7HzPoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ANYdzBeB0l1V+deX7ocjdQmEJGF5SWqy43hox6PR98vMWx4mP3xU+RHp6H93CwCCGA
         8vvi6L7pSyUBoCEDB7b4EBDjimNg4aEQWklLUpFdDK1lV+g0EwdvMYWaMspKRPnv9hWB
         eF2Nh/tAGzwWRepXMYaFBpeHJFw3/hjKrK9qw=
Received: by 10.211.143.19 with SMTP id v19mr4521702ebn.47.1254817538371;
        Tue, 06 Oct 2009 01:25:38 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm1457598eyg.27.2009.10.06.01.25.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Oct 2009 01:25:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <4ACAF515.2060403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129611>

Thanks to both of you!

Stephen Boyd wrote:
> Bj=F6rn Gustavsson wrote:

> Ok, "stop" being misleading makes sense but I still think the English=
 is
> wrong. Particularly the part about allow editing. Maybe just remove
> "stop", so
>=20
>     use commit, but edit the commit message

OK.

> Or we could combine yours, mine, and Hannes' versions.
>=20
> The rebase will stop when "pick" has been replaced with "edit" or whe=
n a command fails due to merge errors. When you are done editing and/or=
 resolving conflicts you can continue with `git rebase --continue`.
>=20

I changed "The rebase" to "'git-rebase' to be consistent with the rest =
of the documentation.

Here is a new patch, to be applied on top of my original patch.

To avoid confusion, I'll better re-roll the patch. But I'll wait
a day or so, in case there will be more corrections or suggestions
for improvements.

-- >8 --
Subject: [PATCH] Minor polishing of documentation, second attempt

To be applied on top of and combined with my original patch.
---
 Documentation/git-rebase.txt |   10 +++++-----
 git-rebase--interactive.sh   |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 52af656..33e0ef1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -368,17 +368,17 @@ By replacing the command "pick" with the command =
"edit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
=20
-If you just want to edit the commit message for a commit, you can repl=
ace
-the command "pick" with the command "reword".
+If you just want to edit the commit message for a commit, replace the
+command "pick" with the command "reword".
=20
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
 commits had different authors, it will attribute the squashed commit t=
o
 the author of the first commit.
=20
-In both cases, or when a "pick" does not succeed (because of merge
-errors), the loop will stop to let you fix things, and you can continu=
e
-the loop with `git rebase --continue`.
+'git-rebase' will stop when "pick" has been replaced with "edit" or
+when a command fails due to merge errors. When you are done editing
+and/or resolving conflicts you can continue with `git rebase --continu=
e`.
=20
 For example, if you want to reorder the last 5 commits, such that what
 was HEAD~4 becomes the new HEAD. To achieve that, you would call
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 30c2f62..a43ee22 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -760,7 +760,7 @@ first and then run 'git rebase --continue' again."
 #
 # Commands:
 #  p, pick =3D use commit
-#  r, reword =3D use commit, but allow editing of the commit message
+#  r, reword =3D use commit, but edit the commit message
 #  e, edit =3D use commit, but stop for amending
 #  s, squash =3D use commit, but meld into previous commit
 #
--=20
1.6.5.rc2.18.g020de
