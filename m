From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 16:52:05 +0200
Message-ID: <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org> <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de> <20080724140959.GU2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807241537000.8986@racer>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2E0-0006Cb-8J
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391AbYGXOwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbYGXOwB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:52:01 -0400
Received: from mailer.zib.de ([130.73.108.11]:35656 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759383AbYGXOwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:52:00 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6OEpbPx018150;
	Thu, 24 Jul 2008 16:51:42 +0200 (CEST)
Received: from cougar.zib.de (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6OEpaMg001863
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 24 Jul 2008 16:51:36 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807241537000.8986@racer>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89893>


On Jul 24, 2008, at 4:38 PM, Johannes Schindelin wrote:

> On Thu, 24 Jul 2008, Dmitry Potapov wrote:
>
>> On Thu, Jul 24, 2008 at 08:06:29AM +0200, Steffen Prohaska wrote:
>>>
>>>  I am the maintainer of this project.  I know that this project  
>>> needs
>>>  crlf conversion, because it is a cross-platform project.
>>>  Therefore, I want to force crlf conversion for this specific
>>>  project, even if the user did not configure core.autocrlf=input on
>>>  Unix.
>>
>> I suspect that most problems with crlf is caused by Windows users who
>> have core.autocrlf=false for whatever reason (I suspect without a  
>> good
>> reason in most cases).
>
> Almost correct.  It is _unset_!  And it should be perfectly valid for
> users not having to set anything there.

Why is it unset?  Since 1.5.5, our installer sets core.autocrlf=true
on Windows.  So we *do* set a sane default for Windows users.

In the projects I am using git, the problematic platform is *Unix*.
To work around the default on Unix (core.autocrlf=false), I deliver
a custom script to our developers that verifies the setup on Unix and
complains if core.autocrlf is not set to "input".  Since I do this,
I haven't seen any further problems.

	Steffen
