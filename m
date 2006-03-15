From: Andreas Ericsson <ae@op5.se>
Subject: Re: seperate commits for objects already updated in index?
Date: Wed, 15 Mar 2006 20:43:12 +0100
Message-ID: <44186E50.6090400@op5.se>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>	<Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>	<Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>	<Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>	<7vwtewk2jp.fsf@assigned-by-dhcp.cox.net>	<7vy7zcie5c.fsf@assigned-by-dhcp.cox.net> <44181DFE.7080204@op5.se> <7vlkvbik8f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jakma <paul@clubi.ie>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 20:43:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJbtu-00077M-1a
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 20:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWCOTnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 14:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOTnP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 14:43:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44753 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750783AbWCOTnO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 14:43:14 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F04416BD24; Wed, 15 Mar 2006 20:43:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkvbik8f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17614>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Can't this be done by updating .git/index first and then use the
>>temporary index to commit? Then .git/index would match the current
>>tree and everybody would be happy with very little tweaking. Doing the
>>temporary index commit first could cause data-loss as described above
>>if the updating of .git/index somehow fails and the user is unaware of
>>it (or what to do to fix it).
> 
> 
> You have to think about how to rewind it when the user decides
> later not to commit by for example giving an empty commit
> message or killing the editor.  The order of things need to be
> to populate the index to be committed so that we can give
> preview in the commit log template upon 'commit -v', spawn the
> editor and get the final version of log, and then make a
> commit.  So it may or may not be doable -- I haven't thought
> about it through, and currently have not much incentive nor
> inclination to think about it myself right now.
> 

cp .git/index .git/pre-commit-index

and roll it back if the user aborts. Should work, but like you I don't 
need that functionality, so...

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
