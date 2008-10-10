From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git confused by rename
Date: Fri, 10 Oct 2008 18:19:22 +0200
Message-ID: <20081010161922.GH3671@atjola.homenet>
References: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com> <7vabdcmp4n.fsf@gitster.siamese.dyndns.org> <7v3aj4momt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 18:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKjD-0002uO-Ld
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 18:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761890AbYJJQT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2008 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761518AbYJJQT1
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 12:19:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:58386 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761527AbYJJQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 12:19:26 -0400
Received: (qmail invoked by alias); 10 Oct 2008 16:19:23 -0000
Received: from i577B8FB1.versanet.de (EHLO atjola.local) [87.123.143.177]
  by mail.gmx.net (mp065) with SMTP; 10 Oct 2008 18:19:23 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+fhm1aJh6fXn7NCe9WZsx8QpkSvC9OFwg6lcAT1N
	TT/OAS9Fw0RLbr
Content-Disposition: inline
In-Reply-To: <7v3aj4momt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97947>

On 2008.10.10 08:54:50 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Because git does not care how you created B (IOW, it does not matte=
r
> > if B was typed from scratch with copying and pasting, or created by
> > copying and editing), the "renamed: A -> B" entry itself is not
> > surprising nor look like a bug at all,...
>=20
> The above observation of mine is correct, but I forgot that "git stat=
us"
> (and the comment in the commit template from "git commit") is generat=
ed
> internally with "diff-index -B -M".  So if
>=20
>  (0) had A but not B in the HEAD commit;
>  (1) you created B that is very similar to the original A; and
>  (2) you modified A beyond recognition;
>=20
> then git will say "A was modified and B was created by renaming A".
>=20
> > ... but its presense at the same time as "modified: A" does feel ve=
ry
> > fishy.
>=20
> So this is not fishy anymore.
>=20
> This however makes me wonder if "diff-index -B -M" should say B is co=
pied
> (instead of being renamed) from A and A is modified in such a case.  =
I do
> not think we would want to make such a change without thinking things=
,
> through.

Oh, heh, my patch doesn't help in that case. It's still modify + rename
with it, of course, as -B still breaks the stuff apart. Me being
confused about -M reporting copies in some cases remains though, I had
really expected that only -C would detect copies. Of course, this
confusion is purely from a user's point of view, I have zero knowledge
about the involved code...

Bj=F6rn
