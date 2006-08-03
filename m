From: Rocco Rutte <pdmef@gmx.net>
Subject: Creating diffs
Date: Thu, 3 Aug 2006 12:29:37 +0000
Organization: Berlin University of Technology
Message-ID: <20060803122937.GI5016@robert.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Thu Aug 03 14:30:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8cKq-0000xo-Cp
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 14:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWHCM3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHCM3w
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 08:29:52 -0400
Received: from mail.gmx.de ([213.165.64.21]:63150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932389AbWHCM3v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 08:29:51 -0400
Received: (qmail invoked by alias); 03 Aug 2006 12:29:50 -0000
Received: from cable-62-117-26-83.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.83]
  by mail.gmx.net (mp043) with SMTP; 03 Aug 2006 14:29:50 +0200
X-Authenticated: #1642131
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.dyndns.org [192.168.0.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 53EB120F01
	for <git@vger.kernel.org>; Thu,  3 Aug 2006 12:29:49 +0000 (UTC)
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de [192.168.0.113])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by robert.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id D3B6933FC3
	for <git@vger.kernel.org>; Thu,  3 Aug 2006 12:29:38 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: robert (FreeBSD 6.1-STABLE i386)
User-Agent: Mutt/1.5.12-pdmef (2006-07-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24719>

Hi,

when creating a diff between two branches, one particular file needs a 
manually created/modified diff (the file contains just 1 line). As I 
cannot exclude files from the diff and create the missing one manually, 
I tried using the opposite approach: include all wanted.

However, when I do:

   $ git diff source:file dest:file

I get:

   --- a/source:file
   +++ b/source:file

But I'd like to drop the branchname. Can I do that without filtering 
everything through sed(1)?

Also, I think the diffs are reversed:

   $ git diff master:builtin-rm.c appname:builtin-rm.c
   diff --git a/master:builtin-rm.c b/master:builtin-rm.c
   index 735f3db..92d205a 100644
   --- a/master:builtin-rm.c
   +++ b/master:builtin-rm.c
   @@ -50,7 +50,6 @@ int cmd_rm(int argc, const char **argv, 
           const char **pathspec;
           char *seen;
   
   -       git_set_appname("git-rm");
           git_config(git_default_config);
   
           newfd = hold_lock_file_for_update(&lock_file, get_index_file());

since the appname branch contains the change while master doesn't.

Git version is 1.4.2.rc2 but both "bugs" happen with unpatched 1.3, too.

   bye, Rocco
-- 
:wq!
