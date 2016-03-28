From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Warning about conflict markers - undocumented 'diff --check' feature & suggestion
Date: Mon, 28 Mar 2016 16:01:25 -0700
Message-ID: <xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
References: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Tue Mar 29 01:02:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgB6-0003sQ-LV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbcC1XB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:01:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755308AbcC1XB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:01:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6D6451307;
	Mon, 28 Mar 2016 19:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3XPwVSeDKiz7KokTkRrikC3vaE=; b=h3xe0k
	uQFztaj5NB0PQ1rSwQPg5k8wAVeHaKT5yquF2vYKMO5I1Fob5SKmty2E5iOYFSsT
	yfOVZ2+rXwJ7GH+DsOomQu8QYrHq4YU/wAJDuctZUGa7UwH5J65YduTiobQ9ywRq
	4rpeQQEo8khZdy3kP3z8lAijk2Pu6uxWpsLkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cr/4+qsB1QNeb/NDgIrmBOyleicF/NQl
	xahptCJ5C3VlkMIs+lYXKWoLeq90fxoBBKTuOQY0HHSD5y+rv54piK/o+KuIwqBJ
	ljfhaSifZhfaF9kL4/WpPHZB74yebNSaVFrqrocVlKroP0UumK4DzukT004YuRX/
	gMdy56na+Xo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9423151306;
	Mon, 28 Mar 2016 19:01:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17B2751303;
	Mon, 28 Mar 2016 19:01:27 -0400 (EDT)
In-Reply-To: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
	(Ori Avtalion's message of "Tue, 29 Mar 2016 01:44:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0044D782-F539-11E5-A0E2-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290083>

Ori Avtalion <ori@avtalion.name> writes:

> A bug report and a suggestion:
>
> `git diff --check` has been warning about conflict markers since 2008:
> https://marc.info/?l=git&m=122398500726634&w=2
>
> This is an undocumented feature. The current documentation for the
> flag only mentions "whitespace errors".

Thanks for digging (even though I do not think the message you
quoted has much to do with this).

04954043 (diff --check: detect leftover conflict markers,
2008-06-26) was the change that added this check to the "check
whitespace breakage" codepath, which forgot to update the
documentation.

And when 4f830390 (Documentation: git diff --check respects
core.whitespace, 2011-06-22) rewrote the paragraph, it again didn't
remember to update it to match the reality.

Care to try a patch?
