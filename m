From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 09/10] pack-objects: Estimate pack size; abort early if
 pack size limit is exceeded
Date: Tue, 24 May 2011 03:17:56 +0200
Message-ID: <201105240317.56144.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-10-git-send-email-johan@herland.net>
 <7vd3j9rlw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 03:18:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOgG6-00059y-2K
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab1EXBSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:18:00 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39924 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1EXBR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:17:58 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO008LWE9XGS30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:17:57 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8F9AA1799C8C_DDB0745B	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:17:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0DE0917965D4_DDB0745F	for <git@vger.kernel.org>; Tue,
 24 May 2011 01:17:57 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00KBIE9WF930@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 03:17:57 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vd3j9rlw7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174308>

On Tuesday 24 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > I'm not really happy with excluding loose objects in the pack size
> > estimate. However, the size contributed by loose objects varies wildly
> > depending on whether a (good) delta is found. Therefore, any estimate
> > done at an early stage is bound to be wildly inaccurate. We could maybe
> > use some sort of absolute minimum size per object instead, but I
> > thought I should publish this version before spending more time futzing
> > with it...
> 
> As the initial approximation, I think this implementation is fine.
> Continuing my comments on 7/10, "pack_to_stdout && pack_size_limit" part
> may need to be replaced with "total_data_limit" or something, though.
> 
> After all it isn't fundamentally wrong to say "I don't want to pack more
> than 2GB in total" even when you are producing packs on your local disk
> without the --stdout option, no?

Agreed. Will fix in the next iteration.


Thanks for reviewing the series! It is very much appreciated.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
