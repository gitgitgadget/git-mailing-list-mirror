From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 10:58:56 -0700 (PDT)
Message-ID: <m3tyzhjmvc.fsf@localhost.localdomain>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
	<7veiql1etz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	SZEDER Gabor <szeder@ira.uka.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjzXX-0000bI-11
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 19:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZIER66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbZIER65
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 13:58:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:15832 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbZIER64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 13:58:56 -0400
Received: by fg-out-1718.google.com with SMTP id 22so405574fge.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NOyzXecwg7fBduXH8lC4oe3WeN9ULzexbhN/q7PPqIE=;
        b=dd/AYtJzb/vQVwwdCcTIHMzo9akKOsNfLh6mnvy2DkWdQkdUAYkHTqQhVKakyFGFZz
         t1ZBlNaKFpGnCSc+KkCVf0nbVpU+RmgIrcGqt6lSlRR4haBhTQR8uTyAfocxQCzWxROC
         +uERvrBmjhb4M63jB4j9+LQSOmBSMJGrAy7m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ZbZQDaBFSAXDDc0oL7D8+rHeuuFh8zMmPYmK8Xqx2WiOC5pSZ/ddFYs0NOg2ediZt4
         UhixnE+KzfNUQv0sYeqCJtPVoUaOWFQOqC1hrjoSMTla6u0u1ViMY5deSMRe1y0T2sH2
         0WW/sB+hknaCXsfBLAJTIusOZ7X7cffP8KfJU=
Received: by 10.86.240.9 with SMTP id n9mr6233766fgh.70.1252173537940;
        Sat, 05 Sep 2009 10:58:57 -0700 (PDT)
Received: from localhost.localdomain (abvd254.neoplus.adsl.tpnet.pl [83.8.201.254])
        by mx.google.com with ESMTPS id e20sm4617652fga.15.2009.09.05.10.58.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 10:58:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n85HvkWR026892;
	Sat, 5 Sep 2009 19:57:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n85HvCaN026886;
	Sat, 5 Sep 2009 19:57:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7veiql1etz.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127824>

Junio C Hamano <gitster@pobox.com> writes:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > "git add -u ." is friendly enough. Just like "git commit ." versus "git
> > commit -a", which is exactly the same concept and should therefore have the
> > same behavior.
> >
> > You are assuming that people are in a subdirectory because they want to
> > limit the scope. But I am usually in a subdirectory for totally
> > versioning-unrelated reasons.
> 
> Limit the scope of what you see in "ls" (no argument) output, shorten the
> paths you must type to non-git commands.  They are the kind of "limit the
> scope" I meant, and they are totally versioning-unrelated.  In other
> words, cwd-centric default helps the users (especially the new ones) by
> making git behave consistently with other commands.

Well, there is still complication that some commands are considered
whole-tree in absence of pathspec, like "git commit".

> 
> So if anything, I personally think it would be much less surprising if all
> git commands worked relative to the cwd (not whole tree root) when run
> without path argument, at least from the newbie's point of view [*1*].

I think it would be very suprising if "git commit" in subdirectory was
limited to changes affecting given subdirectory...

> 
> But notice that the above is qualified with "personally".  An alternative
> would be to declare that in 1.8.0, all commands run without path argument
> will work on the whole tree and you have to give an explicit '.' when you
> want to limit their effect to the cwd.
> 
> This may be slightly less intuitive to newbies than the "relative to cwd",
> but nevertheless that is the course I would suggest us taking, because of
> the following observations:
> 
>  (1) if the commands work on the whole tree when run without paths, it is
>      easy to limit to the cwd with "git frotz ." when you want to.
> 
>  (2) if the commands work on the cwd when run without paths, you have to
>      always be aware how deep you are, and say "git frotz ../../.." when
>      you want to extend their effects to the whole tree.
> 
> The latter is much more irritating.

Well, we can always invent some magic notation meaning either "up to
top directory", e.g. make

  $ git frotz ...

more or less equivalent to

  $ git frotz "$(git rev-parse --show-cdup)"

(The other solution of having "git frotz /" to refer to top directory
is slightly worse, because there are git commands that work without
git repository, and "/" is legitimate parameter, like e.g. for 
"git diff --no-index").

-- 
Jakub Narebski
Poland
ShadeHawk on #git
