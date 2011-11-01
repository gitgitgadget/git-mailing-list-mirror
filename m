From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Tue, 1 Nov 2011 20:06:19 +0000 (UTC)
Message-ID: <loom.20111101T205618-231@post.gmane.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com> <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 21:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLKjr-0001J3-Av
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab1KAUPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 16:15:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:44965 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159Ab1KAUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:15:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RLKjj-0001HL-Tj
	for git@vger.kernel.org; Tue, 01 Nov 2011 21:15:08 +0100
Received: from dslc-082-083-197-091.pools.arcor-ip.net ([82.83.197.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 21:15:07 +0100
Received: from stefan.naewe by dslc-082-083-197-091.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 21:15:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.197.91 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184585>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> [administrivia: dropped the kernel mailing list from and added Peff t=
o Cc]
>=20
> Stefan N=C3=A4we <stefan.naewe <at> atlas-elektronik.com> writes:
>=20
> >>>  * HTTP transport did not use pushurl correctly, and also did not=
 tell
> >>>    what host it is trying to authenticate with when asking for
> >>>    credentials.
> >>>    (merge deba493 jk/http-auth later to maint).
> >>=20
> >> This seems to break pushing with https for me.
> >> It never uses values from my '~/.netrc'.
> >> I'll come up with a detailed scenario later.
> >
> > Update:
> >
> > git push prompts for the password but just pressing return succeeds=
=2E
> >
> > Weird...
>=20
> There are only handful of commits that even remotely touch http relat=
ed
> codepath between v1.7.7 and v1.7.8-rc0:
>=20
> [...]
>=20
> Could you try reverting deba493 and retest, and then if the behaviour=
 is
> the same "need ENTER", further revert 070b4dd and retest?

Did some tests again at my home machine with v1.7.8-rc0.

Push with https works, if the URL looks e.g. like this:

  https://github.com/user/repo.git

rather than this

  https://user@github.com/user/repo.git

and having a ~/.netrc like this

  machine github.com login user password YouDontWantToKnow

If the URL contains 'user@' I get the 'need ENTER' behaviour.

I'll recheck everything at work, where I live behind a very restrictive
firewall (Don't know if that makes any difference).

Regards,
  Stefan
