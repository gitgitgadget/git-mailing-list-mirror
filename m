From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 12:04:29 -0800
Message-ID: <7vk5nrd1yq.fsf@gitster.siamese.dyndns.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	<20071205.202047.58135920.davem@davemloft.net>
	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	<20071205.204848.227521641.davem@davemloft.net>
	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	<1196968371.18340.30.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Mxy-00038q-6v
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXLFUEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 15:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbXLFUEm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:04:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35543 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXLFUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 15:04:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 695002EF;
	Thu,  6 Dec 2007 15:05:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A86C29D9D7;
	Thu,  6 Dec 2007 15:04:53 -0500 (EST)
In-Reply-To: <1196968371.18340.30.camel@ld0161-tx32> (Jon Loeliger's message
	of "Thu, 06 Dec 2007 13:12:51 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67331>

Jon Loeliger <jdl@freescale.com> writes:

> On Thu, 2007-12-06 at 00:09, Linus Torvalds wrote:
>
>> Git also does delta-chains, but it does them a lot more "loosely". There 
>> is no fixed entity. Delta's are generated against any random other version 
>> that git deems to be a good delta candidate (with various fairly 
>> successful heursitics), and there are absolutely no hard grouping rules.
>
> I'd like to learn more about that.  Can someone point me to
> either more documentation on it?  In the absence of that,
> perhaps a pointer to the source code that implements it?

See Documentation/technical/pack-heuristics.txt,
but the document predates and does not talk about delta
reusing, which was covered here:

    http://thread.gmane.org/gmane.comp.version-control.git/16223/focus=16267

> I guess one question I posit is, would it be more accurate
> to think of this as a "delta net" in a weighted graph rather
> than a "delta chain"?

Yes.
