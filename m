From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: merge ignores --no-commit in fast-forward case
Date: Sat, 19 Sep 2009 10:09:03 +0200
Message-ID: <20090919080903.GA16316@atjola.homenet>
References: <A754ACF1-77C2-4036-A15C-8949E76BD2D5@dbservice.com>
 <7vocpfz4gm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tom@dbservice.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 10:09:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mov0T-00025D-Ut
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 10:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbZISIJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Sep 2009 04:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbZISIJK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 04:09:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:36975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932102AbZISIJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 04:09:05 -0400
Received: (qmail invoked by alias); 19 Sep 2009 08:09:06 -0000
Received: from i59F5718D.versanet.de (EHLO atjola.homenet) [89.245.113.141]
  by mail.gmx.net (mp006) with SMTP; 19 Sep 2009 10:09:06 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+8L9AIaRe8L7o9OhEqZERBvhf2AG29CVWnApNHAk
	MXLOtpyvU+O22x
Content-Disposition: inline
In-Reply-To: <7vocpfz4gm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128818>

On 2009.09.13 00:30:49 -0700, Junio C Hamano wrote:
> Tomas Carnecky <tom@dbservice.com> writes:
> > Three possible solutions that I see:
> >
> >  2) Refuse to do anything if user gives --no-commit and merge is fa=
st-=20
> > forward
> >  3) Document this behavior in the manpage
> >  4) Quietly set deny_non_fast_forward when --no-commit was given
>=20
> Heh, this is new.  People laugh at me when I number my bullets starti=
ng
> from zero, like all good computer scientists do ;-)
>=20
> Seriously, we should at least do #3, and as a backward incompatible c=
hange
> at least _consider_ doing #2 (I think #4 is merely an implementation =
detail
> of #2), and if list reaches concensus in favor of such a change, come=
 up
> with a transition plan and do so in the 1.7.0 release.

Hm, I always treated --no-commit as a way of saying: I think this merge
might cause semantic problems, please let me fix those directly, instea=
d
of having to deal with 'commit --amend' and 'diff HEAD^ HEAD'.

Obviously, in case of a fast-forward such semantic problems aren't to b=
e
expected, and I've just been wrong in my expectations. And then I'm
happy with the fast-forward. I'd _not_ be happy if a merge commit would
be forced (that's what #4 was about, right? deny_non_fast_forward only
appears in builtin-receive-pack.c, so I guess allow_fast_forward=3D0
was meant...).

#2 would be ok with me, I guess. I expected the wrong thing from the
merge, so git may complain, though it means more typing ;-)

Bj=F6rn
