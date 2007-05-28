From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Mon, 28 May 2007 08:50:51 +0200
Message-ID: <200705280850.52323.jnareb@gmail.com>
References: <11803077771867-git-send-email-jnareb@gmail.com> <11803077792064-git-send-email-jnareb@gmail.com> <7v1wh1en8k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 08:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsYzQ-0003mo-EY
	for gcvg-git@gmane.org; Mon, 28 May 2007 08:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXE1Gpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 02:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXE1Gpu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 02:45:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:28187 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXE1Gpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 02:45:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1557987ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 23:45:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hHEt5o9Kmx2U9iAp3Hwj4L4YIPaQvFVEz158WRapJfG2yT37oYG+uGUlPhQq4A7e3gBMJNFtJbCjL52VkluyO9jDIdv6VjGgpw1uZhVOluyLNl0RfFSct+GV1NoKl5I0Xb8Qdpq21ML8b+aWXT9sgXsElGki+d/dfXGYa6TEHdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GbXYtSfcRll8gqnJpF3/GBO0YgWa39rpM0z7vtM/FKF4//MwxAzEsCWNkg5lqsDP6AOkL/Wbf9WlrSI74G7DtGXoObTx+bDWP2+g3kjFhmWGg6pCnqRkUZxIckHsT0O4w/fyWrfBBWxlw9YHWZ09ebMnwi4QoKMesPPcqWXO94g=
Received: by 10.67.88.17 with SMTP id q17mr5036656ugl.1180334748786;
        Sun, 27 May 2007 23:45:48 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm25905201mue.2007.05.27.23.45.47;
        Sun, 27 May 2007 23:45:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wh1en8k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48610>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Instead of using default, diff(1) like from-file/to-file header for
>> combined diff (for a merge commit), which looks like:
>>
>>   --- a/git-gui/git-gui.sh
>>   +++ b/_git-gui/git-gui.sh_
>>
>> (where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
>> header, using n/file for each or parents, e.g.:
>>
>>   --- 1/_git-gui/git-gui.sh_
>>   --- 2/_git-gui.sh_
>>   +++ b/_git-gui/git-gui.sh_
> 
> Sounds quite straightforward to implement, and diff with 1/
> would be useful to recreate what the person who did the merge
> pulled in, for most of the time.  I suspect diff with 2/ is
> almost always uninteresting, though.

Errr... it _is_ implemented in this patch, although code is not perfect
and has some unnecessary repetitions. But I thought before improving
code would it make sense to do this... and perhaps even add generated
extended diff headers for renames:

  rename at _2_ parent from _git-gui.sh_
  rename to _git-gui/git-gui.sh_

where as before _link_ denotes hyperlinked part. Hmmm?

-- 
Jakub Narebski
Poland
