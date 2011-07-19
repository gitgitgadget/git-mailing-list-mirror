From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/2] git-gui blame add more common search hotkeys
Date: Tue, 19 Jul 2011 15:35:30 +0100
Message-ID: <87sjq2cp8t.fsf@fox.patthoyts.tk>
References: <20110716165945.GA9722@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 16:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjBOq-0000ug-Km
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 16:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab1GSOfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 10:35:47 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:64399 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750933Ab1GSOfq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 10:35:46 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20110719143531.TVIQ3933.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 19 Jul 2011 15:35:31 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1QjBOV-00056a-15; Tue, 19 Jul 2011 15:35:31 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4BAAF2184E; Tue, 19 Jul 2011 15:35:30 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110716165945.GA9722@spacedout.fries.net> (David Fries's
	message of "Sat, 16 Jul 2011 11:59:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=Sd389fHXx1AA:10 a=kj9zAlcOel0A:10 a=liYg6YWNAAAA:8 a=FP58Ms26AAAA:8 a=Rf460ibiAAAA:8 a=WA7Vqokh4QT3Kg_FmVgA:9 a=TuU1RXZXX-c1ZQBNDrkA:7 a=CjuIK1q_8ugA:10 a=cfdf5vFXyx0A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177456>

David Fries <david@fries.net> writes:

>add slash and Control-S to bring up search
>enter, n, Shift-Enter, Shift-n to to go the next and previous entries
>
>search hotkey return is find_next shift prev
>
>Signed-off-by: David Fries <David@Fries.net>
>

Thank you for this. It looks like a useful feature and I'll apply this
to git-gui with some modifications. Note that Paul Mackerras is the
maintainer of gitk not git-gui.

It is worth putting a bit more detail into the commit message as in
general that is all the context a maintainer has to decide what the
patch is doing and how it should be tested. In this case I'll replace it
with the following:

   git-gui: Add keyboard shortcuts for search and goto commands in blame
   view.

   Use forward-slash or Control-S to bring up the search dialog.
   In the blame view, Enter or 'n' jump to the next selected region
   while
   Shift-Enter or Shift-n will jump to the previous selected region.
   Within the search control, hitting Enter will now jump to the next
   matching
   region.

   Signed-off-by: David Fries <David@Fries.net>
   Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

That aside, the goto-line feature works fine for me. I don't think the
n, Shift-n binding is working though. When I have the focus in the blame
window and enter 'n' it tries to add an 'n' to the text in the search
box. The use of Enter and Shift-Enter makes sense and works as I
expect. So I will drop the 'n' and 'Shift-n' bindings I think.

The -accelerator field on a menu specifies the text to show. Its more
usual to show "Ctrl-G" than "Control-Key-G" here so I'll adjust that as
well. The 'bind' command actually ties up the key binding to the menu
action.

With the above changes, I'll apply this to git-gui's master (which lives
at repo.or.cz/git-gui.git) and it will get merged into git on the next
merge.

Cheers,
Pat Thoyts

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
