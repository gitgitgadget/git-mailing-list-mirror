From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 13:55:39 -0800
Message-ID: <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
	<alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
	<Pine.LNX.4.64.0710260007450.4362@racer.site>
	<7v3avy21il.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710261047450.4362@racer.site>
	<7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711281307420.27959@racer.site>
	<27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
	<Pine.LNX.4.64.0711282039430.27959@racer.site>
	<8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:56:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUt7-0002De-8k
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbXK1Vzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXK1Vzt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:55:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53455 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbXK1Vzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:55:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0C7F02FB;
	Wed, 28 Nov 2007 16:56:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 623FF9ABBA;
	Wed, 28 Nov 2007 16:56:03 -0500 (EST)
In-Reply-To: <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
	(Lars Hjemli's message of "Wed, 28 Nov 2007 22:10:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66432>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 11/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 28 Nov 2007, Steven Grimm wrote:
>> > I wonder if this shouldn't be branch.<name>.pulltype or something like
>> > that, so we can represent more than just "rebase or not." Values could
>> > be "rebase", "merge" (the default) and maybe even "manual" to specify
>> > that git-pull should neither merge nor rebase a particular branch even
>> > if it matches a wildcard refspec.
>>
>> I am not convinced that this is a good thing... We already have
>> branch.<name>.mergeOptions for proper merges, and I want to make clear
>> that this is about rebase, and not about merge.
>
> Maybe branch.<name>.pullOptions ?

Maybe not make this part of git-pull at all?  merge and rebase have
totally different impact on the resulting history, so perhaps a separate
command that is a shorthand for "git fetch && git rebase" may help
unconfuse the users.
