From: Wincent Colaiuta <win@wincent.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 11:39:08 +0200
Message-ID: <D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <7vmym1zny4.fsf@gitster.siamese.dyndns.org> <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com> <m3mym1zkus.fsf@localhost.localdomain> <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 11:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3pTm-0006OC-Kq
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 11:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYFDJje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 05:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYFDJjd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 05:39:33 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:37649 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYFDJjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 05:39:33 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m549d9WK001176
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 4 Jun 2008 05:39:13 -0400
In-Reply-To: <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83766>

El 4/6/2008, a las 10:30, David escribi=F3:

> Thanks :-) This still isn't what I had in mind (see my earlier post
> with examples), but I realise now, thanks to your post, that I can
> probably do it like this:
>
> 1) Make a temporary branch off the topic
>
> 2) Rebase the temporary branch onto master interactively (maybe or
> maybe not with --onto), and in interactive mode take out, reorder,
> etc.
>
> 3) Check & test the temporary branch
>
> 4) Merge the temporary branch into master, and drop the temporary =20
> branch.
>
> 5) Rebase the original topic branch onto the new master.
>
> Thanks to all the posters for their tips.

Sounds like it would definitely work but it also sounds like a lot of =20
repetitive "busy work"[1] which could be avoided by using finer-=20
grained topic branches in the first place.

In the basic case Git makes it incredibly easy to split off topic =20
branches and merge them back in, and when you do this you're working =20
in synergy with the tool. But while what you're wanting to do is =20
certainly possible you can also see that it has a lot of fiddly, error-=
=20
prone overhead in which you're juggling temporary branches and commits =
=20
back and forth in a complicated way. Not working in synergy with the =20
tool.

I know that I'd soon get tied of this "busy work" if I had to do it; =20
maybe with time you'll be able to transition to a style in which you =20
make more, smaller topic branches,  which can really be treated as =20
logically-grouped topics and merged in as a whole rather than sifted =20
out into separate sub-topics.

Having said that, the ability to pass multiple commits or ranges of =20
commits to "git cherry-pick" is a logical enough enhancement, if =20
someone is interested enough in this feature to actually do the work.

Wincent

[1] http://en.wikipedia.org/wiki/Busy_work
