From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] install-webdoc: quell diff output on stdout
Date: Thu, 02 Sep 2010 07:58:06 -0700
Message-ID: <7vhbi842gx.fsf@alter.siamese.dyndns.org>
References: <2730e927194a15f708ea4c5ffa72353f793f2ed4.1283353628.git.git@drmicha.warpmail.net> <7vzkw15t50.fsf@alter.siamese.dyndns.org> <4C7F5267.5030708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 16:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrBF4-0002KA-EY
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 16:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0IBO6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 10:58:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0IBO6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 10:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 854DED2F8F;
	Thu,  2 Sep 2010 10:58:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/WeuMRQ+KTyVyutyjKDlFrU4uM=; b=hb2Euq
	PF8/Jg2f5QIgEUOrAx8x4OwRiONK5kUN2eqgXTFvleJ9r07WtRWEXgK1eIhN0e4U
	5B7ucXCBSnC80j3LhKbj/PH42MLgheKUBDo9FudnALd2UKucJqS/eeU+Q/ZiFCIs
	E6YY/79F4d8VKxZ4pGAhi376VTdwELi46W9Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a/WpIDkrG7AB92x6PPY61FdaJ43U8yAY
	BXG1iz3iXIfMfm1e94b2kmuK9Ii+/OUTG+NcdGKCu6Sk62svM/ihdSZvnSEkyFNf
	9vHkD4Iz1yqZgSivUzFu/9uMEYSDurBlopYpRO2fd+ZyEiimUtIvSbIqhVeMeK9Z
	zrzUTOyRzjg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C602D2F8E;
	Thu,  2 Sep 2010 10:58:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5106D2F8D; Thu,  2 Sep
 2010 10:58:07 -0400 (EDT)
In-Reply-To: <4C7F5267.5030708@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 02 Sep 2010 09\:29\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80A16B2E-B6A2-11DF-95B4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155132>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 01.09.2010 18:24:
> ...
>> When I push to the public repository, a hook is triggered to build and
>> install the documentation, sending its progress to a log file, and I have
>> a window open running "tail -f" on it.
>
> Sorry, isn't that a somewhat crazy type of sanity check? You're getting
> the complete diff for the generated htmls flying by. Wouldn't the actual
> "install..." be sufficient, or maybe, a QUIET_DIFF variant which
> displays the command line? And not only sufficient, but actually easier
> to check visually as you seem to do?

I use the diff to see what text actually changed, so the answer is no.

But I am file with a patch to squelch the output by default, while giving
me an option (perhaps by setting an environment variable when the hook
triggers the build and install of the documentation) to unsquelch.
