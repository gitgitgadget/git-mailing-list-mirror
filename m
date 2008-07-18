From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 01:45:23 -0700 (PDT)
Message-ID: <m363r3y42v.fsf@localhost.localdomain>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	<alpine.DEB.1.00.0807171311010.8986@racer>
	<320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	<320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
	<alpine.DEB.1.00.0807171351380.8986@racer>
	<320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
	<alpine.DEB.1.00.0807171513560.8986@racer>
	<320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
	<20080717182253.GZ32184@machine.or.cz>
	<320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 10:46:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlbn-0007V0-EZ
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 10:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYGRIp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYGRIp3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 04:45:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:44808 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbYGRIp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 04:45:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so115897fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=tqi3cnvsjeANXjNxU18FCamzeAif6CHEj44al26UARQ=;
        b=RQg9YZAa79FP8E0ALm7QcFRvPTixbEMBqOdtq6KmY2m4FTaqAdgElFKcX0qWZOhC1q
         bF3mWoO/59vuwUl2YZL7cPiMFqYpdlpseTYZdqozDB/D2u07qCKmrAanEDekLLTKOIHv
         pyPJ0gtUListxxTFtU2UPceX4H462VFMPRSTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=dOYsLqIahE2Y2rha9G8b7yPKbtpgja3eACDOwtkPRdWmD/U5+Faw9TPyIqr2IsncWF
         SQOXQ1UH8TCX3D2dTXkEseuyt70dyAFW30qO7U5sGOLhgny/lQS1Nv3zPkg2lIJ0ps7W
         Z4sfNc1MAG08k9+xEh66tXu9DJn5TPgIjdB2c=
Received: by 10.86.70.8 with SMTP id s8mr5536711fga.31.1216370724412;
        Fri, 18 Jul 2008 01:45:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.74])
        by mx.google.com with ESMTPS id l12sm1773173fgb.6.2008.07.18.01.45.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 01:45:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6I8iXE4003638;
	Fri, 18 Jul 2008 10:44:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6I8i9RU003631;
	Fri, 18 Jul 2008 10:44:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89009>

"Nigel Magnay" <nigel.magnay@gmail.com> writes:

> On Thu, Jul 17, 2008 at 7:22 PM, Petr Baudis <pasky@suse.cz> wrote:
>> On Thu, Jul 17, 2008 at 04:07:11PM +0100, Nigel Magnay wrote:
>>> And it works, but
>>>
>>> $ git pull fred
>>> $ git submodule update
>>>
>>> Can leave you with problems, because if a submodule wasn't pushed to
>>> origin, you won't have it available. This is because the commands are
>>> equivalent to
>>>
>>> $ git pull fred
>>> for each submodule()
>>>   cd submodule
>>>   git fetch origin
>>>   git checkout <sha1>

> "Someone says 'please review the state of my tree, _before_ I push it
> out to a (central) repository"
> 
> Fred is a person (and != origin). His tree(s) are entirely correct and
> consistent, and he doesn't yet wish to push to origin (and perhaps he
> cannot, because he does not have permission to do so).
> 
> All the tutorials give credit to the fact that in git you don't need a
> central server - you can pull directly from people. Except in the case
> where you're using submodules, where you're basically forced to
> hand-modify .git/config (in this instance, to point to where 'fred' is
> storing his submodule trees) before doing a submodule update. This
> makes git complicated for users.
> 
> I'm trying to improve the UI for projects using submodules to make it
> mostly transparent; the best way I can come up with is to pick on
> individual usecases and show that they're a particular pain and that
> perhaps they don't need to be.

I _think_ that you can currently work around this problem by using
URL rewriting (url.<base>.insteadOf).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
