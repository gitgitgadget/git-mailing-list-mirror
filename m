From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] tail -n not supported in all OSs
Date: Tue, 16 Oct 2007 19:57:14 +0300
Message-ID: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihptw-0000vb-5f
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539AbXJPRIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758267AbXJPRIG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:08:06 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52572 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945AbXJPRID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:08:03 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 448AB619F5
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:19 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0621F41711; Tue, 16 Oct 2007 19:57:19 +0300
Received: from cante.cante.net (a81-197-175-198.elisa-laajakaista.fi [81.197.175.198])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 37D6828038
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:17 +0300 (EEST)
Received: from jaalto by cante.cante.net with local (Exim 4.68)
	(envelope-from <jaalto@cante.cante.net>)
	id 1IhpjJ-0004lg-47
	for git@vger.kernel.org; Tue, 16 Oct 2007 16:57:17 +0000
X-Mailer: git-send-email 1.5.3.4
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@cante.cante.net
X-SA-Exim-Scanned: No (on cante.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61219>


SunOS/Solaris tail(1) does not support option '-n'. The
following patches change occurrances of:

   tail -n <N>

to

   tail <N>

---------------------------------------------------------------------
REFERENCES:

User Commands                                             TAIL(1)
                        
NAME
     tail - output the last part of files

SYNOPSIS
     tail [OPTION]... [FILE]...

- - -

$ uname -a
SunOS host 5.9 Generic_118558-35 sun4u sparc SUNW,Serverblade1

$ echo | tail -n 1

usage: tail [+/-[n][lbc][f]] [file]
       tail [+/-[n][l][r|f]] [file]                     
