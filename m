From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Thu, 10 Dec 2009 09:43:51 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0912100937580.22606@ds9.cixit.se>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se> <20091209093758.GA2977@redhat.com> <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se> <20091209112237.GA27740@atjola.homenet>
 <alpine.DEB.2.00.0912091414460.470@ds9.cixit.se> <20091209134133.GA30596@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 09:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIedm-00086W-8z
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 09:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbZLJIoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 03:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758984AbZLJIoL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 03:44:11 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:42104 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757915AbZLJIoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 03:44:08 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nBA8hqJm024881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Dec 2009 09:43:52 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nBA8hp9f024875;
	Thu, 10 Dec 2009 09:43:51 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20091209134133.GA30596@atjola.homenet>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 10 Dec 2009 09:43:52 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135014>

Bj=F6rn Steinbrink:

> "git merge" is about merging histories. --squash and the A..B you sug=
gest=20
> make it degenerate into merging changes (and you can't record that us=
ing=20
> the commit DAG). So that messes things up conceptually.

I know, this is the one "feature" of CVS that I sometimes miss in Git, =
that=20
I cannot "merge" just parts of a history, and have that recorded in the=
=20
history tree. I know it's wrong, I know I could do it better, but somet=
imes=20
it's the shortcut that would make life easier for me. :-)

But the reason I mentioned it was because of the discussion on whether =
the=20
"reverse rebase" should be an option to "cherry-pick" or not, and I=20
mentioned that it could just as well be "merge" since it can be used to=
=20
throw away history as well.

> Anyway, "git merge" with a range simply makes no sense at all given h=
ow=20
> git's merge works (opposed to svn's idea of merging, which is about=20
> changes, not about histories). If you want a squash flag, tell cherry=
-pick=20
> to handle ranges and teach such a flag to it.

And tell "merge" to tell me that if I try, so that if I try

   $ git merge A..B

I would get a message saying something like

   Cannot merge a range of commits. Try "git cherry-pick A..B" or
   "git rebase --reverse A..B".

And perhaps we could also in the same way retire --squash?

   $ git merge --squash B
   The "--squash" option is obsolete. Please use "git cherry-pick
   --squash B".

(with a transition period where it would just call the other). Or whate=
ver=20
the options to simulate the old behaviour would be. This would make it=20
clearer that "merge" preserves history while "cherry-pick" and "rebase"=
 do=20
not.

--=20
\\// Peter - http://www.softwolves.pp.se/
