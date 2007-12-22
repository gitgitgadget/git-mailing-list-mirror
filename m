From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow selection of different cleanup modes for commit messages
Date: Sat, 22 Dec 2007 11:41:03 -0800
Message-ID: <7vprwywm9c.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	<7vlk7plydv.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
	<20071221173521.GA3494@steel.home>
	<7v8x3n4tbe.fsf@gitster.siamese.dyndns.org>
	<20071221230851.GA3260@steel.home>
	<7v3atv17o9.fsf@gitster.siamese.dyndns.org>
	<20071222184624.GA4167@steel.home>
	<alpine.LFD.0.9999.0712221107240.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 20:41:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6AEA-0005tN-7i
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 20:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXLVTlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 14:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXLVTlM
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 14:41:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbXLVTlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 14:41:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6696865D7;
	Sat, 22 Dec 2007 14:41:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B67C165D6;
	Sat, 22 Dec 2007 14:41:05 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712221107240.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 22 Dec 2007 11:18:34 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69156>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 22 Dec 2007, Alex Riesen wrote:
>>
>> +	if (!no_edit) {
>
> This is unrelated to the rest of the patch, but I do think double 
> negations are horrible, so I thoink we should probably make the "no_edit" 
> flag change meaning, and call it "run_editor" or something.
> ...
> So I wonder if we should perhaps:
>
>  (a) Only add these messages at all when we do *not* do CLEANUP_ALL
> ...
>  (b) Add a a new line to replace he "will not be included" message, ie
> ...
> I personally would prefer (a) - since anybody who then explicitly uses
> --cleanup={space|none} would presumably already know what he is doing.
>
> But this is not a huge deal. Regardless, the patch looks ok, so you can 
> add a "Acked-by:" from me.

I was composing essentially the same message, except my
preference was (as you can guess by the fact that I hinted the
additional instruction) (b), but I agree that (a) is better at
least for now because the user has to ask for verbatim every
time (i.e. there is no config).

By the way, the "if (!no_edit)" conditional itself you quoted
above as the first thing in your message is not needed at all.
If no_edit is set, the function already has returned and we
would not reach that point.

So a third round?
