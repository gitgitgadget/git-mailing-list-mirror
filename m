From: Samuel Abels <newsgroups@debain.org>
Subject: Re: Performance impact of a large number of commits
Date: Sat, 25 Oct 2008 17:12:33 +0200
Message-ID: <1224947553.7566.48.camel@localhost>
References: <1224874946.7566.13.camel@localhost>
	 <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>
	 <1224878202.7566.25.camel@localhost>
	 <alpine.DEB.1.10.0810241301430.27333@asgard.lang.hm>
	 <1224911915.7566.35.camel@localhost>
	 <alpine.DEB.1.10.0810242219440.20238@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Oct 25 17:14:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktkq6-0005rd-65
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 17:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbYJYPMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYJYPMg
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 11:12:36 -0400
Received: from mail.speedpartner.de ([91.184.32.3]:35734 "EHLO
	mail.speedpartner.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbYJYPMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 11:12:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.speedpartner.de (Postfix) with ESMTP id 8175EB3CAF;
	Sat, 25 Oct 2008 17:12:34 +0200 (CEST)
Received: from mail.speedpartner.de ([127.0.0.1])
	by localhost (mail.speedpartner.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8skELobgKU2; Sat, 25 Oct 2008 17:12:34 +0200 (CEST)
Received: from [192.168.0.3] (stgt-4d02f7a8.pool.mediaWays.net [77.2.247.168])
	by mail.speedpartner.de (Postfix) with ESMTP id 3F096B3CAC;
	Sat, 25 Oct 2008 17:12:33 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.10.0810242219440.20238@asgard.lang.hm>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99113>

On Fri, 2008-10-24 at 22:29 -0700, david@lang.hm wrote:
> when git stores the copies of the files it does a sha1 hash of the file 
> contents and then stores the file in the directory
> .git/objects/<first two digits of the hash>/<hash>

> it would be a pretty minor change to git to have it use more directories 

Ah, I see how this works. Well, I'll think of a way to cope with this (I
might patch my Git installation, or see how well it performs on an
indexed file system). If all else fails we'll have to slash the number
of commits even if this means that some files are not added to the
history.

> my concern is that spending time creating the pack files will mean that 
> you don't have time to insert the new files.
> 
> that being said, there may be other ways of dealing with this data rather 
> than putting it into files and then adding it to the git repository.
> 
> Git has a fast-import streaming format that is designed for programs to 
> use that are converting repositories from other SCM systems.

I'm pretty sure that the streaming format won't do us much good, as the
files are re-created from scratch between commits.

Thanks a lot for the information, this was very helpful.

-Samuel
