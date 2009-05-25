From: Johan Herland <johan@herland.net>
Subject: Re: git submodule update --merge
Date: Tue, 26 May 2009 00:48:54 +0200
Message-ID: <200905260048.54625.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
 <32541b130905251204q20b5600fr4486390cc9157f66@mail.gmail.com>
 <alpine.DEB.1.00.0905252149370.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 26 00:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iye-0007aQ-0H
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbZEYWs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZEYWs4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:48:56 -0400
Received: from mx.getmail.no ([84.208.15.66]:43616 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752212AbZEYWsz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 18:48:55 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK800HG521K84D0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 May 2009 00:48:56 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK800KB921IM9B0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 May 2009 00:48:56 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.25.223737
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0905252149370.4288@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119979>

On Monday 25 May 2009, Johannes Schindelin wrote:
> On Mon, 25 May 2009, Avery Pennarun wrote:
> > On Mon, May 25, 2009 at 2:57 PM, Johannes Schindelin wrote:
> > > Because in the project I use submodules most heavily, there is one
> > > recurring theme: you cannot push to the submodules.  And by "you" I
> > > mean "a regular user".
> > >
> > > So virtually all you do in these submodules cannot be pushed at all.
> > >  It has to be submitted to the respective submodule maintainer.
> > >
> > > And guess what happens in such a case when you set that tentative
> > > "update" variable to "merge"?
> > >
> > > Exactly.
> > >
> > > FWIW I consider any scenario where the average users have push access
> > > to the submodule a toy scenario.

Well, in the scenario I described earlier, the project developers (your 
"average users") _do_ have push access to the submodules. And that scenario 
is certainly not a toy scenario.

> > I have the same problem.  Out of curiosity, how do you handle the case
> > where you really need to make a change to the submodule and let your
> > team members see that change, even though the submodule's upstream is
> > slow and/or doesn't accept the patch?
> >
> > In that situation, we've had to make local shared mirrors of all the
> > submodules and point .gitmodules at that.  But that would be your
> > "toy" scenario - our local users have push access to the submodule.

For the purposes of this discussion, this is pretty close to the use case I 
described earlier in my scenario as well. Thanks, Avery, for presenting the 
argument in a more readable manner.

> Happily enough, our changes were accepted so far.
>
> For a few branches, though, the patches are not ready to be sent upstream
> (or, from a certain viewpoint, sometimes downstream) yet, so we do have
> local forks for those working on that.
>
> Note, however, that even in this case, it is better to use 'rebase'
> rather than 'merge', for exactly the same (I almost wrote "unconvincing")
> reason as before.

Yes, and I have never argued that your "average users" should use 'merge'. 
Indeed I have not argued that 'merge' is suitable for your workflow _at_ 
_all_.

One of the guiding principles I have learned from earlier submodule 
discussions on this list, is that the git submodule commands should NOT 
impose restrictions on the workflows available to its users. But in this 
case you are using your own workflow to argue what should, and should not be 
part of the git submodule repertoire. I am arguing that there are 
_different_ workflows, with _different_ requirements where 'merge' would be 
a useful addition. Just because you won't ever use it, does not mean that it 
will not be useful to anybody else.

> P.S.: in some cases, the submodules' "upstreams" are maintained by team
> members, but that is very much on purpose.  They are trusted maintainers,
> and there is no reason to let some young and maybe overly energetic
> friends push to such a trusted repository.

Do you argue that protecting these "young and maybe overly energetic" 
developers from themselves should be hardcoded into the git submodule 
behaviour, in such a way that it obscures the availability of other 
alternative submodule workflows?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
