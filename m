From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected   transfer.
Date: Thu, 15 Feb 2007 22:23:59 -0500
Message-ID: <45D523CF.1060803@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net>
 <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D3C62D.6090609@verizon.net>
 <Pine.LNX.4.63.0702151629130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D4F6D4.9070703@verizon.net>
 <Pine.LNX.4.63.0702160137330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 04:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHthq-0000Qp-Eu
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 04:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161715AbXBPDYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 22:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161716AbXBPDYM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 22:24:12 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:10874 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161715AbXBPDYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 22:24:11 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDJ00A7KDFXOWEL@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 21:23:58 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702160137330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39881>

Johannes Schindelin wrote:
> It is not a usability issue if you are cleanly separating things which do 
> not belong together.
>
>   
This introduces order dependency that is otherwise not there. The order 
dependency makes perfect sense to one who understands the details, but 
otherwise seems arbitrary. (..still pondering what to do here).
> Example:
>
> #!/bin/sh
>
> (echo Hallo; echo Bello; echo; echo blabla) | \
> (
> 	while read line; do
> 		echo "$line"
> 		if [ -z "$line" ]; then
> 			break
> 		fi
> 	done
> 	echo "xxx"
> 	cat
> )
>
> In this case, shell reads the header until an empty line is encountered. 
> The rest is piped through cat. And it does not matter if "blabla" is text 
> or binary.
>   
Doh! (sometimes you just have to whack people over the head with a 2x4). 
Thanks.

Mark
