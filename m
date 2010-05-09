From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] Documentation/log: add a CONFIGURATION section
Date: Sat, 8 May 2010 22:30:41 -0500
Message-ID: <20100509033040.GE7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:30:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxE2-0003eg-1F
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab0EID3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:29:39 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:55418 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0EID3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:29:38 -0400
Received: by yxe1 with SMTP id 1so1738528yxe.33
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Z8zC4Ot2Tck1kSCs1XmmTLXKtTjWb85x7iCKMoTKilA=;
        b=RJjKUcAKJ+3rKBDYlhRNDHAyJo8SRUXt5ox/+qtU6PlvTi4PHWuGkMDjrdtsMbMRRX
         u59TOiET+7GkK9vgY7aWUnS8P0/SikKGpCpQ+vPGJhInETrpoWnhGiAxFbqjEhBYPYse
         +mkOCzwFp/Fv7fe1T5xu3HEQSP9AbFXTnY8lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=N8gyF1ql1ijdOW1WiSboXiZw2HhtY4jWjhzSPTe6F6sHAIcPbeY4HEcSv747enXarJ
         5iYS8xe0yg+sG3raMW8aLKFrNkFG4eKpPrM+Flh79Rqms+zTBpWiVSyLCwFGio1Pu5qh
         pep9n7ueC0a4XDKOYf2wgSFxVZ2d8BYlsFIcM=
Received: by 10.151.92.14 with SMTP id u14mr5029866ybl.45.1273375777149;
        Sat, 08 May 2010 20:29:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2578104yxe.6.2010.05.08.20.29.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:29:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146696>

Add a configuration section summarizing variables that affect the
log family of commands.

Cc: Thomas Rast <trast@student.ethz.ch>
Cc: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-log.txt |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fb184ba..d7f6a9c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -132,6 +132,48 @@ Discussion
 
 include::i18n.txt[]
 
+Configuration
+-------------
+
+See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
+for settings related to diff generation.
+
+format.pretty::
+	Default for the `--format` option.  (See "PRETTY FORMATS" above.)
+	Defaults to "medium".
+
+i18n.logOutputEncoding::
+	Encoding to use when displaying logs.  (See "Discussion", above.)
+	Defaults to the value of `i18n.commitEncoding` if set, UTF-8
+	otherwise.
+
+log.date::
+	Default format for human-readable dates.  (Compare the
+	`--date` option.)  Defaults to "default", which means to write
+	dates like `Sat May 8 19:35:34 2010 -0500`.
+
+log.showroot::
+	If `false`, 'git log' and related commands will not treat the
+	initial commit as a big creation event.  Any root commits in
+	`git log -p` output would be shown without a diff attached.
+	The default is `true`.
+
+mailmap.file::
+	See linkgit:git-shortlog[1].
+
+notes.displayRef::
+	Which refs, in addition to the default set by `core.notesRef`
+	or 'GIT_NOTES_REF', to read notes from when showing commit
+	messages with the 'log' family of commands.  See
+	linkgit:git-notes[1].
++
+May be an unabbreviated ref name or a glob and may be specified
+multiple times.  A warning will be issued for refs that do not exist,
+but a glob that does not match any refs is silently ignored.
++
+This setting can be disabled by the `--no-standard-notes` option,
+overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
+and supplemented by the `--show-notes` option.
 
 Author
 ------
-- 
1.7.1
