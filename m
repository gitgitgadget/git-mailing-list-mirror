From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Tue, 05 Feb 2008 01:34:15 -0800 (PST)
Message-ID: <m38x1z692o.fsf@localhost.localdomain>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	<402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	<7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
	<402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
	<7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
	<402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 10:34:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKCb-0006zZ-Bq
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 10:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYBEJeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 04:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYBEJeT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 04:34:19 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:17915 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbYBEJeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 04:34:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3404279wah.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=d4Ev2Xydn3EkeEZyiANXK89m7pBLY9K4wEoVI9cJDeM=;
        b=mT3JNDBmgZV7ZhnCWkf/0liaxtOaeu08fyeyq8wvsgTfztSOKS6wwPRRR60sNM15mU6XOOFddtEqVQt20ROmPQfENO2Xgp+4Jfo0yQm7q63bWW48iarmPhCMf+QtiYQxQxuCQzYzoc+Rf+6qefbZ409uQEbtmVGG+unWkJAsvF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=HJ7Hmh4rGrZyu6PxpgFDqCVPVIzY9OfofMjD5jgkfsvATkZKKvslVq/8YTiUE90q/hIi/ut9Gz6HEoN9I+ZNOvv+qw5KLaF8hPrv3Hv/UUDn4Zy6rIuvYgICgHkfA9jfpLRRaznv4HUH38fPyIwK3joiOlgw4Bwx629Jl+bAM8A=
Received: by 10.114.209.1 with SMTP id h1mr8116770wag.130.1202204057062;
        Tue, 05 Feb 2008 01:34:17 -0800 (PST)
Received: from localhost.localdomain ( [83.8.224.128])
        by mx.google.com with ESMTPS id k5sm3789375nfh.19.2008.02.05.01.34.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 01:34:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m159Y8cD004677;
	Tue, 5 Feb 2008 10:34:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m159Y7mG004674;
	Tue, 5 Feb 2008 10:34:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72635>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Feb 4, 2008 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > The documentation updates talked about what the options do, but
> > it was unclear why they could be useful in what situations and
> > workflows.  At least it was not apparent to me on my cursory
> > read.
> 
> Common, fork, and path only make sense where there are at least three
> repositories or two plus an observer involved.
> 
> Lets explain the observer cases.
> 
> The observer is interested in changes that X, Y and Z agree upon.  He
> can merge as follows:
> 
>   git merge --ff=common X Y Z
> 
> The observer is interested in changes up to the point where someone is
> known to disagree.  He can merge as follows:
> 
>    git merge --ff=fork X Y Z
> 
>  The observer is interested in any give path up to one of the true
> parents.  He can merge as follows:
> 
>   git merge --ff=path X Y Z
> 
> This will give priority to X then Y.

Could you please provide ascii-art diagrams for above explanations
(above cases), such as the following diagrams for fast-forward, and
for forced merge (no fast-forward)? This would make your explanations
much easier to follow, I think.


1. Fast-forward ("traditional", 2 heads)

   before merge

   a---b---c---d               <-- main
                \
                 \-E---F---G  <-- side


   after merge

   a---b---c---d---E---F---G  <-- main
                           ^
                            \----- side

2. Forced merge commits ("never", 2 heads)

   before merge

   a---b---c---d               <-- main
                \
                 \-E---F---G  <-- side


   after merge

   a---b---c---d-------------*  <-- main
                \           /
                 \-E---F---G    <-- side


-- 
Jakub Narebski
Poland
ShadeHawk on #git
