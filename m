From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Thu, 24 Apr 2014 09:26:19 -0500
Message-ID: <8538h24xdg.fsf@stephe-leake.org>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com> <53558f6269f91_640076f2f08f@nysa.notmuch>
	<857g6h5ssh.fsf@stephe-leake.org>
	<5356996d12ede_3e5aed7308e5@nysa.notmuch>
	<85mwfc4hab.fsf@stephe-leake.org>
	<535782d95bbed_24448772ec7a@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 16:26:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdKbg-00014T-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 16:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529AbaDXO0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 10:26:25 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:35667 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757365AbaDXO0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2014 10:26:24 -0400
Received: from [75.87.81.6] ([75.87.81.6:52667] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 68/8F-16062-C0F19535; Thu, 24 Apr 2014 14:26:21 +0000
In-Reply-To: <535782d95bbed_24448772ec7a@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 04:07:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246970>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> >> I have a branch which should always be recompiled on update;
>> >> post-update-branch would be a good place for that.
>> >
>> > And why would pre-update-branch not serve that purpose?
>> 
>> Because the code that needs to be compiled is not yet in the workspace
>
> And it won't be in 'post-update-branch' either.

Then you are using a very odd definition of "post update"

>  % git checkout master
>  % git branch feature-a stable
>  <- update-branch hook will be called here
>
> The hook will get 'feature-a' as the first argument, but the code in the
> workspace would correspond to 'master'; the checked out branch (pre or post).

Then the hooks should be called 'pre-branch', 'post-branch'; there is no
"update" involved.

The hook I need is actually "post-merge", since "merge" is the command that
updates the workspace.

Sorry for the noise.
-- 
-- Stephe
