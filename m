From: Chris Wilson <cwilson@vigilantsw.com>
Subject: [PATCH] Simple dead assignment
Date: Tue, 24 May 2011 18:45:25 -0400
Message-ID: <20110524224525.GI16052@localhost>
References: <20110524210758.GH16052@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 00:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0M4-0002JD-Ch
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687Ab1EXWpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:45:30 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:45616 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab1EXWp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:45:29 -0400
Received: by pxi16 with SMTP id 16so4683736pxi.4
        for <git@vger.kernel.org>; Tue, 24 May 2011 15:45:29 -0700 (PDT)
Received: by 10.68.69.102 with SMTP id d6mr3405679pbu.138.1306277129488;
        Tue, 24 May 2011 15:45:29 -0700 (PDT)
Received: from localhost (c-76-126-142-103.hsd1.ca.comcast.net [76.126.142.103])
        by mx.google.com with ESMTPS id q10sm5265960pbk.39.2011.05.24.15.45.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 15:45:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110524210758.GH16052@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174352>

On Tue, May 24, 2011 at 05:07:58PM -0400, Chris Wilson wrote:
> Sentry picked up this dead assignment commited yesterday in ba67aaf.
> I've provided a patch to remove it. It might also be a good idea to
> ask the author if that value was supposed to be used for something
> in particular before pulling it out.

Oops, I see others putting the patches inline. Here you go.

Chris

-- 
Chris Wilson
http://vigilantsw.com/
Vigilant Software, LLC

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
