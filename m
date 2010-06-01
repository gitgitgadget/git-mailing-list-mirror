From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: git send-email should always ask for in-reply-to
Date: Tue, 1 Jun 2010 16:41:12 +0200
Message-ID: <201006011641.12401.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 17:31:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTRA-0001jY-2W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab0FAPbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:31:23 -0400
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:39070 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601Ab0FAPbW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:31:22 -0400
X-Greylist: delayed 3006 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2010 11:31:22 EDT
Received: from 178-25-116-20-dynip.superkabel.de ([178.25.116.20] helo=ws-stein.localnet)
	by jessica.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alexander.stein@informatik.tu-chemnitz.de>)
	id 1OJSeZ-0000Bw-JN
	for git@vger.kernel.org; Tue, 01 Jun 2010 16:41:15 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.32-gentoo-r7; KDE/4.3.5; x86_64; ; )
X-Spam-Score: -1.0 (-)
X-Spam-Report: --- Start der SpamAssassin 3.3.0 Textanalyse (-1.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 8a8fa125b9cc748093f12ed7809f170b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148128>

Hi,

i currently have the problem that, if I set sendemail.from and sendemail.to in 
git-config (from global and to project-specific but that doesn't matter) git 
send-email doesn't ask me for a in-reply-to message-ID. I set these 2 config 
options for convenience. But i also want to specify a message-id after calling 
git send-email to get a proper thread on the mailing list.
I dived into git-send-email.perl and found $prompting which is only != 0 if 
$sender or @to isn't already set (lines 672-685). On line 706-709 there are 
some check whether $initial_reply_to should be asked or not. If $prompting is 
sitll 0 $initial_reply_to will not be asked.
In my opinion git send-email should always ask for in-reply-to. I know there 
is --in-reply-to option but this keeps me from using the git command from 
shell history as i have to modify the parameter each time.

What do you think about it?
Best regards
Alexander
