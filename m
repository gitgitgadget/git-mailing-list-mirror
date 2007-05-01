From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] git-cvsserver: Add a basic test file for cvsserver
Date: Tue, 01 May 2007 01:50:12 -0700
Message-ID: <7vfy6h7wsb.fsf@assigned-by-dhcp.cox.net>
References: <11778774271937-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue May 01 10:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hio43-0001DO-Dp
	for gcvg-git@gmane.org; Tue, 01 May 2007 10:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbXEAIuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbXEAIuY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 04:50:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57268 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031142AbXEAIuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 04:50:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501085013.QYBU22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 04:50:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tkqC1W0041kojtg0000000; Tue, 01 May 2007 04:50:13 -0400
In-Reply-To: <11778774271937-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sun, 29 Apr 2007 22:10:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45929>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Contains only one test (checkout) at this point and is
> mostly indented to be used as a RFC to discuss
> how to properly implement tests for git-cvsserver.
>
> Currently the test uses netcat to run git-cvsserver
> pserver on a unprivilegded port.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  t/t9400-git-cvsserver-read.sh |   56 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 t/t9400-git-cvsserver-read.sh
>
>  Since this is my first test script for git I would welcome comments
>  and suggestions. Especially if someone has a simpler method of
>  testing it than the somewhat fragile netcat hack I used.

Yes, before reading this three-line paragraph, use of netcat and
hardcoded port number made my eyebrows raise.

But a git-cvsserver test suite that can be run from "make test"
is a really good thing to have for us.

I haven't pursued this but have you considered :fork: connect
method instead of :ext:, so that you do not have to use pserver
nor ssh connection?
