From: Samuel Tardieu <sam@rfc1149.net>
Subject: Choosing between "renaming" and "copy"
Date: Thu, 12 Mar 2009 14:01:14 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2009-03-12-14-01-15+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 14:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkiN-0007a8-DS
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbZCLNLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 09:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755600AbZCLNLP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:11:15 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:41364 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbZCLNLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 09:11:14 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2009 09:11:13 EDT
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 6E02310FD6B
	for <git@vger.kernel.org>; Thu, 12 Mar 2009 14:01:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HqT0kpcDPodA for <git@vger.kernel.org>;
	Thu, 12 Mar 2009 14:01:10 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "CAcert Class 3 Root" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 700A210FD09
	for <git@vger.kernel.org>; Thu, 12 Mar 2009 14:01:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 5ECDFC400A;
	Thu, 12 Mar 2009 14:01:15 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QkBQCVCe847; Thu, 12 Mar 2009 14:01:15 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 42CB2C4099; Thu, 12 Mar 2009 14:01:15 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113066>

I renamed a file in my repository, and made a slightly modified copy
of it. It looks like GIT gets confused on which one is the renaming
and which one is the copy, and doesn't favour the 100% identical one
to be chosen as the renaming.

Not a big deal, but maybe git could be more clever here.

% git commit -m "Split into flash and ram alternatives." 
[stm32-sk 601462c] Split into flash and ram alternatives.
 3 files changed, 3 insertions(+), 2 deletions(-)
 copy Demo/CORTEX_STM32SK_GCC/{stm32f103r8t6.ld => stm32f103r8t6_flash.ld} (100%)
 rename Demo/CORTEX_STM32SK_GCC/{stm32f103r8t6.ld => stm32f103r8t6_ram.ld} (98%)

% git --version
git version 1.6.2.rc2.305.g23381

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
