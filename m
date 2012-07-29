From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 16:13:54 +0200
Message-ID: <20120729141354.GA16223@paksenarrion.iveqy.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 16:13:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvUFn-0002iT-F2
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 16:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab2G2ONt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 10:13:49 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50002 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169Ab2G2ONs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 10:13:48 -0400
Received: by lahd3 with SMTP id d3so2995236lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n/lkCh1zxupQpiQ2DCrZqXX02bbl7s6JPvS47KHNMmY=;
        b=wF2EKg/l3HrQtTXpbCRHWSQNQcS6FQYlVA2zaAjLTPUtbcrJY2t5s42cRGC7OYEwql
         bYVqJV7f4phNkXqjOYbgZqaYVk5SZnbBj7SRuLGssgIJcW53C0hpRTOEZqH9Hnd74TZH
         pJ3YNUwHxXtPqvLKeHkVVPOQtZbd26j2Kyr/YKfHJ0EQJizc/leFH+7O2VGrWriIsq+o
         eKiRqPYzT/Wi7GgVORl+LqfOjyLnoDkbyGDHVD69n4REuufl/x5VKad63+ZN1D+ufb2i
         0SF/x1R4xR1vaXO7p0tjMGQYUKsNMbZezsV2anM0z++kzLFLCmfDHzx6Zgy+q6QJUNdN
         mTEA==
Received: by 10.112.46.37 with SMTP id s5mr3993778lbm.1.1343571227358;
        Sun, 29 Jul 2012 07:13:47 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id gv8sm7845071lab.14.2012.07.29.07.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 07:13:46 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SvUFm-0004Ei-QB; Sun, 29 Jul 2012 16:13:54 +0200
Content-Disposition: inline
In-Reply-To: <CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202477>

On Sun, Jul 29, 2012 at 04:07:13PM +0530, Sitaram Chamarty wrote:
> On Sun, Jul 29, 2012 at 3:11 AM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> > Hi,
> > sometimes git communicates with something that's not git on the oth=
er
> > side (gitolite and github for example).
> >
> > Sometimes the server wants to communicate directly to the git user.
> >
> > git isn't really designed for this. gitolite solves this by do user
> > interaction on STDERR instead. The bad thing about this is that it =
can
> > only be one-direction communication, for example error messages.
> >
> > If git would allow for the user to interact direct with the server,=
 a
> > lot of cool and and userfriendly features could be developed.
> >
> > For example:
> > gitolite has something called wild repos[1]. The management is
> > cumbersome and if you misspell when you clone a repo you might inst=
ead
> > create a new repo.
>=20
> For the record, although it cannot do the yes/no part, if you want to
> disable auto-creation on a fetch/clone (read operation) it's trivial
> to add a "PRE_CREATE" trigger to do that.

Thanks, however I think auto-creation is a great feature for some cases
and I think there can be even more useable functions if we could get
user interaction.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
