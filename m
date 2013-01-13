From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] t/lib-cvs: cvsimport no longer works without Python >=
 2.7
Date: Sun, 13 Jan 2013 17:17:20 +0000
Message-ID: <20130113171720.GM4574@serenity.lan>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7v62339du4.fsf@alter.siamese.dyndns.org>
 <7vip72iykx.fsf_-_@alter.siamese.dyndns.org>
 <50F180E8.8010907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRBv-0006Mx-1p
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab3AMRRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 12:17:30 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53997 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab3AMRR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 12:17:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C23AB60653C;
	Sun, 13 Jan 2013 17:17:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sX92EgqTqXty; Sun, 13 Jan 2013 17:17:28 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 675B060652F;
	Sun, 13 Jan 2013 17:17:28 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 50047161E4FB;
	Sun, 13 Jan 2013 17:17:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY-o9wZTgAoe; Sun, 13 Jan 2013 17:17:28 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 641CA161E266;
	Sun, 13 Jan 2013 17:17:21 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50F180E8.8010907@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213389>

On Sat, Jan 12, 2013 at 04:27:36PM +0100, Michael Haggerty wrote:
>>  Even if we were to rip out the fallback code that uses the 2.7-only
>>  subprocess.check_output() on "cvsps -V", the function is also used
>>  for doing the real work interacting with cvsps-3.x, so I think this
>>  patch will be necessary.  Unless new cvsimport is tweaked not to
>>  use the method, that is.
>> 
>>  A suggestion for a better alternative is of course very much
>>  appreciated.
> 
> If the only reason to require Python 2.7 is subprocess.check_output(),
> it would be easy to reimplement it (it is only 12 lines of
> straightforward code, plus a few lines to define the exception type
> CalledProcessError).  According to [1], the Python license is
> GPL-compatible; therefore these lines could even be copied into
> git-cvsimport.

Note that this has already be done in git_remote_helpers.util.  Is there
any reason not to just reference that?


John
