From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Smart-http: check if repository is OK to export before
 serving it
Date: Tue, 29 Dec 2009 01:19:51 -0800
Message-ID: <7vy6kmjfwo.fsf@alter.siamese.dyndns.org>
References: <20091228170811.GE2252@spearce.org>
 <1262036940-9678-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 10:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPYFT-0006gz-7m
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 10:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZL2JUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 04:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbZL2JUF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 04:20:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZL2JUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 04:20:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44346AAB9C;
	Tue, 29 Dec 2009 04:20:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=WtBqrtY+HUm5kD5Qe5MHMX6wEqQ=; b=VRMOw3tZCZq925oYnfZaIWz
	F1kyiboL0fVyjsiilF37KGrZ+p+Kwuud+6y8Q/nL5WQzUrYuzq9EvSjt6XFEGWv9
	VSLaX6xeD/0eviks6xuyoZ8DDouw+H+K1jId6I/ywu1duqgbKK8kmQJCyLlIRXCn
	rieP4OKFjFVTnvKoaeOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HdyOCsuEviAJwEzQ7RNFKBzFkryenHdtE9gKCfY484xLBD9jt
	QtY5nBsmVXxMbqm8dLAiP+YMAgadCBxCbKPG2ZDk4pq/Gwo6YNozWVT7EyYJ/7We
	tkaS8JLtCfrZpWluD7aeA4UKGjad/e+aYCT2g8brgeOTAfLITQB0Aryamc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14898AAB9B;
	Tue, 29 Dec 2009 04:19:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 02A22AAB9A; Tue, 29 Dec 2009
 04:19:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54D9A79A-F45B-11DE-B7C6-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135785>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> Similar to how git-daemon checks whether a repository is OK to be
> exported, smart-http should also check.  This check can be satisfied
> in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
> may be set to export all repositories, or the individual repository
> may have the file git-daemon-export-ok.
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> ---
> OK, I see what you're saying Shawn.  I've changed it back to "404 
> Not Found" again.
>
> I've also reordered the new tests since the last time I sent it out.
> The new tests use the same test as in
> "static file is ok"
> so put the new tests after that test in case that test breaks.

Looks sane to me, although I am afraid that I am not as familiar with the
codepath involved as I should be.  Shawn, is your Ack still good?
