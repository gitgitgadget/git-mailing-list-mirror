From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 12:31:44 +0300
Message-ID: <9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home>
 <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 <7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOVkS-0004CR-L8
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 11:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763286AbXHXJqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 05:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758861AbXHXJqc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 05:46:32 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:62364 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbXHXJqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 05:46:31 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JN900D84UXSVL30@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 24 Aug 2007 12:41:52 +0300 (EEST)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JN900M9SUY0F3A0@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 24 Aug 2007 12:42:00 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam1.suomi.net (Postfix) with ESMTP id 18CE7242235; Fri,
 24 Aug 2007 12:32:22 +0300 (EEST)
In-reply-to: <7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 5, autolearn=not spam, BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56566>

On Aug 24, 2007, at 10:46, Junio C Hamano wrote:

> V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi> writes:
>
>> The way I see the flag used is: A user runs "git status", sees that
>> there is too much untracked files and not enough scrollback, so he
>> runs "git status --only-tracked" to filter the results.
>
> Why?
>
> Just set up .gitignore once then (1) you do not have to worry
> about them ever again, and (2) you _will_ still be able to
> notice if you accidentally added more cruft, or more
> importantly, if you forgot to tell an important file to git.
>
> I think the latter is more important point.  If you train a
> naive user to use --only-tracked to ignore "Untracked" list, you
> are doing him or her a great disservice.  Mistake to forget "git
> add" a new file before commiting will bound to happen.

I also think that maintaining a proper .gitignore is imporant, and =20
more productive than using --only-tracked instead. But when I have =20
cruft that can't be put in .gitignore, or it would ignore files that =20
are supposed to be shown and tracked, I use --only-tracked.

It's true though, that the user might forget to add a file if he =20
always uses --only-tracked, that's why I added the note in the status =20
that the untracked files were filtered out. The flag is supposed to =20
be a helper for situations where .gitignore wouldn't work, not a way =20
to work always. Maybe if this flag is accepted, the manual should say =20
that in most cases it's better to use .gitignore.

--
V=E4in=F6
