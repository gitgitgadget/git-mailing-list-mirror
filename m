From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4] Remove --allow-empty from the git-commit synopsis
Date: Wed,  7 Apr 2010 19:28:18 +0000
Message-ID: <1270668498-30495-1-git-send-email-avarab@gmail.com>
References: <7vfx37cckf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 21:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzavg-0005V2-Pf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab0DGT2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 15:28:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:61628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0DGT2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:28:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1664533fgg.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=k5zl+2VWR9WTaqC5aQFMg7GU08B7cXMvixb6JlNZJFA=;
        b=iAO2WofxfTNkPp+jtpSEQiFPgYKGLGmeU4u6u9HBZClv0KX3CYR0BVYLtMAh0c5HfM
         dkFKT6WdWrO4w6461veZQv4lcGHWK9hYn0x+xKEJbxE4EYsmxFVnwXBjPl6UoSej9viC
         90Hr5YkiUpNK7LVb+K/J/v56Xowtx9tll+FLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lX5ELt051WmFCig2Bzc8GG3G3znwN8xRth8Cv5AsAUsgZ3M+Yr3N6lk10mNhdaSW7V
         DzyJGeoW3bZEVUwTIaVajiVUWREYRQOFfyflYAbjKqlOK4u/ULNZzCAJ8KEaheKghWEO
         D5CEMfZIHCexhNMTih5+4zJmLGl1QTHAe8p70=
Received: by 10.87.67.25 with SMTP id u25mr260125fgk.32.1270668521604;
        Wed, 07 Apr 2010 12:28:41 -0700 (PDT)
Received: from localhost.localdomain ([188.104.23.89])
        by mx.google.com with ESMTPS id e3sm2901841fga.24.2010.04.07.12.28.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 12:28:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.298.gc81d
In-Reply-To: <7vfx37cckf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144274>

The --allow-empty option is too rarely used to warrant being displayed
in the SYNOPSIS. It should only be mentioned in the main body of the
documentation like --porcelain.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

> If you mention what Peff said, it would be nice to Cc: him.

Corrected.

> Please don't cite marc

Sorry, I'm new here and there was no mention of this in
Documentation/SubmittingPatches. I looked through `git log' for the
project and found 10 such links in other commit messages.

Now that I look closer there are 14 references to some `Message-ID:',
but of course someone getting it wrong in the past doesn't mean that
it's a good idea to follow their example. I won't cite marc.info
again.

> I do not think Jeff was against having a complete listing in the
> documentation.  Wasn't his suggestion about "git commit -h" output

Yes I misread (or rather, mis-recalled) the content of his message. He
was indeed talking about `git commit -h' output, but I subsequently
updated my --allow-empty-message patch to omit it from the SYNOPSIS
for git-commit(1). I've removed the links to `marc.info' (or any
Message-ID's) since they aren't pertinent anymore.

The relatively obscure --allow-empty* options should regardless of
that misunderstanding probably be omitted from the SYNOPSIS
section. It would reduce the cognitive load of the casual manual
reader who's trying to get an idea of the most common usage for the
command.

As for Jeff's suggestion of omitting options from the `--help' output:
I couldn't find a way to do that using parse-options.[ch]. It's also
customary for `--help' to include the full usage examples regardless
of how long they get (just look at wget, ls etc.). The SYNOPSIS
sections in manual pages by comparison usually aim for brevity.

 Documentation/git-commit.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 64fb458..ed2cd95 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,9 +10,8 @@ SYNOPSIS
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dr=
y-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
-	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
-	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] [-=
-]
-	   [[-i | -o ]<file>...]
+	   [--no-verify] [-e] [--author=3D<author>] [--date=3D<date>]
+	   [--cleanup=3D<mode>] [--status | --no-status] [--] [[-i | -o ]<fil=
e>...]
=20
 DESCRIPTION
 -----------
--=20
1.7.0.4.298.gc81d
