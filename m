From: Thomas Koch <thomas@koch.ro>
Subject: Forking a CVS project
Date: Sun, 13 Apr 2008 10:19:43 +0200
Organization: Young Media Concepts
Message-ID: <200804131019.43201.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 11:05:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jky9k-00007w-Nm
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbYDMJFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 05:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbYDMJFE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:05:04 -0400
Received: from koch.ro ([195.34.83.107]:52203 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754297AbYDMJFB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 05:05:01 -0400
X-Greylist: delayed 2705 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Apr 2008 05:05:01 EDT
Received: from 231-56.62-81.cust.bluewin.ch ([81.62.56.231] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1JkxRA-00023A-HB
	for git@vger.kernel.org; Sun, 13 Apr 2008 10:19:48 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam_score: -1.6
X-Spam_score_int: -15
X-Spam_bar: -
X-Spam_report: Spam detection software, running on the system "ve825703057.providerbox.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Good day everybody, I'm a new disciple of GIT and eager to
	learn. My current problem is, that I'd like to track an old CVS project and
	make my own fork via GIT. The CVS project in question is horde[1]. My first
	attempt looked like: [...] 
	Content analysis details:   (-1.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	1.9 TVD_RCVD_IP            TVD_RCVD_IP
	-2.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79398>

Good day everybody,

I'm a new disciple of GIT and eager to learn.

My current problem is, that I'd like to track an old CVS project and make my 
own fork via GIT. The CVS project in question is horde[1]. My first attempt 
looked like:

mkdir horde
cd horde
export CVSROOT=":pserver:cvsread@anoncvs.horde.org:/repository"
git-cvsimport -v -C. .

But this did not work. I only got millions of lines like

WARNING: file /repository/horde/templates/index/frames_index.inc doesn't match 
strip_path /repository/CVSROOT/cfg.p. ignoring

So I imported each module separately:

MODULES="agora
ansel
chora
..."

for MODULE in $MODULES
do
    git-cvsimport -v -C$MODULE $MODULE
done

This took like 2 or 3 days and now I have one git repository for each module. 
But I'd rather have one big git repository containing all modules.

Could somebody give me a hint on how this could be achieved, please?

I also don't know CVS at all, because I started already with SVN. And I really 
don't want to learn CVS!

How do I keep track of the CVS repository after the import and merge the 
changes into my fork? Is there a way to not import the whole history, but to 
start my GIT repo with the current snapshot? Would that speed up the import?

[1] http://www.horde.org/source/using.php

Best regards,
-- 
Thomas Koch, Software Developer

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
