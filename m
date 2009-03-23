From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: put all startup code into a proc to enable re-sourcing
Date: Tue, 24 Mar 2009 00:40:33 +0100
Message-ID: <49C81DF1.6010208@users.sourceforge.net>
References: <87prh3e7p2.fsf@users.sourceforge.net> <18887.24242.451428.980685@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lltmc-0007pL-7J
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbZCWXkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 19:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZCWXkq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:40:46 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:56691 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752137AbZCWXkp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 19:40:45 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lltl4-0002qc-SU; Mon, 23 Mar 2009 23:40:42 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lltl4-0001yM-DS; Mon, 23 Mar 2009 23:40:42 +0000
Received: from [192.168.0.25] (pc025.patthoyts.tk [192.168.0.25])
	by badger.patthoyts.tk (Postfix) with ESMTP id C3A3C5182B;
	Mon, 23 Mar 2009 23:40:41 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <18887.24242.451428.980685@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114365>

Paul Mackerras wrote:
> Pat Thoyts writes:
> 
>>     All the startup code is moved into a procedure. All the variables
>>     get initialized using 'variable' to ensure they are in the global
>>     namespace.  This makes it possible to re-source the script during
>>     development from the Tk console or a tkcon interactive session.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> The patch does other stuff as well, that should be mentioned in the
> patch description or split out into a separate patch - namely it
> changes error_popup on win32 (why?) and it introduces some ttk widget
> use into confirm_popup.
> 
> Paul.

The changes to error_popup -- its fugly on windows. We have
tk_messageBox for showing message boxes and where available this
function will use a native messagebox which will look normal for the
platform.

However, these should be in the theme patch and not in a code
refactoring patch. So I apologize and will redo more carefully.

Pat Thoyts
