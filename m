From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: Failing svn imports from apache.org
Date: Mon, 17 Sep 2012 21:05:43 +1000
Message-ID: <EBBF198F1CCD4DA79F6CD50548FA1DE4@rr-dav.id.au>
References: <974faf03-e8e6-4b98-81df-e2bd4d9ae77a@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDZ9O-00026n-Au
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 13:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab2IQLFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2012 07:05:51 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41840 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab2IQLFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 07:05:50 -0400
Received: by ieak13 with SMTP id k13so305313iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 04:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:x-gm-message-state;
        bh=CUnBCUIy8UCqzSNsLl/rQV9kBJHaiFgEWRF/XTNbLdo=;
        b=URP0UeGsLcR/0KAquyuryaif8TFGD+n8/49I8Jza1XdOVJoYAgoRLKFNDsjxx6lytd
         DEErXWjuRi8RybzNnzFpVwAV0mO6ek20nsvQSS24Y8b483pGAi+m0E0kK81HSRuQ7YmN
         VuWBoX7zOG136dphhCZL4PkXYrllGpNBPIZ7KOG1RBhj8p7llU894+3hUtXucvstN2ew
         Cc+4C1Pi8yvbpqVFpR307DxKrhH6jX4bFANM5U6E7WB5moSrLrSlbuoKizggYfstt06u
         aM17mHRLymMJ4zSEEhy8ZDnUt7Bju91UsLr2j5FwB5atgVIARtVBOHxPlxGcCvBU/yYv
         rtwg==
Received: by 10.50.192.135 with SMTP id hg7mr6207534igc.44.1347879949287;
        Mon, 17 Sep 2012 04:05:49 -0700 (PDT)
Received: from [192.168.0.12] (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id d19sm7201926igp.6.2012.09.17.04.05.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 04:05:48 -0700 (PDT)
In-Reply-To: <974faf03-e8e6-4b98-81df-e2bd4d9ae77a@zcs>
X-Mailer: sparrow 1.6.4 (build 1176)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQlzkF11/EMMsCTV4khz3xn6sKqvpi4UFK6fsFR7kxRXZ8LsoC1bcItFjEOHQHE7uAKIQ31u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205672>

Hi Enrico,
Repositories as old and large as ASF are the reason I created svn-fe. =20
git-svn is known to choke on these repositories.
If you have plenty of bandwidth, it might well be faster to:
* Grab an ASF archive (16GB)
* Use svn-fe to import the entire tree into git.
* Use a simple script to extract the standard layout into a new repo.
* Use git-svn to keep the new repo up-to-date.

-- =20
David Michael Barr


On Saturday, 15 September 2012 at 8:07 PM, Enrico Weigelt wrote:

> =20
> > > Does anyone have an idea, what might be wrong here / how to fix i=
t
> > > ?
> > =20
> > =20
> > =20
> > Here: git svn --version
> > git-svn version 1.7.12.592.g41e7905 (svn 1.6.18)
> > =20
> > What's yours?
> =20
> 1.7.9.5 (ubuntu precise)
> =20
> > I'm getting
> > =20
> > Initialized empty Git repository in /tmp/discovery/.git/
> > Using higher level of URL:
> > http://svn.apache.org/repos/asf/commons/proper/discovery =3D>
> > http://svn.apache.org/repos/asf
> > W: Ignoring error from SVN, path probably does not exist: (160013):
> > Dateisystem hat keinen Eintrag: File not found: revision 100, path
> > '/commons/proper/discovery'
> > W: Do not be alarmed at the above message git-svn is just searching
> > aggressively for old history.
> > This may take a while on large repositories
> > =20
> > and then it checks the revisions. I didn't want to wait for
> > r1301705...
> > =20
> > Does your git svn abort earlier or after checking all revs?
> =20
> It also scanned through thousands of revisions and then failed:
> =20
> W: Do not be alarmed at the above message git-svn is just searching a=
ggressively for old history.
> This may take a while on large repositories
> mkdir .git: No such file or directory at /usr/lib/git-core/git-svn li=
ne 3669
> =20
> =20
> cu
> -- =20
> Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards =20
> =20
> Enrico Weigelt =20
> VNC - Virtual Network Consult GmbH =20
> Head Of Development =20
> =20
> Pariser Platz 4a, D-10117 Berlin
> Tel.: +49 (30) 3464615-20
> Fax: +49 (30) 3464615-59
> =20
> enrico.weigelt@vnc.biz; www.vnc.de (http://www.vnc.de) =20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html
