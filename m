From: Andreas Ericsson <ae@op5.se>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 13:05:16 +0100
Message-ID: <43CB8BFC.8050900@op5.se>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de> <20060116085238.GA3768@fiberbit.xs4all.nl> <7vr778wmj3.fsf@assigned-by-dhcp.cox.net> <20060116101722.GB5196@fiberbit.xs4all.nl> <43CB753D.2030706@op5.se> <20060116113332.GA5356@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 13:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyT6v-0002UX-Sh
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 13:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAPMFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 07:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWAPMFS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 07:05:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41156 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750722AbWAPMFS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 07:05:18 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DDAFE6BCBE; Mon, 16 Jan 2006 13:05:16 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060116113332.GA5356@fiberbit.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14742>

Marco Roeland wrote:
> On Monday January 16th 2006 Andreas Ericsson wrote:
> 
> 
>>Since "pu" = "proposed updates" it only makes sense to keep it on top of 
>>the current master, otherwise the effort required for anyone to test it 
>>in conjunction with the latest master branch would simply be too great.
> 
> 
> But couldn't (in theory) the new "rebased" versions of blobs in the "pu"
> branch be first committed as the old not yet rebased version and then
> as the new version.


The blobs are immutable and never change for a rebase, unless the 
file(s) it applies to is changed in master as well. It's the commits 
that do because they get new parents.

Remember that the blob object is just the (deltified?) file that's the 
result of the commit operation. The commit object is an object in its 
own rights, holding author info and commit-time and such. Do

	$ git cat-file commit HEAD

and you'll see what a commit-object looks like.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
