From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 18:26:45 +0200
Message-ID: <10DD3DE0-E554-4BE3-A20B-FDBC73219646@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net> <5009892E.9010808@kdbg.org> <20120720170913.GA14057@sigill.intra.peff.net> <CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:26:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuQtr-00019j-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab2GZQ0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:26:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40661 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab2GZQ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:26:49 -0400
Received: by eaak13 with SMTP id k13so276301eaa.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=9RtY4yDj7KyqHTn4QGQDkOrnq8pb7pZWfUNc98Y8bJw=;
        b=JlmuujiqBXPfeMPMymmAq1yij82wC311txdhLV3BznS30RnSw+eGIbqnemOQ8+F++v
         c5lLCqrWAg4OIPG+dz2NaHvTpUq89sjx4BC0vBINEZ2LukC9bBlxTroSHmUgnQgRId+i
         jtl6ZFCdfgX24oVxY0WqNS5C+x+2NVTpJgy2jU/APjruSg1Saf57AFKurEsGhcyW88Rl
         lg/uApJyPI/tAAO+kLtnrdYJ+DHvRfiiHqUuC6Gy8/pw1vu9iGGmEcQKSuaIaqlhhFv0
         2aPTrIh06/lcTQ2PHC52Jk9Ddsfw7j65g57C5Vd6SfMgR7WVudABp1VGWkNEvA7wyV34
         w3Dg==
Received: by 10.14.198.200 with SMTP id v48mr4813485een.3.1343320008011;
        Thu, 26 Jul 2012 09:26:48 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id t6sm9998518eeo.17.2012.07.26.09.26.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 09:26:47 -0700 (PDT)
In-Reply-To: <CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202273>

On 26 Jul 2012, at 14:47, Nguyen Thai Ngoc Duy wrote:

> So we haven't found any way to present both branches "foo" and
> "foo/bar" on file system at the same time. How about when we a new
> branch introduces such a conflict, we push the new branch directly to
> packed-refs? If we need either of them on a separate file, for fast
> update for example, then we unpack just one and repack all refs that
> conflict with it. Attempting to update two conflict branches in
> parallel may impact performance, but I don't think that happens often.
> -- 
> Duy

How about simply deprecating "/" in branch name?

-Alexey.
