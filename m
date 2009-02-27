From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] added -C option to chdir() into another directory first
Date: Fri, 27 Feb 2009 15:21:15 +0100
Message-ID: <49A7F6DB.7040403@drmicha.warpmail.net>
References: <1235679099-33994-1-git-send-email-kbrint@rufus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kevin brintnall <kbrint@rufus.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 15:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld3c6-0003MN-5d
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 15:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbZB0OVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 09:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbZB0OVZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 09:21:25 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55866 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753159AbZB0OVY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 09:21:24 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CF0552A5F5B;
	Fri, 27 Feb 2009 09:21:22 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Feb 2009 09:21:22 -0500
X-Sasl-enc: +mdUFEnxpXcxns9WsxnUcS0gUKGma9YR63N2jcRJeVNx 1235744482
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 39D9C27316;
	Fri, 27 Feb 2009 09:21:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090227 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1235679099-33994-1-git-send-email-kbrint@rufus.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111672>

kevin brintnall venit, vidit, dixit 26.02.2009 21:11:
> This allows things like 'git -C /somewhere pull' without specifying both
> --work-tree and --git-dir.
> 

I'm afraid you hit a somewhat reoccurring issue here. chdir'ing looks
simple, but it has many side effects, such as on relative paths (as
Junio pointed out) but also on the order of parsing config. Having -C as
a global git option would require dealing with all of these effects.

On the other hand, a shell function can achieve the same very easily.
The side effects are left to be dealt with by the user then ;)

Michael
