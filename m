From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Sat, 23 Feb 2008 03:00:02 +0100
Organization: GNU's Not UNIX!
Message-ID: <200802230200.m1N202Y7007392@localhost.localdomain>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
	<200802221121.35706.jnareb@gmail.com> <87ir0h9soh.fsf@lysator.liu.se> <87d4qpgs9y.dlv@maison.homelinux.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: davidk@lysator.liu.se, jnareb@gmail.com, julliard@winehq.org,
	git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 03:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkE0-0003rA-C9
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYBWCdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYBWCdx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:33:53 -0500
Received: from master.uucpssh.org ([193.218.105.66]:51387 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbYBWCdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:33:52 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 3C376C82CF; Sat, 23 Feb 2008 03:32:24 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m1N203tS007395;
	Sat, 23 Feb 2008 03:00:03 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m1N202Y7007392;
	Sat, 23 Feb 2008 03:00:02 +0100
In-reply-to: <87d4qpgs9y.dlv@maison.homelinux.org> (message from Remi Vanicat
	on Fri, 22 Feb 2008 12:11:21 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.358,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.04,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74787>

Hi,

   Here is a modification with inclusion of git-grep only when the grep
   library is available. 

   +(require 'grep () t)

   +(when (featurep 'grep)
   +  (defvar git-grep-history nil)
   +
   +  (defun git-grep (regexp &optional files dir)

Why not just do something like this ?

(when (require 'grep () t)
      (defvar ...)
      (defun git-grep ...))

Regards,

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
