From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Commit to wrong branch. How to fix?
Date: Fri, 04 Sep 2009 18:19:00 +0200
Message-ID: <4AA13DF4.4050604@drmicha.warpmail.net>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Howard Miller <howardsmiller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjbVV-0005ol-7z
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 18:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbZIDQTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbZIDQTM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 12:19:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38371 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932404AbZIDQTL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 12:19:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C045E62666;
	Fri,  4 Sep 2009 12:19:12 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Sep 2009 12:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pkpdm7+tKoEgs/wAjEp+xTqy1V8=; b=W5vgIIE/GYefj0bJsFQfy2JZar8aRFMtG/dzA09P/kwItoZJuSIvMhODiEHy1G+Qvr3HVoVr+bE5+RMOPEwVolm1HFxsHqd1ShtakutncqcaIJ3uiTSU+uUjJGJQaA2cRm49iKy8iRufRkrSKZR9cJq25H6xJHysz0BXXFuMcgk=
X-Sasl-enc: 7UYAygC4reRL6/oL2o5SzgwRHvxXim6mSiJlJcDw564S 1252081152
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 03FDB39A1F;
	Fri,  4 Sep 2009 12:19:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127739>

Howard Miller venit, vidit, dixit 04.09.2009 17:54:
> I commited to the wrong branch and I can't figure out what to do. To  
> make matters worse I then did 'git reset HEAD^' which has made things  
> much worse. It didn't remove the commit and now I can't change  
> branches. I'm utterly confused. Any help much appreciated!
> 
> Moral - use git status liberally and read it carefully before doing  
> anything. A 'git undo" command would be great is someone is feeling  
> generous :-) 

Whatever happens, don't panic ;)

Let's say "geesh" is the branch on which you committed by mistake, and
which you have reset.

git reflog geesh

which show you what has happened to that branch lately. In particular,
it will list the "lost" commit. (Most probably it is the same as geesh@{1}.)

git tag sigh sha1ofthatcommit

will assign the tag "sigh", so that it won't get lost by doing "git gc"
or such. Now you can lean back!

Next step is committing "sigh" to the right branch. Depends on how you
arrived at that commit. Did you commit the complete tree you wanted, or
did you apply a change to geesh which you rather had wanted applied to
some other branch?

Michael
