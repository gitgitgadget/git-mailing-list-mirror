From: "martin f. krafft" <madduck@madduck.net>
Subject: Install section 3 manpages to .../share/man for consistency
Date: Mon, 20 Aug 2007 09:23:14 +0200
Message-ID: <11875945951398-git-send-email-madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 09:23:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN1c6-0005sh-Vk
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbXHTHXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXHTHXU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:23:20 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:51538 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbXHTHXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:23:18 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 622108966ED
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:17 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21467-04 for <git@vger.kernel.org>;
	Mon, 20 Aug 2007 09:23:17 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 0FBE08966EC
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:16 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id CFE639F16A
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:15 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 89F8943F9; Mon, 20 Aug 2007 09:23:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.40.g2f82
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56184>

When an admin installs git site-wide, e.g. to /usr/local, perl's makemaker
decides to use 'site' mode (as opposed to distro or user mode). For whatever
reason, it then installs all perl-related manpages (those in section 3) to
.../man, while the rest of git happily installs manpages to .../share/man.

In as such, this is different from the patch proposed in this thread:
  http://marc.info/?t=117862141100003&r=1&w=2

My patch should only ever affect site installs and does not cause
installations to $HOME to go to $HOME/share/...
