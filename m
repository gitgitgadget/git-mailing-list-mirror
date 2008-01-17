From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [BUG] git send-email brakes patches with very long lines
Date: Thu, 17 Jan 2008 14:26:48 +0100
Message-ID: <478F5798.6020405@users.sourceforge.net>
References: <478F2994.9080708@users.sourceforge.net> <478F5478.7000200@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ryan Anderson <ryan@michonline.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 14:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFV0h-0004JP-11
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYAQNlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYAQNlx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:41:53 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:45943 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbYAQNlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 08:41:52 -0500
X-Greylist: delayed 1187 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2008 08:41:51 EST
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0HDZ5Rs020791;
	Thu, 17 Jan 2008 14:39:08 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.65] (pc1065.et.put.poznan.pl [150.254.11.65])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0HDQoD26619;
	Thu, 17 Jan 2008 14:26:51 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <478F5478.7000200@users.sourceforge.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.17.51147
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70859>

* Adam Piatyszek [17 I 2008 14:13]:
> The incorrect line wrapping with an exclamation mark is exactly at 990 
> column. Is there any limitation of the line size for text/plain messages?

Replying to myself again:

RFC2822 (Internet Message Format) states:

   2.1.1. Line Length Limits

     There are two limits that this standard places on the number of
     characters in a line. Each line of characters MUST be no more than
     998 characters, and SHOULD be no more than 78 characters, excluding
     the CRLF.

RFC2821 (Simple Mail Transfer Protocol) states:

   4.5.3.1 Size limits and minimums
   [...]
   text line
     The maximum total length of a text line including the <CRLF> is 1000
     characters (not counting the leading dot duplicated for
     transparency).  This number may be increased by the use of SMTP
     Service Extensions.


Now, the question is. Don't you think that "git send-email" should at 
least warn users that they are trying to send emails with patches that 
will be broken at the end?

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
