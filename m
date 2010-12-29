From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help for a git newbie please
Date: Wed, 29 Dec 2010 10:58:11 -0800 (PST)
Message-ID: <m3k4iscsq2.fsf@localhost.localdomain>
References: <20053D7ED46E664F8B9A4D5E5B31937407197534@MBX021-W4-CA-1.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 19:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1E3-0001UO-JC
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 19:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab0L2S6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 13:58:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39124 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab0L2S6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 13:58:13 -0500
Received: by bwz15 with SMTP id 15so11188617bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DztVpRh90Q9pgI2bzKSuUlClVUoH7MuyVDYQ8K5KAM4=;
        b=gK1SVqow1cfbwzkEBCzHWh61qap/UyrvaESbarkjKvYU3yHkDklZMSVesa/5eNZZbG
         HGYnzB9g7lK43t05CyfyCxsX5k7UlqW1unI/nuNtIwDSwylxlWy2CMKxj3yxyKS6diFP
         j8ltg1u7fC1vbDwMDvadJQe9mlYndW/YTae8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jFKR/r+MwzDd8kFI8MMltf63SS3vhwfTfqwhyRsIEmI7zeVx7wCT9nguLanLqeya7e
         VF0tjRKQUjB6XhmFLivj08gWqXCteAh7dfRxgjg1sTxSsV254r7NeeT/Tjs6uoP2RuUh
         DN9uNlfeShOK1sHTPRTb3ZQrOFVd2J7AWuUiw=
Received: by 10.204.45.150 with SMTP id e22mr514330bkf.125.1293649092206;
        Wed, 29 Dec 2010 10:58:12 -0800 (PST)
Received: from localhost.localdomain (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id d27sm8799194bkw.2.2010.12.29.10.58.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 10:58:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBTIvlmP025862;
	Wed, 29 Dec 2010 19:57:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBTIvQ6g025856;
	Wed, 29 Dec 2010 19:57:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20053D7ED46E664F8B9A4D5E5B31937407197534@MBX021-W4-CA-1.exch021.domain.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164321>

Marlene Cote <Marlene_Cote@affirmednetworks.com> writes:

> I don't understand the docs when they talk about hooks.  I have
> tried making my .git/hooks samples executable and they don't have
> any suffix to remove, so they should just run.  However, every time
> I make a new clone, the changes I made to the hooks are gone.  Just
> the samples get put into the clone again.  How do I put a hook in
> place that every developer will get and execute?  If I should be
> using server side hooks, where exactly would those go?  Should I
> modify the hooks under my repositories directory?

First, for the future, could you please use more specific subject?
"Help for a git newbie please" doesn't tell us _anything_ about what
problem do you have with git on first glance.

Second, hooks are not versioned and not under version control.  They
are not transferred on clone either.  There are reasons for that,
including the safety (running code under control of other side), and
the fact that hooks are usually configured to local needs, so they
might not make sense for other people.


Now, if you either use some kind of networked filesystem, or you can
configure it so each developers machine has the same install, you can
make use of git templates mechanism.  This is the way git includes
sample hooks in newly created repositories (git init, git clone, or
even IIRC "git init" on existing repository).

Those template files are by default (on Linux) installed in
/usr/share/git-core/templates.  So what you can do is to put hooks you
want each developer to have (either as executable hook, or as hook
sample) in /usr/share/git-core/templates/hooks/ directory (or its
equivalent in your installation).

I hope that helps.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
