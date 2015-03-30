From: Max Kirillov <max@max630.net>
Subject: Re: RFC: Renaming "git rebase --onto"
Date: Tue, 31 Mar 2015 00:53:54 +0300
Message-ID: <20150330215354.GB8771@wheezy.local>
References: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 23:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ychd0-0001CD-V6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 23:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbbC3Vxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 17:53:47 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:56714
	"EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752945AbbC3Vxr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 17:53:47 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-07.prod.phx3.secureserver.net with 
	id 9xti1q0045B68XE01xtkLR; Mon, 30 Mar 2015 14:53:46 -0700
Content-Disposition: inline
In-Reply-To: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266479>

On Mon, Mar 30, 2015 at 01:49:34PM -0700, Jonathon Mah wrote:
> During a few years of discussing git operations with colleagues, I=E2=
=80=99ve found the =E2=80=9Cgit rebase --onto=E2=80=9D operation partic=
ularly ambiguous. The reason is that I always describe a rebase operati=
on as =E2=80=9Conto=E2=80=9D something else (because of the English phr=
ase =E2=80=9CA is based on B=E2=80=9D). For example:=20
>=20
> $ git rebase new-base  # =E2=80=9CRebase HEAD onto new-base (from mer=
ge-base of HEAD and new-base)"
> $ git rebase new-base my-branch  # =E2=80=9CRebase my-branch onto new=
-base (from merge-base of my-branch and new-base)=E2=80=9D
>=20
> Personally, I understand =E2=80=9Cgit-rebase --onto new-base old-base=
=E2=80=9D as meaning =E2=80=9Crebase from old-base to new-base=E2=80=9D=
=2E Some prepositions that might make this clearer:
>=20
> $ git rebase --from old-base new-base  # =E2=80=9CRebase HEAD onto ne=
w-base, from old-base"
> $ git rebase --after old-base new-base  # =E2=80=9CRebase commits on =
HEAD after old-base HEAD onto new-base"
> $ git rebase --excluding old-base new-base  # =E2=80=9CRebase HEAD on=
to new-base, excluding commit old-base (and its parents)"
>=20
> In all cases this would change the order of the arguments compared to=
 --onto, making it more consistent with the  no-option rebase.
>=20
> What do others think? Is my view of =E2=80=9Conto=E2=80=9D common or =
unusual?

I have never liked the --onto syntax also. It's not only
ugly but still fails to cover some needs. So in my, you know,
clone of rebase I have made completely different syntax.
You can take a look at it here:
https://github.com/max630/git-rebase2/#usage

I just copy the line here, without descriptions:
git rebase2 [options] <dest> [[<source_from>]..[<through1>..<through2>]=
=2E.[<source_to>]] [<target>]

--=20
Max
