From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 16 Jul 2008 14:44:03 -0700
Message-ID: <7v8ww1pkrg.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
 <20080716212707.GQ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:45:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEoK-0001VO-Nq
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbYGPVoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYGPVoV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:44:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbYGPVoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:44:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACAF72AD15;
	Wed, 16 Jul 2008 17:44:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B8F4F2AD0F; Wed, 16 Jul 2008 17:44:10 -0400 (EDT)
In-Reply-To: <20080716212707.GQ32184@machine.or.cz> (Petr Baudis's message of
 "Wed, 16 Jul 2008 23:27:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57EB1FEA-5380-11DD-9ACE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88763>

Petr Baudis <pasky@suse.cz> writes:

>> Of course, you can name it as you want.  But I thought that the name 
>> "rebase" applies as well: the patches are rebased from somewhere else on 
>> top of HEAD :-)
>
>   even not considering the sequencer work, wouldn't "sequence" be a well
> descriptive name?

Heh, I did not want to become a painter, especially I already have a
rather busy plumber job, but here is my thought process:

 * "rebase-merge" is used only by rebase that uses merge as the pick
   mechanism;

 * when $dotest is used by rebase, it is to implement the "pick" mechanism
   based on applying patches.  "rebase-apply" is a good parallel to
   "rebase-merge" here;

 * when $dotest is used by am, it is to hold the patches to be applied.

Calling the directory "rebase-apply" would be easy to understand for
somebody who does _not_ know nor care about such low-level details, too.
It is a temporary holding area that is used by the procedure to rebase a
history and the procedure to apply patches.
