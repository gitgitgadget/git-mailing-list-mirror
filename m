From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 23:03:30 -0400
Message-ID: <BAYC1-PASMTP01E800F7F176623630BE98AE1B0@CEZ.ICE>
References: <BAYC1-PASMTP06CEC55B088A0817EB52CBAE1B0@CEZ.ICE>
	<20060928024938.46785.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 05:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmBh-00056B-3D
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbWI1DDd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWI1DDd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:03:33 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:32196 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965241AbWI1DDc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:03:32 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 27 Sep 2006 20:03:32 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSmBO-0007eJ-Vp; Wed, 27 Sep 2006 23:03:31 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Message-Id: <20060927230330.90c63d23.seanlkml@sympatico.ca>
In-Reply-To: <20060928024938.46785.qmail@web51009.mail.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Sep 2006 03:03:32.0287 (UTC) FILETIME=[AE4764F0:01C6E2AA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2006 19:49:37 -0700 (PDT)
Matthew L Foster <mfoster167@yahoo.com> wrote:

> How does git ensure that the timestamp in a commit records when it was actually created? I am not
> saying throw away creation time, just that local time is more preferable and relevant and
> git/gitweb.cgi should not in any way depend on time being configured correctly on each and every

The time stamp held in each Git commit accurately records the system time
of the machine on which it was created.  That's about the only guarantee 
offered.

The vast majority of the time this accurately records the proper time.
In the rare case when the system time is set incorrectly Git will
"accurately" record this value.  The good news is that Git continues
to work without any problem even if this happens.  Hopefully, you
can put your mind at ease over that issue.

> git server. I think users of kernel.org's repo (or web interface) care more about when change X
> was commited to it than when an author created/emailed change X, but perhaps I am wrong or don't
> understand git or both. 

Well no, the time each commit was actually created and imported into its
initial repository is also interesting to people.

But I happen to agree with you that it would be nice to _also_ show the
time that each commit appeared in the kernel.org repo.  Unfortunately, the
way Git is designed this just isn't easy.  In fact, Junio has gone so far
as to dare everyone not to even try to implement that feature.  So we might
just have to accept that we'll never see that information on kernel.org.

You will likely become a lot more comfortable with this, the more you get
to know and use Git.  Perhaps playing with gitk is worthwhile, as Linus
suggested.  Hopefully you can let this issue go, at least until you've
played with git some more.

Sean
