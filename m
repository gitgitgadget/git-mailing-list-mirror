From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [BUG] Problem compiling documentation
Date: Thu, 04 Sep 2008 12:43:59 +0200
Message-ID: <48BFBBEF.6010403@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbCKu-0006l2-4J
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYIDKoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbYIDKoF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:44:05 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:64388 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDKoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:44:04 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id A3B8B25A6A;
	Thu,  4 Sep 2008 12:44:01 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 16703-01; Fri,  4 Jul 2008 02:08:54 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id A99D825A67;
	Thu,  4 Sep 2008 12:44:00 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94923>

Hi!

Trying to compile the documentation from next has failed for me for a
while and now I got to the point where I tracked down the offending
commit: 70a3f89733a (git-merge documentation: describe how conflict is
presented).

I don't have time to dig much deeper into this until later today, but it
seems to be that the conflict markers are interpreted to indicate a
section heading, that is then not correctly formated.  The error i get
is listed below.  Feel free to try to beat me to finding a nice solution. :)

I am using xmlto 0.0.21 and Asciidoc 8.2.7.

/Gustaf

xmlto -m callouts.xsl man git-merge.xml
xmlto: input does not validate (status 1)
/scratch/src/git/git/Documentation/git-merge.xml:551: parser error :
attributes construct error
"&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&gt;&gt;&gt;&gt;&gt;".  The p
                                 ^
/scratch/src/git/git/Documentation/git-merge.xml:551: parser error :
Couldn't find end of Start Tag link line 551
"&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&gt;&gt;&gt;&gt;&gt;".  The p
                                 ^
/scratch/src/git/git/Documentation/git-merge.xml:551: parser error :
Opening and ending tag mismatch: simpara line 550 and link
"&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&gt;&gt;&gt;&gt;&gt;".  The p
                                                   ^
/scratch/src/git/git/Documentation/git-merge.xml:552: parser error :
Opening and ending tag mismatch: refsect1 line 526 and simpara
typically your side, and the part after it is typically their
side.</simpara>

     ^
/scratch/src/git/git/Documentation/git-merge.xml:577: parser error :
attributes construct error
<simpara>In addition to the "&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&
                                                             ^
/scratch/src/git/git/Documentation/git-merge.xml:577: parser error :
Couldn't find end of Start Tag link line 577
<simpara>In addition to the "&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&
                                                             ^
/scratch/src/git/git/Documentation/git-merge.xml:577: parser error :
Opening and ending tag mismatch: simpara line 577 and link
<simpara>In addition to the "&lt;&lt;&lt;&lt;<link
linkend=""">"======="</link>&

       ^
/scratch/src/git/git/Documentation/git-merge.xml:582: parser error :
Opening and ending tag mismatch: refentry line 3 and simpara
viewing the original.</simpara>
                               ^
/scratch/src/git/git/Documentation/git-merge.xml:584: parser error :
Extra content at the end of the document
</refsect1>
^
