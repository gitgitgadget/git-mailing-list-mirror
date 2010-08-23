From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 23 Aug 2010 23:44:38 +0200
Message-ID: <yf97hjhrol5.fsf@chiyo.mc.pp.se>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
	<20100823213531.GD2120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 23:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oneoz-0007Ni-0x
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 23:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab0HWVoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 17:44:44 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:35508 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0HWVon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 17:44:43 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 637F5F845;
	Mon, 23 Aug 2010 23:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1282599881; bh=MRXZojJaxe0Q8Re+wbGyjCrnk/h+N0P9WBr+IRpExRY=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ydEpxhlIUjOjTYbNedCy/gYve7kGV6+wuBdf8
	3RPeAJvdGKEDd5XGiLJmHkwk1596mLKk3q8BkjpzdWodf+oO858n783KSBbWNhkOVZO
	cq5EJV64DTq5XqJRg+NhVEbJhVvaF38GlYyDR0PTrqHAlz8x+3peUs6HvI4/+nwF/Hs
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Oneop-0002z6-AU; Mon, 23 Aug 2010 23:44:39 +0200
In-Reply-To: <20100823213531.GD2120@burratino> (Jonathan Nieder's message of "Mon, 23 Aug 2010 16:35:31 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154262>


Hi Jonathan.

Thanks for the quick feedback.


Jonathan Nieder <jrnieder@gmail.com> writes:

> I was with you up to here.  Is commit time really the right moment
> to clobber a foreign ident?  I suspect it would be confusing.

Well, it's how ident is normally expected to behave; when you
commit something new, the file should get a new ident.


> It might be simpler to just never clobber a foreign ident and instead
> rely on local policy (scripts, pre-commit hooks, and so on) to remove
> them at the appropriate time.

Simpler as far as patch size is concerned (although this patch isn't
really that complex as it is), but it sounds like much more of a
hassle to actually use.  Do you have a use case in mind where you have
the ident attribute on a file but do _not_ want a new ident each time
you commit a change to the file?


  // Marcus
