From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a branch
Date: Mon, 12 Oct 2009 17:31:03 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910121708030.5105@dr-wily.mit.edu>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSYU-0004he-O4
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469AbZJLVbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 17:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbZJLVbp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:31:45 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61302 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758451AbZJLVbn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:31:43 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9CLV0Y4004156;
	Mon, 12 Oct 2009 17:31:01 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9CLV4PN009115;
	Mon, 12 Oct 2009 17:31:04 -0400 (EDT)
In-Reply-To: <7vr5t8coex.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130078>

On Mon, 12 Oct 2009, Junio C Hamano wrote:
> I offhand do not see a good rationale for such a shortcut to finish=20
> bisect and switch to another branch (IOW, I understand "it is shorter=
 to=20
> type", but I do not see "it is often done and very useful"), but I am=
=20
> open to be enlightened by a workflow where such a shortcut is useful.

I agree that =E2=80=98git bisect reset <branch>=E2=80=99 is a confusing=
 shortcut.  It only=20
really made sense before Git supported detached HEADs, and you needed t=
o=20
be on a branch all the time.  I think that lifting the arbitrary=20
restriction to branch names makes it less confusing, but if you want to=
=20
remove the argument altogether, that would eliminate the confusion=20
entirely.

I had in mind only one case where =E2=80=98git bisect reset <commit>=E2=
=80=99 would be=20
useful.  I often don=E2=80=99t even remember what commit I was on befor=
e I started=20
a bisect, much less believe that I want to immediately switch back to i=
t. =20
I would prefer to be able to clean the bisection state without checking=
=20
out another commit at all, because that takes forever and invalidates m=
y=20
compiled tree.  This is what =E2=80=98git bisect reset HEAD=E2=80=99 wo=
uld do if it=20
worked.

Perhaps it makes sense to add a command that just clears the bisection=20
state.  =E2=80=98git bisect stop=E2=80=99?

Anders
