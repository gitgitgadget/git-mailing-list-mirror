From: Johan Herland <johan@herland.net>
Subject: Re: 'git notes merge' implementation questions
Date: Thu, 22 Apr 2010 10:34:00 +0200
Message-ID: <201004221034.00639.johan@herland.net>
References: <201004210957.48138.johan@herland.net>
 <201004220208.03706.johan@herland.net>
 <7v8w8g8hvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 10:34:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4rrW-0006V5-5Q
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 10:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab0DVIeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 04:34:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39183 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0DVIeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 04:34:05 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19000GWRSPUT60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 10:34:01 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1900AO8RSOCG10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 10:34:01 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.22.81815
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <7v8w8g8hvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145510>

On Thursday 22 April 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Ok, I'm just worried that it'll force us to re-implement much of the
> > three- way merge logic that's already implemented in the merge
> > machinery.
> 
> There is no way around it, as long as you have that variable fan-out in
> the notes structure.  Changing and unstabilizing "merge" for dubious
> benefit of code reuse is unacceptable, as the part that deals with
> variable fan-out has no benefit to the regular "merge".

Understood. At some point I merely contemplated whether a generic 
"tree_filter" callback could be added somewhere in the merge machinery, and 
then whether flattening the fanout could be implemented as such a 
"tree_filter" (with an inverse "tree_filter" for reconstructing the fanout 
in the merge result). But it seems the costs outweigh the benefits, even 
more so as I don't yet see any other use case for such a "tree_filter".

In any case, you have already given me lots of other/better options on how 
to implement 'git notes merge'.


Thanks! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
