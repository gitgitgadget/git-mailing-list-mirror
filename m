From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow selection of different cleanup modes for commit messages
Date: Sat, 22 Dec 2007 19:01:17 -0800
Message-ID: <7v1w9ew1vm.fsf@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Sun Dec 23 04:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6H6M-0008D3-Pt
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 04:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbXLWDBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 22:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbXLWDBk
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 22:01:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbXLWDBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 22:01:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 308E07C8E;
	Sat, 22 Dec 2007 22:01:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A89C97C8D;
	Sat, 22 Dec 2007 22:01:26 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712221107240.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 22 Dec 2007 11:18:34 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69163>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I wonder if we should perhaps:
>
>  (a) Only add these messages at all when we do *not* do CLEANUP_ALL
>
> I personally would prefer (a) - since anybody who then explicitly uses
> --cleanup={space|none} would presumably already know what he is doing.

I thought about this a bit more, but then realized that people
would still want to see the status output in their editors.
This applies even to "verbatim" case.

Which means that they need to remove the '#' lines when they do
not use CLEANUP_ALL.

So I am inclined to suggest we need to take (b).
