From: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or
 upstream
Date: Fri, 7 Jun 2013 18:14:02 +0200
Message-ID: <20130607161402.GH28668@sociomantic.com>
References: <20130607124146.GF28668@sociomantic.com>
 <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
 <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkzJ5-0000CJ-7O
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab3FGQOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 12:14:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab3FGQON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 12:14:13 -0400
Received: from labs09.localdomain (pD957613F.dip0.t-ipconnect.de [217.87.97.63])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LmPME-1UBNIf41ly-00ZPx4; Fri, 07 Jun 2013 18:14:04 +0200
Received: from luca by labs09.localdomain with local (Exim 4.76)
	(envelope-from <leandro.lucarella@sociomantic.com>)
	id 1UkzIh-0000au-1p; Fri, 07 Jun 2013 18:14:03 +0200
Content-Disposition: inline
In-Reply-To: <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
X-Paranoid: Just because you're paranoid, don't mean they're not after you.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:MJPVh12h/4gFdu4K/bFjIopB9uydRYFdhURZso/aGuN
 034kQ+oiDNVoe0dQrQ3LyeScOg9HsjvkHMs5grW4OcDHJH8+xf
 4GVFw4exdLqvCXauptkcmKuaSfuPa2PeEJbEVWId5kVQ4Z33Kz
 KFlwA43ooIHWluS9uB5Cpt/h368h7/6lDc93sqgeWBx2nmORQa
 Ua0yGDCdmXby0sGD6FLBAKA+78fDMXdUtGVwb72Tsb27KfPJpm
 24edR8bfBcRR5IG6aF8VflLFpMr9BGWMneOBJ//JyPnKKUNika
 Ke2SmL/PUSMYR9elFCSbYRAaP3lS9xLh4ZNEKY+nlBApRVGVNA
 kG+bIb/HxZKz33nUpPBmtA4PdEkr+Mf2CDy6SYLl5NFhNWKqrd
 PBFlbKkuJHosQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226645>

On Fri, Jun 07, 2013 at 08:47:59AM -0700, Junio C Hamano wrote:
> When branch.$name.push mechanism is introduced and the user uses it,
> then "upstream", "simple", or any other setting for that matter
> would be ignored.  With
> 
> 	[branch "master"]
> 		remote = upstream
>                 merge = refs/heads/master
>                 pushremote = origin
> 		push = refs/heads/master
> 
> it is clear that "git push" while on 'master' should push to origin
> to update its master branch.

Thanks for the detailed explanations, I think this would cover my use
case. Just for clarification, here are some more details on this use
case, which I think is becoming very popular among github users.
We have a "blessed" repository (upstream in my case) and only a few
people is able to push to it (let's call them maintainers). Every
developer, including the ones with push access, have to go through peer
reviewing and are not allowed to push their own commits to upstream. For
peer reviewing, each have it's own public fork, that other people can
review and merge/push if is good.

In this scheme, you always pull from the blessed repository and only
push to your personal fork, with the exceptions of the maintainers that
need to push from time to time other people pull requests.

My ideal would be to be able to just do 'git pull' to get the new stuff
and 'git push' to push to my fork. Since pushing to the blessed
repository is more "critical", is perfect that I need to explicitly push
to it with 'git push upstream master'.

Thank you.

-- 
Leandro Lucarella
Senior R&D Developer
sociomantic labs GmbH <http://www.sociomantic.com>
