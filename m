From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] rev-parse: fix --resolve-git-dir argument handling
Date: Wed, 19 Feb 2014 09:09:48 +0000
Message-ID: <20140219090948.GD1048@serenity.lan>
References: <5301C4B4.5070503@thequod.de>
 <65ea2c8ce4f0d60f0d93f730aac50183ba63bd1c.1392626780.git.john@keeping.me.uk>
 <xmqq61ocdug5.fsf@gitster.dls.corp.google.com>
 <xmqqzjlo9ce6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Hahler <genml+git-2014@thequod.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 10:10:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG3AY-0008FW-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 10:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaBSJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 04:10:11 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:50126 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbaBSJJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 04:09:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 13AA1CDA5EC;
	Wed, 19 Feb 2014 09:09:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdduVcXDlqLA; Wed, 19 Feb 2014 09:09:55 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3F492866038;
	Wed, 19 Feb 2014 09:09:50 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqzjlo9ce6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242386>

On Tue, Feb 18, 2014 at 04:25:37PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > John Keeping <john@keeping.me.uk> writes:
> >
> >> There are two problems here:
> >>
> >> 1) If no argument is provided, then the command segfaults
> >> 2) The argument is not consumed, so there will be excess output
> >>
> >> Fix both of these in one go by restructuring the handler for this
> >> option.
> >>
> >> Reported-by: Daniel Hahler <genml+git-2014@thequod.de>
> >> Signed-off-by: John Keeping <john@keeping.me.uk>
> >> ---
> >
> > Looks sensible; thanks.
> 
> Ehh, I spoke too fast. Don't we already have this queued as a43219f2
> (rev-parse: check i before using argv[i] against argc, 2014-01-28)?

Yes, and it catches more cases than mine.  I only checked against master
and had missed that when it went past on the list.
