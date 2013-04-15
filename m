From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 10:46:05 +0100
Message-ID: <20130415094605.GD2278@serenity.lan>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
 <20130415083558.GB2278@serenity.lan>
 <CALkWK0kzpgucLbe5TtwbZ0st51+9ZW2hkML4=yHV4y--USfynA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfzb-0006Gh-2q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab3DOJq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 05:46:26 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34216 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab3DOJq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:46:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6D684CDA56C;
	Mon, 15 Apr 2013 10:46:25 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fxIXUiiTMBO; Mon, 15 Apr 2013 10:46:19 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id E2227CDA5B6;
	Mon, 15 Apr 2013 10:46:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D3083161E44B;
	Mon, 15 Apr 2013 10:46:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g-llxadEiBT0; Mon, 15 Apr 2013 10:46:17 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8FCC6161E3B5;
	Mon, 15 Apr 2013 10:46:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kzpgucLbe5TtwbZ0st51+9ZW2hkML4=yHV4y--USfynA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221214>

On Mon, Apr 15, 2013 at 02:47:35PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > I may be an atypical user, but my expectation currently is that
> > branch.<name>.remote is what is used when I run "git push" with no
> > additional arguments.
> >
> > This is probably because whenever I add additional arguments (curre=
ntly)
> > I have to specify where I am pushing to.
> >
> > So I think breaking user expectations is a red herring here because=
 the
> > current behaviour means that users cannot have any expectation of w=
hat
> > will happen in this case.  Either you don't say anything and "git p=
ush"
> > DTRT for your current branch or you must specify precisely what you=
 want
> > to happen (or at least the remote to use if you have push.default =3D
> > matching or remote.<name>.mirror set).
> >
> > Personally I'd vote for "git push -- master" pushing to
> > remote.pushdefault, but I really don't know how you handle "git pus=
h --"
> > with the na=EFve implementation of that - is it the same as "git pu=
sh" or
> > "git push $(git config remote.pushdefault)"?
>=20
> We're not changing, or even discussing, what a plain git push without
> destination or refspecs specified should do (yes, that means git push
> -- too); it depends on push.default, which already exists.  My
> proposal does not aim to change the current behavior of _any_ current
> invocation (that means git push, git push origin master, git push nex=
t
> master v1.2, and so on). It aims to make the new syntax git push
> master +next behave logically.  I think we can all agree that the
> logical solution (leaving aside founded/ unfounded user expectations)
> is to pick destinations for each of the branches specified
> individually.  As I explained in my last email, using
> remote.pushdefault is Wrong because it treats branches like tags, and
> invents a new precedence.  Voting without a basis is useless: do you
> have a counter-argument for the points I raised as to why it is Wrong=
?

As Junio says in his parallel message, there are different opinions
here, my suggestions was to effectively replace "--" with the value of
remote.pushdefault.  I don't think your solution is not logical, but I
don't think it is the unique logical solution.

The problem is that people have different opinions of what the current
situation means, resulting in different expectations of what push
without a remote should do.  Whatever behaviour we choose /will/ be
surprising to some users, even though it is completely logical.  That
much is clear from the differing opinions in this thread.
