From: Xavier Claessens <xclaesse@gmail.com>
Subject: Re: Branches with git-svn
Date: Fri, 19 Sep 2008 15:13:38 +0200
Message-ID: <1221830018.6784.12.camel@zdra-laptop>
References: <1221819302.6784.4.camel@zdra-laptop>
	 <48D39C7B.9020709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 15:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgfp3-0008E9-GY
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYISNNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 09:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYISNNo
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:13:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:34773 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbYISNNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:13:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so562076fgg.17
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ntmYoreJq5J+Z3aHrFIv+hYS/z+exPqVSahNMAbct4A=;
        b=JL0sosMBPDaIaMwm7n2OOq3ILpFuSzrNCJ523ERAe96qIJT0XXETDZVyH5+J6lVRYF
         iGLpWhO3k0qWXW54DxxkpXlG4/c/FqESMzvABFY+DXAnVA5bDhlYYzHIuFEYKWRL0GmJ
         nxjKIp3shHMN+7z4iHs7opTKCwFZknZBl9oFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BdVDNpBsn8TXPiZHv8EJnXIIUpXHwyi30MCAdR7kwg3oibitp5v0hJ4tZWk+vPmJKh
         deQy19ksuasgmG7DVc+4+eQrNRCUKPIgVjebkpLZPOTPdPJasMX0pmrJMC+kDIMhB3bi
         W2eXlre+5H5ioXDM2n0wzcASFLCHVJYQS2owA=
Received: by 10.86.92.7 with SMTP id p7mr1920965fgb.8.1221830021309;
        Fri, 19 Sep 2008 06:13:41 -0700 (PDT)
Received: from ?192.168.1.13? (114.142-247-81.adsl-dyn.isp.belgacom.be [81.247.142.114])
        by mx.google.com with ESMTPS id d6sm101704fga.2.2008.09.19.06.13.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 06:13:40 -0700 (PDT)
In-Reply-To: <48D39C7B.9020709@drmicha.warpmail.net>
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96284>

On ven, 2008-09-19 at 14:35 +0200, Michael J Gruber wrote:
> Xavier Claessens venit, vidit, dixit 19.09.2008 12:15:
> > Hi,
> >=20
> > I created a git repository using "git-svn clone <url>" a long time =
ago.
> > But now I realise that I don't get SVN branches into my git reposit=
ory.
> > I see that the doc tells to use "git clone -t tags -b branches -T t=
runk
> > <url>" to create the repository. If I create a new repository with =
that
> > command, I get branches and tags.
> >=20
> > However I have lots of contributors having branches based on my git
> > repository. Is there a way to add SVN branch to my existing git rep=
o?
>=20
> If you haven't use those options back then, then what was the svn rep=
o
> structure - no trunk, just main?
> Did you change the structure now?
>=20
> If you git-svn fetch from that new structure then all your new branch=
es
> etc. will show up as subdirectories, which is most certainly not what
> you want.
>=20
> So, what was the structure in svn like before, and have your
> contributors based their branches on the mis-imported new structure a=
lready?

Hi,

Thanks for your email, but Bj=C3=B6rn Steinbrink on IRC solved my probl=
em.
=46or the record what I did is:
1) make a new "git svn clone -t tags -b branches -T trunk <url>"
2) copy/past the description of the "svn" remote in .git/config from th=
e
new clone into my old repository. Just replaced, in right part of the
fetch line, "trunk" by "git-svn"
3) "git svn fetch" imported all branches correctly based on the commits
I already have.

Thanks to all git and git-svn developers to make my life easier!

Xavier Claessens.
