From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 01 May 2012 14:03:05 -0700
Message-ID: <7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
 <7vipgf8wve.fsf@alter.siamese.dyndns.org> <86r4v3mxf7.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue May 01 23:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKE6-0004pf-LY
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab2EAVDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:03:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab2EAVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:03:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB917083;
	Tue,  1 May 2012 17:03:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XXZf8Sv+Ps6ybY9IlifCq6WLW38=; b=RTMT8C
	Cee3SoUb8XZ+fhq12srT7nXdlXrb0OswAdLcWQnItUSjbLQ9734GTSj8+Ws24XQF
	0DEDjGWehNNcRJQmJ5AEUKFwKwmjZStGl8volKTbM1u57xrphdGXGaIC3BE7l9wK
	tFPguq6JT93d/acTUgjHE2kCWSBzd7vBmfaoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wSTioVDf1HzYdxe8AMR1PvL+2NpSsIHQ
	vHVDEo1t9Jbz3tuawroCzDZxYBHDHxDexI60IvmGDRHK9Vj91gLO0cBq15RemLy0
	8oeOAGaw7tCaDbhonT5V+I7brBMCkYuHOswJR5wc+hB2ZYofEKSqA/HLEKL7K4Tn
	7p9o9H6g8yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76D47082;
	Tue,  1 May 2012 17:03:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4B17081; Tue,  1 May 2012
 17:03:07 -0400 (EDT)
In-Reply-To: <86r4v3mxf7.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Tue, 01 May 2012 13:57:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D1BB3A4-93D1-11E1-A2DF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196749>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>
> Junio> By design.  Do you want me to include "rm -fr ~hilco" in some hook of
> Junio> git.git repository?
>
> This just came up yesterday at $PRIMARY_CLIENT.  One idea we kicked
> around was having a convention for storing the hooks-to-be-populated in
> ".githooks" in the repository tree, and then having clone notice that
> and offer to install them directly if from a trusted source, or at least
> move them into a disabled state in .git/hooks otherwise.

We've talked about something like that a few times in the past, but as far
as I (am concerned / remember) the conclusion has always been that is not
worth "standardizing", i.e. nothing a ./setup script in-tree or a Makefile
target cannot offer the same convenience.
