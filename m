From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 3/3] Teach --dirstat to not completely ignore rearranged
 lines within a file
Date: Tue, 12 Apr 2011 11:22:56 +0200
Message-ID: <201104121122.56870.johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <201104112356.09408.johan@herland.net>
 <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:23:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ZoQ-00052M-4N
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab1DLJXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 05:23:00 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40114 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab1DLJW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:22:59 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ006X38Q94J80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:22:57 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 750571EA56CD_DA419F1B	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:22:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5B2EE1EA2B1F_DA419F1F	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:22:57 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ00EDT8Q9EZ20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:22:57 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171384>

On Tuesday 12 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > I still feel that a file with 1000 rearranged lines should somehow
> > count "more" than a file with only 1 rearranged line,...
> 
> I think that is just entirely a different mode of operation.  I do not
> think it is wrong to have an alternative implementation of the dirstat
> damage counter that is based on numstat code.
> 
> It may end up counting the damage slower than the current code, and more
> importantly it will count a different kind of damage than the current
> code does, so we may probably want to make it an optional feature.

I wrote it up just for fun, and here's the patch. I'll leave it up to you
to decide if it's worth it.

First, though, I've got another patch to --dirstat, which - in the case
of renames, attributes the damage to the target filename instead of the
source filename. I found this more intuitive, especially in the case of
copies (-C -C) where damage would be attributed to the directory
containing the (unchanged) source file, instead of the directory
containing the (changed) target file.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
