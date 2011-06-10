From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 14:20:12 +0200
Message-ID: <201106101420.12892.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106101219.18497.jnareb@gmail.com> <BANLkTikHkTHP7eJ=_wPosi7yj4BX=c1gaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jun 10 14:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV0hQ-0006Rs-7e
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 14:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab1FJMUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 08:20:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43996 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab1FJMUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 08:20:22 -0400
Received: by fxm17 with SMTP id 17so1573420fxm.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=9FvlR6ViTDcu43FelycpiMj3zYrBE2VctKoAcUL7itY=;
        b=rUCSNDToCEtbSFKTKLKRZkkofzQDYKs7tN28TmAtGjpVdlZmjjfXk/qIkVorMqu5RC
         9tRT0OmnaNw2uNV+QdisFyFAuJmYa7O06a8hNQJLOJISae+Yg/sr4NTR1mOnk4xmUtJ9
         i+aF9SMDJCzYAbVPT/MCJMy2yP2CRVoh0uyNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GokX6d7YkLFIbgvZe1i+OXpx7oqCBlA88wy+ARjnonGt3sUIQ6836M/MHltm07Geez
         usGBxCagPqGYFg2h3iOPYQw/cK197o7aXnD0evgjsqu2qwDr0bYM4JUao6NHKQtRlWSF
         p2VRC9ev++c5hsZvJAIfRpn5WwfwrM1I8uP2g=
Received: by 10.223.2.205 with SMTP id 13mr1023649fak.138.1307708420703;
        Fri, 10 Jun 2011 05:20:20 -0700 (PDT)
Received: from [192.168.1.15] (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id l26sm1042423fah.38.2011.06.10.05.20.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 05:20:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTikHkTHP7eJ=_wPosi7yj4BX=c1gaA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175605>

On Fri, 10 Jul 2011, Michael Nahas wrote:
> Jakub Narebski wrote:

> > 'git diff' / 'git diff --cached' / 'git diff HEAD' is about use cas=
es
> > (or "user stories"). =A0'git diff NEXT WTREE' / 'git diff HEAD NEXT=
' /
> > / 'git diff HEAD WTREE' are about mechanism.
>=20
> Would you say that the UNIX commands "find", "grep", and "xargs" are
> about use cases?  I rarely use them by themselves.  They clearly
> manipulate concepts: files and lines.  So, it's easy for me to think
> what this does:
>=20
> find . | grep "\.h" | xargs grep MyClass | grep public

You do know that this is way suboptimal, even if you don't have 'ack'
installed, and don't use "git grep --no-index"?

>=20
> I'm trying to find concepts the concepts that git manipulates and I
> think NEXT and WTREE are part of those concepts.
>=20
> It is my opinion that if we focus on concepts, we'll be able to creat=
e
> general commands and that the user will be able to combine the
> commands in new and interesting ways, like I combined the UNIX
> commands above.
>=20
> I believe in "common" use cases.  The common case should be fast.  I
> have always recommended still allowing "git diff" by itself.
>=20
>=20
> BUT if we focus only on use cases, we'll create tools that are
> specific to ONE thing and are NOT general.  They will be harder for
> users to conceptualize and harder to combine in new and interesting
> ways.

But if it is the angle you want to play, then don't advertise it as
a feature meant for _new users_!  But if you go that route (e.g. as a w=
ay
to compare BASE with THEIRS, for whatever reason), then you probably
would need to invent some notation that is obvious that these are not
refs, like HEAD, ORIG_HEAD, MERGE_HEAD and FETCH_HEAD are.  Something
that is easy to remember, won't go in the way of either git or shell;
see e.g.

  http://thread.gmane.org/gmane.comp.version-control.git/175262/focus=3D=
175407

in "[RFC/PATCH] git put: an alternative to add/reset/checkout" thread.

--=20
Jakub Narebski
Poland
