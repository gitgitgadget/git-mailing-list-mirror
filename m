From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [bug] git cannot find "git pull"?
Date: Mon, 15 Jun 2009 13:23:13 -0400
Message-ID: <4A368381.3040601@garzik.org>
References: <4A319CE1.6040201@garzik.org> <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org> <4A32A814.5050802@garzik.org> <20090612202642.GI5076@inocybe.localdomain> <4A32BF52.50603@garzik.org> <20090613150451.GK5076@inocybe.localdomain> <4A33E069.4050401@garzik.org> <20090613173600.GL5076@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:23:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGFtu-0002tD-G3
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbZFORXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZFORXH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 13:23:07 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37824 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbZFORXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 13:23:05 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MGFtj-0008C3-8L; Mon, 15 Jun 2009 17:23:08 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090613173600.GL5076@inocybe.localdomain>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121617>

Todd Zullinger wrote:
> Jeff Garzik wrote:
>> Found it!  A forgotten package I created, a collective of shell
>> scripts, was setting GIT_EXEC_PATH=/usr/local/bin.
> 
> Phew.  I was worried I might have to start drinking much earlier than
> usual today. ;)
> 
>> Given that /usr/local/bin/*git* has not existed on my systems for a
>> long time, it appears that this is a new behavior, being a bit more
>> strict in complaining about an invalid GIT_EXEC_PATH, rather than
>> simply falling back to the internal compiled default
>> (/usr/libexec/git-core).
> 
> Without looking closely at the make files and build logic, is it
> perhaps something caused by the previous Fedora git-1.6.0.x packages
> passing gitexecdir=%{_bindir} to make, while the F-11 and newer
> packages do not set any gitexecdir?

Perhaps, though it seems more likely that this was a change in the core 
git code, and not related to hardcoding gitexecdir= in the RPM build 
process.


	Jeff
