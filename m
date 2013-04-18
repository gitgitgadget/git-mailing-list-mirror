From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 16:25:56 +0200
Message-ID: <87k3nzx6dn.fsf@linux-k42r.v.cablecom.net>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
	<alpine.DEB.2.00.1304181146090.30868@ds9.cixit.se>
	<CAMP44s014Yv9+N7=0CYiYYybJCZJ7r-vQp_zcfg6Xo=3f21RWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 16:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USpmp-0007Gl-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 16:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965968Ab3DRO0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 10:26:01 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11452 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964989Ab3DRO0A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 10:26:00 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Apr
 2013 16:25:48 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 18 Apr 2013 16:25:56 +0200
In-Reply-To: <CAMP44s014Yv9+N7=0CYiYYybJCZJ7r-vQp_zcfg6Xo=3f21RWA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 18 Apr 2013 06:18:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221658>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 18, 2013 at 5:47 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
>
>>> % git log --oneline -1 v1.8.1.5^..v1.8.1.6
>>> % git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6
>>>
>>> I expect to get a different output, and not both showing v1.8.1.6.
>>> Wouldn't you agree?
>>
>>
>>  Quoting the manual page:
>>
>>  Commit Limiting
>>    Besides specifying a range of commits that should be listed using the
>> special notations explained in the description, additional commit limiting
>> may be applied. Note that they are applied before commit ordering and
>> formatting options, such as --reverse.
>>
>> Given that, I would expect the output to be the same.
>
> If expectations were based on documentation, all one has to do is
> document bugs, and there would be no bugs anymore :)
>
> Code can be changed to fit more appropriately user expectations (which
> are independent of documentation), and the documentation updated
> accordingly.

It's been this way forever, and applies to rev-list where we can't just
break how options work (for fear of breaking scripts).

You could come up with a patch series that first starts emitting
warnings whenever the user asks for behavior that will change, and later
flips the default and removes the warning (the latter would be merged
for 2.0 or so).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
