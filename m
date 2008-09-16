From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Tue, 16 Sep 2008 10:09:08 +0200
Message-ID: <20080916080908.GA14272@atjola.homenet>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com> <20080916052425.GA14644@spearce.org> <7v3ak08v5l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 10:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVdg-0003MV-J6
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 10:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYIPIJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 04:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYIPIJO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 04:09:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752469AbYIPIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 04:09:12 -0400
Received: (qmail invoked by alias); 16 Sep 2008 08:09:10 -0000
Received: from i577B8C4C.versanet.de (EHLO atjola.local) [87.123.140.76]
  by mail.gmx.net (mp067) with SMTP; 16 Sep 2008 10:09:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19NIUZuPcJNCX55rQuT8ssLG+weUnUQ47wO9WFaBi
	hkKvflYJjigOVI
Content-Disposition: inline
In-Reply-To: <7v3ak08v5l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95989>

On 2008.09.15 23:25:10 -0700, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>=20
> > Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >> Here is my attempt at a "let's publish a shallow repository for br=
anch
> >> of moodle". Let me show you what I did...
> > ...
> >>  # 1.7 was a significant release, anything earlier than that
> >>  # is just not interesting -- even for pickaxe/annotate purposes
> >>  # so add a graft point right at the branching point.
> > ...
> >> Is this kind of workflow (or a variation of it) supported? For thi=
s to
> >> work, we should communicate the grafts in some push operations and
> >> read them in clone ops - and perhaps in fetch too.
> > ...
> > I think that in this case the best thing to do is give users
> > a shell script that does roughly:
> >
> > 	git init
> > 	echo $BASE >.git/info/grafts
> > 	git remote add -f origin $url
> > 	git checkout -b master origin/master
> >
> > Sign the script, and let users verify it before executing.  You may
> > also want a script to drag in the history behind by removing the
> > graft and fetching $BASE^, but that is hard because your repository
> > already "has" that.
>=20
> Why not just filter-branch _once at the origin_ and publish the resul=
t?

I think the idea was to have a shallow clone starting at a certain
point, as opposed to the --depth option, where you cannot specify a
starting point, but only the depth of the clone.

Bj=F6rn
