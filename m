From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 07:56:42 -0700
Message-ID: <7vppwvnd1x.fsf@alter.siamese.dyndns.org>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
	<7vr4hbou7d.fsf@alter.siamese.dyndns.org>
	<CALkWK0kE9tvNjPW7jH10ZatLHEuqbH+XmovEpp3RPAh1koyvpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuBF-0001bU-LN
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab3EMO4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:56:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab3EMO4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 267071DC8E;
	Mon, 13 May 2013 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PwUcUobn2Uz5DGB3R63v1Q5DqEg=; b=e0TJWH
	RsD6UWgVtOSqVCfVTNyPGYUrVNhVMGoUeFD1MelmlFovzUAvwWY3/8PFSHAVjymL
	jbw43YXkCUswBSvCjYqFEj0yIS2tm+AnIIyg49sKry0BiVck74wHSmMReMJFV64W
	Cb4bt53rllEnNtyR1PrGchLk4H5tQ5t5pX00o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKYIyk8fM0BvmQzMW5KrcARPgkkRkwpU
	2Fuh+d00WffdXOw3q5RWlx4zy35NhwzFwG14JwiakEb/MG2IWwhjFMOeMFZl1Eoz
	IgGVJax/9yL/lyTWU9PrM5qSwarP3sNbM9Al7zvgn9dtE4XKAoe06NtvaHPk2JDz
	p47nRLivGMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0DA1DC8D;
	Mon, 13 May 2013 14:56:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 944131DC8C;
	Mon, 13 May 2013 14:56:44 +0000 (UTC)
In-Reply-To: <CALkWK0kE9tvNjPW7jH10ZatLHEuqbH+XmovEpp3RPAh1koyvpg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 19:47:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5402C458-BBDD-11E2-A0F7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224161>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Maybe we should add the
> line "Not for end user interactive use" to both descriptions?  We can
> get that double-underscore if you really want, but it'd stick out like
> a sore thumb since we can't change create.

Yeah, good point about the __name.

It was a mistake that the description of 'create' does not have
"This is probably not what you want to use; see 'save'" there.
Let's do that, and do the same for 'store' (that is, not advertise
in 'git stash -h' output, describe in the manual for scripters, and
mark it not for the end user in the description).
