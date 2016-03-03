From: =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Subject: Re: Bypassing hooks while cherry-picking
Date: Thu, 3 Mar 2016 23:18:29 +0100
Message-ID: <56D8B835.5040407@greg0ire.fr>
References: <56D576A1.3020202@greg0ire.fr>
	<20160303211738.GA26609@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:25:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbgs-0000uD-Kh
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbcCCWZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 17:25:46 -0500
Received: from smtp24.services.sfr.fr ([93.17.128.81]:42494 "EHLO
	smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758485AbcCCWZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:25:45 -0500
Received: from filter.sfr.fr (localhost [84.99.208.145])
	by msfrf2406.sfr.fr (SMTP Server) with ESMTP id 00ED0180005F7;
	Thu,  3 Mar 2016 23:18:31 +0100 (CET)
Authentication-Results: sfrmc.priv.atos.fr; dkim=none (no signature);
	dkim-adsp=none (no policy) header.from=postmaster@greg0ire.fr
Received: from [192.168.1.22] (145.208.99.84.rev.sfr.net [84.99.208.145])	(using TLSv1
	with cipher DHE-RSA-AES128-SHA (128/128 bits))	(No client certificate requested)
	by msfrf2406.sfr.fr (SMTP Server) with ESMTP id C3695180005EE;
	Thu,  3 Mar 2016 23:18:30 +0100 (CET)
X-SFR-UUID: 20160303221830800.C3695180005EE@msfrf2406.sfr.fr
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
In-Reply-To: <20160303211738.GA26609@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288218>

Oh great, glad to see that, good job!

greg0ire

Le 03/03/2016 22:17, Kevin Daudt a =E9crit :
> On Tue, Mar 01, 2016 at 12:01:53PM +0100, greg0ire wrote:
>> Hello,
>>
>> using git 2.1.4 here, and it seems there is no option to bypass pre-=
commit
>> hooks while cherry-picking, while git commit provides a --no-verify =
option.
>> I ended up doing this to disable hooks while cherry picking :
>>
>>      test -f "$GIT_DIR"/CHERRY_PICK_HEAD && exit 0
>>
>> Wouldn't it be best to add the --no-verify option to cherry-pick too=
?
>> I had a conflict when cherry-picking the commit, maybe this does not=
 happen
>> otherwise?
>>
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
>>
>> Regards,
>>
>> --
>> greg0ire
> Forgot to CC you, but I've submitted a patch[0] that adds this option=
=2E
> The conflict does matter because otherwise the pre-commit hook does n=
ot
> run.
>
> Because they're now the rc-cycle, it might take a while before the pa=
tch
> is accepted.
>
>
> [0]:http://article.gmane.org/gmane.comp.version-control.git/288124
>
