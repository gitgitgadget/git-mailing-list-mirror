From: Guillaume Desmottes <guillaume.desmottes@collabora.co.uk>
Subject: Re: [BUG] git rebase is confuse if conflict resolution doesn't 
	produce diff
Date: Mon, 18 Aug 2008 11:10:56 +0200
Message-ID: <1219050656.20418.3.camel@cass-lpt>
References: <1218819643.6345.57.camel@cass-lpt>
	 <20080815182439.GB23326@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 11:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV0mR-0003nZ-68
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 11:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbYHRJK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 05:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYHRJK7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 05:10:59 -0400
Received: from bhuna.collabora.co.uk ([195.10.223.82]:43546 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYHRJK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 05:10:58 -0400
Received: from [192.168.0.5] (unknown [91.177.199.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bhuna.collabora.co.uk (Postfix) with ESMTP id E7F5D101BC4;
	Mon, 18 Aug 2008 10:10:56 +0100 (BST)
In-Reply-To: <20080815182439.GB23326@leksak.fem-net>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92690>

Le vendredi 15 ao=C3=BBt 2008 =C3=A0 20:24 +0200, Stephan Beyer a =C3=A9=
crit :
> Hi,
>=20
> Guillaume Desmottes wrote:
> > To reproduce:
> > - Rebase a branch "foo" on a branch "bar" in a way that there is a
> > conflict that you have to manually resolve.
> > - Run git diff and see the conflict
> > - Edit the conflicted file and remove all the conflicting bits (tha=
t
> > could be a valid resolution of the conflict)
> > - Now git diff produces an empty diff
> > - git add $CONFLICTED_FILE  as you have resolve the conflict
> > - git rebase --continue
> >=20
> > You get the following error:
> > No changes - did you forget to use 'git add'?
> >=20
> > git status is empty as the conflict was resolved.
> >=20
> > A simple workaround is to add a dummy blank line in the conflicted =
file
> > so the diff is not empty.
>=20
> I think this is no bug, since you would generate an empty commit, i.e
> a commit with no changes at all. Usually you do not want such commits=
=2E
> So git rebase --skip is perhaps what you want.

Yeah, I know, that's what I did when I finally understood the problem.
But that took me more than 20 minutes before understanding what I did
wrong (I just manually resolved the conflict and wasn't aware that what
I actually wanted was to remove the commit).

Maybe in that case git rebase should suggest something like that "Seems
you want to skip this commit. Do you want to --skip it ?".


	G.
