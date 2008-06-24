From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] implement some resilience against pack corruptions
Date: Mon, 23 Jun 2008 21:33:31 -0400
Message-ID: <20080624013331.GR11793@spearce.org>
References: <alpine.LFD.1.10.0806232122180.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxQZ-0006d2-QP
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYFXBdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbYFXBdj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:33:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41344 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYFXBdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:33:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxPP-0006wB-H7; Mon, 23 Jun 2008 21:33:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7782A20FBAE; Mon, 23 Jun 2008 21:33:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806232122180.2979@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85962>

Nicolas Pitre <nico@cam.org> wrote:
> We should be able to fall back to loose objects or alternative packs when
> a pack becomes corrupted.  This is especially true when an object exists
> in one pack only as a delta but its base object is corrupted.  Currently
> there is no way to retrieve the former object even if the later is
> available in another pack or loose.

Dang, nice timing Nico.  We were bitten by something like this at
day-job a couple of weeks back.  Adding this sort of support went
onto my internal todo-list.  I'm glad you beat me to it.  :)
 
> Yes I've been bitten by the corruption described above...

But sorry to hear about this.

As usual for your patches, the implementation looks quite sane.
Thanks for taking care of it.
 
-- 
Shawn.
