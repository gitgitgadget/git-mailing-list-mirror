From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Proper tracking of copies in git log and others
Date: Sat, 4 Jul 2009 11:31:12 -0700
Message-ID: <BLU0-SMTP94B7E43F5EE983A2F9BFA8AE2D0@phx.gbl>
References: <4A4F8258.5070701@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lasse =?ISO-8859-1?Q?K=E4rkk=E4inen?= <tronic+dfhy@trn.iki.fi>
X-From: git-owner@vger.kernel.org Sat Jul 04 20:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNA1F-0002e6-82
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 20:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZGDSbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jul 2009 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbZGDSbN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 14:31:13 -0400
Received: from blu0-omc3-s27.blu0.hotmail.com ([65.55.116.102]:2334 "EHLO
	blu0-omc3-s27.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942AbZGDSbM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Jul 2009 14:31:12 -0400
Received: from BLU0-SMTP94 ([65.55.116.73]) by blu0-omc3-s27.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 4 Jul 2009 11:31:16 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP94.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 4 Jul 2009 11:31:15 -0700
In-Reply-To: <4A4F8258.5070701@trn.iki.fi>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 04 Jul 2009 18:31:15.0725 (UTC) FILETIME=[9D7D7BD0:01C9FCD5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122721>

On Sat, 04 Jul 2009 19:24:56 +0300
Lasse K=E4rkk=E4inen <tronic+dfhy@trn.iki.fi> wrote:

> Getting full history of a file, including that beyond copies, is rath=
er=20
> important and apparently not currently supported by git tools.

[...]

> It would be useful if the git tools could produce history like this w=
ith=20
> all the tools (log, blame, gitk, etc), preferably with proper branchi=
ng=20
> guesses (guesses because there is no info on where the copy came from=
),=20
> but even a linear history (sorted by commit time?) would do much bett=
er=20
> than not having anything.

Lasse,

You're right, it appears that Git does not currently support what you a=
re
trying to do.   However, if you were to run the command "git log -C -C =
--raw"
on your test case, you would see that Git can actually detect the copie=
s
in question.  The detection just isn't applied in the "follow" case.

There was a patch sent to the list in January that would have enabled t=
he
functionality you're asking about:

http://kerneltrap.org/mailarchive/git/2009/1/22/4792454

Although it seems the author never followed up after Junio questioned o=
ne
aspect of the patch.  It wouldn't do _exactly_ as you requested though;
intermediate copies are not shown, copies are linked back to the origin=
al.

You could apply that patch and test it out.  Perhaps you could address
Junio's concern or reignite some interest from the original author.

HTH,
Sean
