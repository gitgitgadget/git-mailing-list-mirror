From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git clone -b
Date: Fri, 28 Jun 2013 14:18:47 +0200
Message-ID: <20130628121847.GB1351@paksenarrion.iveqy.com>
References: <51CD7AB7.3040409@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, iveqy@iveqy.com
To: Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 14:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsXdz-0002FF-8v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 14:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab3F1MTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 08:19:11 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:47915 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab3F1MTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 08:19:10 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so2031921lab.41
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W/bEYbxRnNy4/Ya0SQEeFxX78wAGGlKoON6h32Sj9C0=;
        b=lwqIrpp92uc+2d4LGy0ViC+nIGr0NemayCB0D919w0p4pdrWrrVtK2CmGiKLQCOmBU
         SJ1Jma8cRPeuAKtLePlOaEAA8KOh8LjfgXhqJQrT9qvTw9EQn4/UXEBn5dwpRg6TrdbI
         b868+n5+acTPUryp+0AevnWzd4jeOvGZr57HlzxW6TIpzVarzXFAapaI2WpDKblVuNBv
         Pgrh/ijMPe/oaY24qgbouhUn0zDB/QtUUk1RddaFNPxYYRFPJPNvfvLTtY/XKC4qynb3
         fJOrBu0o856sNJPnnIMAjeZMvIjhP+45/eAZVS3K7z4LIlst0oaHxy00C4D5TPFrlO1h
         cGMA==
X-Received: by 10.112.4.164 with SMTP id l4mr6305094lbl.94.1372421949251;
        Fri, 28 Jun 2013 05:19:09 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id 6sm2573928lbu.13.2013.06.28.05.19.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 05:19:08 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsXdX-0006Pl-81; Fri, 28 Jun 2013 14:18:47 +0200
Content-Disposition: inline
In-Reply-To: <51CD7AB7.3040409@atlas-elektronik.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229192>

On Fri, Jun 28, 2013 at 01:59:51PM +0200, Stefan N=E4we wrote:
> Hi there!
>=20
> Is there any reason why 'git clone -b' only takes a branch (from refs=
/heads/)
> or a tag (from refs/tags/) ?
>=20
> Background: At $dayjob we're using some kind of 'hidden' refs (in ref=
s/releases/)
> to communicate between the 'branch integrator' (who creates the ref i=
n refs/releases/)
> and the 'build master' who wants to build that ref.=20
>=20
> It would be a little easier if the build master could simply say
>=20
>   git clone -b refs/releases/the-release-for-today URL
>=20
> instead of: git clone... ; cd ... ; git fetch... ; git checkout....
>=20
> Any answer or even a better idea to solve that is appreciated.
>=20
> Stefan

I don't understand what the alternative should be. You can't look in
/refs/* because there's a lot of other stuff like bisect/remotes etc.
there.

Of course you could add to also look in /refs/releases/ but as I
understand you that a special solution for your company. Why should all
git users have that addition?

Two questions about your setup:

	1. Why do you always clone your repository? To me clone is a one
	time operation.

	2. Why don't you tag your releases with an ordinary tag?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
