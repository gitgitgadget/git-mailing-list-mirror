From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Different svn-id URLs in history
Date: Tue, 07 Oct 2008 17:01:44 +0200
Message-ID: <48EB79D8.6090908@drmicha.warpmail.net>
References: <48EB40E1.40506@3d-radar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Knut Eldhuset <knut@3d-radar.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 17:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnE5W-0002qk-LL
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYJGPBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYJGPBu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:01:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55259 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250AbYJGPBt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2008 11:01:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5F3F3178157;
	Tue,  7 Oct 2008 11:01:48 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 07 Oct 2008 11:01:48 -0400
X-Sasl-enc: R1zM1Hy/9/j1N3dGQZC8IQkcGYQ718ZA8CVs+ByvkI85 1223391708
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C4AAF3C234;
	Tue,  7 Oct 2008 11:01:47 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48EB40E1.40506@3d-radar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97715>

Knut Eldhuset venit, vidit, dixit 07.10.2008 12:58:
> Hi,
> 
> After cloning my svn repository, I notice that the svn-id URL is 
> different when going back in history:
> 
> git-svn-id: https://server/trunk@300
> 
> vs
> 
> git-svn-id: https://server/trunk/some_folder/project/src@250
> 
> If i checkout the first version, I get a working copy that has the 
> folder "some_folder" in it. If I checkout the latter version, I get a 
> working copy with the contents of the folder "src". Why is this? I 
> thought I always was supposed to get a wc with the whole tree.
> 
> Regards,
> Knut Eldhuset

I take this is as an invitation for guesswork (given the amount of
details)...

You probably have commits which don't follow your usual svn repo layout
(trunk/some_folder/project/src) but commit to trunk/ directly. The output of

svn log -v -r300 https://server/trunk@300
svn log -v -r250 https://server/trunk/some_folder/project/src@250

should give some clues.

Michael
