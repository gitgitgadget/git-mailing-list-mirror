From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH] Honor sysconfdir when set as an configure option
Date: Thu, 28 Apr 2011 23:22:18 +0200
Message-ID: <20110428212218.GG4833@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
 <20110428192751.GE4833@camk.edu.pl>
 <20110428200113.GF4833@camk.edu.pl>
 <7vzkna2ika.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:22:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYfS-0002yi-Qv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 23:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab1D1VW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 17:22:26 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:54250 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab1D1VW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 17:22:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 8550C5F0046;
	Thu, 28 Apr 2011 23:22:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A9BZ-neCcAYZ; Thu, 28 Apr 2011 23:22:18 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 9CD3F5F0047;
	Thu, 28 Apr 2011 23:22:18 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8C68980A1F; Thu, 28 Apr 2011 23:22:18 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
Content-Disposition: inline
In-Reply-To: <7vzkna2ika.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172409>

On Thu, Apr 28, 2011 at 02:05:09PM -0700, Junio C Hamano wrote:
> Kacper Kornet <kornet@camk.edu.pl> writes:

> > ./configure can be run with option --sysconfdir=...
> > and Makefile should respect that choice.

> Thanks.  That statement is not wrong per-se, but your patch will result in
> git_etcdir always set to the same as $(sysconfdir) that is an absolute
> path, which in turn would mean that the build product with prefix set to
> something other than /usr won't relocate well, no?

Only when ./configure is used. But autotools do not support relative
paths, as far as I know. When autotools are not used, it is still
possible to have relative path in git_etcdir.

-- 
  Kacper Kornet
