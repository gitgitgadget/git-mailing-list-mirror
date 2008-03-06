From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Added command synopsis in code and edited them in
 manual
Date: Thu, 06 Mar 2008 02:42:36 -0800
Message-ID: <7vfxv49lr7.fsf@gitster.siamese.dyndns.org>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 06 11:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDZV-0007fc-4y
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106AbYCFKmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757928AbYCFKmq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:42:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643AbYCFKmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:42:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F600181D;
	Thu,  6 Mar 2008 05:42:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 96EC2181C; Thu,  6 Mar 2008 05:42:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76367>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
> Added the command synopsis so that they are available for
> any future command additions.

I think you are talking about the comments you added at the beginning of
the script; I do not particularly see it as improvement.  Rather, it
is just an additional maintenance burden that risks going out of sync with
the documentation.

It may make more sense to make your added lines into one line per
subcommand descriptions in LONG_USAGE, and shorten USAGE to just mention
"git submodule <command> <options>".  The command is multi-featured enough
that it can afford to have a long on-line usage text, and I am reasonably
sure you would agree with me if you read your later patches that cram tons
of options on a single line USAGE.  It simply is unreadable, no matter how
wide your terminal is.

By the way, please use imperative, e.g. "Add gostak so that doshes are
properly distimmed", instead of past tense "Added synopsis".

> In the init/update command synopsis either of them is required
> command as is add in its synopsis, so removed the square brackets
> around them from the documentation

But without grouping, the reader cannot tell where the alternation begins
and ends.  Typically we use () in our documentation set.

That reminds me of the topic of marking "either this or that, you must
have one" with { this | that }, and that is more in line with other
systems' documentation, and is also consistent with what POSIX recommends.
I think the list atmosphere back then was "Yeah, {} may be more kosher,
but we have been consistently using () and that is not misleading, so
unless we convert everything consistently, using {} at only a few places
makes it even worse."  I personally do not mind patches to convert
everybody to {} if we are confident that we can finish it before -rc1.
