From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 12:59:29 -0700
Message-ID: <7v8v3zdc2m.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGi8-00067m-O3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721Ab3D3T7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:59:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933683Ab3D3T7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6361B96C;
	Tue, 30 Apr 2013 19:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wGAWthyltta6+qhAsCO54yRK10E=; b=ticpuY
	Lx6KsBv2HOFHd5i/tKPchskaIMkousXQqDjFWefR3P9nNK8zXmVIbQGK/Ss8M+TC
	+QIpWNAHBlXjb23Q3tzDC27KEVrzHQ6sETJHgPbB5KYf4SlLmcTZiVIeS0zUWNz/
	QGvoVWcxstAxYpZRCcFje2aEO0iMgAWmUDosc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YdQ3bkBE5ZNERPE7B6d08hjSGZwaIdUh
	pxNkGYdZS+HR5s4o2FDPLs0OR4hwVMBPotDqebe/YDXhj2d4aN9OLNYNbBbQPeEE
	YnhbbfJnCoSwKrlG4x0x9l7tXgps7G6xHfgGVNri05q3UQyz/y0CWNDZaflf6Eax
	br3aaqib6bc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 218711B96B;
	Tue, 30 Apr 2013 19:59:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AB171B969;
	Tue, 30 Apr 2013 19:59:30 +0000 (UTC)
In-Reply-To: <7vhaindcuk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Apr 2013 12:42:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 786FD022-B1D0-11E2-A145-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222999>

Junio C Hamano <gitster@pobox.com> writes:

> The rule would be "You should be able to say '@' where-ever you
> currently say HEAD" (aka '@' is a short-hand for 'HEAD').
>
> That means "git checout @" should work the same way as "git checkout
> HEAD", "git log @~4" would work the same way as "git log HEAD~4",
> "git update-ref @ $(git rev-parse master)" should update the HEAD
> without creating $GIT_DIR/@, etc.
>
> You can't go any simpler than that rule, and there is no room for
> confusion if that rule is properly implemented.
>
> Hmm?

I personally would not mind an easier-to-implement rule that says
"You can say '@' to mean HEAD^0, i.e. the object name of the commit
at the tip of your current branch".  That would make sure that
nobody would expect "git update-ref @ $(git rev-parse master~4)" to
work.
