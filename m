From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 12:11:35 +0100
Message-ID: <201002071211.36440.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002070220.36897.jnareb@gmail.com> <cb7bb73a1002070257g8f1e59dvf124c8966cdf3270@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 12:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne58o-0007eV-7z
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 12:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab0BGLLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 06:11:46 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:41770 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0BGLLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 06:11:45 -0500
Received: by fxm3 with SMTP id 3so6181742fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PIs1KJk1JiH3XlGbUW6IpdPmh03hCIrQSyI3HRpyPbw=;
        b=WmdGwvkoqt/ZNawc3uzp7gmJ+YbWOgy/4pAoGSSau8X5CshzCRFEj2p7go7BwBktY/
         qdEk/vheEzw70HDW4WxcfDE5Raj8wYmt69PKR6ISQLEpOohSQZgHyIJlafSgUGun24ee
         XikscwMqJ6f4OVAeJEB0YQuCE4R/0SCeRcY6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=awkGeXD422w+oKW1LBxg+DWegfmZzifed1p/teGNt/oTXsywa4jFqFRPI+bNV3rIv9
         lZYFWuQ9QgVLtPPc4Cq77yVc3rOh2BhlJtCsmYEbAukSW9gLeSVlIsM0Z5u7vFaNJPOc
         GhWh6pGIqiBXPuJG3o90Ko8yUe83hg2k6cn38=
Received: by 10.223.76.91 with SMTP id b27mr342953fak.4.1265541103825;
        Sun, 07 Feb 2010 03:11:43 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id z10sm4893523fka.30.2010.02.07.03.11.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 03:11:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002070257g8f1e59dvf124c8966cdf3270@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139234>

Giuseppe Bilotta wrote:
> On Sun, Feb 7, 2010 at 2:20 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:

> > Errr, I not made myself clear.
> >
> > I have added a note to a commit, using "git notes edit d6bbe7f". =A0=
Now if
> > you take a look at gitweb output for this commit (e.g. 'commit' vie=
w for
> > this commit) using gitweb without your changes, you would see that =
it
> > flattened notes at the bottom of the commit message (which I think =
is
> > intended result by notes implementation).
> >
> > If you run the command that parse_commit runs, namely
> >
> > =A0$ git rev-list --parents --header -z --max-count=3D1 \
> > =A0 =A0d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3
> >
> > you would get (up to invisible NUL characters) the output shown abo=
ve.
>=20
> And that's what I don't get. git version 1.7.0.rc1.193.ge8618. If I
> remember correctly, the behaviour of automatically displaying notes i=
n
> git log & friends was changed recently. So git log -1
> e8618c52b5f815624251f048609744c9558d92a1 gives me the notes I put
> there for testing, git rev-list --parents --header -z --max-count=3D1
> does not.

Ah, sorry.  Git version 1.6.6.1 here.

--=20
Jakub Narebski
Poland
