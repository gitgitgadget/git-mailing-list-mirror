From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 05 Jul 2007 11:53:59 -0700
Message-ID: <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
	<81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
	<7vsl82dcj0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051811310.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 20:54:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6WSt-0004ZO-25
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 20:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbXGESyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 14:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759861AbXGESyD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 14:54:03 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37243 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbXGESyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 14:54:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705185401.INVF3098.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 14:54:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Kuu01X0021kojtg0000000; Thu, 05 Jul 2007 14:54:00 -0400
In-Reply-To: <Pine.LNX.4.64.0707051811310.9789@racer.site> (Johannes
	Schindelin's message of "Thu, 5 Jul 2007 18:15:29 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51688>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 5 Jul 2007, Junio C Hamano wrote:
>
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> 
>> > On 7/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >> We have a working implementation of rerere since long ago, and we even
>> >> make sure that it works as expected in a test case.  It is also a very
>> >> useful feature, so why not turn it on for the benefit of users who are
>> >> not even aware of it? This patch does that.
>> >
>> > Maybe just create in template directory?
>> 
>> Sounds saner.
>
> Does it?
>
> I had the impression that the templates are meant for site-specific 
> modifications. My patch tried to make it more standard than that.
>
> For example, you _could_ have set core.logallrefupdates from the 
> templates, yet you chose not to, but rather hard-wire it into "git init". 
> Which I completely agree to.

I think what Alex meant is this.

diff --git a/templates/rr-cache-- b/templates/rr-cache--
new file mode 100644
index 0000000..fae8870
--- /dev/null
+++ b/templates/rr-cache--
@@ -0,0 +1 @@
+: this is just to ensure the directory exists.
