From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] cvsimport: ease migration from CVSROOT/users format
Date: Sun, 15 Jan 2006 21:50:22 +0100
Message-ID: <43CAB58E.7090707@op5.se>
References: <7vbqyd684p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 21:52:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyErZ-0000Gh-6K
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 21:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWAOUup (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWAOUu0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 15:50:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:23999 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750771AbWAOUuY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 15:50:24 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 122E66BCBE; Sun, 15 Jan 2006 21:50:23 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqyd684p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14708>

Junio C Hamano wrote:
> 
>  * Andreas, I also tweaked the regexp to parse the native format
>    from /^([^ \t=]*)[ \t=]*([^<]*)(<.*$)\s*/
>    to /^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/.  I think this tweak is
>    correct, but I would appreciate if you can proofread and ACK
>    on it.  The differences are:
> 

It looks correct and seems to do the trick.


>    - We grabbed <> pairs and stored in author_email (this is a
>      bugfix).
> 

gitk showed them as a single such even though theye were passed double. 
Perhaps some other tool stripped it along the way? Good catch anyways.

> +		}
> +		# NEEDSWORK: Maybe warn on unrecognized lines?
>  	}

I don't think so. I think it's safe to assume that people will check and 
double-check that everything's correct before removing the CVS repo, so 
it should be easy enough to redo the import (although possibly 
time-consuming).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
