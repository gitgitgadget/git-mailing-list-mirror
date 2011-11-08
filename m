From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: Update install-doc-quick (Re* What's cooking in git.git (Nov 2011, #02; Sun, 6))
Date: Tue, 8 Nov 2011 20:59:30 +0000 (UTC)
Message-ID: <loom.20111108T215341-107@post.gmane.org>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org> <4EB91D2C.6020504@atlas-elektronik.com> <7v8vnqzitb.fsf@alter.siamese.dyndns.org> <7vr51ixyuz.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 21:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNslr-0000n9-On
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 21:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294Ab1KHU7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 15:59:47 -0500
Received: from lo.gmane.org ([80.91.229.12]:39949 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1KHU7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 15:59:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RNslk-0000lT-NN
	for git@vger.kernel.org; Tue, 08 Nov 2011 21:59:44 +0100
Received: from dslc-082-083-251-204.pools.arcor-ip.net ([82.83.251.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 21:59:44 +0100
Received: from stefan.naewe by dslc-082-083-251-204.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 21:59:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.251.204 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185110>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> Junio C Hamano <gitster <at> pobox.com> writes:
>=20
> > Stefan N=C3=A4we <stefan.naewe <at> atlas-elektronik.com> writes:
> >
> >> This breaks the 'quick-install-{doc,html,man}' make targets, btw.
> >
> > Thanks. As the "push into kernel.org auto-rebuilds these branches"
> > infrastructure is no longer available, I think we should remove the=
se
> > targets and description of them in the INSTALL file in the meantime=
=2E
> >
> > Anybody care to do a big removal patch?
>=20
> Alternatively, we could keep it alive if people really want it, like =
this.

Yes!
=20
> Stefan, care to apply it on top of 'maint' and try it out?

(That was a little harder than I thought, because the patch got garbled
when I added '/raw' to the URL in gmane. Had to use a news reader to
get an 'applyable' version).
=20
>=20
>  git read-tree $head
>  git checkout-index -a -f --prefix=3D"$mandir"/

-git checkout-index -a -f --prefix=3D"$mandir"/
+git checkout-index -a -f --prefix=3D"$destdir"/

> -if test -n "$GZ"; then
> +if test -n "$GZ"
> +then
>  	git ls-tree -r --name-only $head |
>  	xargs printf "$mandir/%s\n" |

-       xargs printf "$mandir/%s\n" |
+       xargs printf "$destdir/%s\n" |


Works for me.

Thanks,
  Stefan
