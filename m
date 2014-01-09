From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] "git rebase": fatal: Not a valid object name: ''
Date: Thu, 9 Jan 2014 15:56:21 +0000
Message-ID: <20140109155620.GH7608@serenity.lan>
References: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
 <20140109153618.GA18975@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 09 17:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1I4f-0005rX-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 17:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbaAIQDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 11:03:10 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:39316 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaAIQDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 11:03:07 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2014 11:03:07 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C6A1222BA0;
	Thu,  9 Jan 2014 15:56:26 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKW0yFyNsyQL; Thu,  9 Jan 2014 15:56:26 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 70C4B1FC46;
	Thu,  9 Jan 2014 15:56:22 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20140109153618.GA18975@inner.h.apk.li>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240258>

On Thu, Jan 09, 2014 at 04:36:18PM +0100, Andreas Krey wrote:
> since ad8261d (rebase: use reflog to find common base with upstream)
> a rebase without arguments says "fatal: Not a valid object name: ''",
> caused by trying to determine the fork point with an empty $switch_to.
> 
> I don't really see what the appropriate fix would be. :-(

I think the correct fix is to change the "$switch_to" in the call to
"git merge-base --fork-point" to "${switch_to:-HEAD}", but I'm not at a
machine where I can test that or work up a patch at the moment...
