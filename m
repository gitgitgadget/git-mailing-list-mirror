From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Sun, 07 Jul 2013 10:53:03 -0700
Message-ID: <7vppuu45q8.fsf@alter.siamese.dyndns.org>
References: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
	<CAEBDL5UfHpR3GNeqbDf9X3Ya+Spcpx0Byq5MZPMMsE=a3y2jhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvt96-0007xS-CF
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab3GGRxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:53:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab3GGRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:53:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 647992ED09;
	Sun,  7 Jul 2013 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9yKmArRTUUq/NyCOvQNvZ0aBPlI=; b=RfaHZh
	+Uor6+9LmwR7+7Y7tocswmr3S73QcsdVZmwK8M9QoiuAC7fkahlN6a+pRJgpu8qk
	Uiw82Q43cHhsMJMa7TQX3e2ZZteCk6hkEh4q5wan+rE5y48dF3+NUjJyr/SU1TJH
	Q3zzsXJ+zeU8yeaOgZbKIOY3OxbWRfFqG9Gzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OahfShr1mY1xwjnFOcU24zdz97vXlR65
	M71h43G8sTsBZPoDtQWBo3UTJEFYCwGvHmjcn02YOTGnOsnBMZpCARxmhGiv+5Lw
	NEQJvATSKhW/H0uUw41WagV6GF30TmsaQmGt5xZzwC2RFrE1wM0uwh8PVoAYy49B
	86LeS7RPTWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A69B2ED08;
	Sun,  7 Jul 2013 17:53:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA8B52ED06;
	Sun,  7 Jul 2013 17:53:04 +0000 (UTC)
In-Reply-To: <CAEBDL5UfHpR3GNeqbDf9X3Ya+Spcpx0Byq5MZPMMsE=a3y2jhg@mail.gmail.com>
	(John Szakmeister's message of "Sun, 7 Jul 2013 09:35:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1308A0C2-E72E-11E2-B581-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229785>

John Szakmeister <john@szakmeister.net> writes:

> On Sun, Jul 7, 2013 at 8:52 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> When GIT_PS1_SHOWCOLORHINTS is turned on, there is no need to put a
>> detached HEAD within parenthesis: the color can be used to discriminate
>> the detached HEAD.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  For cuteness :)
>
> Personally, I'd rather see the parens kept.  Not everyone sees red
> very well--I know several people who can't see it at all, and it keeps
> it consistent with non-colored output.

+1; I find red on many terminal emulators to be too dark to tell,
especially in a small font, from black myself.
