From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5Bgit=20wiki=20PATCH=5D=20=22Modernizing=20and=20expanding=20Git=2Epm=22=20project?=
Date: Sat,  3 Mar 2012 22:14:41 +0100
Message-ID: <1330809281-25774-1-git-send-email-jnareb@gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3wI4-0006hl-TY
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 22:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2CCVOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 16:14:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52819 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab2CCVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 16:14:50 -0500
Received: by eaaq12 with SMTP id q12so978461eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 13:14:49 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.4.131 as permitted sender) client-ip=10.213.4.131;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.4.131 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.4.131])
        by 10.213.4.131 with SMTP id 3mr2015611ebr.22.1330809289849 (num_hops = 1);
        Sat, 03 Mar 2012 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z2W5WX4rjYEv9Dbm3v+CI7jvigJU2R5NFvrFhhMcvbE=;
        b=npr6u/bxE3n5pJBVglnQSlFjIJpFTl6XRJ+RfpP4fXFR3z3+FfDfaL2NkFYLUXgLqC
         e6BkTwFSx4AFMSy/aMz3VfE65CpXq7qIqSWiRl4hlPkujHAM77d2BB7hyu+xFrU/QsWN
         JPxMafy+u7XO4o149FcZLdO8bgza//CKRECLLQWZr762/8xbIa9Qb1hXn6AUq1pUcdv7
         miM2rykzTJaoKUqFyx6gVvUA7JqAbsSvRXsHZ0dw3iOFB4Io4ieyhGzImkE7LI70ioLC
         unEttXDOlBUKwDGjU6grpQ53QYU9fL3gYzAb0fmWDe8C6vgM7ITDMj5hq5vixt+Io6D6
         MwEg==
Received: by 10.213.4.131 with SMTP id 3mr1538598ebr.22.1330809289734;
        Sat, 03 Mar 2012 13:14:49 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id r5sm38983625eef.6.2012.03.03.13.14.48
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 13:14:49 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192134>

---
I'm not sure if my Markdown is entirely correct.

 SoC-2012-Ideas.md |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 02a8fc7..f56b601 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -181,3 +181,44 @@ this project.
=20
 Proposed by: Thomas Rast =20
 Possible mentor(s): Thomas Rast
+
+Modernizing and expanding Git.pm
+--------------------------------
+
+Git.pm was created in 2006 to make it easy to call git commands from
+Perl scripts safely, in a portable way (including workarounds required
+for ActiveState Perl on MS Windows).  Its error handling via exception=
s
+also comes from that year.
+
+Git.pm module uses Error (and Error::Simple) for its exception handlin=
g.
+Unfortunately, while it might looked like a good choice in 2006, Error
+module is deprecated:
+
+> WARNING
+> -------
+>
+> Using the "Error" module is **no longer recommended** due to the
+> black-magical nature of its syntactic sugar, which often tends to
+> break. Its maintainers have stopped actively writing code that uses
+> it, and discourage people from doing so. See the "SEE ALSO" section
+> below for better recommendations.
+
+Nowadays the recommended solution to exception handling in Perl are
+Try::Tiny (or TryCatch, but I don't think Git.pm would need this more
+heavyweight module) for capturing and handling exceptions, and
+Exception::Class (or Throwable, but that requires heavyweight Moose
+object system) for throwing OO exceptions.
+
+The major goal would be to update Git.pm to modern Perl conventions,
+amon others moving from Error / Error::Simple to Try::Tiny and
+Exception::Class, preserving backwards compatibility, but perhaps also
+adding a better interface and using it in git commands implemented in
+Perl.
+
+Other optional goals would be to extend Git.pm, for example adding
+Git::Config module which would read git configuration once like gitweb
+does, or Git::Commit module for parsing commit objects, etc.
+
+Programming language: Perl =20
+Proposed by: Jakub Nar=C4=99bski =20
+Possible mentor(s): Jakub Nar=C4=99bski (?)
--=20
1.7.9
