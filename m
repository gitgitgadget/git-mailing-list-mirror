From: Greg KH <greg@kroah.com>
Subject: git applymbox is too anal
Date: Thu, 8 Sep 2005 16:25:35 -0700
Message-ID: <20050908232535.GA7700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 09 01:27:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDVnR-0005r1-OZ
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 01:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVIHXZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVIHXZt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 19:25:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:31196 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965067AbVIHXZt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 19:25:49 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j88NPkw23192
	for <git@vger.kernel.org>; Thu, 8 Sep 2005 16:25:46 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1EDVlv-228-00 for <git@vger.kernel.org>; Thu, 08 Sep 2005 16:25:35
 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8227>

Ick.  I'm trying to apply a bunch of patches to a git repo (the kernel
tree), using 'git applymbox' and it's just dieing on simple patches that
apply with fuzz.

for example:

$ git applymbox ~/linux/patches/u07

Applying 'USB: fix up URB_ASYNC_UNLINK usages from the usb-serial drivers'

error: patch failed: drivers/usb/serial/option.c:513
error: drivers/usb/serial/option.c: patch does not apply

$ patch -p1 --dry-run < ~/linux/patches/u07
patching file drivers/usb/serial/keyspan.c
patching file drivers/usb/serial/option.c
Hunk #3 succeeded at 509 with fuzz 1.


So, I have to then do a 'patch, git diff, git checkout-cache -f -u -a,
git applymbox' type dance to get this patch to apply.

Or am I missing some option to 'git applymbox' that I can't seem to
find?

thanks,

greg k-h
