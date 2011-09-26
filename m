From: David Aguilar <davvid@gmail.com>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 21:21:27 +0200
Message-ID: <20110926192126.GA55743@gmail.com>
References: <20110923195829.GA27677@sigill.intra.peff.net>
 <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 21:20:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Gim-0006hw-9o
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab1IZTUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 15:20:01 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52367 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1IZTUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 15:20:00 -0400
Received: by qyk7 with SMTP id 7so6933730qyk.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bDh5CW9HcjsbWlYp75+hDFt9pS64EvSawXjfCuViGdw=;
        b=QV7tVGgeONGbo4dF72c62u3nU3qwWY7aTTx6qAjIXu4Q5I2cvSN/OuHGXi5Evn2kI6
         Cm2Fvnzx+ral4f5F3DKEgnL5L2rCOyy2caEOp3Qb7qsRL2QEZOpK97dJ1Tz3keA0zp8/
         AvGIssN+/ppoRi2t8e7b1t31TreQkVWDvMwCQ=
Received: by 10.224.215.196 with SMTP id hf4mr5236575qab.78.1317064799587;
        Mon, 26 Sep 2011 12:19:59 -0700 (PDT)
Received: from gmail.com ([207.164.135.98])
        by mx.google.com with ESMTPS id v6sm22471454qaz.7.2011.09.26.12.19.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 12:19:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182152>

On Mon, Sep 26, 2011 at 08:45:58PM +1000, Nguyen Thai Ngoc Duy wrote:
> On Sat, Sep 24, 2011 at 5:58 AM, Jeff King <peff@peff.net> wrote:
>=20
> Another thing is, what if I want to exclude certain part of the inclu=
ded config?
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/163285/foc=
us=3D163288
>=20
> > [1] I want conditional inclusion because sometimes the rules for co=
nfig
> > =C2=A0 =C2=A0entries changes from version to version. For example, =
I have
> > =C2=A0 =C2=A0pager.diff set to a script in my ~/.gitconfig. But old=
er versions of
> > =C2=A0 =C2=A0git don't understand non-boolean values and barf. I'd =
really like to
> > =C2=A0 =C2=A0do something like:
> >
> > =C2=A0 =C2=A0[include-ifdef "has-pager-scripts"]
> > =C2=A0 =C2=A0path =3D ~/.gitconfig-pager
> >
> > =C2=A0 =C2=A0where "has-pager-scripts" would be a magic flag compil=
ed into git
> > =C2=A0 =C2=A0versions that understand that config.
>=20
> But how far would you go with conditional expressions?
> --=20
> Duy

This syntax is simple yet would solve one problem I run into
often.  It could be used for the case where some settings
(e.g. diff.tool, merge.tool) are different on OS X and Linux.

[include-ifdef "darwin"]
	path =3D ~/.gitconfig-darwin
--=20
					David
