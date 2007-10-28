From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] walk $PATH to generate list of commands for "help -a"
Date: Sun, 28 Oct 2007 03:07:14 -0700
Message-ID: <7vodejv9gt.fsf@gitster.siamese.dyndns.org>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
	<1193474215-6728-2-git-send-email-srp@srparish.net>
	<1193474215-6728-3-git-send-email-srp@srparish.net>
	<1193474215-6728-4-git-send-email-srp@srparish.net>
	<1193474215-6728-5-git-send-email-srp@srparish.net>
	<1193474215-6728-6-git-send-email-srp@srparish.net>
	<7vsl3vzrs5.fsf@gitster.siamese.dyndns.org>
	<20071028094530.GA7749@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 11:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im53O-0005Hp-2g
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbXJ1KHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbXJ1KHW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:07:22 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47694 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbXJ1KHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:07:21 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 361872EF;
	Sun, 28 Oct 2007 06:07:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A90A38EA01;
	Sun, 28 Oct 2007 06:07:39 -0400 (EDT)
In-Reply-To: <20071028094530.GA7749@srparish.net> (Scott Parish's message of
	"Sun, 28 Oct 2007 02:45:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62547>

Scott Parish <sRp@srparish.net> writes:

> On Sat, Oct 27, 2007 at 11:18:02PM -0700, Junio C Hamano wrote:
>
>> > We walk all the paths in $PATH collecting the names of "git-*"
>> > commands. To help distinguish between the main git commands
>> > and commands picked up elsewhere (probably extensions) we
>> > print them seperately. The main commands are the ones that
>> > are found in the first directory in $PATH that contains the
>> > "git" binary.
>> ...
> Its not clear to me what exactly you're looking for me to change,
> just the wording i'm using in my comment? Or are you refering to
> the approach?

"git" binary will be found as /usr/bin/git while git-foo will be
found as /usr/libexec/git/git-foo in such an installation that
takes advantage of $(gitexecdir).  And /usr/libexec/git/git will
not exist.  Using existence of /usr/bin/git (I am referring to
your 'first directory on $PATH that contains the "git" binary'
above) as the cue for the location of "main commands" is wrong.

> When i email the changes, should i keep emailing the whole
> patch series, or just the few patches that have changed?

It's up to you.  Obviously, if you are replacing 2 patches out
of 100-patch series, you would not want to resend the whole
thing, though ;-)
