From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 15:48:33 +0200
Message-ID: <20130614134833.GB1086@paksenarrion.iveqy.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
 <20130614131629.GA1086@paksenarrion.iveqy.com>
 <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUJn-0005Y3-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab3FNNp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:45:27 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:46726 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3FNNp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:45:26 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so540971lab.24
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e7VflbnLo3o6idcJEM9w/xUTwBDB3d+OdYr7gcfa2n4=;
        b=TTwdXFT66y2pywbTjer+ITFW3OUuTcJpJJEs2NS5uzA6WOvBDKngxkXue/eaALcMFK
         LmWDhsE7jKcjJ/aauQ70TW5qNdAlIf7zE9Vs0D7neHYn2kdtNlALn2urbjSn304kc0F1
         PglaLTIBvGoBbrZ1jAQH0T9ymHddW7esTEffiPir1ZxJ2dSzWzKxsok74L0bWO7PxkLZ
         dqr2xPD2xDUek33H5BRFKIr7+cIaVqNWUd/txeev4eqWbHCKfZUs2uaRMjR7n40SgREW
         Z9Jv4wePbxzjmNxc5XF9SY4eCf0iyCBSh7klg7zk450QkuzUt5QzeAyxzQ0F22aMbYeD
         Lx7A==
X-Received: by 10.112.11.84 with SMTP id o20mr1152328lbb.86.1371217524608;
        Fri, 14 Jun 2013 06:45:24 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id e9sm918701lbj.3.2013.06.14.06.45.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:45:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnUMj-0000N2-Nu; Fri, 14 Jun 2013 15:48:33 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227833>

On Fri, Jun 14, 2013 at 07:04:18PM +0530, Ramkumar Ramachandra wrote:
> Fredrik Gustafsson wrote:
> > However I think this patch can improve the workflow for experienced
> > developers. Can we tweak this in some way to get the best out of bo=
th
> > worlds?
>=20
> The main problem is that output-directory can be an absolute path
> (like ~, in the extreme case).  I'm not sure how to trade-off safety
> for speed.  My main itch is that completion doesn't work with my fp:
>=20
>   alias.fp =3D !rm -rf outgoing && git format-patch -M -C -o outgoing
>=20

If I let myself to drift off a bit...

git format-patch always creates a new directory like:
=2Egit/outgoing/[patchname]<FROM commit short sha1>...<TO commit short =
sha1>
and possible runs a custom command afterwards. Like cd to the patch
directory, open the cover-letter in your editor etc.

git send-email without patches specified gives you a list of
patch-series from .git/outgoing to choose from with the latest generate=
d
patchserie already selected.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
