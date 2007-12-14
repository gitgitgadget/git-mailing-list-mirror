From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Fri, 14 Dec 2007 14:47:03 +0100
Message-ID: <200712141447.05039.robin.rosenberg.lists@dewire.com>
References: <20071211200418.GA13815@mkl-desktop> <20071214044554.GB10169@sigill.intra.peff.net> <20071214091546.GA20907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 14:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ArF-0002PM-NK
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 14:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXLNNpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 08:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXLNNpA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 08:45:00 -0500
Received: from [83.140.172.130] ([83.140.172.130]:22268 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbXLNNo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 08:44:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 662808033AB;
	Fri, 14 Dec 2007 14:35:28 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMnWN7VvJnO0; Fri, 14 Dec 2007 14:35:27 +0100 (CET)
Received: from [10.9.0.9] (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id BDC0E80284D;
	Fri, 14 Dec 2007 14:35:25 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071214091546.GA20907@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68304>

fredag 14 december 2007 skrev Jeff King:
> On Thu, Dec 13, 2007 at 11:45:54PM -0500, Jeff King wrote:
> 
> > So it seems that we could probably go with something more like 64K, and
> > then only truly pathological cases should trigger the behavior.
> 
> So here is a cleaned up patch. It bumps the maximum size to 64kB, adds
> scalar support (nobody uses it, but it makes sense for the interface to
> match that of safe_pipe_capture -- I am even tempted to just replace
> safe_pipe_capture entirely and convert the few other callers), and
> cleans up the unused safe_pipe_capture_blob.

Wouldn't using the POSIX::ARG_MAX constant work?

-- robin
