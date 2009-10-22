From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 22 Oct 2009 19:21:49 +0900
Message-ID: <20091022192149.6117@nanako3.lavabit.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
	<20091015185253.6117@nanako3.lavabit.com>
	<20091015143340.GI10505@spearce.org>
	<200910151721.08352.johan@herland.net>
	<20091015154142.GL10505@spearce.org>
	<7vfx9k4d33.fsf@alter.siamese.dyndns.org>
	<20091015204543.GP10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 12:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0unt-0006yV-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 12:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZJVKVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 06:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZJVKVs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 06:21:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60662 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbZJVKVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 06:21:47 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id F2B6111B9CF;
	Thu, 22 Oct 2009 05:21:51 -0500 (CDT)
Received: from 5391.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id Z0P9HL5H6WOR; Thu, 22 Oct 2009 05:21:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vlhRHOo1MN/sgy3ZBfhqJHp0/MppAbBmRICFUWLb/KIuMsYuuxyIcYO4FuQd90TBDTlrJJBxcOGEESFkd89CPsWX60Z+eI5ylQeSRqxJ0Ss9ruD826EdCY7cSb8mx2ZmEtA4/1D+bFqsmOvdJQC35dURL8geCsmv3eFw2erH2h4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091015204543.GP10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131015>

Quoting "Shawn O. Pearce" <spearce@spearce.org>

> Actually, after some further research, the bug is not Johan's but is
> actually Daniel's.  Johan, I apologize for claiming it was your bug.
> ...
> Long story short, transport_close() is what is supposed to perform
> the work that disconnect_helper does, as its the final thing right
> before we free the struct transport block.  Free'ing the data block
> inside of the fetch or push functions is wrong.
>
> Its fine to close the helper and restart it within the single
> lifespan of a struct transport, but dammit, don't free the
> struct helper_data until transport_close().

Ping? Are there any progress on this issue?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
