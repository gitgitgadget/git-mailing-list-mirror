From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Tue, 6 Jan 2009 10:07:19 +0100
Message-ID: <20090106090719.GA25609@chistera.yi.org>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com> <20081216114138.GM12856@machine.or.cz> <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com> <20090105164001.GA12275@machine.or.cz> <20090105194011.GB25104@glandium.org> <20090105212716.GJ6595@eratosthenes.cryptobackpack.org> <d411cc4a0901051749p2ef880bub45bba1c0d41bfc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7vZ-0004ER-FF
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZAFJHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jan 2009 04:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZAFJHY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:07:24 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2542
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAFJHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:07:22 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 5E822801C0E4;
	Tue,  6 Jan 2009 10:07:20 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LK7uB-00076e-5B; Tue, 06 Jan 2009 10:07:19 +0100
Content-Disposition: inline
In-Reply-To: <d411cc4a0901051749p2ef880bub45bba1c0d41bfc7@mail.gmail.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104669>

* Scott Chacon [Mon, 05 Jan 2009 17:49:01 -0800]:

> Also, Miklos : your patch changes the format of the output and doesn'=
t
> speed things up or anything, so I'm just sticking with the current
> script for now (unless I'm missing something).

-8<-
git log --pretty=3Dshort --no-merges | git shortlog -n | grep -v -e '^ =
' | grep ':' > ../gitscm/config/authors.txt

    data =3D author.split(' ')
    number =3D data.pop.gsub('(', '').gsub(')', '').chomp
    name =3D data.join(' ')
-8<-

vs

-8<- v2 -8<-
git shortlog --no-merges -sn > ../gitscm/config/authors.txt

    if author =3D~ /(\d+)\s+(.+)/
        name, number =3D $2, $1
-8<-

HTH.

P.S.: And it is a tad faster, yes (not that that should be the primary
criteria).

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
The true teacher defends his pupils against his own personal influence.
                -- Amos Bronson Alcott
