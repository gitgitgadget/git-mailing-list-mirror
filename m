From: Blaisorblade <blaisorblade@yahoo.it>
Subject: git-send-email: default values do not work
Date: Sat, 10 Feb 2007 18:15:45 +0100
Message-ID: <200702101815.45201.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 18:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFw76-0008G8-VG
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 18:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXBJReO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXBJReO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 12:34:14 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:31803 "HELO
	smtp006.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751486AbXBJReN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Feb 2007 12:34:13 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Feb 2007 12:34:12 EST
Received: (qmail 17384 invoked from network); 10 Feb 2007 17:27:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=B9da8QOPifrje6cLyR8/eHLb+L5rYQiBJWNQkd7DmYjXzw3NqBmPXGyiLEzLwpVNSKAHUFNMGYSuEhPLvL2cv/3803jDaU32xmuuWbunLUIRHndYP1hInLhKinnXQ/1AkbqhtMTAQ5ocZNb/zz4Qtioi2oPCxB9S1sWbl+pYGpg=  ;
Received: from unknown (HELO americanbeauty.home.lan) (blaisorblade@82.53.44.70 with login)
  by smtp006.mail.ukl.yahoo.com with SMTP; 10 Feb 2007 17:27:30 -0000
X-YMail-OSG: GGOxjAoVM1lWyBJQoiyESF9rDXULUVoRIOmF2eygd9w9YErIMJSmkmnIh9_3NigKFOb.8.c3ymsnMNYkNbVU4pEpx8tPzHF4cSSfyduAgPXyxydwYOnfDbWWmJnqy6Rb0NyF3Dm0sAQXDfK4VKuXjv5Fjx9ucU159nDud5ZUqf.Rlkp9bMC3HXUwSg--
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39245>

I'm using git v1.4.4.4, and trying to use directly git-send-email on plain 
files.

bug #1 (default values when prompting do not work)

According to git-send-email documentation, it should suggest default values 
when prompting the user.

However it does not, since ->readline does not accept a default value.

I've verified this in man Term\:\:ReadLine and by looking 
at /usr/share/perl/5.8.7/Term/ReadLine.pm, and with the perl debugger - the 
default is correctly calculated but not printed. At least with my perl 
(5.8.7, from up-to-date Ubuntu 6.06 LTS).

git-send-email should instead say "press Enter for default [$default]" and 
behave correspondingly.

bug #2 (subject line is cut away but ignored)

Additionally, I was sending a patch starting with (on 1st line):

Kconfig: FAULT_INJECTION can be selected only if LOCKDEP is enabled.

'Kconfig:' is interpreted as a mbox parameter, and ignored, and that line is 
removed from the email.

This should be documented and pitfall, and probably the user should be allowed 
to override that.

Thanks.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
