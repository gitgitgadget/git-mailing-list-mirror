From: =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Subject: Re: Bypassing hooks while cherry-picking
Date: Thu, 3 Mar 2016 23:20:05 +0100
Message-ID: <56D8B895.9030308@greg0ire.fr>
References: <56D576A1.3020202@greg0ire.fr>
	<xmqqwppj1c83.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:25:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbgt-0000uD-AO
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758549AbcCCWZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 17:25:45 -0500
Received: from smtp24.services.sfr.fr ([93.17.128.81]:3156 "EHLO
	smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273AbcCCWZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:25:44 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Mar 2016 17:25:44 EST
Received: from filter.sfr.fr (localhost [84.99.208.145])
	by msfrf2406.sfr.fr (SMTP Server) with ESMTP id DEEF5180005F8;
	Thu,  3 Mar 2016 23:20:05 +0100 (CET)
Authentication-Results: sfrmc.priv.atos.fr; dkim=none (no signature);
	dkim-adsp=none (no policy) header.from=postmaster@greg0ire.fr
Received: from [192.168.1.22] (145.208.99.84.rev.sfr.net [84.99.208.145])	(using TLSv1
	with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)
	by msfrf2406.sfr.fr (SMTP Server) with ESMTP id B72F0180005EE;
	Thu,  3 Mar 2016 23:20:05 +0100 (CET)
X-SFR-UUID: 20160303222005750.B72F0180005EE@msfrf2406.sfr.fr
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
In-Reply-To: <xmqqwppj1c83.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288217>

Not sure how cherry-picking is managed, and whether commit is able to=20
see that we are doing a cherry-pick, and end it up properly. Anyway,=20
with Kevin's patch, we should be able to happily use cherry-pick

greg0ire

Le 03/03/2016 22:30, Junio C Hamano a =E9crit :
> greg0ire <postmaster@greg0ire.fr> writes:
>
>> Steps to reproduce :
>>
>> 1. create a pre-commit hook
>> 2. create a commit that fails the hook, and bypass the hook
>> 3. checkout another branch
>> 4. might be optional : create a conflicting change with the previous=
ly
>> created commit
>> 5. cherry-pick the commit
>> 6. might be optional : solve the conflick and use git cherry-pick --=
continue
> Wouldn't "commit --no-verify" at that last step, instead of
> "cherry-pick --continue", just work?
>
>
