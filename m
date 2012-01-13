From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Sending patches with KMail (Re: [PATCH] git-blame.el: Fix
 compilation warnings.)
Date: Fri, 13 Jan 2012 17:31:58 -0600
Message-ID: <20120113233158.GD7343@burratino>
References: <2608010.fNV39qBMLu@descartes>
 <20120112162617.GA2479@burratino>
 <2304907.sEfEeC6Eon@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Michele Ballabio <barra_cuda@katamail.com>
To: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 00:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlqbT-00041Y-BU
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 00:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457Ab2AMXcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 18:32:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60271 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab2AMXcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 18:32:04 -0500
Received: by ggdk6 with SMTP id k6so1939843ggd.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 15:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/mkKMHMvC99Tajnz8AAfU6Qsa0qQslVTotQWJRhhp68=;
        b=IYij8tWoVNbK8ETLZpvPyOkD9YnDrTrTu2pRkjbDkU6gUDmvb9coIlKVNxRmVFR8NQ
         ktf8O5yAF65+2aqzRzzVGc8pjTuHuIEX6Y+3xo6jpw62I4fIZD1GKDRpBEAdBKEUAfQ/
         dQy4QmcOOrdmk1nPiR5R9KQRh0TvaSf50KNeE=
Received: by 10.101.210.30 with SMTP id m30mr1446380anq.64.1326497523293;
        Fri, 13 Jan 2012 15:32:03 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 9sm27393004ans.15.2012.01.13.15.32.02
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 15:32:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2304907.sEfEeC6Eon@descartes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188543>

Hi,

R=C3=BCdiger Sonderfeld wrote:
> On Thursday 12 January 2012 10:26:41 Jonathan Nieder wrote:

>> These lines should be left out [*].
>
> Sorry, I wasn't sure whether to remove them or not. I followed the de=
scription=20
> in git-format-patch(1) on how to send patches with kmail. I'll remove=
 them in=20
> the future. Thanks for the advice.

Oh, thanks for the pointer.  How about something like this?

The hints at [1] might also be useful, in case you would like to try
and consider improving the manpage to document them if they work.

-- >8 --
Subject: Documentation/format-patch: mention removal of in-body headers=
 for KMail

The opening "From " line and following lines in "git format-patch"

	From 13c41b41b832d41680ccd33a2422ef8217965566 Mon Sep 17 00:00:00 2001
	From: Jonathan Nieder <jrnieder@gmail.com>
	Date: Fri, 13 Jan 2012 17:22:41 -0600

are for your mailer and should be omitted except for fields that
differ from the mail header when reading your patch into an email
body.  Otherwise "git am" thinks these lines are part of the commit
message  when trying to reproduce the resulting patch from an mbox
automatically.  Add a reminder in this direction to the KMail recipe.

Suggested-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[1] http://thread.gmane.org/gmane.comp.version-control.git/171580/focus=
=3D171720

 Documentation/git-format-patch.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 6ea9be77..5e1d6d2c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -462,8 +462,10 @@ This should help you to submit patches inline usin=
g KMail.
=20
 4. Use Message -> Insert file... and insert the patch.
=20
-5. Back in the compose window: add whatever other text you wish to the
-   message, complete the addressing and subject fields, and press send=
=2E
+5. Back in the compose window: remove the "`From $SHA1 $magic_timestam=
p`"
+   marker and unwanted in-body headers, add whatever other text you wi=
sh
+   to the message, complete the addressing and subject fields, and
+   press send.
=20
=20
 EXAMPLES
--=20
1.7.8.3
