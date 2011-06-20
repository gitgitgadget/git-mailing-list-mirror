From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/6] Bring notes.c template handling in line with commit.c.
Date: Mon, 20 Jun 2011 09:41:54 +0200
Message-ID: <201106200941.54883.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <201106192323.09511.johan@herland.net>
 <7vpqm9e8rn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 09:42:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYZ7a-00029Q-Aq
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab1FTHl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:41:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51735 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab1FTHl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:41:57 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200968W1WP650@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 09:41:56 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DBF94179914A_DFEF9C3B	for <git@vger.kernel.org>; Mon,
 20 Jun 2011 07:41:55 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C0EF41796835_DFEF9C3F	for <git@vger.kernel.org>; Mon,
 20 Jun 2011 07:41:55 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200IU5W1VSB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 09:41:55 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vpqm9e8rn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176056>

On Monday 20 June 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Saturday 18 June 2011, Yann Dirson wrote:
> >> Signed-off-by: Yann Dirson <ydirson@free.fr>
> > 
> > Please mention in the commit message that the commit merely replaces
> > write_or_die()/int fd with the corresponding stdio functionality, and
> > that there is no (intended) change in behavior. It was not apparent
> > from your commit message that you had not made any other changes.
> > 
> > Otherwise the patch looks OK.
> 
> I had an impression that you would lose a lot of error checking, unless
> you are careful, if you go from write_or_die() to stdio.

Yeah, write_or_die() dies on failure, while with fwrite/fprintf I guess one 
needs to check the return value, and handle errors accordingly.

An alternative solution would be to drop this patch, and instead use 
strbuf_addf() to get the format printing functionality needed in PATCH 3/6.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
