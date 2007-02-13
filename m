From: Timur Tabi <timur@freescale.com>
Subject: How do I get git-format-patch to ignore changes that remove spaces
 from the end of the line?
Date: Tue, 13 Feb 2007 15:59:33 -0600
Organization: Freescale
Message-ID: <45D234C5.5090005@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 22:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH5gf-0002WQ-Ca
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 22:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXBMV7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbXBMV7h
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 16:59:37 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:54707 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXBMV7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 16:59:37 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l1DLxYnp022081
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:59:34 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1DLxXqV023738
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 15:59:34 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39588>

I have configured my text editor to remove spaces at the end of each line 
whenever it saves a file.  I do this so that I don't inadvertently add spaces to 
the end of any line.

Unfortunately, if the file *already* had spaces at the end of some lines before 
I start editing it, this spaces will also be removed.

After I commit my changes, I use git-format-patch to make a patch.  I then get 
deltas like this:

   * Copyright (C) 1996-2005 Paul Mackerras.
- *
+ *
   *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
- *    {engebret|bergner}@us.ibm.com
+ *    {engebret|bergner}@us.ibm.com
   *

I don't want these deltas in my patch.  However, if I specify an option like 
--ignore-all-space, git-format-patch omits deltas like this one:

-               memcpy(fs_enet_data.macaddr, mac_addr, 6);
+                       memcpy(fs_enet_data.macaddr, mac_addr, 6);

In this case, I *do* want the delta, because I'm indenting a line to fix a 
formatting error.

So how do I get the output that I want, and not the output that I don't want?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
