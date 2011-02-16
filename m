From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 10:37:10 -0800
Message-ID: <7vy65fkeqx.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
 <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr>
 <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
 <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:37:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpmG2-0003G2-Nb
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab1BPShm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 13:37:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1BPShk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 13:37:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE91A4DBD;
	Wed, 16 Feb 2011 13:38:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUcHpTiEDZSv1jYx+JVdEXF/b2k=; b=JrY2ch
	RYYyKFvGYcTz9ZGIiYgZrMsUH+A85Kkrm6mE1NXcIU9sN8OdzRmZuJ4VBBgsHxKN
	nfxEiF7260MAxopAu2egl8Z5xu41EpeRHrS5jKVeksOKtPb/WgwC9mFIjoNMrQPk
	fyx7bG0JThedZSxgKzAmxiR+MrGHPvzsyM2kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+E/0jfZKgZtS6r6mOIKK3GMa3O2TUq9
	JUVkZWqKKw1OY7MqiWIrmTDE+V+Jwl0Zx+XhBFQ9YrHFf5ixfFz930NVySrEoFjC
	FqtU1uPT45umJ3fWeErAc9+pCmrPKhEQetivjhJvgTxCfPaVGYPY7vhJNFNOf1Bt
	bROj4Uv7ueU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5158D4DB5;
	Wed, 16 Feb 2011 13:38:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 908304DA6; Wed, 16 Feb 2011
 13:38:18 -0500 (EST)
In-Reply-To: <7v8vxflv7p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 16 Feb 2011 09\:56\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F51AF380-39FB-11E0-9B17-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166983>

Junio C Hamano <gitster@pobox.com> writes:

> IOW, I consider --set-upstream that takes refs/remotes without bothering
> to go through the remotes.<name>.fetch mapping is a design bug (it may
> have come from sloppy initial coding---it certainly is easier to store
> what you get without computing anything).  That may be something we might
> want to fix in 1.8.0.

Please scratch this paragraph; this was a sloppy thinking on my part.
The option, and its cousin --track, do call into setup_tracking() to look
up the mapping.

The --set-upstream option needs to set both which remote's what branch,
and refs/remotes/origin/master is a way to say "origin's master" and it
was inevitable to expose refs/remotes/ to the UI level if you wanted to
implement it as an option with a single argument.  So in that sense there
is nothing to fix.

Conceptually, "git branch --set-upstream=master --set-remote=origin" is
what it really wants to say, even though that is probably longer to type.
There still might be a room for UI improvement.
