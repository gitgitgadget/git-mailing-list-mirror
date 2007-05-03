From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-email vs address syntax
Date: Wed, 02 May 2007 23:25:33 -0700
Message-ID: <7v8xc62zky.fsf@assigned-by-dhcp.cox.net>
References: <CFF307C98FEABE47A452B27C06B85BB6030BDEAF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Brown, Len" <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Thu May 03 08:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjUl0-0001ip-KK
	for gcvg-git@gmane.org; Thu, 03 May 2007 08:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbXECGZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 02:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030799AbXECGZf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 02:25:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53564 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030715AbXECGZe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 02:25:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503062534.RUNE1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 02:25:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uWRZ1W00Y1kojtg0000000; Thu, 03 May 2007 02:25:34 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6030BDEAF@hdsmsx411.amr.corp.intel.com>
	(Len Brown's message of "Thu, 3 May 2007 02:13:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46070>

"Brown, Len" <len.brown@intel.com> writes:

> I don't know if the fix should be in the git-am script
> which set the From: field, or in the git-format-patch
> script which takes that field and makes it into
> an e-mail message.

The fix should be in send-email script, as COMMITTER_NAME and
AUTHOR_NAME are just simple strings without RFC2822 limitation
(such as necessity of quoting a ".").

As a matter of fact, recent enough send-email is supposed to
have a fix for this exact problem.  If your copy of send-email
does not have

	sub sanitize_address_rfc822 {

you might want to upgrade.  Both 1.5.2-rc1 and 1.5.1.3 have
this.
