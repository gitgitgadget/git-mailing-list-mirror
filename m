From: David Brownell <david-b@pacbell.net>
Subject: Re: warning: no common commits - slow pull
Date: Thu, 6 Mar 2008 17:35:46 -0800
Message-ID: <200803061735.47674.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 02:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRVe-0005bn-CV
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936AbYCGBfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757288AbYCGBfv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:35:51 -0500
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:40358 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757271AbYCGBfu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 20:35:50 -0500
Received: (qmail 9824 invoked from network); 7 Mar 2008 01:35:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=kWkwVvzOY2DF/PPSOaW4pRuokGh6VFVY6Jji8BnTbA9/jN/nsWJ9bKKPyDjjoAFy86HhaL+b/tzbNazU/E0PkRjFvV11LNdOZhlu55uYPLVu49xjNXx5kNsIWfC4gVZs7LP4AmTeEYb/erAzDcVwSVXt1JWabtofIkY5PZP78o4=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.243.232 with plain)
  by smtp120.sbc.mail.sp1.yahoo.com with SMTP; 7 Mar 2008 01:35:49 -0000
X-YMail-OSG: 2MVkgVcVM1lhn926KyOX8YS3q1aVywW7PBJRufRjyZmO2mecAShv4gnQN7YE3Iv9dqNsoyMXRw--
X-Yahoo-Newman-Property: ymail-3
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76444>

Any progress on fixing this?

I'll report that with git version 1.5.4.3.447.gc95b3.dirty
(just a couple days old) I've observed this when updating
a clone by pulling from

 (a) a parent on the same disk partition
 (b) a parent on a non-mirrored network server

So that would seem to trash the assumptions that this is
related to version mismatch between mirrors, and that the
fix can (or should!) wait till 1.6.0 ...


I was glad to see the "^C" workaround, that seems to work.

When I "git pull" it first fetches a bunch of files, then
concludes (wrongly) "no common commits", then starts a
second fetch of a *HUGE* number of files ... 400 MB is too
much to pay when updating from rc3-last-week to rc4.  But
if I interrupt that second one with ^C, it seems that the
first one fetched enough to make the next "git pull" go
pretty quickly.


This does seem appear to show up more often lately because
of RC4 having been tagged ... but I don't know for sure.

I've got a couple kernel workspaces still on last Friday's
version, which -- if this holds true to form! -- will show
this bug when I "git pull".  So if there are experiments
that would help nail down what's going on here, please
spell them out to me ("this command, then this ... send
this output...").

- Dave
