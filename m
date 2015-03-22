From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Sat, 21 Mar 2015 21:59:30 -0700
Message-ID: <xmqqoanld3v1.fsf@gitster.dls.corp.google.com>
References: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
	<1426969262.3756.1.camel@kaarsemaker.net> <550E430F.9010308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, dwheeler@dwheeler.com,
	git <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 05:59:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZXzC-0004cP-ET
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 05:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbbCVE7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 00:59:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751235AbbCVE7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 00:59:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3610743FF1;
	Sun, 22 Mar 2015 00:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kb8Uyp9uI/F3AQd7clDYaai+pGU=; b=gRySQ8
	mdQ9ekZsrZWQzaGdMNkk3C/yrsXxbtYqcUL99n5QutoeM6kJZRZ9ifFyVGtNzD3M
	wn8ecKaf4Np5ea0k85HECiTozP21VMuRnWt3TVt7BEzCFdvANIIxOiM0pdAspo4Q
	9Xc2PrhEJ2xWqSZZjbUhC5fzI4gkejVM9/4xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FFD/y0HU1wglGcgdOOrWSP9jobQoNHas
	xCpq9wmFM1xZAkevT2s9DdSjVNmSz3PyK86mRAlDsYRYWb0UtF7ULAdxm5MTAb9a
	q05vPd9igjsZOu2BI4DHyjjYf9SkUB7EbRPbLd5DDKK9jtWo7pZtdekfVQtLkjPu
	xq1AJtf0odE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D45D43FF0;
	Sun, 22 Mar 2015 00:59:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6BAE43FD9;
	Sun, 22 Mar 2015 00:59:31 -0400 (EDT)
In-Reply-To: <550E430F.9010308@gmail.com> (Stefan Beller's message of "Sat, 21
	Mar 2015 21:20:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39FF7FC2-D050-11E4-AC05-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266050>

Stefan Beller <stefanbeller@gmail.com> writes:

> To spin this further it would be interesting to have
> a server advertisement during git clone which indicates
> if this setting is recommended to be set.
> Then hosting sites popular in the open source world such as
> github could enable this feature, and the client may enable
> this for the currently cloned repository (the user may have
> a global setting set to suppress this message though).
>
> At $work the default of not advertising checking for such a
> feature would be set.

Hmm.

An open source hosting site can help better by checking at the
project creation time, because the people who interact with that
interface are solely in the position to set and publish licensing
terms.  The general consumer who are cloning and fetching do not
have direct control over this, and the only thing the could do to
nudge the publishers is with an out-of-line communication, e.g.
sending e-mails telling the publisher "I am interested in using your
ware, but you do not have licensing terms described, which makes me
wary; please improve".

An approach that checks only the top-level directory for fixed
filename pattern would not be an effective way to protect the
cloners, either.

I am personally not interested in the patch under discussion, with
or without "please be quiet" configuration.

Thanks.
