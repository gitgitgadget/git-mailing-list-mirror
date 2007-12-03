From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit was created
Date: Sun, 02 Dec 2007 23:33:28 -0800
Message-ID: <7vzlwsmdvb.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
	<Pine.LNX.4.64.0711111736440.4362@racer.site>
	<20071201222106.GA27102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5oS-0004yf-TC
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbXLCHdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXLCHdi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:33:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60370 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbXLCHdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:33:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0C0C82EF;
	Mon,  3 Dec 2007 02:33:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BAECB9A844;
	Mon,  3 Dec 2007 02:33:51 -0500 (EST)
In-Reply-To: <20071201222106.GA27102@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Dec 2007 17:21:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66881>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 11, 2007 at 05:36:52PM +0000, Johannes Schindelin wrote:
>
>> The function log_tree_commit() does not break the line, so we have to
>> do it ourselves.
>
> Johannes,
>
> Can you explain the rationale for this change in more detail?
>
> When I run builtin-commit from the tip of next, I always get an extra
> newline (as compared to the shell behavior):

After reverting this, recording a merge commit seems to have lost the
newline.  Can be easily reproduced with:

	$ git merge --no-commit some-branch
        $ git commit -a -m 'foo'
