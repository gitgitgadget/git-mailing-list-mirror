From: David Miller <davem@davemloft.net>
Subject: setup_path()
Date: Wed, 13 Feb 2008 04:49:15 -0800 (PST)
Message-ID: <20080213.044915.123319879.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 13:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPH39-0001DJ-Hg
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 13:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828AbYBMMso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 07:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYBMMso
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 07:48:44 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60341
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751819AbYBMMsn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 07:48:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 4C893C8C1F2
	for <git@vger.kernel.org>; Wed, 13 Feb 2008 04:49:15 -0800 (PST)
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73782>


Shouldn't stand-alone programs other than git.c itself also call
setup_path()?

I have a problem where if I only install git into my own home
directory ~/bin, I can't send pull requests over SSH to that machine
successfully because the execvp() of "pack-objects" by git-upload-pack
fails due to the PATH not containing "git --exec-dir"

If I add a dummy setup_path(NULL) call to upload-pack.c, it works
fine.
