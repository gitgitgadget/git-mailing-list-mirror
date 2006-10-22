From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 16:55:11 +0200
Message-ID: <200610221655.11598.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Erik =?iso-8859-1?q?B=E5gfors?=" <zindar@gmail.com>,
	"Jan Hudec" <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 16:55:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbejE-0000PU-DA
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWJVOzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWJVOzF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:55:05 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:47007 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751093AbWJVOzC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 10:55:02 -0400
Received: by qb-out-0506.google.com with SMTP id f29so439699qba
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 07:55:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=azh4PIyuM8ytVH0MSS1Rpk//9n0JccH7cHgV1C/+JVD5+HUdPN2A9qV864VtYGf3bIX0LXcqvzqj+BYbbPkwRFhY3PuTkSORMPEnPFXLOCdd+PMK+rN4I/4CzKFbb5dC9hbHANiUhunqyoVbzJiEjVRkrquLUKnDQbp7fCft/LU=
Received: by 10.67.21.11 with SMTP id y11mr5537838ugi;
        Sun, 22 Oct 2006 07:55:00 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 32sm1251506ugf.2006.10.22.07.55.00;
        Sun, 22 Oct 2006 07:55:00 -0700 (PDT)
To: Carl Worth <cworth@cworth.org>
User-Agent: KMail/1.9.3
In-Reply-To: <87zmbozau2.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29756>

Carl Worth wrote:
> Erik B=E5gfors wrote:
>> If I understand it correctly, in git, you don't really know what has
>> been committed as part of this branch/repo, and what has been
>> committed in another branch/repo (this is my understanding from
>> reading this thread, I might be wrong, feel free to correct me again
>> :) )
>=20
> You're correct that git doesn't _store_ any sort of "branch ownership=
"
> in the commit object. But this is a huge feature. It avoids a lot of
> the things in bzr that look so bizarre to people coming from git.

Because "branch ownership" is obvously local, we have reflog, which is
local and not propagated. Reflog uses the following format

 oldsha1 SP newsha1 SP committer TAB reason LF

where reason might be "commit: <commit description/title/subject>"
or "commit (amend): <commit description>", "am: <commit=20
description>" (applied mail patch), "reset --hard HEAD^" (dropped
top commit), "branch: Created from origin^0", or "pull origin: In-index=
=20
merge".

We have not yet tools to examine reflog (e.g. change committer
info with it's timestamp to human readable format) yet.
--=20
Jakub Narebski
Poland
