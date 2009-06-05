From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 12:11:55 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117DC2@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <32541b130906051001k1ea4d960m4fcf7679b5b4f740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcxY-0000Aj-Ak
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 19:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbZFERL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 13:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZFERLz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 13:11:55 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:20596 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbZFERLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 13:11:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <32541b130906051001k1ea4d960m4fcf7679b5b4f740@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Best way to merge two repos with same content, different history
Thread-Index: Acnl/0CbZOF3YCR2Qye4c0NfuJQUjAAAV6ow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120813>

> -----Original Message-----
> From: Avery Pennarun [mailto:apenwarr@gmail.com]
> Sent: Friday, June 05, 2009 12:01 PM
> To: Kelly F. Hickel
> Cc: git@vger.kernel.org
> Subject: Re: Best way to merge two repos with same content, different
> history
>=20
> On Fri, Jun 5, 2009 at 12:30 PM, Kelly F. Hickel <kfh@mqsoftware.com>
> wrote:
> > =A0 =A0 =A0 =A0Stated another way, I have two repositories, "new" a=
nd "old",
> > where the files in the initial commit on branch "B1" in "new" have
> > exactly the same content as the last commit on branch "B1" in "old"=
=2E
> > There also exist various branches in "new" based on "B1". =A0I'd li=
ke
> to
> > merge all the commits from "new" into "old", but the SHA1s are
> > different, presumably because the history leading up to those point=
s
> are
> > different.
> >
> > =A0 =A0 =A0 =A0Other than using manually format-patch on every bran=
ch in new,
> > then applying the patches (presumably with regular old patch, since
> the
> > ancestor commit IDs won't match), is there any "good" way to merge
> "new"
> > into "old"?
>=20
> The usual replacement for "manually using format-patch" is to use "gi=
t
> rebase."  It does pretty much exactly what you're describing, assumin=
g
> you don't do too many complicated merges in the meantime.
>=20
> Another option is to use the .git/info/grafts file.  Here's a brief
> intro: http://git.or.cz/gitwiki/GraftPoint
>=20
> You'd use that to pretend the parent of your top-skimmed branch is
> actually the equivalent commit in your new branch.  Then could run
> "git filter-branch" to make the graft permanent, and get all your
> users to switch to the new repository.
>=20
> Or you could skip the filter-branch stuff and keep the really hold
> history somewhere else, available for use if someone installs the
> graft in their local repo.  This would lead to a smaller repository i=
n
> the general case.  (I gather that's what the Linux kernel does for
> per-2.6.11 versions.)
>=20
> Have fun,
>=20
> Avery

Thanks Avery,
	This appears to be just what I was looking for!  I'll fiddle with it a=
 bit to see if I can convince it to work for me.


Thanks,
	Kelly
