From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Wed, 06 Feb 2008 15:21:40 -0800 (PST)
Message-ID: <m3myqd4qo2.fsf@localhost.localdomain>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
	<7vodatvmtl.fsf@gitster.siamese.dyndns.org>
	<200802062314.39440.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:22:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtat-0001BR-MK
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808AbYBFXVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757637AbYBFXVq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:21:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4818 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124AbYBFXVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:21:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so559624ugc.16
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 15:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=otL39QoDQ1wJ12JjsO1tzVqTZ5vepS0vQUnVumFAx/U=;
        b=oxzVQ9NiXLDJ/IaUEKSpXu7eSzGoB44AJI5wv0DRGDJrVR0upILVB5jz66ZuldHTuBjyQG/mLTF1eM6uWNd6iC5CZ5ftGpuiYmb4JipJuc6zVq4l/rPUCIjTsDe4HN3flJlYGyLH3wGiWUI4GDemJ4SxAxyN2LB6zyMwQjEqO7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=mJSBSkqdKqAUG0cSFKOvju4bCfdQG+xTKf+CX9H5zF0CO2HcFeBCUdDjGxwatKl//UNFB4SvAFdJf0sWLweX1lg6tHoDRDG462nIy1AvIYKdj5dsKiKtCFYT+DTBcTBv2hovapjmZ5J9mKTYHn/PfxnucnsUFibgr8yTH1FuA5w=
Received: by 10.67.26.7 with SMTP id d7mr3300711ugj.23.1202340101455;
        Wed, 06 Feb 2008 15:21:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.239.145])
        by mx.google.com with ESMTPS id b35sm7815315ugd.33.2008.02.06.15.21.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 15:21:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m16NLZYG016385;
	Thu, 7 Feb 2008 00:21:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m16NLXIq016382;
	Thu, 7 Feb 2008 00:21:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <200802062314.39440.robin.rosenberg.lists@dewire.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72873>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> This patch makes the git prompt (when enabled) show if a merge or a
> rebase is unfinished. It also detects if a bisect is being done as
> well as detached checkouts.
[...]
> +		if [ -d "$g/../.dotest" ]
[...]
> +		elif [ -f "$g/.dotest-merge/interactive" ]
[...]
> +		elif [ -d "$g/.dotest-merge" ]

Hmmm... is it time to ressurect "git explain" / "git info" / "git state"
command idea, as to not need to harcode info about state in scripts,
putting it in only one place?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
