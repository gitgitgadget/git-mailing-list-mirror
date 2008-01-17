From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [BUG] git send-email brakes patches with very long lines
Date: Thu, 17 Jan 2008 14:13:28 +0100
Message-ID: <478F5478.7000200@users.sourceforge.net>
References: <478F2994.9080708@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Ryan Anderson <ryan@michonline.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 14:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFV0z-0004PH-G0
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYAQNmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbYAQNmK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:42:10 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:45948 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYAQNmI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 08:42:08 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0HDF2p7020488;
	Thu, 17 Jan 2008 14:15:07 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.65] (pc1065.et.put.poznan.pl [150.254.11.65])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0HDDUD25793;
	Thu, 17 Jan 2008 14:13:30 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <478F2994.9080708@users.sourceforge.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.17.45954
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70860>

* Adam Piatyszek [17 I 2008 11:10]:
> Please find the attached two emails, which show this problem. The 
> original file (0001-Add-Dolph-Chebyshev-window.patch) was produced with 
> "git format-patch" from one of my private Git repositories. The other 
> file (0001-Add-Dolph-Chebyshev-window-sent.patch) includes the same 
> patch but sent with "git send-email". The problem is with the last hunk, 
> which is somehow broken by the "git send-email" tool. The very long 
> lines are wrapped and some exclamation marks are inserted.
> 
> The result of applying such a broken patch in my repository is as follows:
> 
> ===== >8 =====
> ediap@lespaul ~/git/itpp $ git am 0001-Add-Dolph-Chebyshev-window-sent.patch
> Applying Add Dolph Chebyshev window.
> fatal: corrupt patch at line 126
> Patch failed at 0001.
> When you have resolved this problem run "git-am --resolved".
> If you would prefer to skip this patch, instead run "git-am --skip".
> ===== >8 =====
> 
> If I send the same patch with mutt inlined or attached, the patch is not 
> broken and applies cleanly.

Sorry for the noise! It seems that it is not a problem of "git send-email".

I have just resent this patch to myself once again, this time using mutt 
"bounce" function, and it resulted in the broken patch in exactly the 
same way.

The incorrect line wrapping with an exclamation mark is exactly at 990 
column. Is there any limitation of the line size for text/plain messages?

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
