From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 23:17:09 +0100
Message-ID: <51CCB9E5.3010907@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 01:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsLVZ-0003IB-0y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 01:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab3F0XVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 19:21:40 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:51606 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753707Ab3F0XVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 19:21:40 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id CCFA2A0C080;
	Fri, 28 Jun 2013 00:21:37 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 16777A0C07F;
	Fri, 28 Jun 2013 00:21:37 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Fri, 28 Jun 2013 00:21:34 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130626223552.GA12785@sigill.intra.peff.net>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229165>

Jeff King wrote:
> On Wed, Jun 26, 2013 at 10:45:48PM +0100, Ramsay Jones wrote:
[ ... ]
> I think Michael's assessment above is missing one thing. It is true that
> a false positive is just a performance problem in most cases, as we
> unnecessarily reload the file, thinking it has changed.
> 
> However, when we have taken a lock on the file, there is an additional
> safety measure: if we find the file is changed, we abort, as that should
> never happen (it means somebody else modified the file while we had it
> locked). But of course Cygwin's false positive here triggers the safety
> valve, and we die without even realizing that nothing changed.

Indeed, this is exactly the situation.

ATB,
Ramsay Jones
