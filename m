From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: [Virtual PATCH] Add an option to wrap a patch in <pre> in   git-imap-send
 which ironically results in a cleaner patch from Thunderbird.
Date: Fri, 13 Feb 2009 15:47:12 +0100
Organization: Beonex
Message-ID: <499587F0.1010102@beonex.com>
References: <499446D0.90602@codeweavers.com> <7viqnfezo5.fsf@gitster.siamese.dyndns.org> <49955860.80504@drmicha.warpmail.net> <49957AAE.7070505@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 15:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXzLJ-0006aY-KW
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 15:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576AbZBMOrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 09:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758077AbZBMOrN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 09:47:13 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:37469 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbZBMOrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 09:47:12 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 20F31303C560;
	Fri, 13 Feb 2009 15:47:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <49957AAE.7070505@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109751>

>
> I do not think of a reason, why any sane user would
> want to send a patch as HTML.

The patch is not sent as HTML. It is merely passed to the mailer as HTML.
The "reason" is that HTML allows more information: It allows to separate 
human language text from preformatted text / source code.

Human language text follows other rules in some (I'll call them "more 
capable", to be just as advocating) mailers than others: text flow / 
wrapping, link and quote recognition etc.pp. all make sense for human 
language text / normal emails, but not for source code. Plain text is 
inherently limited in which information it can convey (no links, no 
quotes, no flow etc.pp.).

For more information, see the long email thread that preceeded. I don't 
feel like repeating it.

> This configuration variable sounds more
> like "imap.forceThunderbirdToSendNonFlowedTextByExploitingItsBug" than
> "imap.html", in other words.

I agree that "html" is not a good wording, given the immediate disgust 
that it invokes with many people in the community. (Which is partially 
warranted, and partially irrational.)

I'd propose a less inflammatory wording (and posts):
imap.preformatted
imap.thunderbird
(The first is better, because other mailers might have the same problem, 
now or in the future, and might benefit from the same workaround).

> What worries me the most is if there is any guarantee that this bug you
> are exploiting

FWIW, it's not a bug that he's exploiting.
mailto:foo@example.com?subject=""&html-body="" is a feature (not sure if 
documented).

> _will not be fixed_ in future versions of Thunderbird.

What you see is not a bug in Thunderbird.

> I see your patch deals only with ampersand, less-than, greater-than and
> dquot. Do you know if this is enough

Yes, this is enough to escape literals in HTML code.

> or would letters outside US-ASCII
> need to be expressed in ampersand-hash "character reference" notation?

If so, this this was a bug before and after the patch. What matters for 
non-ascii is the charset, and that's the same problem for plaintext and 
HTML. You'll just have to set the right charset header, and I think he 
does that.
