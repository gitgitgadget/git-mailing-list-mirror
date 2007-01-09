From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Tue, 09 Jan 2007 12:22:08 -0800
Message-ID: <7vmz4sj6hb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701081316110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<enumq8$oa$1@sea.gmane.org>
	<Pine.LNX.4.63.0701091056520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 09 21:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NUA-0001Nt-ME
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXAIUWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIUWL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:22:11 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59069 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbXAIUWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:22:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109202209.WSAT15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 15:22:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 98MJ1W00x1kojtg0000000; Tue, 09 Jan 2007 15:21:19 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36393>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 9 Jan 2007, Jakub Narebski wrote:
>
>> Johannes Schindelin wrote:
>> ... 
>> > My reasoning is that invalid entries should rather be ignored than be 
>> > taken into account. So, to verify that you are not walking invalid data, 
>> > you have to parse it anyway.
>> 
>> I think that Junio was talking about the fact, that if you for example
>> do need only refname and sha1, there is no need to parse object at all.
>> If you don't need to, don't parse.
>
> And it was exactly what _I_ was talking about, too:
>
> if there are invalid entries, you ignore them. So for example, if there is 
> no timestamp and message, you don't want the osha1 or nsha1, because it is 
> an _invalid_ record.

That's fine.  I applied your patch with minimum fixups so that
it does not make the surviving records _invalid_ ones after
"reflog expire" runs ;-).
