From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Wed, 09 Jan 2008 23:22:54 -0800
Message-ID: <7vzlve6t69.fsf@gitster.siamese.dyndns.org>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	<7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
	<7bfdc29a0801092251p3d46a3cau3db4d57c4f705043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 08:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCrlE-0001sH-DS
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 08:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYAJHXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 02:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYAJHXD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 02:23:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbYAJHXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 02:23:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 961DA333F;
	Thu, 10 Jan 2008 02:22:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 09021333E;
	Thu, 10 Jan 2008 02:22:56 -0500 (EST)
In-Reply-To: <7bfdc29a0801092251p3d46a3cau3db4d57c4f705043@mail.gmail.com>
	(Imran M. Yousuf's message of "Thu, 10 Jan 2008 12:51:42 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70047>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> On Jan 10, 2008 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I somehow feel that syntactically the original implementation
>> that allowed subcommand specific options to come before the
>> subcommand name was a mistake.  It may be easier for users that
>> both "-b branch add" and "add -b branch" are accepted, but I
>> have to wonder if it would really hurt if we made "-b branch
>> add" a syntax error.
>
> I will recode it to have all options except for --quiet (which is
> inverse of -v or --verbose) be mentioned after the subcommand.

Just a word of caution when dealing with me.

Unlike Linus, I am not always right.  And other people on the
list who are here longer already know this. I am reasonably sure
that some of them will disagree with me on design issues like
this one; I mildly suspect that this forbidding "-b branch add"
might be met with resistance from existing users.

You do not have to agree with me on every little detail I
mention.  If you feel a design issue might be contentious, it
could turn out to be a better use of your time to keep the code
as it is while waiting to see if other people would offer better
alternatives.

> Actually module_$command is not possible because only add's module is
> module_add rest are modules_$command....

Is there a fundamental reason why you cannot rename them to be
more consistent?
