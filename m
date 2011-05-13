From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about git-cherry and the rev list it's using
Date: Fri, 13 May 2011 08:54:37 +0200
Message-ID: <BANLkTi=qRbpBG_PDPjO_TVEe+nWqrFQ28w@mail.gmail.com>
References: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
	<4DCB826F.5020406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 13 08:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKmGq-0000GV-DO
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 08:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab1EMGyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 02:54:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32877 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258Ab1EMGyi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 02:54:38 -0400
Received: by pvg12 with SMTP id 12so1034738pvg.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xCq/djo5xBNCdiTG28G5/q9R9wqCjf4Lxf7QwI9BWgY=;
        b=QuRKjB4xEPCoBpJJE1zbVvDIJGy0KqNuezJ3aNoRY9esprqcNT5IP/DRfIErHD0/Ey
         PZpZ5GsGSYuPu4lOfTiqnh4YHpOiOYcTmHkNAJEVsLhee75oNTA4qH5sfuETfnGH7DbV
         04Tzx9xwh27VB6fheLUCc+u3LE3G0HJRTraaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sFgmI0oTb4p+28QudYae+OAWqfOVWWQfXGPBHUFgfQ16aVpQCpStM6SFv6GoZKwmAL
         XdoZK9rphMWJnSprD/P0KnDcIIBrFVEjUbba9xmb8khDOjbHYJZ38UPi9p0DrGC9e7o3
         tLa7HCcoC8Z3LEbEbRIkYJOwCs7vfNFvDC9jI=
Received: by 10.143.78.14 with SMTP id f14mr693459wfl.110.1305269677915; Thu,
 12 May 2011 23:54:37 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Thu, 12 May 2011 23:54:37 -0700 (PDT)
In-Reply-To: <4DCB826F.5020406@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173506>

[ resending to the mailing list too ]

On Thu, May 12, 2011 at 8:47 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Francis Moreau venit, vidit, dixit 11.05.2011 18:11:
>> Hello,
>>
>> I'm using "git cherry old master base" to see if all commits between
>> master and base have been applied in my 'old' branch.
>>
>> So I expect that git cherry is using a list of commits given by : "git
>> rev-list --no-merges base..master".
>
> Not really.
>
> For each commit in "--no-merges old..master ^base" (i.e. "--no-merges
> master ^old ^base"), "git cherry" checks whether there is a patch
> equivalent commit in "--no-merges master..old", and outputs it with + or -.
>

oh you're right, I missed the case when old has been merged in master.

Thanks !
-- 
Francis
