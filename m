From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to force git to use authentication as author
Date: Thu, 14 Jul 2011 05:44:50 -0700 (PDT)
Message-ID: <m3zkkh9gmq.fsf@localhost.localdomain>
References: <20110714160638.065b6542@shiva.selfip.org>
	<CACBZZX4X8qRBXqwi70kZ0eZ+mb7rdD6p36xD=GoX6soha0TZcg@mail.gmail.com>
	<20110714161838.1e30893a@shiva.selfip.org>
	<1310641202.18730.16.camel@bee.lab.cmartin.tk>
	<20110714164547.0b359e60@shiva.selfip.org>
	<1310643482.6041.17.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bakshi" <joydeep@infoservices.in>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: =?iso-8859-15?q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 14 14:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhLHn-0007YV-6e
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 14:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab1GNMoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 08:44:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45773 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1GNMoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 08:44:54 -0400
Received: by eyx24 with SMTP id 24so115162eyx.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=YDcgkxKxCgiuQhzQXnEDecXRw0BhoiZk6nXVeJFIn9A=;
        b=pFxyzYjucKY8t3sM+3cVbjE5J6ft/o5V+F9qwYLS/hSlkBROOIw8aGDAGjtRMOz1mM
         eWkxlU2Ixr2DpJ4a1Fxffc/dTddumYZfUBYYoCQLWtJoSK3IUhJ0WbJVLMg0zKxcgoXF
         dvd4CeMUYM8GdaIR4/Ahc+ko8YrSS/QOJh2aY=
Received: by 10.14.53.7 with SMTP id f7mr757439eec.69.1310647492023;
        Thu, 14 Jul 2011 05:44:52 -0700 (PDT)
Received: from localhost.localdomain (abvg158.neoplus.adsl.tpnet.pl [83.8.204.158])
        by mx.google.com with ESMTPS id d44sm141920eeb.22.2011.07.14.05.44.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 05:44:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6ECiHlt032544;
	Thu, 14 Jul 2011 14:44:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6EChwFv032540;
	Thu, 14 Jul 2011 14:43:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1310643482.6041.17.camel@centaur.lab.cmartin.tk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177127>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> That's not how it works. It may even be possible to rewrite the commi=
ts
> in the post-receive hook in a way that most stuff doesn't break
> horribly, this would be rewriting history behind the users' backs, an=
d
> that only brings problems.

What you can do is forbid push.  I think update-paranoid and gitolite
have some examples on how to do that.
=20
> The way to set the author name and mail in a standard way, be it
> user-wide or per-repo. You can write up some simple instructions on h=
ow
> to do it.
>=20
>     git config user.name "Max Smith"
>     git config user.mail max.smith@example.com
>=20
> and if the config should be valid for every repo, use --global flag.
> There is more information in the manual page.
>=20
> You could then add a check in the post-receive hook to reject pushes
> with invalid author names, if you feel it's worth it.
>=20
> Taking a step back, why is this even an issue, though? If you don't
> trust your developers to set their name and email correctly, why do y=
ou
> trust them to write code? If it's company policy for people to be
> referred to by their usernames rather than their given names, why not
> tell them to set it to that[0]? It seems like you are trying to solve=
 a
> social issue with a technological measure that works at a different
> level.
>=20
> [0] and given that they're probably using their company email address=
,
> it wouldn't be a problem to get a unique ID for each developer if tha=
t's
> what you need.

Note that there is also .mailmap mechanism (see the documentation)
which can translate on the fly between public emails and internal
company emails, and which can fix invalid names... at least got
git-log, git-blame etc.

--=20
Jakub Nar=EAbski
