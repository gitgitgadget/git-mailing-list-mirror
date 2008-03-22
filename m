From: "Fedor V. Sergeev" <theodor@geo.phys.spbu.ru>
Subject: hg-to-git performance on big repos
Date: Sat, 22 Mar 2008 16:34:22 +0300 (MSK)
Message-ID: <20080322162618.K47359@geo.geo.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 14:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd3yZ-00053v-Cn
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 14:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbYCVNks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYCVNkr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 09:40:47 -0400
Received: from geo.phys.spbu.ru ([195.19.235.110]:62331 "EHLO geo.phys.spbu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbYCVNkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 09:40:47 -0400
X-Greylist: delayed 770 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Mar 2008 09:40:46 EDT
Received: from geo.phys.spbu.ru (localhost [127.0.0.1])
	by geo.phys.spbu.ru (Postfix) with ESMTP id 5FAC7688AE
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 16:40:45 +0300 (MSK)
Received: from geo (geo.geo.loc [192.168.15.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by geo.phys.spbu.ru (Postfix) with ESMTP id A9FF8688AD
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 16:40:44 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by geo.phys.spbu.ru (8.13.1/8.13.1/SMPEV) with ESMTP id m2MDYMJl047382
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 16:34:23 +0300 (MSK)
	(envelope-from theodor@geo.phys.spbu.ru)
X-X-Sender: theodor@geo.geo.loc
X-Antivirus: Dr.Web (R) for Mail Servers on geo host
X-Antivirus-Code: 100000
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on geo
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77803>

Folks,

I'm trying to convert a relatively big Mercurial repo (70K commits) into Git using
contrib/hg-to-git.
It initially goes fine but starts to slow down nearly exponentially as the
number of converted changesets goes up.

git-fast-import seems to just hang around, while all the work (100% cpu)
is spent in that python thing. It does not eat up memory, pstack looks
fine, but after some 10K commits it just crawls.

It did not finish in 2 days and after that machine got a power down :(

Can anybody tell me is this normal or what?

thanks in advance,
  Fedor.
P.S. Yeah, if that does matter I'm doing it on OpenSolaris ;)
