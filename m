From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Fri, 07 Mar 2014 15:37:20 -0800
Message-ID: <xmqqvbvpshqn.fsf@gitster.dls.corp.google.com>
References: <1394178834.7891.38.camel@Naugrim>
	<BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
	<1394231714.7891.39.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Keller <andrew@kellerfarm.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 00:37:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM4Kw-0003oh-AB
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 00:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbaCGXhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 18:37:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaCGXhY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 18:37:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0F472346;
	Fri,  7 Mar 2014 18:37:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bNJbpKgxXN4cYsQ0ybc5tK7Q/Ao=; b=e+1KUA
	Wv1Yvvg0cSXcOVUlUf3fAVUfLqq7zw8aBsq7IqEI1Yktsl7uogaBVYAzwmAm4Nxn
	5lxXMKFiytKA2hq7A/lvBM7OdJKm+WcK58AONqfiL/7JuwFrJR/D/mOqSM+lRYRM
	I3Zh+idNilWR0lh22TLQ4TGY9QRdjbpgxklFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ljqqtm+iGY+Ogk5Jk0Kyhs/2M0A+ziXv
	hsgaDrn0nnJjyvoBevGlG/qVsuI8dBSVc4YKWGbijuXsOJPXBpOREyKz01HiBlhW
	rOseizMbuVLTgSzK5+Y92NtwXPEWzX7MGi05eQwxKcctKDJUnjgBe9b7Pr52kxww
	Gf0qgmJDNvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F269D72345;
	Fri,  7 Mar 2014 18:37:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4948372344;
	Fri,  7 Mar 2014 18:37:23 -0500 (EST)
In-Reply-To: <1394231714.7891.39.camel@Naugrim> (Henri GEIST's message of
	"Fri, 07 Mar 2014 23:35:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6ED25EEC-A651-11E3-8AD8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243637>

Henri GEIST <geist.henri@laposte.net> writes:

> This information is technical in nature but has some importance for general users.
> As this kind of clone have a separate gitdir, you will have a surprise if you
> copy past the worktree as the gitdir will not come together.

I am not sure if I understand exactly what you are trying to say.
Are you saying that you had a submodule at "sub/dir" in your working
tree, and then "mkdir ../another && cp -R sub/dir ../another" did
not result in a usable Git working tree in ../another directory?

It is almost like complaining that "mkdir ../newone && cp -R * ../newone/"
did not result in a usable git repository in ../newone directory and
honestly speaking, that sounds borderline insane, I'd have to say.

Yes, if a user knows what she is doing, she should be able to make
something like that work, without running "git clone" (which is
probably the way most users would do it).  And yes, it would be good
to let the user learn from the documentation enough so that she
"knows what she is doing".  But no, I do not think end-user facing
documentation for "git-submodule" subcommand is the way to do that.

That is why I suggested repository-layout as potentially a better
alternative location.

But perhaps I am mis-reading your rationale.
