From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3 2/2] add documentation for mailinfo.scissors and '--no-scissors'
Date: Fri, 11 Sep 2009 21:50:25 +0200
Message-ID: <46a8212df1c43729a9b2d3ff3029e2c28ac34119.1252698215.git.nicolas.s.dev@gmx.fr>
References: <7veiqe0x05.fsf@alter.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmC90-00087z-F3
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 21:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbZIKTup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbZIKTuo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 15:50:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:21447 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbZIKTuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 15:50:44 -0400
Received: by ey-out-2122.google.com with SMTP id 25so287436eya.19
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=ZXBdHk8I5fc75Dr+lOovZUIG4QovM1wICPUPvgnoGVk=;
        b=C4pH4+s+i28HMEXermFacyf/hR4p8LzWLAIeluWNVaDFyYX0rM9uksj2cGwrz5C10K
         3nMTjxVPAqqo5eIUIhC8nIeccMYd/AhRVimSU7wfc5+MJlJY+wnam39Imx0O8ywC0ulg
         4An7n34d27vMz/BZBAIaZeuBJxbS745SKqsOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=NgEw5fCmsY6JCZGYkRftxNP4osj8K0ciyC5qhKwSB3oxsIhzAddjJi7e8QeCSeJnMQ
         Vz4WpNc5BCfqz0/YCtfuZITp4k/7+EBkeRBLilKvUBC9FIWrlK63mFo0GZDr5aFTCrQf
         tX//8cYvrB0Fqz27YuYqrsRPBepQ6SdpTm7EI=
Received: by 10.211.141.2 with SMTP id t2mr1012045ebn.59.1252698646041;
        Fri, 11 Sep 2009 12:50:46 -0700 (PDT)
Received: from localhost (91-165-134-53.rev.libertysurf.net [91.165.134.53])
        by mx.google.com with ESMTPS id 7sm1853197eyb.37.2009.09.11.12.50.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 12:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.166.g46a82
In-Reply-To: <7veiqe0x05.fsf@alter.siamese.dyndns.org>
In-Reply-To: <682ef47420f36d8c53e42981370d377b621d7b86.1252698215.git.nicolas.s.dev@gmx.fr>
References: <682ef47420f36d8c53e42981370d377b621d7b86.1252698215.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128212>

The 11/09/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > +---no-scissors::
> > +   Do not obey to a scissors line (see linkgit:git-mailinfo[1]).
> > +
> 
> obey is v.t. so "do not obey a scissors line" would be grammatical; I
> think "ignore scissors lines" would be better.
> 
> > +--no-scissors::
> > +   Do not obey to a scissors line. This is only useful if mailinfo.scissors is
> > +   enabled (see --scissors).
> 
> Ditto; also it is useful in general if you do not know which way it is
> configured.  Saying "_only_" is misleading.
> 
>       Ignore scissors lines; useful for overriding mailinfo.scissors
>       settings.
> 
> > diff --git a/git-am.sh b/git-am.sh
> > index 26ffe70..f242d1a 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
> >  u,utf8          recode into utf8 (default)
> >  k,keep          pass -k flag to git-mailinfo
> >  c,scissors      strip everything before a scissors line
> > +no-scissors     don't obey to a scissors line (default)
> >  whitespace=     pass it through git-apply
> >  ignore-space-change pass it through git-apply
> >  ignore-whitespace pass it through git-apply
> 
> Do we want it to allow --no-no-scissors?  I do not think this hunk is
> necessary at all.

This version includes the above comments.

Thanks,

-- >8 --

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 Documentation/git-am.txt       |    5 ++++-
 Documentation/git-mailinfo.txt |    5 +++++
 builtin-mailinfo.c             |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 87781f4..06e6ea6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors]
+	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
@@ -44,6 +44,9 @@ OPTIONS
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]).
 
+---no-scissors::
+	ignore scissors lines (see linkgit:git-mailinfo[1]).
+
 -q::
 --quiet::
 	Be quiet. Only print error messages.
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 823ab82..d1f9cb8 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -62,6 +62,11 @@ This is useful if you want to begin your message in a discussion thread
 with comments and suggestions on the message you are responding to, and to
 conclude it with a patch submission, separating the discussion and the
 beginning of the proposed commit log message with a scissors line.
++
+This can enabled by default with the configuration option mailinfo.scissors.
+
+--no-scissors::
+	ignore scissors lines; useful for overriding mailinfo.scissors settings.
 
 <msg>::
 	The commit log message extracted from e-mail, usually
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 7d22fd7..d498b1c 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1004,7 +1004,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors] msg patch < mail >info";
+	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
-- 
1.6.5.rc0.166.g46a82
