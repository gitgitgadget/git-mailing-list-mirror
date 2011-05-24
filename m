From: Chris Wilson <cwilson@vigilantsw.com>
Subject: Simple dead assignment
Date: Tue, 24 May 2011 17:07:58 -0400
Message-ID: <20110524210758.GH16052@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TRYliJ5NKNqkz5bu"
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 23:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOypq-00022V-20
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab1EXVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:08:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42617 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab1EXVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:08:04 -0400
Received: by pwi15 with SMTP id 15so3182041pwi.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 14:08:02 -0700 (PDT)
Received: by 10.68.38.98 with SMTP id f2mr2934116pbk.462.1306271282632;
        Tue, 24 May 2011 14:08:02 -0700 (PDT)
Received: from localhost (c-76-126-142-103.hsd1.ca.comcast.net [76.126.142.103])
        by mx.google.com with ESMTPS id b4sm5216331pbo.80.2011.05.24.14.08.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 14:08:01 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174342>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Folks,

Sentry picked up this dead assignment commited yesterday in ba67aaf.
I've provided a patch to remove it. It might also be a good idea to
ask the author if that value was supposed to be used for something
in particular before pulling it out.

Thanks,
Chris

-- 
Chris Wilson
http://vigilantsw.com/
Vigilant Software, LLC

--TRYliJ5NKNqkz5bu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="da.diff"

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 7125093..5829463 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -67,9 +67,6 @@ static void subst_from_stdin (void);
 int
 main (int argc, char *argv[])
 {
-  /* Default values for command line options.  */
-  unsigned short int show_variables = 0;
-
   switch (argc)
 	{
 	case 1:
@@ -88,7 +85,6 @@ main (int argc, char *argv[])
 	  /* git sh-i18n--envsubst --variables '$foo and $bar' */
 	  if (strcmp(argv[1], "--variables"))
 		error ("first argument must be --variables when two are given");
-	  show_variables = 1;
       print_variables (argv[2]);
 	  break;
 	default:

--TRYliJ5NKNqkz5bu--
