From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 20:54:52 +0100
Message-ID: <1361822092.30765.12.camel@centaur.cmartin.tk>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
	 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
	 <1361819916.24515.5.camel@centaur.cmartin.tk>
	 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA48Z-0008Sd-Lp
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759441Ab3BYTyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 14:54:35 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:54685 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759348Ab3BYTye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:54:34 -0500
Received: from [192.168.1.2] (p57A1F6E7.dip.t-dialin.net [87.161.246.231])
	by hessy.dwim.me (Postfix) with ESMTPSA id B36D180616;
	Mon, 25 Feb 2013 20:54:32 +0100 (CET)
In-Reply-To: <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217099>

On Mon, 2013-02-25 at 11:27 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On Mon, 2013-02-25 at 10:31 -0800, Junio C Hamano wrote:
> > ...
> >> Interesting.  "git ls-remote . | grep 1.8.0-" for maint, master,
> >> next and pu produce identical results for me, all showing peeled
> >> ones correctly.
> >
> > Bisection leads me to Peff's 435c8332 (2012-10-04; upload-pack: use
> > peel_ref for ref advertisements) and reverting that commit brings t=
he
> > -rc3^{} back.
>=20
> A shot in the dark, as I do not seem to be able to reproduce the issu=
e
> with anything that contains the commit.  Perhaps your .git/packed-ref=
s
> is corrupt?

My packed-refs file did not end with LF. It seems it must or the parser
won't consider the last tag in the file to have a peeled target and min=
e
didn't. I don't how the ended up this way but it looks like there's is =
a
bug in the parser (or does the format force you to have LF at the end?)

   cmn
