From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git
 status
Date: Fri, 6 May 2011 01:47:23 +0200
Message-ID: <20110505234722.GF636@madism.org>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
 <7vbozg67oj.fsf@alter.siamese.dyndns.org>
 <20110505233925.GE636@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI8Ga-0002Q2-JB
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1EEXrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 19:47:25 -0400
Received: from pan.madism.org ([88.191.52.104]:55889 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab1EEXrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:47:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DBD0D51AC1;
	Fri,  6 May 2011 01:47:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2AAE413EC; Fri,  6 May 2011 01:47:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110505233925.GE636@madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172927>

On Fri, May 06, 2011 at 01:39:25AM +0200, Pierre Habouzit wrote:
> On Thu, May 05, 2011 at 04:37:00PM -0700, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> >=20
> > > @@ -732,6 +805,7 @@ void wt_status_print(struct wt_status *s)
> > >  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
> > >  	}
> > > =20
> > > +	wt_status_print_doingwhat(s);
> > >  	wt_status_print_updated(s);
> > >  	wt_status_print_unmerged(s);
> > >  	wt_status_print_changed(s);
> >=20
> > I am very surprised that a new call to this function is added here.
> >=20
> > As the "You are in middle of" information is useful mostly when you=
 are on
> > detached head, I would have expected that the call would be inside =
the
> > if/elif chain near the top of wt_status_print() where we say "On br=
anch"
> > vs "Not currently on...", to replace that information that comes fr=
om that
> > on_what variable.
>=20
> It's also useful when you're in the middle of a rebase or during a me=
rge
> conflict who aren't on a detached head.

s/rebase/bisect/ sorry it's late.

Anyways it prints nothing if the repository "looks normal"
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
