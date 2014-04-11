From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test: fix t5560 on FreeBSD
Date: Fri, 11 Apr 2014 13:52:30 -0700
Message-ID: <xmqqioqfr3ld.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0101ef71fafab90325bb799cb8ad80e@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiRE-0006YL-Mb
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbaDKUwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:52:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755773AbaDKUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:52:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3657A37C;
	Fri, 11 Apr 2014 16:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G2/OsH0ieZCbTHqfvmndkX4EFY0=; b=H9l3Ik
	WdcMCz1MXAsin4xSj48psCJs3tF1MnVPjXkuNg6rjFyttcRjWJFicI6asvonycrr
	M6k8dAggbWvZCjE/ETvdU+1RnZ/4L3rWLX8i9grX92K4UA3oR2w1aBnt/DbikXqz
	8kQ0tJDntg5iH4euz10DhFGHr0wgwcQizHmwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNzNgaNllOvzRhpXjItFS7ASoEUh6yDO
	TeKygEEtlbb64JUDynTd0/TdovLkg+mX7Qbtp3i1YUGcgv+guqgxAZc9vaQjaqfY
	Q2JXHjgYOquoU27vPNDdw2r821RxKY250zaX57bzXe+JudgqnRxvoez2ZtcHlDuM
	ENqH50Z6gvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41327A378;
	Fri, 11 Apr 2014 16:52:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8A57A376;
	Fri, 11 Apr 2014 16:52:32 -0400 (EDT)
In-Reply-To: <0101ef71fafab90325bb799cb8ad80e@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 11 Apr 2014 01:28:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 340BCC8C-C1BB-11E3-A9FC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246149>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Instead, we can use the [...] construct to defeat the special meaning
> of the '?' character and match it exactly in a way that works for the
> FreeBSD /bin/sh as well as other POSIX /bin/sh implementations.
>
> Changing the example like so:
>
> x='one?two?three'
> echo "${x#*[?]}"
>
> Produces the expected output using the FreeBSD /bin/sh.

I'll queue this in the meantime, while 1&2/3 are sorted out between
you and Matthieu.

I will also take "cp -a" patch with "-R -P -p", not just "-R" for
the reasons stated in the other thread.

Thanks.
