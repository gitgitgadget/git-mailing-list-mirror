From: David Kastrup <dak@gnu.org>
Subject: Question about unpack-trees.c and tree_entry_list
Date: Sun, 22 Jul 2007 18:17:47 +0200
Message-ID: <85d4ykjtuc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 18:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICe89-0000eS-Pn
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 18:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517AbXGVQRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXGVQRx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 12:17:53 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:45289 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754301AbXGVQRw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 12:17:52 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id BA6161F5E19
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 18:17:50 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id A26D127943A
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 18:17:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 71D6935E5A9
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 18:17:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0D2D21D1E182; Sun, 22 Jul 2007 18:17:47 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3728/Sun Jul 22 07:07:30 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53276>


The definition of tree_entry_list ist the following

struct tree_entry_list {
	struct tree_entry_list *next;
	unsigned directory : 1;
	unsigned executable : 1;
	unsigned symlink : 1;
	unsigned int mode;
	const char *name;
	const unsigned char *sha1;
};

but it appears to me that the only of the bit fields that is used at
all is "directory" : all other uses revert to "mode" which directory
presumably could do as well.

Is there something I am overlooking?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
