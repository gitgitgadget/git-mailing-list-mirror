From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-completion.bash should not add a space after a ref
Date: Sun, 13 Jan 2013 15:16:32 -0800
Message-ID: <7vk3rghdwv.fsf@alter.siamese.dyndns.org>
References: <50F1AD0F.7080503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWnQ-0001Zf-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 00:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab3AMXQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 18:16:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab3AMXQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 18:16:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D6EDA52B;
	Sun, 13 Jan 2013 18:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=En3EknBcLFyU2HMFFBk1/JTuWf8=; b=EIoovy
	ZchUxbIhrODvib/m5pm11w6iXmXhS7oyyv5nYdVwHLPfNbfTgOJhZrNxQOudls69
	fizJ8QL+vkZ6diXeJkT7jxNp5OI1TPskEGHl/JGqkf30p1RQXTvuT3NtEaodCius
	h/2b/wQRSkahLK3oqWNgjAq3RmZzoZO9TQuTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fPIHjGbmEl9iBXKH3SRlKH/wxAN8L+YJ
	c2IDq9bdlRsctKd5IYo5nG4RukPoxKGeqAT+LBvSBLM+tTHUEaA7cUuD3hd0Lbi2
	D+Oqk5nrlR9WVLK5tXedo1nSlvFP/8Y9eGos2cGgqbNCPxA0lIFq1HBdR7Z6fhB7
	7qunY/CGc5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1CAA529;
	Sun, 13 Jan 2013 18:16:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7D80A523; Sun, 13 Jan 2013
 18:16:34 -0500 (EST)
In-Reply-To: <50F1AD0F.7080503@gmail.com> (Manlio Perillo's message of "Sat,
 12 Jan 2013 19:35:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45EBCCE8-5DD7-11E2-9610-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213407>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> This is not really a bug, but a small usability problem.
>
> When completing a reference, Bash will add a space after the reference name.
>
> As an example in:
>
>     $git show master<TAB>
>
> The problem is that an user may want to show a tree or blog object from
> master:
>
>     $git show master:git.c

Or the user may want to see only changes to the documentation, e.g.

	$ git show master Documentation/

so removing a SP is a regression in the other way around.

Given that "refer to an object in a tree" is a much less often used
operation, I have a feeling that the current behaviour happens to
make a good trade-off between these two conflicting purposes that
cannot be satisfied both at the same time.
