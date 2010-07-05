From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: fatal: internal error in diff-resolve-rename-copy
Date: Mon, 05 Jul 2010 14:05:09 +0200
Message-ID: <4C31CA75.9010709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 05 14:06:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkRL-0005js-7q
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0GEMGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:06:18 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51942 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0GEMGR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 08:06:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CE9F1119590
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 08:06:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 05 Jul 2010 08:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=Mc9amZvuzXWfG/OSF6phbESnzJk=; b=Op7YW/m+89lea290Wv70lWUJGv8XB15MK2SP8EBX6AXsM0+Rbsp5IRw2EWeAXz9YEA+YIeESf85d9/xPauvezBrV06DdYgQpR2qLek3gJIDU5fWm8YWmBzupTkWZtuIDN0vNOfNhEDjEAvuSupSAiD6dBvvrB6zVlDNznCgMV6c=
X-Sasl-enc: aWNsduShMY5NnqNIXy8/t5uhag0Fm+raJBT0SSmc7rSL 1278331560
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB27C43963
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 08:05:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150259>

Hi there,

can someone help me with understanding or debugging the following? With
"log -p --stat" I get that strange fatal error. (With GIT_FLUSH=0 it
appears upfront.)

Without "-p --stat" the log is displayed without a fatal error (same 3
commits), but with "-p" or "--stat" (or both) it's fatal.

I suspect the error is out right before the problematic commit, which is
shown with an empty diffstat.

I did this from a subdir, but the same happens from the root of the
worktree.

git show on the last commit "7896762" shows the creation of a binary
blob "Formular_Lehrverpflichtung_SS09.odt", and "show --stat" gives the
expected stat. What problem could log -p --stat have?

Michael

GIT_FLUSH=1 git log -p  --stat --follow   Formular\ Lehrverpflichtung\
SS\ 2009_FakIII.odt
commit b7a1918f2712fdd8f0de3fa08510ef5f2b9e4428
Author: Michael J Gruber <gruber@m>
Date:   Thu Feb 18 16:40:37 2010 +0100

    clean up
---
 .../Formular Lehrverpflichtung SS 2009_FakIII.odt  |  Bin 13951 ->
13951 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/Formular Lehrverpflichtung SS 2009_FakIII.odt
b/LVVO/Formular Lehrverpflichtung SS 2009_FakIII.odt
similarity index 100%
rename from Formular Lehrverpflichtung SS 2009_FakIII.odt
rename to LVVO/Formular Lehrverpflichtung SS 2009_FakIII.odt

commit 223e14515f1d2f50d0985e8b2d100e47e0bdde81
Author: Michael J Gruber <gruber@m>
Date:   Wed Jul 8 16:39:10 2009 +0200

    make LVVO names uniform
---
 ...> Formular Lehrverpflichtung SS 2009_FakIII.odt |  Bin 13951 ->
13951 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/Formular_Lehrverpflichtung_SS09.odt b/Formular
Lehrverpflichtung SS 2009_FakIII.odt
similarity index 100%
rename from Formular_Lehrverpflichtung_SS09.odt
rename to Formular Lehrverpflichtung SS 2009_FakIII.odt
fatal: internal error in diff-resolve-rename-copy

commit 78967623b839ec174e2ed3cb4bf30e27b4d38481
Author: Michael J Gruber <gruber@m>
Date:   Wed Jul 8 16:37:29 2009 +0200

    Lehrverpflichtung SS09
---
