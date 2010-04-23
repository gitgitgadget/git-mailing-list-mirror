From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff without num-stat
Date: Fri, 23 Apr 2010 02:21:04 -0700
Message-ID: <7vwrvyzfr3.fsf@alter.siamese.dyndns.org>
References: <19408.40250.102191.314496@winooski.ccs.neu.edu>
 <4BD156F8.5090307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:21:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5F4d-0002Tk-Jp
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab0DWJVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:21:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0DWJVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:21:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC24AD40B;
	Fri, 23 Apr 2010 05:21:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=od1I/FP0YmGS7ChmFrJtyWipQKE=; b=iYtFa2
	R5YChMosWStqtBnKElXcsxBMJhSMR0Ry91PcEXbg7cC0/n2FR1uT9hXUyRqrhsYr
	xBOdCXg1nZfNrbOqiLouTeJd41maE/u03JkZrYULvKYHZrvNVTahr97RZ7RgdKrc
	FZ7yq6qR46Rnbc6R35BSInwHEgTlpemJW4VOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dr3pOQ6Qwz9Zbp/ggASB+WVyXEVdUFNn
	P6E16s57n8MyWwV7XOMOSFgGOofCMo+HaqIMcuDN0YephfKTk2NuM+8dojtHUGKL
	/XZcWeDzJuDjSl4HegnsjnHqpPOXntdWjpUGOWQBpjLYRiJYBlX36rvMZ2x/rpLs
	qV0vSs94nLs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77522AD40A;
	Fri, 23 Apr 2010 05:21:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96281AD3FA; Fri, 23 Apr
 2010 05:21:06 -0400 (EDT)
In-Reply-To: <4BD156F8.5090307@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 23 Apr 2010 10\:14\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E179568-4EB9-11DF-B35B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145600>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Eli Barzilay venit, vidit, dixit 22.04.2010 21:02:
>> `git diff' has a `--numstat' flag, but is there any way to *avoid* the
>> numstat?  (I'm using `--stat' but want to void the summary line, and
>> I'd like to avoid piping it to `head'.)
>
> So, what DO you want? Except for the different formatting:
>
> --stat output minus --numstat output == summary line
>
> where "summary line" is something like
>
> 5 files changed, 5974 insertions(+), 0 deletions(-)
>
> Do you want to (a)void the numstat or the summary?

Summary is "create mode ..." etc. and you can already enable/disable it.

That "N files +M/-N lines in total" is _not_ a summary; it is an integral
part of ascii-graphical --stat output, which is supposed to produce output
like "git diff -p | diffstat".  We won't split it out of --stat without a
very good reason, there doesn't seem to be an option to "diffstat" for
such a thing, so...
