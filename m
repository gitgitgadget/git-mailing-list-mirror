From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libgit2 on the Summer of Code
Date: Thu, 27 May 2010 11:05:54 -0700
Message-ID: <20100527180554.GM16470@spearce.org>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com> <20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu May 27 20:06:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHhT7-0001Fg-4N
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 20:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab0E0SF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 14:05:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab0E0SF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 14:05:56 -0400
Received: by pwi7 with SMTP id 7so166091pwi.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 11:05:56 -0700 (PDT)
Received: by 10.114.237.21 with SMTP id k21mr9393596wah.141.1274983556438;
        Thu, 27 May 2010 11:05:56 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id a23sm12009097wam.2.2010.05.27.11.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 11:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147890>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> * Where algorithm in git_revpool_table__hash() is from? Since it appears to
> hash binary object IDs, wouldn't just simple sum/xor over words be sufficient
> (all SHA-1 output bits are very nearly independent). Or do you need to be
> compatible with some other implementation (doesn't appear so, because hash
> is computed differently depending on endianess)?

If you need a hash value for a SHA-1, why not just cast the unsigned
char* to unsigned int* and load the first int as the hash code?
The output of SHA-1 is pretty evenly distributed, using the first
few bytes as an int should yield a sufficient distribution throughout
the hashtable.
 
-- 
Shawn.
