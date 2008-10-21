From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH, RFC] diff: add option to show context between close chunks
Date: Tue, 21 Oct 2008 22:45:07 +0200
Message-ID: <48FE3F53.6030303@lsrfire.ath.cx>
References: <48FB757B.9030105@lsrfire.ath.cx> <48FC9685.8030704@viscovery.net> <48FCC8A1.5090109@lsrfire.ath.cx> <48FD721D.9030105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 22:46:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsO7Y-0000bz-RG
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 22:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYJUUpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 16:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYJUUpP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 16:45:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:59360 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYJUUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 16:45:14 -0400
Received: from [10.0.1.101] (p57B7DC8D.dip.t-dialin.net [87.183.220.141])
	by india601.server4you.de (Postfix) with ESMTPSA id 003A92F8063;
	Tue, 21 Oct 2008 22:45:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48FD721D.9030105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98815>

Johannes Sixt schrieb:
> Ren=E9 Scharfe schrieb:
>> I have to admit my main motivation was that one line gap, where a ch=
unk
>> header hid an interesting line of context.  Showing it didn't change=
 the
>> length of the patch, so I found this to be a sad wastage.
>=20
> "Wastage" is relative. For a given patch, the one line of context tha=
t was
> hidden by the hunk header would be welcome by a human reader, but it =
is
> not necessarily useful if the patch is to be applied, in particular, =
if it
> is applied to a version of the file that has *more* than one line bet=
ween
> the hunk contexts. This is the reason that diff does not produce 7 li=
nes
> of context between changes in -U3 mode ("you asked for 3 lines of con=
text,
> you get 3 lines of context").

Yes, that's an interesting example of the possible "merge conflicts" I
mentioned in my original mail, and one I didn't think of.  And since I
don't do any merges myself, I don't know how much of a problem this is.

As Daniel writes, one could teach git-apply to ignore extra context.  I=
t
should even be possible to infer the -U option used to create a patch
and to remove any extra lines (which might get complicated for patches
that change both the start and the end of a file, though).

Also, I'd like to know how many patches of a given repo would be have
created such a problem, but I can't think of a way to count them at the
moment.  I need some sleep first.

> BTW, nomenclature seems to have settled at the word "hunk", not "chun=
k".

While http://en.wikipedia.org/wiki/Diff uses both and defines "chunk" a=
s
"change hunk", the GNU patch(1) manpage uses "hunk" throughout.  "Hunk"
it is, then. :)

Ren=E9
