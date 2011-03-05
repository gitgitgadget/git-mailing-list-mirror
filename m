From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 05 Mar 2011 03:33:26 -0800 (PST)
Message-ID: <m37hcd7qfv.fsf@localhost.localdomain>
References: <4D71D63E.3030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 12:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvpjq-0002Lq-Hh
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 12:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1CELd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 06:33:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1CELd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 06:33:28 -0500
Received: by fxm17 with SMTP id 17so2893593fxm.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 03:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=JMAhhQSDF3ct5pZUSteJahC6Lq5TxYZzWrVY88zfOVI=;
        b=Bk5K7iil6Lf79aOqISIf7wKQb/szmUT5A72qob+lNU1zb2e6H0Ldfgopyo1+krul2g
         NhYTBN+b+rKFI0ZpMBGH4F9LCXeB/FII3aobycawj6MHkXTVeyMWnrr/IF1gsPQePY6L
         OFOXgHxg6RvVnoG4uLv1kPJfu/nPo2w6mwwfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YjPnVtECAwe5x1s0+5lNcvmmdbRpL9FoH/LQ8pIwPBjnnKkeu8DdQXobm68nvxkMsC
         EuV8gvmn1/y6m/QaU1tukGvU2PsWGpR+GqEA9PmrujWh5we96GrDss1nUxrNFdERvuq8
         9vs+8TWjwI6JbDI3g2TS84cl67px4L07j99Ok=
Received: by 10.223.15.152 with SMTP id k24mr2029804faa.96.1299324807352;
        Sat, 05 Mar 2011 03:33:27 -0800 (PST)
Received: from localhost.localdomain (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id e17sm131626fak.34.2011.03.05.03.33.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 03:33:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p25BX8J2028958;
	Sat, 5 Mar 2011 12:33:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p25BWtkm028950;
	Sat, 5 Mar 2011 12:32:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4D71D63E.3030907@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168488>

Adam Monsen <haircut@gmail.com> writes:

> I made a fix a month ago on the master branch in a shared repo. A week
> later, a colleague did a merge that undid the fix. I didn't figure out
> the problem until just now because I'd been assuming the fix was still
> on master. I mean, if it wasn't, I should see a reverse patch using "git
> log -p master", right? Wrong. Turns out the fix was undone as part of
> merge conflict resolution (I think).
> 
> Is there some way to include merge conflict resolutions in "git log -p"
> or "git show"? Apparently some important information can be hidden in
> the conflict resolution. Or, more likely, I just don't understand how
> this bit of git works.

By default "git log -p" and "git show" considers merges uninteresting.
Try "git log -p -c" or "git log -p -m".
 
> I also tried bisect and pickaxe. Bisect wrongly identified the first bad
> commit, and pickaxe just didn't see the change at all.

I guess that pickaxe also needs -c or -m.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
