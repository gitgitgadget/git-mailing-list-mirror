From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone dies (large git repository)
Date: Tue, 22 Aug 2006 02:42:53 +0200
Organization: At home
Message-ID: <ecdjub$bed$1@sea.gmane.org>
References: <op.teh30gmyies9li@rygel.lnxi.com> <7vfyfs313t.fsf@assigned-by-dhcp.cox.net> <op.tenp9fv1ies9li@rygel.lnxi.com> <7v3bbpty7j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 22 02:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFKMb-00054U-40
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 02:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHVAnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 20:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHVAnO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 20:43:14 -0400
Received: from main.gmane.org ([80.91.229.2]:50141 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751341AbWHVAnN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 20:43:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFKME-0004z6-52
	for git@vger.kernel.org; Tue, 22 Aug 2006 02:43:06 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 02:43:06 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 02:43:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25829>

Junio C Hamano wrote:

> "Troy Telford" <ttelford@linuxnetworx.com> writes:
>=20
>> I'm thinking of it as an option for git-repack-- that the user can s=
et
>> the maximum size of any individual pack, and after that limit is
>> reached, a =A0new pack file is started. =A0(ie. --max-size 2GB) and =
will
>> end up with two =A0packs, each 2GB in size.
>=20
> The way I would suggest you do it is not by size but by distance
> from the latest. =A0If you want to split the kernel history for
> example, you repack up to 2.6.14 for example, and then repack
> the remainder. =A0That way, you can optimize for size for older
> (presumably less frequently used) data while optimizing for
> speed for more reent stuff.

If there would be some enhancement to pack files allowing either limiti=
ng
the size of pack (e.g. filesystem limits, mmap limits) and/or mmaping o=
nly
fragment or fragments of pack file, the maximal size of the pack, or
maximal size of the mmapped fragment should be configurable per reposit=
ory,
not olny as an option to some command (git-repack for example).

Probably would need some enhancement to git-fetch/git-clone too...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
