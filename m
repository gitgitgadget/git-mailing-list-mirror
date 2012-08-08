From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] Add index-v5
Date: Wed, 8 Aug 2012 12:54:03 +0200
Message-ID: <20120808105403.GA884@tgummerer.unibz.it>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <1344263760-31191-3-git-send-email-pclouds@gmail.com>
 <50218E16.1010304@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7IG4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 12:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz3uJ-0008Qw-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 12:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab2HHKyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Aug 2012 06:54:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62906 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab2HHKyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 06:54:07 -0400
Received: by weyx8 with SMTP id x8so368401wey.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JvXD9dC0u31zCj5j3JWcGx+a6taoSsuj0YaRzMi6/Qw=;
        b=B3AwWkTbRK41GAYrfoQ0UivMo+ERtpZDmrHEuIBhUD09IStsLPmBbWnSJKC17OpKwC
         zFbSGRIzOaMRgy+L3tzoUdf+GDVcYxer2ol2GK16KXgZZtE7u1mOq7x7NXNlAscpO18/
         HzOyME5ribitBLhTDzWdWj7LtzOdkIVrxY3DHhmxe8Acaoq9UPJ10tNxLpWUvk4VwRPy
         JzKbwuVCqB3z1w3T1vGnM7bk+HbyibifTr+XFI+raN6W9nHUZpdRoYPJo/IktLsKlw/p
         BAa7U6iGTZpaSrhfFnjQK77C5SjCfqMpjSJvINKX3ZpxQpZJ6g6FxW2bjtQagZkTyRFc
         3ZiA==
Received: by 10.180.78.4 with SMTP id x4mr1629326wiw.19.1344423246368;
        Wed, 08 Aug 2012 03:54:06 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id j6sm6750062wiy.4.2012.08.08.03.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 03:54:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50218E16.1010304@dewire.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203071>



On 08/07, Robin Rosenberg wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy skrev 2012-08-06 16.36:
>=20
> >+++ b/read-cache-v5.c
> >@@ -0,0 +1,1170 @@
> >+#include "cache.h"
> >+#include "read-cache.h"
> >+#include "resolve-undo.h"
> >+#include "cache-tree.h"
> >+
> >+struct cache_header_v5 {
> >+	unsigned int hdr_ndir;
> >+	unsigned int hdr_nfile;
> >+	unsigned int hdr_fblockoffset;
> >+	unsigned int hdr_nextension;
> >+};
> >+
> >+struct ondisk_cache_entry_v5 {
> >+	unsigned short flags;
> >+	unsigned short mode;
> >+	struct cache_time mtime;
> >+	int stat_crc;
> >+	unsigned char sha1[20];
> >+};
>=20
> I mentioned this before in another thread, but for JGit I'd like
> to see size as a separate attribute. The rest of stat_crc is not
> available to Java so when this index gets its way into JGit,
> stat_crc will be zero and will never be checked.
>=20

I'm sorry for forgetting to add this, it will be included in the
re-roll.  The stat_crc will be ignored if it is 0 in the ondisk
index.
