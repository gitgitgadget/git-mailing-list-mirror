From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/4] grep: pass current line number down to
 match_one_pattern
Date: Mon, 02 May 2011 09:40:46 -0700
Message-ID: <7vbozloy29.fsf@alter.siamese.dyndns.org>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <cover.1304321122.git.bert.wesarg@googlemail.com>
 <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com> <2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com> <BANLkTi=HtStcEFezT9sEeRFzsGw1mMyg7Q@mail.gmail.com> <BANLkTimr7A64OYB51kSWe7pkjYaiOZy-ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 18:41:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGwBF-0004XH-Cr
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 18:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1EBQlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 12:41:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab1EBQk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 12:40:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55C894E03;
	Mon,  2 May 2011 12:43:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TASQkk+I29a4CoDPKLeRe1nEyxw=; b=JD8taK
	AOEWO53YZae5lpnYFS+VvmcnQmONcXfZKtVu9xw8p76h2hELI7ZjPhbdqK0Uz/T+
	8ck44onmZkqGUWC46tkxxBGj+gEHpS5PG6d9lYd6UC9O8oTWExg1yeHjxaUpZGlW
	v8PI4Vb6v74/LQ4lIkQQxKa0ylhwNNvge+4vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QLmsTEIYYVmmtyxmbGy2jOvMd2SoqhVv
	0gR9gxmQVjGHtl0s8kYNTZagFfDQ3AsSUc9k0ydLPGL8ksZndB4e1+zaJrWnmQ2a
	La2lvm0lxu15lZO4RnLirUL57iGGIxijTnFaYdfWIUGeIz1wNfKl/dKhyK5sTZYr
	N9/ZSAZVXRs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21B504DFE;
	Mon,  2 May 2011 12:42:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3C8A4DF1; Mon,  2 May 2011
 12:42:51 -0400 (EDT)
In-Reply-To: <BANLkTimr7A64OYB51kSWe7pkjYaiOZy-ZQ@mail.gmail.com> (Bert
 Wesarg's message of "Mon, 2 May 2011 16:29:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B2BF184-74DB-11E0-95A9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172600>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> lno is already in use in this file, so I followed here the precept.
> The position was chosen, because bol/eol is the line content to match,
> so the line number should probably be near the content parameter.

The choice of "lno" is fine (and probably better than line_nr) as variable
and enum names in the context of this file.

If we were to do this change, that is.
