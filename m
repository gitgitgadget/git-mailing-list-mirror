From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 16:18:11 -0800
Message-ID: <7vwsq458vw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org>
	<7vfxwu9s2z.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
	<alpine.LSU.1.00.0801200142170.5731@racer.site>
	<07FDB6ED-EBE0-4F66-9167-6A0F8AD58E2B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGkNQ-0001z5-S7
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 01:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbYAUASb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 19:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbYAUASa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 19:18:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbYAUAS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 19:18:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B49B622B6;
	Sun, 20 Jan 2008 19:18:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3090422B5;
	Sun, 20 Jan 2008 19:18:23 -0500 (EST)
In-Reply-To: <07FDB6ED-EBE0-4F66-9167-6A0F8AD58E2B@zib.de> (Steffen Prohaska's
	message of "Sun, 20 Jan 2008 11:33:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71205>

Steffen Prohaska <prohaska@zib.de> writes:

> On Jan 20, 2008, at 2:48 AM, Johannes Schindelin wrote:
>
>>> I bet you'll see a much bigger performance improvement from this on
>>> Windows in particular.
>>
>> I bet so, too.  Traditionally, filesystem calls are painfully slow on
>> Windows.
>>
>> But I cannot test before Monday, so I would not be mad if somebody
>> else
>> could perform some tests on Windows.
>
> Has someone collected the whole series on a topic branch?

Yes, I have.

Haven't pushed it out, though.
