From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 19:49:59 +0100
Message-ID: <200701301950.00195.jnareb@gmail.com>
References: <17855.35058.967318.546726@lisa.zopyra.com> <17855.36470.309129.391271@lisa.zopyra.com> <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBy2J-0003eJ-SJ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbXA3Ssr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXA3Ssr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:48:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:17174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbXA3Ssq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:48:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1616053uga
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 10:48:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Gevo0RqgM5J+kfnLSuOpdfX0rOW2xv6WOMuuaJ4mMLbSz+dLgUMJmbVh2VWbA63chxEhG3I6ifS4WLrbP5aAMi8DXsOcHRaOfkozJ1npphqEThEl7MKdlt43GVY8+z2ys+//c54Vugqm+TbAEiDKtmzW290a361DQkiQ/zngF3Y=
Received: by 10.67.96.14 with SMTP id y14mr10542191ugl.1170182923551;
        Tue, 30 Jan 2007 10:48:43 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j34sm9045112ugc.2007.01.30.10.48.42;
        Tue, 30 Jan 2007 10:48:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38185>

Linus Torvalds wrote:
> On Tue, 30 Jan 2007, Bill Lear wrote:
>> 
>> % cd /repos/git/project
>> % ls
>> branches  description  HEAD   info     refs
>> config    FETCH_HEAD   hooks  objects  remotes
>> % cat HEAD
>> ref: refs/heads/master
> 
> Ok, HEAD points to "master".
> 
>> This repository was created like this:
>> 
>> % mkdir /repos/git/project
>> % cd /repos/git/project
>> % git --bare init-db --shared
>> % GIT_DIR=. git fetch git://xiphi/public/project topic:topic
> 
> ...but you don't _have_ any such branch. You only have a "topic"
> branch. 

...so "git clone" tries to checkout HEAD -> refs/heads/master
branch, which does not exist. It is strange that git does not
report error or at least warning, though...

-- 
Jakub Narebski
Poland
