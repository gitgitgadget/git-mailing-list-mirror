From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 18:07:47 +0300
Message-ID: <20091120150747.GF22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <20091120013545.GA22556@dpotapov.dyndns.org> <7vmy2h904e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Dennie <gdennie@pospeople.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 16:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBV5j-0005NK-Uq
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 16:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZKTPHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 10:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZKTPHy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 10:07:54 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:56687 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZKTPHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 10:07:53 -0500
Received: by fxm21 with SMTP id 21so3773400fxm.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h3GPPJ7H+OJVuSO/OBpzFSrCJiDqEoxXdIvlbeedwm4=;
        b=Y7A7ejPoOxhXmPJbXqshWoSbh9FsT3MmO0PpIaJwm3gWH6D4amOj32AvgGz9K2eJmW
         3C3C/LFdox4kh7HNnxZSrHvRUPvy0E2nCufbXYKaq4VaeasimByL4DT9Lfjffb7gMtpN
         yEbZZdvikMjF2y70E8j+n+pFnQ8CPuc3aeqx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uzzSl26pJDutWJPwOI+REol0T2m9NeHsqwskeJuBC5llQAYSFqsghHLGP4P9g+/GRl
         In51/yi37tguF0D/0Bt9mm1LEjTqbaigEYSqPS1RVVXyN/cufppdamM2ht5MMVZbd9G1
         yNgjhAoro88bOTBfX2UAkpncXSQyjViESD26A=
Received: by 10.87.40.40 with SMTP id s40mr1196852fgj.74.1258729679042;
        Fri, 20 Nov 2009 07:07:59 -0800 (PST)
Received: from localhost (ppp91-78-51-128.pppoe.mtu-net.ru [91.78.51.128])
        by mx.google.com with ESMTPS id e3sm133071fga.1.2009.11.20.07.07.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 07:07:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmy2h904e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133351>

On Thu, Nov 19, 2009 at 10:33:05PM -0800, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > It is more difficult to make this mistake with Git than many others
> > VCSes, because Git shows the list of files that are changed but not
> > committed as well as the list of untracked files when you try to commit
> > something.
> 
> Not really in practice.  Too many people carry their existing practice of
> using -m to write a useless single liner commit log message that they
> acquired while using their previous SCM.

Well, at least, Git allows to avoid this mistake and produce good commit
messages, but you are right it is difficult to break old bad habits...

> Arguably, useless log messages
> are less of a problem on systems like CVS/SVN because they do not do
> useful log summarization such as "log -- paths..." or "shortlog", so they
> can be excused for learning the practice in the first place, though.

I think quite often commits in CVS/SVN cannot be summarized, because a
single commit often contains what would be a short series of patches in
Git plus a few separated fix-ups that are completely unrelated to the
whole series. It is trivial to split your changes in a few separate
commits in Git, but it is difficult to do that with CVS/SVN.

> That incidentally is exactly why earlier we (mostly me and Linus)
> recommended people not to teach "commit -m" to new people, but of course
> nobody listened ;-).

Those who got used to '-m' in another VCS will quickly find it on their
own... BTW, Git User's Manual uses "git commit -m" 8 times in different
examples, largely to explain what is committed here, and I think it is
similar with other introductions to Git. Though, clearly '-m' is rarely
useful in practice...


Dmitry
