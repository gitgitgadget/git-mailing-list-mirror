From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
 for push
Date: Mon, 16 Mar 2009 14:13:05 -0700
Message-ID: <7vljr5uq72.fsf@gitster.siamese.dyndns.org>
References: <20090311220144.GA6782@pvv.org>
 <7vwsavlg6q.fsf@gitster.siamese.dyndns.org> <20090312115433.GA2848@pvv.org>
 <7viqmbakmt.fsf@gitster.siamese.dyndns.org>
 <7viqmayslg.fsf@gitster.siamese.dyndns.org> <20090316155629.GA17526@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:14:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjK8y-0004Gc-4z
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760301AbZCPVNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 17:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760976AbZCPVNP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:13:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760825AbZCPVNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 17:13:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FE21A2988;
	Mon, 16 Mar 2009 17:13:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86F1BA2984; Mon,
 16 Mar 2009 17:13:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40D88FBE-126F-11DE-9F8B-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113384>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Sun, Mar 15, 2009 at 09:55:23PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> As some people still seem to object to the change of default (and that
>> includes 20-30% of myself), we may end up deciding not to switch the
>> default after all, but even in that case, applying the first half would
>> benefit people who would want different behaviour.
>
> I think the suggested new default is a lot safer then the current
> one. A default of "nothing" will print a nice message if you end up
> pushing nothing, which you will fix in a heartbeat with a single git
> config command.
>
> If you erroneously push one or more branches however, cleanup might
> end up being very complicated. Many pushable repos are set up with
> disallowing non-fast-forward pushes, so it may require intervention by
> someone else to clean up, and by then someone else have already
> fetched the bad push.

I think traditionalists who do not like changing the default already know
these, though.  I would not object to the push.default as a _choice_.

In fact, sourceforge.jp (they added git support late last year, and I keep
a secondary public repository just like my alt-git.git at repo.or.cz) is
one of such places.  It seems to forbid non fast-forward pushes, and that
is why I have been pushing only maint and master there.  It does allow
deletion, and I could push deletion followed by creation in two stages,
i.e. "git push sfjp :pu && git push sfjp pu", but I did not bother.

In a later part of the message you are responding to (but did not quote),
I was agreeing with all of what you wrote here, and even more ;-) Notice
the "tradeoff does not look too bad to me" part.

Your new [1/2] gives the choice without advertisement, and _if_ you remove
or tone down "The default may change in the future" from [2/2], it becomes
purely an advertisement of the feature to help people from burning
themselves.  I do not see anything a sane traditionist would object to at
that point, and I thought we could even squash the two into one commit
(which was what I meant by "I am inclined to change my mind" in the
message you are responding to).
