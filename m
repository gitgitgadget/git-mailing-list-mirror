From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [bug] git cannot find "git pull"?
Date: Sat, 13 Jun 2009 13:22:49 -0400
Message-ID: <4A33E069.4050401@garzik.org>
References: <4A319CE1.6040201@garzik.org> <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org> <4A32A814.5050802@garzik.org> <20090612202642.GI5076@inocybe.localdomain> <4A32BF52.50603@garzik.org> <20090613150451.GK5076@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 19:23:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFWwV-0002Wu-9X
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 19:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbZFMRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbZFMRWt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 13:22:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52137 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbZFMRWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 13:22:48 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MFWwL-0002a2-HT; Sat, 13 Jun 2009 17:22:50 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090613150451.GK5076@inocybe.localdomain>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121510>

Todd Zullinger wrote:
> Jeff Garzik wrote:
>> FWIW, to reproduce my Fedora install, this is the setup I always use
>> for my lab computers:
>>
>> * perform a fresh format + install, not an upgrade
>> * uncheck 'office' category
>> * check 'software development' category
>> * do not select 'customize now', thus using Fedora's default package
>> selection
> 
> Stranger and stranger.  I followed the above steps with an F-11/x86
> network install and then ran:

Found it!  A forgotten package I created, a collective of shell scripts, 
was setting GIT_EXEC_PATH=/usr/local/bin.

Given that /usr/local/bin/*git* has not existed on my systems for a long 
time, it appears that this is a new behavior, being a bit more strict in 
complaining about an invalid GIT_EXEC_PATH, rather than simply falling 
back to the internal compiled default (/usr/libexec/git-core).

Things are working again now that the local GIT_EXEC_PATH export is removed.

	Jeff
