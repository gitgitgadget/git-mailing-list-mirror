From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Sun, 4 Jan 2009 12:18:58 +0100
Message-ID: <200901041218.59112.chriscool@tuxfamily.org>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org> <200901030640.36426.chriscool@tuxfamily.org> <7vhc4gadg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 12:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJR0s-0008Mh-Cw
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 12:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbZADLSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 06:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbZADLSB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 06:18:01 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60525 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbZADLSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 06:18:00 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 73B4517B547;
	Sun,  4 Jan 2009 12:17:57 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 58E3D17B53A;
	Sun,  4 Jan 2009 12:17:57 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vhc4gadg9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104506>

Le samedi 3 janvier 2009, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Le mardi 30 d=C3=A9cembre 2008, Junio C Hamano a =C3=A9crit :
> >> * cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
> >>  - bisect: add "--no-replace" option to bisect without using repla=
ce
> >>    refs
> >>  - rev-list: make it possible to disable replacing using "--no-
> >>    bisect-replace"
> >>  - bisect: use "--bisect-replace" options when checking merge base=
s
> >>  - merge-base: add "--bisect-replace" option to use fixed up revs
> >>  - commit: add "bisect_replace_all" prototype to "commit.h"
> >>  - rev-list: add "--bisect-replace" to list revisions with fixed u=
p
> >>    history
> >>  - Documentation: add "git bisect replace" documentation
> >>  - bisect: add test cases for "git bisect replace"
> >>  - bisect: add "git bisect replace" subcommand
> >>
> >> I think a mechanism like this should be added to replace grafts,
> >
> > The problem with replacing grafts is that a graft can specify many
> > parents for one commit while a ref associates only one object to a
> > name.
>
> Sorry, maybe I misunderstood your implementation.  What I thought we
> discussed during GitTogether was to write out the object name of the
> replacement object in refs/replace/<sha1>.
>
> When the caller asks read_sha1_file() for an object whose object name=
 is
> <sha1>, you see if there is refs/replace/<sha1> in the repository, an=
d
> read the ref to learn the object name of the object that replaces it.=
=20
> And you return that as if it is the original object.

Ok. When I first implemented "bisect replace" I saw that I could reuse =
the=20
graft fix-up mechanism. And as you talked about replacing grafts, I tho=
ught=20
that you wanted the implementation to use that mechanism instead of add=
ing=20
a different one.

But I agree that it may be more powerfull and generic to replace object=
s the=20
way you describe it. So I will work on that.

Thanks,
Christian.
