From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Mon, 3 Nov 2008 13:06:27 +0100
Message-ID: <200811031306.28615.jnareb@gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <200810310836.02908.jnareb@gmail.com> <1225701813.20883.85.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 13:07:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwyDp-000247-CZ
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 13:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbYKCMGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbYKCMGl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 07:06:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24464 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbYKCMGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 07:06:40 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1685544ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 04:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uSZFKJ5RNRbcE33d6VjrbA6q0dGwcwcIKVhBGbs5Ce8=;
        b=NgHogBgM/MhAJW1U7a/29hGdTPasvG8vFWomFkgvvhLQQFiMV5CSLpC1WF1/xLRVaZ
         4r7M5WpC+ShgWndke5sSRbWy8D2UABwOheHQRfH+QWwoZLmAVZPQJ+5gChojrYNO+kpL
         0fkTzETHvS+fQDPrbrIkvRmFSrKZwAfX1vzx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MGBxxeWT44zPpKAjHGXipiFHrYrPvHIwGKc5kGBzurqXLK64CHR59fTUPH4rCs4su9
         QF7gmMY7wmX+45S+IjABbcedVexoPamy4z9ACnHSmaErZnT7W18RyHQ8ZqcDbf0njv6g
         WFzuku4plWaeYmy6z4S2QhQAJkV3ddmpH0oCU=
Received: by 10.66.221.6 with SMTP id t6mr1942843ugg.55.1225713998650;
        Mon, 03 Nov 2008 04:06:38 -0800 (PST)
Received: from ?192.168.1.11? (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id k28sm20101977ugd.42.2008.11.03.04.06.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 04:06:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1225701813.20883.85.camel@maia.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99934>

Dnia poniedzia=B3ek 3. listopada 2008 09:43, Sam Vilain napisa=B3:
> On Fri, 2008-10-31 at 08:36 +0100, Jakub Narebski wrote:

> > > >     git checkout --track origin/wr34251-do-something
> > >=20
> > > Ah, that's a new feature.  Still, I think it's poorly Huffman cod=
ed; far
> > > too verbose.
> >=20
> > Well, either you have a little bit more verbose, or you have to hav=
e
> > some DWIM-mery, which (as usual with DWIM) can go wrong.
>=20
> That's right, you need to choose when to assume that the user meant
> something that they didn't write very carefully.
>=20
> But look at this:
>=20
>   git checkout origin/master
>=20
>   git checkout -t origin/master
>=20
> The option is called "--track", yet in this case what it actually mea=
ns
> in the default situation where you have autosetupmerge (or whatever i=
t's
> really called) set to true, is that it modifies the command to imply =
"-b
> master".  So, in this situation, that is clearly what was meant.
>=20
> Perhaps you can give an example of why this particular piece of DWIM
> might not be WYM?

I was not talking about "git checkout -t origin/master" being shortcut
for "git checkout -b master -t origin/master", but about proposed
DWIM-mery for "git checkout -b <branch>" which would be

                             { git checkout -b <branch> -t <remote>/<br=
anch>
  git checkout -b <branch> =3D {        if there exists <remote>/<branc=
h>=20
                             {
                             { git checkout -b <branch> HEAD
                             {        otherwise
--=20
Jakub Narebski
Poland
