From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 05 Nov 2007 11:13:33 -0800
Message-ID: <7vir4gqzdu.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
	<20071105085513.GB25574@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7OV-0001HG-VI
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXKETNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXKETNk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:13:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59261 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXKETNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:13:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CF4182EF;
	Mon,  5 Nov 2007 14:14:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 525DC927C7;
	Mon,  5 Nov 2007 14:13:57 -0500 (EST)
In-Reply-To: <20071105085513.GB25574@artemis.corp> (Pierre Habouzit's message
	of "Mon, 05 Nov 2007 09:55:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63538>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
>> I mostly did this and the next one for practice with the API. I'm 
>> impressed that "git fetch -vv" is even handled correctly without anything 
>> special.
>
>   About that: OPTION_BOOLEAN increments the associated variable, to
> support this case specifically.
>
>   The last thing that really miss in parse-options is a way to recurse
> into a sub-array of struct option, to be able to port the generic diff
> and revision arguments.

Another micronit is I found lacking is that it is a bit too
cumbersome to accept only a subset of integer as a value
(e.g. "this option takes a positive integer, not zero nor
negative").  The caller can set up a callback to handle that,
though.
