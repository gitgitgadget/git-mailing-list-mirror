From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 3/3] improved validation of entry type in mktree
Date: Fri, 15 May 2009 16:57:35 +0000 (UTC)
Message-ID: <loom.20090515T163644-832@post.gmane.org>
References: <loom.20090514T050424-673@post.gmane.org> <loom.20090514T051052-920@post.gmane.org> <7vd4acxkug.fsf@alter.siamese.dyndns.org> <a644352c0905141546w4193d45aq4940e72bbb4bda1c@mail.gmail.com> <guj1pi$tbk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 18:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M50jf-000118-IX
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbZEOQ5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbZEOQ5r
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:57:47 -0400
Received: from main.gmane.org ([80.91.229.2]:52646 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbZEOQ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 12:57:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M50jD-000139-Lr
	for git@vger.kernel.org; Fri, 15 May 2009 16:57:48 +0000
Received: from adsl-99-176-34-153.dsl.pltn13.sbcglobal.net ([99.176.34.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 16:57:47 +0000
Received: from josh.micich by adsl-99-176-34-153.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 16:57:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.176.34.153 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119265>

Jakub Narebski <jnareb <at> gmail.com> writes:

>=20
> Josh Micich wrote:
>=20
> > Furthermore even with '--missing', a tree entry like this should be=
=20
rejected:
> > 160000 commit e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 =C2=A0foo
>=20
> But with submodules you might not _have_ e69de29b in object database
> to check its type!

The code already accounted for that case.  If the tree entry is a GIT_L=
INK=20
("160000 commit ..."), it is not mandatory for the referenced object to=
 exist=20
locally.  But if the object _does_ exist, the type should match.  I gue=
ss I=20
should have prefixed that example with "assuming object e69de29b (empty=
 tree)=20
is present in the local database".
