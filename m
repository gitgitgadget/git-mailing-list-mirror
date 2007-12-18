From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: preventing a push
Date: Tue, 18 Dec 2007 17:53:10 +0100
Message-ID: <4767FAF6.6050204@melosgmbh.de>
References: <4767BDD8.9080404@melosgmbh.de> <alpine.LFD.0.9999.0712180819480.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 17:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fix-0006Zt-7D
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761448AbXLRQyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760927AbXLRQyg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:54:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:16375 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761419AbXLRQye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:54:34 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDNT6n5rcY=
Received: from mail.melosgmbh.de (p5B07A85D.dip0.t-ipconnect.de [91.7.168.93])
	by post.webmailer.de (klopstock mo41) (RZmta 14.6)
	with ESMTP id i03c76jBIF7HST ; Tue, 18 Dec 2007 17:54:32 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.032,BAYES_00: -1.665,TOTAL_SCORE: -1.633
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Tue, 18 Dec 2007 17:54:30 +0100
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <alpine.LFD.0.9999.0712180819480.21557@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68780>

Linus Torvalds schrieb:
> 
> On Tue, 18 Dec 2007, Christoph Duelli wrote:
>> Is there a (recommended?) way to prevent accidental pushing (or pulling) from
>> one repository into another (like the level command from bk days)?
> 
> I used BK for years, never knew about any level thing. I assume that was 
> some way to introduce an "ordering" between repositories, where you could 
> only push/pull in a controlled manner?
Indeed, you can not move changes to a repo with a lower level.

> There's no obvious way to do exactly that, but the hooks git has may or 
> may not be ok. For example, if you want to disallow pushing into some 
> repository entirely (because you _only_ expect people to pull into it), 
> you should be able to just make a "pre-receive" hook that always returns 
> false. See Documentation/hooks.txt.
Ok, I will give hooks a try here.

> NOTE! There is no way to figure out what the pushing repository status is, 
> which is why I say there is no way to do a "level"-equivalent thing 
> (assuming I guessed what "level" does from the name). However, depending 
> on how you allow people to access the machine, the hook obviously can look 
> at things like $USER or other environment variables (ie you could make it 
> look at what machine the user connected from etc).
> 
> But nothing really ever identifies the source repository (on a "git 
> level") for a push: as far as git is concerned, all repositories are 
> equal, and your hooks would invariably have to use non-git knowledge to 
> figure out whether some operation should be allowed or not.
Perhaps it would be more git-like to use branches here. An accidental 
merge from a branch to another is probably less likely than an 
accidental push.

Thanks, and best regards

Christoph
