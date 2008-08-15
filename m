From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Issues when changing submodule URLs
Date: Fri, 15 Aug 2008 17:01:29 +0200
Message-ID: <48A59A49.9030305@fastmail.fm>
References: <d3af73dc0808150537r1f708bct14113943d741e653@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 17:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0pf-0001sb-KY
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYHOPBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbYHOPBs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:01:48 -0400
Received: from main.gmane.org ([80.91.229.2]:50324 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbYHOPBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:01:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KU0oB-0004wC-6k
	for git@vger.kernel.org; Fri, 15 Aug 2008 15:01:43 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:01:43 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:01:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <d3af73dc0808150537r1f708bct14113943d741e653@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92484>

Gerard Lled=F3 venit, vidit, dixit 15.08.2008 14:37:
> We are using a super repository for our development where all our cod=
e
> resides inside submodules. I'm maintaining this tree, so it's quite
> common that I change a submodule to point to a different URL accordin=
g
> to our needs (ie, another developer is now in charge of one module).
>=20
> So, basically I delete the old submodule "rm -rf module && git rm
> module", tune .gitmodules and add it again from a different location
> "git submodule add ssh://server/newpath module".
>=20
> The problem comes when another developer pulls the super repository
> from me and he already has the old module URL initialized/updated.
> What is a safe/obvious update path for him? "git submodule update"
> does not work and running init/update doesn't help neither.
> Is there any way for me to ease these tasks for the rest of developer=
s?
>=20
> I know one option is to keep the URLs untouched and then merge trees
> as needed, but this seems to be a bigger workload for everyone.

How about:
- You mirror the submodule repos.
- Your superproject references the mirrors.
- In your mirror configuration, use descriptive names rather than actua=
l=20
URLs for the origin of the mirror.
- Use "url.realurl.insteadOf descriptivename" in your own config, which=
=20
can be changed easily whenever the authoritative source of a submodule=20
changes (see git config).

Cheers,
Michael
