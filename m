From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 02:58:37 -0800
Message-ID: <7vps7mprj6.fsf@assigned-by-dhcp.cox.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
	<989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
	<20070306104127.GA13096@coredump.intra.peff.net>
	<7vveheprsc.fsf@assigned-by-dhcp.cox.net>
	<20070306105629.GA13285@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXNQ-0007Jm-UZ
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965837AbXCFK6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965840AbXCFK6j
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:58:39 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57427 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965837AbXCFK6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 05:58:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306105837.LSNM3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 05:58:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XNyd1W0061kojtg0000000; Tue, 06 Mar 2007 05:58:38 -0500
In-Reply-To: <20070306105629.GA13285@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 6 Mar 2007 05:56:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41573>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2007 at 02:53:07AM -0800, Junio C Hamano wrote:
>
>> But then you are letting _other_ mod_perl users to affect your
>> behaviour, aren't you?  "sub autoEscape" does this:
>
> Yes (but I don't know how mod_perl works, and I haven't been able to
> find a simple answer by skimming the docs).
>
>> If we worry about mod_perl (provided if $CGI::Q is shared across
>> mod_perl users), I suspect we would need to be a bit more
>> paranoid, perhaps like this, woudln't we?
>> [...]
>> +$cgi->autoEscape(1);
>
> That rebreaks the original problem, though.

Sorry, what I meant to say was on top of Li's patch.
