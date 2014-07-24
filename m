From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 24 Jul 2014 13:03:56 -0700
Message-ID: <xmqqha268qxf.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
	<53D12078.2070004@gmail.com> <vpq1ttadauu.fsf@anie.imag.fr>
	<53D12D56.2080505@gmail.com> <vpqsilq7muy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:04:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAPFK-0002gb-9y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 22:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934494AbaGXUEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 16:04:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55445 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934430AbaGXUEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 16:04:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2367F2B90D;
	Thu, 24 Jul 2014 16:04:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sXC99WnCFAijcc5lmuzwNtmBzuI=; b=GyUDk9
	8HLZ5KzT3D/sH6VKRkX87aPGk0IWhdiv1Ur/SercytUSnC9+X96Epkl62tL0p9DC
	LDopjE817ZHJxzqJhmM92mlNxmgRcCq9XUjFnXPP+9UR8UjUe088mK45Iy3p/9Dz
	RR1bIoCp5Zl9C2VudAsf2JgRWaYC+ArjISUDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iPEF487W+siiX6MzOTxOGN7EnlDtmKv0
	4oMwszOT6EeI0LM8yJtkDN2Wvt39zXtHajzpIkZQnpkuhdjzE2DcIRBhOxUC+RVA
	yGSr5oUh4lbYJgrXAFefGr7ENRzrltzP9qiEVKQZGA6y7eeLLIxHFKdYjPmpuNhD
	/0/07/nNyAM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 150AE2B90C;
	Thu, 24 Jul 2014 16:04:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE0F52B8F3;
	Thu, 24 Jul 2014 16:03:57 -0400 (EDT)
In-Reply-To: <vpqsilq7muy.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	24 Jul 2014 18:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5A2B0F0-136D-11E4-BF0D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254184>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> As a side effect, I guess Junio will apply this on top of master so the
> string interning API will be available immediately at the tip of the
> branch.

Thanks for a heads-up.  The two-patch series does not use the
interning, but does use string_list_init(), which is recent, and
I will have to apply on a newer base than I have been applying its
earlier iterations.
