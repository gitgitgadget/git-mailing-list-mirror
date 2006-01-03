From: Andreas Ericsson <ae@op5.se>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories
 ?
Date: Tue, 03 Jan 2006 20:35:14 +0100
Message-ID: <43BAD1F2.8040209@op5.se>
References: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de> <1136315518.11946.28.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:35:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtrwH-0006iz-M9
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWACTfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 14:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWACTfS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 14:35:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:1240 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932410AbWACTfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 14:35:16 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 442F46BD08; Tue,  3 Jan 2006 20:35:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1136315518.11946.28.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14157>

Jon Loeliger wrote:
> 
> Could someone remind me where the <ref>..<ref> syntax
> is documented, please?  I went digging, but I am lame
> and couldn't find it.
> 

'man git-rev-parse' gets you the <committish> explanation. A ref is tag 
or a branch, and those are committish. A range such as 
<committish1>..<committish2> means "include all commits since and 
including <committish1>, leading up to (and including) <committish2>".

When Linus generates patches for the kernel he uses tags as <committish> 
and does something like this:
git diff v2.6.14..v2.6.15 | gzip -9f > linux-2.6.14-2.6.15.patch.gz

You can mix tags, commits and branches any way you like, so long as you 
get the commitological order right. That is, <committish2> should refer 
to a descendant of <committish1>.

"origin..HEAD" is a valid and fairly common range.
"HEAD..origin" is not (well, it is, but it doesn't include any commits 
since it's going backwards).

I don't know where to find a more complete explanation, but at least 
google should provide this one once it has gotten round to indexing this 
mail.

Now lets just have to hope I didn't get it all wrong. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
