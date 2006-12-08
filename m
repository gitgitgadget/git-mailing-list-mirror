X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rerere: record (or avoid misrecording) resolved, skipped or aborted rebase/am
Date: Fri, 8 Dec 2006 13:50:21 -0800
Message-ID: <20061208215021.GA28018@localdomain>
References: <20061208212830.GB13944@localdomain> <11656133963055-git-send-email-normalperson@yhbt.net> <1165613397460-git-send-email-normalperson@yhbt.net> <elcm6u$l8t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 21:50:38 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elcm6u$l8t$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33754>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsnbu-0002Bx-GW for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947400AbWLHVuX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 16:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947404AbWLHVuX
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:50:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48223 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947400AbWLHVuW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:50:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 5E5E32DC034; Fri,  8 Dec 2006 13:50:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 08 Dec 2006
 13:50:21 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric Wong wrote:
>=20
> Just one comment:
>=20
> > +=A0=A0=A0=A0=A0=A0=A0if test -d "$GIT_DIR/rr-cache"
> > +=A0=A0=A0=A0=A0=A0=A0then
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git-rerere clear
> > +=A0=A0=A0=A0=A0=A0=A0fi
> > =A0=A0=A0=A0=A0=A0=A0=A0this=3D`expr "$this" + 1`
> > =A0=A0=A0=A0=A0=A0=A0=A0resume=3D
> > =A0fi
> > @@ -408,6 +412,10 @@ do
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0stop_here_user_resolve $this
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fi
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0apply_status=3D0
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if test -d "$GIT_DIR/=
rr-cache"
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0then
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0git rerere
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fi
>=20
> Why do you use once "git-rerere", and another time "git rerere"?
> Shouldn't scripts always use git-command form?

Yes.  Or at least I remember git-command form being preferred.

I don't think I've been entirely consistent in the things I've
written, and my shell history is just as inconsistent :x

--=20
