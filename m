From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is current HEAD pointing at a given revision ?
Date: Tue, 14 Jun 2011 18:17:22 +0200
Message-ID: <201106141817.23585.jnareb@gmail.com>
References: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com> <m3mxhkvlcw.fsf@localhost.localdomain> <BANLkTimMkOS_Q9gb_ta2P3NSMGyNJtKgJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 18:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWWQe-0001SO-IT
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 18:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1FNQZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 12:25:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41073 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1FNQZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 12:25:18 -0400
Received: by fxm17 with SMTP id 17so3823733fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=q3KrLgrrr9SKSNBLyAHQ2ZnqAGkZpuHaL55mdcPzqZQ=;
        b=QQX7I5jisTvkPEjVIjrckpQ5+qeVMrBQfCly8HKkCfuYj0IHL8+Y1kFL50FTeQtmqB
         sGN5+YmDTxwTYWtn+81Cui74x7+HAZ3eLz4kdNO5u2b9XYdaXTY3tegfX51DPYrXDLs7
         8spYF2IVTT6fSiLI+c1Lb/ApPtRhfzp0JnV7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TUUQl/3f25+iMDius9JM+zE6/wCvDg7fVX+mDo90rVD22bH8DpYGe6sDUfyHGAalFy
         JwCkfj6jEDNJmfLEW2sWPnlByBknhRU9v7FmgacQlXu0iiQi5abL3W5EmA2fEDre3+4J
         tNVX3Jy2Ol8uieq/kPLS05ZmoF51Vu/97itfw=
Received: by 10.223.76.129 with SMTP id c1mr722901fak.107.1308068245852;
        Tue, 14 Jun 2011 09:17:25 -0700 (PDT)
Received: from [192.168.1.15] (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id n7sm2848057fam.43.2011.06.14.09.17.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 09:17:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTimMkOS_Q9gb_ta2P3NSMGyNJtKgJA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175781>

=46rancis Moreau wrote:
> On Tue, Jun 14, 2011 at 11:00 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
> > Francis Moreau <francis.moro@gmail.com> writes:
> >
> > > I have a given revision (tag, sha1 ...) and I'd like to know if t=
hat
> > > revisions corresponds to what the current HEAD is pointing at.
> > >
> > > Could anybody give me some advices for achieving this ?
> >
> > If you want to know if given revision (or ref) points at the same
> > thing as HEAD, you can use
> >
> > =A0[ "$(git rev-parse HEAD)" =3D "$(git rev-parse $ref^{commit})" ]
> >
> > or something like that. =A0The '^{commit}' is here in case $ref poi=
nts
> > only indirectly to commit, via a tag object.
> >
>=20
> I see thanks.
>=20
> I'm not sure what the ^{commit} is for because in the case of tag
> object, git-rev-parse seems to work fine without the suffix:
>=20
> git rev-parse v2.6.39
> 8b0753a3df28c21b0570fa21362c5f1b3b4f59bf
>=20
> This is in a kernel git repository

But that is the SHA-1 id of a _tag object_, not of commit (revision)
it points to. '^{}' means peel to not tag, '^{commit}' means peel to
commit.

In git repository:

 $ git rev-parse v1.7.5
 4d2f8aeba22578022e2d2a56dac37fcdf78d82d4
 $ git rev-parse v1.7.5^{}
 ec014eac0e9e6f30cbbca616090fa2ecf74797e7
 $ git rev-parse v1.7.5^{commit}
 ec014eac0e9e6f30cbbca616090fa2ecf74797e7
 $ git cat-file -t 4d2f8aeba22578022e2d2a56dac37fcdf78d82d4
 tag
 $ git cat-file -t ec014eac0e9e6f30cbbca616090fa2ecf74797e7
 commit

 $ git cat-file -t HEAD
 commit

--=20
Jakub Narebski
Poland
