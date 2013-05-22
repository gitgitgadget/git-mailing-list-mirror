From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Wed, 22 May 2013 07:26:27 -0700
Message-ID: <7v7girks4s.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	<7vppwkm682.fsf@alter.siamese.dyndns.org>
	<CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 16:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf9zv-0004dr-LP
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab3EVO0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:26:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3EVO0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:26:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19BC520C2B;
	Wed, 22 May 2013 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UPEyj9mgx3JeyCymWKoFxsJeO3c=; b=pFEexwMonHOE+Khm1i4+
	iZ1t+VoRcoAszHeyTtMqhhug3YEsbJ+R8ZS4J5vVl7xIEfUH0DijnLJFMbTCauzE
	gbW9h/DidPyjAt3zhthPHVe77tEKqdNJivoI2F6jsZZ8S7cHYpwSsnlsf/9u6KnO
	T+7pxJLA6Clo1psvBtPYQIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Np5/KWIqzJde1gHvwm1aGXob3j+rSgN7ykqpeNesYxEpdM
	nQOG6EBw7jeoYhg5QlaoPBkAZ74jWtfoz8EAoiYNc1GGYFO/4+1/EPxcC47/8XwF
	NODPVV/k/YBOBJYJEzONBvYVfYFlrlO+DOuBk/nXlQ9sDGJeAlFriajXfAdFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C6F920C29;
	Wed, 22 May 2013 14:26:30 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C87420C27;
	Wed, 22 May 2013 14:26:29 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97CEDB30-C2EB-11E2-90BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225163>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Why should I lie in the patch?  The terminal flipping was a very big
> itch I had, and the patch fixes exactly that issue.  Showing the real
> branch name was an unintended side-effect.
>
> I just said "early" and showed a nice end-user example in which it
> works, not "theoretically impossible to race with".  Better wording
> (while not lying about the motivation behind the patch)?

The patch may have been done by a wrong motivation, in that it does
not fundamentally "fix" the itch.  The particular "itch" is not
something we are going to promise to the end users, ever, anyway.

The only remaining justification for the change is, even though the
user cannot _safely_ flip the branches with this patch, it improves
the output.

That does not make the patch wrong, but the original motivation is
an irrelevant, lost cause.  "Even though this started to address an
itch, the patch does not fundamentally fix that itch at all." may be
a honest statement to make, but that alone is not a justification to
have this change.

The "side effect" is the only improvement this patch gives us, and
that happens to be a good enough justification.  At that point, is
the original itch the patch does not correctly address even worth
mentioning?  I answered "no" to that question.

So I do not think you are lying anything.
