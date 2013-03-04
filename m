From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 03 Mar 2013 19:42:46 -0800
Message-ID: <7vzjyjygnd.fsf@alter.siamese.dyndns.org>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch> <20130303102946.GH7738@serenity.lan>
 <7vk3pob38d.fsf@alter.siamese.dyndns.org>
 <20130303214206.GL7738@serenity.lan>
 <7vppzg9k0n.fsf@alter.siamese.dyndns.org>
 <20130303232413.GN7738@serenity.lan>
 <7vzjyk83gn.fsf@alter.siamese.dyndns.org>
 <20130304000337.GP7738@serenity.lan>
 <CAHmME9oAiZDcAeMCE=haUmC9yeC0crZCKB-WrxQ3CVd1YrBdHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 05:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCMoC-0000vB-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 05:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab3CDDmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 22:42:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab3CDDmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 22:42:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AAADCF66;
	Sun,  3 Mar 2013 22:42:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gmm8RY3joY9LejLKEAJDjhnFCRM=; b=wc+1Vc
	Z5wh8K9JmMAPEwcHAL7uId/xZne+GdasUdFbMkESL3IXukgYWYFFIDPM4TwHP1AP
	ftX8+EboVEojnty5ktWULqtRvmQtD/N8X75CxbILrgIcv+dCJ7RGek+Nxi5DHvQG
	aHrzxJrPwZmgAltCqRarWCJKCdAXjzU5mWkWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yb5J0LOexyEx1yZsuInu2Y8ulOPqnwwv
	QkFnwUeLzVV8miqK6cGxaGrwpUcmJdY/Dstkv5R+IqDwAWRBwR8h6qwnLhwL5+RC
	ge3S5oJycgm2Y9UBydByESy2twyClwO8YHxQKHb+jQSFcV7naGTnNlnMt4zQ1Xk3
	SmiFkCwpJ+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D7BCF65;
	Sun,  3 Mar 2013 22:42:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FBDDCF62; Sun,  3 Mar 2013
 22:42:48 -0500 (EST)
In-Reply-To: <CAHmME9oAiZDcAeMCE=haUmC9yeC0crZCKB-WrxQ3CVd1YrBdHQ@mail.gmail.com> (Jason
 A. Donenfeld's message of "Sun, 3 Mar 2013 19:12:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9545729A-847D-11E2-A78C-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217390>

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I suspect that many people outside CGit circle may not know who this
Jason (who never appeared in git@vger.kernel.org) is, and are
wondering in what capacity he is sending a S-o-b for somebody else's
patch without explanation.  An inroduction may help others (as can
be seen on Cc: line, I added Lars there because I didn't even know
he was still the man behind CGit).

Later last year, the project was taken over by an active contributor
with the other active contributor (Ferry Huberts)'s support and then
later with Lars's blessing:

  http://hjemli.net/pipermail/cgit/2013-January/000884.html

That active contributor is Jason. The repository has also been moved
to Jason's http://git.zx2c4.com/cgit/ even though mailing list and
its archive seem to be still suported by Lars's hjemli.net.  And the
latest CGit 0.9.1 was release mid November 2012 by him.

John Keeping has been actively working on making sure that CGit
works with newer codebase for the past couple of days, until he
found out that after our v1.7.12.4 some symbols were unavailable to
him from us X-< which triggered this topic.  Jason's S-o-b as the
CGit maintainer is certainly appropriate for this patch.

So, thanks, Jason and John for your efforts.
