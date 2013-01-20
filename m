From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Allow Git::get_tz_offset to properly handle DST
 boundary times
Date: Sun, 20 Jan 2013 13:03:54 -0800
Message-ID: <7vzk03k1mt.fsf@alter.siamese.dyndns.org>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
 <1358291405-10173-3-git-send-email-bdwalton@gmail.com>
 <7vy5frtymt.fsf@alter.siamese.dyndns.org>
 <CAP30j14Og7YLaZj0dbpAhUHFfuy0Y=bEn_3EqGzxR5PRA7vQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx23t-0003Pw-V4
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab3ATVD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:03:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab3ATVD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:03:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269E0A202;
	Sun, 20 Jan 2013 16:03:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oOfkI6aR8t+ZoBYql5gXJMLzdBg=; b=nbMk7w
	qFfPsqwJd7xRbu4N1JFv0a5lSBDrzIDiyjrM6Xwh5FiPJ0ZfDv6hv8NR8duREt2i
	56yD/toLEngY9tSuUfT36hDvjwdbA0VDoWZvaZjHpvdmhhWXVOtdl73u8gi+2FdP
	EaOeU5tkrYfx1cZVqL9UYayFrqBYrIPMNUi6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOBrme9lirVqVG5/XUlz/9DQQmPVlo6l
	qtezL+HhZIH3hB2HVyHwJEmSWoJvG51KaG7yD9cZ6oYg0t3pjSmr7fKPlIvW+fpf
	WZ4c9RQwJWDB9zTTQMyHvz0QFAx1U7h3BIV2XkBgPMwGJQ76oBVdMcngyY0qaWGB
	TVpJVEWVbAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19EDAA201;
	Sun, 20 Jan 2013 16:03:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81BA6A1FA; Sun, 20 Jan 2013
 16:03:55 -0500 (EST)
In-Reply-To: <CAP30j14Og7YLaZj0dbpAhUHFfuy0Y=bEn_3EqGzxR5PRA7vQXA@mail.gmail.com> (Ben
 Walton's message of "Sun, 20 Jan 2013 20:06:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6C8F646-6344-11E2-91F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214049>

Ben Walton <bdwalton@gmail.com> writes:

> also avoids the oddball 1/2 hour DST shift.  I can re-roll the series
> with your code (and credit for it) or you can apply you change on top
> of my series...whichever is easiest for you.

Please reroll, as I do not have patience either to set up a test
case and verify the end result is correct, or to come up with a test
case for it.  For this particular case, I think the identification
of the issue weighs more than the implementation for fix it, so
please retain the authorship for the fix; mentioning "taking the
implementation idea from Junio" in the log message is the right
amount of credit due to me.

Thanks.
