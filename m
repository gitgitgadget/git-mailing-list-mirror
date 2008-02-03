From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What about git cp ?
Date: Sun, 03 Feb 2008 11:07:10 -0800 (PST)
Message-ID: <m3tzkp6eqz.fsf@localhost.localdomain>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com>
	<vpq63x5swsj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Francis Moreau" <francis.moro@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLkBw-0004yd-1n
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 20:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYBCTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYBCTHP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 14:07:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:62204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYBCTHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 14:07:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1039166ugc.16
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=KuR0k/l03hrWwYcIV9m7pef9Z56Vr9WuJ0lGt91/EJE=;
        b=Z5vKUX+r2yXamLBYSKgQA6eSgx1EYqyL++1cpo93bmfhuzv94T/ns6AqeHwj2zqGIUOujRiSvvchXltIk1g+7/oDfB7vUVpImxSKDCbTIs8baIxxlTnT0K+oqsGr8OQhTsOl1j6uSrU1hCCtCED/ZlbgMzGPXUZueo11mXMMB7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=t5X23KRL3h3WXDX2riSQJIwEkDNy9THrFtQ2As9OH0TeTalr/CkGYzO85sxnr+f/k1be/tbKy6HSRQj1BXMDfwEN93U7JGkjmchvsOziMPLrK+7+BB/0ws779Dvbso2eSiEsLsWSECOgR7YYhc3s45aHrYIUe7kqLwaIAk9Mx4U=
Received: by 10.67.122.12 with SMTP id z12mr348054ugm.18.1202065631613;
        Sun, 03 Feb 2008 11:07:11 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.5])
        by mx.google.com with ESMTPS id w28sm5781439uge.79.2008.02.03.11.07.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 11:07:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m13J71E7006921;
	Sun, 3 Feb 2008 20:07:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m13J70Mo006918;
	Sun, 3 Feb 2008 20:07:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <vpq63x5swsj.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72394>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "Francis Moreau" <francis.moro@gmail.com> writes:
> 
> > Hello,
> >
> > I'm looking for a something which could be done by a git-cp
> > command.
> >
> > I'd like to copy a file with its history to a new file but want to
> > keep the old one,
> 
> Git doesn't _record_ copies and renames, but detects them
> after-the-fact (either by default, or explicitly like "git blame -C"
> or so).
> 
> So, just "cp + git add" and you're done. That's what a "git cp"
> command would do if it existed.

You can just put git-cp shell script doing this in PATH (or
GIT_EXEC_PATH if they are different) for "git cp" to just work.
Or you can write builtin-cp.c, following builtin-mv.c

-- 
Jakub Narebski
Poland
ShadeHawk on #git
