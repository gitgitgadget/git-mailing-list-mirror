From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 2/2] Add index-v5
Date: Tue, 07 Aug 2012 23:52:22 +0200
Message-ID: <50218E16.1010304@dewire.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com> <1344263760-31191-1-git-send-email-pclouds@gmail.com> <1344263760-31191-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:52:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyrhY-0005u4-HD
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab2HGVw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Aug 2012 17:52:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:11152 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309Ab2HGVw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:52:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A1C658FC73;
	Tue,  7 Aug 2012 23:52:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAF1qjDvU2qH; Tue,  7 Aug 2012 23:52:24 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h30n1fls32o828.telia.com [213.65.101.30])
	by dewire.com (Postfix) with ESMTP id D21DA8FC5D;
	Tue,  7 Aug 2012 23:52:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120717 Thunderbird/15.0
In-Reply-To: <1344263760-31191-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203051>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy skrev 2012-08-06 16.36:

> +++ b/read-cache-v5.c
> @@ -0,0 +1,1170 @@
> +#include "cache.h"
> +#include "read-cache.h"
> +#include "resolve-undo.h"
> +#include "cache-tree.h"
> +
> +struct cache_header_v5 {
> +	unsigned int hdr_ndir;
> +	unsigned int hdr_nfile;
> +	unsigned int hdr_fblockoffset;
> +	unsigned int hdr_nextension;
> +};
> +
> +struct ondisk_cache_entry_v5 {
> +	unsigned short flags;
> +	unsigned short mode;
> +	struct cache_time mtime;
> +	int stat_crc;
> +	unsigned char sha1[20];
> +};

I mentioned this before in another thread, but for JGit I'd like
to see size as a separate attribute. The rest of stat_crc is not
available to Java so when this index gets its way into JGit,
stat_crc will be zero and will never be checked.

-- robin
