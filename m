From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] l10n: git-parse-remote.sh: mark strings for translation
Date: Fri, 08 Apr 2016 13:30:18 -0700
Message-ID: <xmqqh9fbvo6d.fsf@gitster.mtv.corp.google.com>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
	<1460145765-7454-3-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:30:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aod2y-0001Zx-VY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758848AbcDHUaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:30:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758423AbcDHUaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09AB252F77;
	Fri,  8 Apr 2016 16:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDr6pC+VkUgeqY0SzDntYG972nc=; b=taCkAK
	I4TfZtaDlAaO0p1bzqnNs/3XjSXKQQayEy1rMEvQInvSn7FNe4jcLfmq/DEEqm4K
	1uoqV8YZ57QOomQ3FOEpHR+5e+AkK7PXQmPZfVjzHeAqdVb9nWBkKlvadmsTUdGI
	curD+FfvkqSIfKY9UTqNHZhfIxvE2xL/VRt+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+Xo4HCvBlT5ywzm7cwzJhMZ4pRx/jw0
	t8e1p0bXZzegsOyB495SSu9e4EYY76YMXgWV7AOs4sOAQQT6KhLXGFad5azxK9Cy
	kK0WFxBpGwuiHgH+g6OpmJhnNHj66O52fw+cupAmo4Kf1U6eapjroCtl1gI5f3g5
	hPelon9QAfM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3CE852F76;
	Fri,  8 Apr 2016 16:30:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 739CB52F75;
	Fri,  8 Apr 2016 16:30:19 -0400 (EDT)
In-Reply-To: <1460145765-7454-3-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 8 Apr 2016 20:02:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B61627E0-FDC8-11E5-BB25-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291069>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> +		gettextln "You are not currently on a branch."
> +		if test $op_type = "rebase"

	if test "$op_type" = rebase

that is, $op_type could be an empty string that 'test' may not even
see hence it should be double-quoted to ensure 'test' sees an empty
string in that case, while "rebase" cannot be an empty string by
definition so there is no need to quote it.

Thanks.
