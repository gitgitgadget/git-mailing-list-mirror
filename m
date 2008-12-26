From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitrepository-layout: No longer first two letters. Also
 add "down".
Date: Fri, 26 Dec 2008 12:07:48 -0800
Message-ID: <7veizuog2z.fsf@gitster.siamese.dyndns.org>
References: <E1LGFoE-0001EZ-0F@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 26 21:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGJ0l-0007sT-69
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 21:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYLZUH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 15:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYLZUHz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 15:07:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbYLZUHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 15:07:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D121B89DDA;
	Fri, 26 Dec 2008 15:07:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED95389DD8; Fri,
 26 Dec 2008 15:07:49 -0500 (EST)
In-Reply-To: <E1LGFoE-0001EZ-0F@jidanni.org> (jidanni@jidanni.org's message
 of "Sat, 27 Dec 2008 00:43:07 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E09DD958-D388-11DD-8E20-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103948>

jidanni@jidanni.org writes:

> Signed-off-by: jidanni <jidanni@jidanni.org>

First off, when I tried to respond to your message, I got this:

    Cc: undisclosed-recipients:;

which I had to edit it to point at the list.

I think you did "Bcc: git@vger.kernel.org" without any explicit recipient;
please don't.  It wastes everybody's time.

Second, please realize that the Subject: line is one of the most important
piece of information in your patch submission.  It is used as the summary
of what this change is about in the shortlog output.  2 months from now,
do you think anybody (other than you) can guess what the "first two
letters" is about among 400 other changes?

I would have preferred the Subject: and the commit log message like this
for this patch:

    Subject: [PATCH] Fix description of objects/??/ directories in the repository-layout doc

    These fan-out directories are no longer first two letters.  Also fix
    a sentence that meant to say "keep something down" but forgot "down".

That is, summarize what this patch is about on Subject: line, and explain
why the change is a good idea (in other words, why the current one is bad)
in the commit log message.

I agree with the "down" fix; thanks for catching this grammatical and
semantic error.

I however do not understand the reason behind the former "two letters"
change.

When creating a new object, the filename to hold it when its object name
is e.g. 92b35d66d0e335771c2e4a4a79f95adb844b1f91 (that's a tag object for
v1.6.1 if anybody cares) is computed by taking its first two letters "92"
and using that to choose ".git/object/92" as the containing "fan-out"
directory.  The file in that directory is named using the remainder of the
object name.

The entry in the repository layout document explains what the directories
with two-letter names you find in objects/ directory are, and I do not see
a reason why you want to say "no longer first two letters".  Their names
still are, and very likely continue to be, two-letter long.

Maybe I misunderstood what you wanted to say by "no longer...".  Did you
mean (unlike the sample commit log message I suggested above):

    Subject: [PATCH] Fix description of objects/??/ directories in the repository-layout doc

    Do not say first two letters anymore.  Also fix a sentence that meant
    to say "keep something down" but forgot "down".

If that is the case, please justify why you think it is better not to say
"first two letters" the documentation.

Thanks.
