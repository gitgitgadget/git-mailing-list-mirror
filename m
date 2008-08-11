From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Allow missing objects during packing
Date: Mon, 11 Aug 2008 15:44:04 -0700
Message-ID: <20080811224404.GQ26363@spearce.org>
References: <20080811182839.GJ26363@spearce.org> <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSg8U-0007VV-MZ
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYHKWoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbYHKWoH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:44:07 -0400
Received: from george.spearce.org ([209.20.77.23]:52504 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYHKWoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:44:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CC5D638375; Mon, 11 Aug 2008 22:44:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92016>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > ... It seems pretty harmless to allow an object we
> > aren't going to transmit but that we want to use as a delta base
> > in a thin pack to be missing.  At worst we just get a little bit
> > more data transfer.
> 
> If the check is only about a thin delta base that is not going to be
> transmit, I'd agree.  But I do not see how you are distinguishing that
> case and the case where an object you are actually sending is missing (in
> which case we would want to error out, wouldn't we?)

Arrgh.  Good catch.  My patch is flawed in that it does not correctly
fail if we really needed the missing object in this output pack.

I don't think that would be hard to fix.  I'll respin something
shortly.

-- 
Shawn.
