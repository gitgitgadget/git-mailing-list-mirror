From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] config: add support for --bool and --int while setting values
Date: Mon, 25 Jun 2007 18:14:01 +0200
Message-ID: <20070625161401.GW19725@planck.djpig.de>
References: <1182780024442-git-send-email-frank@lichtenheld.de> <467FCBEA.906B14@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2rCl-0001wG-RY
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 18:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXFYQOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXFYQOK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 12:14:10 -0400
Received: from planck.djpig.de ([85.10.192.180]:2265 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbXFYQOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 12:14:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id CD5DC88102;
	Mon, 25 Jun 2007 18:14:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAOoA9mdALDX; Mon, 25 Jun 2007 18:14:02 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 30DE588105; Mon, 25 Jun 2007 18:14:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <467FCBEA.906B14@eudaptics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50905>

On Mon, Jun 25, 2007 at 04:06:34PM +0200, Johannes Sixt wrote:
> Frank Lichtenheld wrote:
> > 
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> 
> Please excuse if I'm missing the big picture, but why do we need this
> change?

- Of course the user or script calling git-config can do the
  normalization and error checking, if they want to. But I would
  prefer to have it available in git-config.
- I would prefer that these options wouldn't be silently ignored,
  because that can be confusing (at least it is documented now, but
  still). So we should either using them or error out. I prefer the former.

Something that I forgot to mention in the previous mail:
One real problem with the patch is that it expands the k,m,g suffixes
for integer values. It probably shouldn't do that.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
