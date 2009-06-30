From: Tim <opensourcetim@yahoo.com>
Subject: correct workflow with bare repo and pull?
Date: Mon, 29 Jun 2009 17:01:15 -0700 (PDT)
Message-ID: <583913.73865.qm@web52205.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 02:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLQtF-0000YW-ON
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 02:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909AbZF3AHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbZF3AHx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 20:07:53 -0400
Received: from web52205.mail.re2.yahoo.com ([206.190.48.128]:20146 "HELO
	web52205.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753839AbZF3AHw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 20:07:52 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2009 20:07:52 EDT
Received: (qmail 81790 invoked by uid 60001); 30 Jun 2009 00:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1246320075; bh=SElJ3K55bLG5NqUKJYnBrk9iMYt+JEBVH7266O/TdUQ=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=X0X0wl4s/bdWGYnCuae5lIm6qmnbpp/hCrK4uRdAJVoirPpQLy1jQLGRh/DebmWZHTxCg9PsUpVU9/FpNCoxcqtK1CI7DD4hENrn0YY003IETajPfYsZnj7w20bOzhpBfGpn+O4RjnP76wiJ7i/9HCZRwI4fWIJMEpMCYpPxiT8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=gHnVGAKP7hIYnqLzsEHnFDdbL5NMWuqRcrXi+mxhbk9h8SorEz4rNM+UD53+u6pV86xWu/vjxnR2UByNBsOyCt+wBNzxPe2nEAZEAc1xDHGNgBPYiZhE2im7LSIQV+Z22mP/DgqvHNT1fQzGb1aAI6grERyOXrALRhd+riMlBos=;
X-YMail-OSG: lzInEA4VM1kycDNLUHDH1iQoKAIKkikv.N9G_HvSmWy4B33lWIeTT6CPF8sJKkHvY5xmcE__VRUbf6sofs0DDnYTZHGVTmaa.IS35ngffUHDtKNPUuqsKCH8kXJuVaWw2gQMtGxEu7v725MScsTk558IG2ZKqR3JbcmRGYzd5F4Ilnywq1TMjWcrXYtqJDEJjWKN4fyoxV5M17.bus1qo6Pd.wlKjRy1rt26Mwi66G4qXN9bCMd85MGbf4SUgjSl8jrZCEUkBIhkOSZbQ7TpzpuiW0xobAh01hqVOzWForbOYNraiar6Mk0NjCofKpGfMhZ15Ti2.A--
Received: from [70.99.96.178] by web52205.mail.re2.yahoo.com via HTTP; Mon, 29 Jun 2009 17:01:15 PDT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122477>


Myself and the other developer on the team have private repos, and we
push to a bare repo (which we use for Hudson builds).  For now we only
use the master branch.  No other remote repos.  When another developer
pushes changes to the bare repo, and I pull them, all of the files they
pushed show up as modified on my box when I do "git status" (even
though I had not modified them).  How to avoid this?   Also, one
developer saw really strange results when they did a "git pull origin
master" and "git status" -- the paths shown below do not exist in the
local work area.  These files have always lived under a-core/.... so it
is really odd that they show up under a-web
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#    new file:   a-web/src/main/java/com/blah/account/Account.java
#    new file:   a-web/src/main/java/com/blah/account/AccountType.java
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    deleted:    a-web/src/main/java/com/blah/account/Account.java
#    deleted:    a-web/src/main/java/com/blah/account/AccountType.java

What are we doing wrong?  


      
