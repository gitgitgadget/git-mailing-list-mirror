From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Thu, 15 Jan 2009 12:39:06 -0800
Message-ID: <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
 <20090115194926.GA6899@roro3.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNZ1H-0000y5-Bq
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933303AbZAOUjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763747AbZAOUjS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:39:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbZAOUjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:39:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E5031C9DC;
	Thu, 15 Jan 2009 15:39:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 31C281C9DB; Thu,
 15 Jan 2009 15:39:07 -0500 (EST)
In-Reply-To: <20090115194926.GA6899@roro3.zxlink> (Kirill Smelkov's message
 of "Thu, 15 Jan 2009 22:49:26 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 909BCEF8-E344-11DD-9261-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105876>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Sorry for the inconvenience, and please pull them all from
>
>     git://repo.or.cz/git/kirr.git   for-junio
>
> Kirill Smelkov (4):
>       mailinfo: 'From:' header should be unfold as well
>       mailinfo: more smarter removal of rfc822 comments from 'From'
>       mailinfo: correctly handle multiline 'Subject:' header
>       mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'

Sorry, but I cannot _pull_ this one; not because these four patches are
bad (I haven't looked at them).

They include all the other totally unrelated stuff that happend on the
master branch since the topic ks/maint-mailinfo-folded forked.  I've been
hoping upon completion of this topic we can merge it down to maint to
propagate the fix back to v1.6.1.X series.

With this alias:

$ git config alias.lg log --pretty=oneline --abbrev-commit --boundary --left-right

Here are what I have queued so far (and they are in next):

$ git lg master..ks/maint-mailinfo-folded
>ddfb369... mailinfo: 'From:' header should be unfold as well
>353aaf2... mailinfo: correctly handle multiline 'Subject:' header
-141201d... Merge branch 'maint-1.5.6' into maint-1.6.0

$ git lg maint..ks/maint-mailinfo-folded
>ddfb369... mailinfo: 'From:' header should be unfold as well
>353aaf2... mailinfo: correctly handle multiline 'Subject:' header
-141201d... Merge branch 'maint-1.5.6' into maint-1.6.0

141201d is only three commits ahead of v1.6.0.6 and

$ git lg v1.6.0.6..141201d

will show that we _could_ even issue v1.6.0.7 with the fixes in this topic
if we cared about this bug deeply enough.  If I pull the above to the
topic, we'll lose the ability to propagate these fixes to the maintenance
serires.

So please either say "Yes, you are welcome to cherry-pick -- fetching and
cherry-picking would be easier than e-mail for this kind of patch", or
"Ok, I'll rebase my series on top of ddfb369".

Well, I just noticed that some of your commits already conflict with the
two patches that I already have, so I guess we would need at least one
rebase anyway, so this time around, I'd really prefer you not to say "you
are welcome to cherry-pick" ;-)

Thanks.
