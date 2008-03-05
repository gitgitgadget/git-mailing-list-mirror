From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 3/3] Teach git-fetch to exploit server side automatic tag following
Date: Wed, 5 Mar 2008 00:56:59 -0500
Message-ID: <20080305055659.GD8410@spearce.org>
References: <20080304032740.GC16462@spearce.org> <alpine.LSU.1.00.0803041512040.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:57:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWmdW-0005tH-09
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYCEF5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbYCEF5G
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:57:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34642 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbYCEF5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:57:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWmcd-0001xv-VZ; Wed, 05 Mar 2008 00:57:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 222B520FBAE; Wed,  5 Mar 2008 00:56:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803041512040.22527@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76176>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> just two comments from me for this patch series:
> 
> - it's a beaut, and

Thanks.
 
> - should followtags not be the default?

No.  Absolutely not.

The client may not want tag objects from this remote.  It might not
want those tags for all sorts of reasons.  Maybe they are doing a
one-shot pull.  Maybe they don't trust this remote.  Maybe they trust
this remote but this remote is famous for 192M tags containing PDFs
of photo images of build logs printed out on paper, then photographed
on a wood table and finally scanned in at 600 dpi.

So it should only be enabled *if* we were willing to open a second
connection to this remote to followtags from it.  And that's not
a change from prior behavior either, its just faster.

-- 
Shawn.
