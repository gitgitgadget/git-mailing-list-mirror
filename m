From: Jan Engelhardt <jengelh@medozas.de>
Subject: Retry on all A/AAAA records
Date: Sat, 16 Apr 2011 13:14:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1104161312590.11706@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 13:14:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB3SV-0003np-Q8
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 13:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759309Ab1DPLOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 07:14:30 -0400
Received: from borg.medozas.de ([188.40.89.202]:55946 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759277Ab1DPLOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 07:14:30 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id D9E7CF0C32BC8; Sat, 16 Apr 2011 13:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id C4A0464C0
	for <git@vger.kernel.org>; Sat, 16 Apr 2011 13:14:27 +0200 (CEST)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171670>


Just now, some git server that is in the DNS rotation seems to have an 
issue,
$ telnet git.eu.kernel.org git
Trying 199.6.1.166...
Connected to git.eu.kernel.org.
Escape character is '^]'.
Connection closed by foreign host.

I thought it would be nice if git-fetch would retry the operation on 
the other DNS records that were returned if the connection breaks.
