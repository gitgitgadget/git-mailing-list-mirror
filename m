From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] Import git-forest (20080403)
Date: Thu, 3 Apr 2008 09:27:50 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804030231180.26216@fbirervta.pbzchgretzou.qr>
References: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de> <9aca54e6e106be3f26ae289606b9a47a91806d54.1207169779.git.jengelh@computergmbh.de> <7vve3053n7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, kzak@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 09:28:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhJsB-00081R-Vo
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 09:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136AbYDCH1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 03:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758910AbYDCH1w
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 03:27:52 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:37089 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847AbYDCH1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 03:27:51 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 7EC0218030642; Thu,  3 Apr 2008 09:27:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 76D2A1C0624F7;
	Thu,  3 Apr 2008 09:27:50 +0200 (CEST)
In-Reply-To: <7vve3053n7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78729>


On Wednesday 2008-04-02 23:49, Junio C Hamano wrote:
> Jan Engelhardt <jengelh@computergmbh.de> writes:
>
>    Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
>
>> +#	git-??????
>
> Hmmmm...

A git-send-email bug it seems. It does not add any Content-Type header
thereby effectively trashing UTF-8. How wonderful. Explains a many=20
corrumped patches on LKML (and subsequently, the git history).

> This is a Perl script with a curious style.  Your subroutines force t=
he
> "funny" parameter semantics to their callers by using prototypes, but
> avoid the potential surprises and inconveniences prototypes may cause=
 by
> using the &name(...) form when they themselves make subroutine calls,
> i.e. not eating their own dog food.

Right, I removed that. I would have probably used PHP (perl is touted a=
s=20
a write-once language), but I could not be sure everyone has _that_=20
installed. Perl, most people have it.

> Is it fashionable to make text based tree render these days?

 	Same arguments as last time :>
Definitely. Do not assume everyone has an X display ready at any given=20
time. Also, gitk does a Follows/Precedes scan which would not really be=
=20
necessary if you just wanted to have the commit forest.

> How does this compare with the git-graph in the nearby thread?

git-forest does have...
- unicode/line-drawing graphics, colors
- display of signs like gitk, that is, ref names like  =80=80[v2.6.25-r=
c7],
   =80=80[remotes/linus/master], =80=80[original/filtered-branch] etc.
- display detached HEAD and its parents when --all is given
- track in-progress rebase

differences:
- graph does space reduction between vines
- git-forest keeps a vine in its column right now - this way
   you can point the mouse on it, scroll down until its end and
   keep track of it. (Diagonal art would require adjusting the
   mouse position, which is error prone in complex history
   like linux.)

> Can they borrow from each other?

Mh, I have uptaken some suggestions from the git-graph code: support
for --pretty and --reverse. Did not take very long (and if you look
at the git log for hxtools you can see it's criminally small
patches=9A:-)

--=20
make boldconfig -- to boldly select what no one has selected before
