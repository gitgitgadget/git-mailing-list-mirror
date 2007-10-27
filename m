From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] Bisect run: "skip" current commit if script exit code
	is 125.
Date: Sat, 27 Oct 2007 01:33:06 -0400
Message-ID: <20071027053305.GB3115@hermes.priv>
References: <20071026053937.2831a89b.chriscool@tuxfamily.org> <A43880E9-E496-48AA-BC1C-2C98DFD12370@lrde.epita.fr> <200710270702.31923.chriscool@tuxfamily.org> <20071027052834.GA3115@hermes.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 07:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IleG3-0004Ds-NH
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 07:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXJ0Fae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 01:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbXJ0Fad
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 01:30:33 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:29902 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbXJ0Fad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 01:30:33 -0400
Received: by py-out-1112.google.com with SMTP id u77so1792859pyb
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        bh=eyfllGXmIuemR8wRTHrFXItPJPqerGoOhe8ercJT3Dc=;
        b=MymFSojUBN4RSZjb/Yy+rEZVRE7aPXccRdC17cBJYSLQeYiqn55NzpQvL++uC4sdoG0jR30PuZXko9T7j/e1Oqb0x8NNc7KDmpo9jnXkJQAbbVMm0bMJG4K/RaJ5hI39ul5cE0MyRco0H1fsHMi7IwtRJESmaEOXc8RT+ojFeiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=ZQU4nUOF4MEVJctRuzK1a8ggZqDjeI0G0AszrNICjfe29OGsV8p4Qh+U+57+5Fv2sd+CYFn4HeMadqeZZdxvfJbbGyXsSfdg3PF0gSbUl3tN+q8dsjobNZuHpl8v83Cox+iPuA9cJx1ZbPTvWraNM6MTpUHf51jnjKEz+KWOvF0=
Received: by 10.64.203.4 with SMTP id a4mr7711062qbg.1193463031558;
        Fri, 26 Oct 2007 22:30:31 -0700 (PDT)
Received: from hermes ( [206.248.137.23])
        by mx.google.com with ESMTPS id q18sm2578275qbq.2007.10.26.22.30.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2007 22:30:30 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Sat, 27 Oct 2007 01:33:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071027052834.GA3115@hermes.priv>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62461>

On Sat, Oct 27, 2007 at 07:02:31AM +0200, Christian Couder wrote:
> Le vendredi 26 octobre 2007, Benoit SIGOURE a =E9crit :
> > On Oct 26, 2007, at 5:39 AM, Christian Couder wrote:
> > >
> > > +The special exit code 125 should be used when the current source=
 code
> > > +cannot be tested. If the "run" script exits with this code, the
> > > current
> > > +revision will be "skip"ped, see `git bisect skip` above.
> > > [...]
> >
> Also there is:
>=20
> $ grep 77 /usr/include/sysexits.h
> #define EX_NOPERM       77      /* permission denied */

How about=20

#define EX_TEMPFAIL     75      /* temp failure; user is invited to ret=
ry */
