From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Tue, 29 Jan 2013 11:34:31 -0800
Message-ID: <7vzjzrokag.fsf@alter.siamese.dyndns.org>
References: <20130129190844.GB1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0GxP-0007wG-7x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3A2Teg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:34:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab3A2Tee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:34:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A40BC6B7;
	Tue, 29 Jan 2013 14:34:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SodLywF9Tx4po7ZtCcM+TqOaXvM=; b=FUTNbU
	JdpNFbHjs0P304a6XWY9/XnF+a6jtLQqs2x/yk0gdl30SBzHJR6f/MoocYbvJ2HW
	MNaWzPAHcekjbwJhy7YoybdqnqgxxacfHCBNPTINqZ4QRnUssCNpZ1z2ozu6TiHL
	iPsSwVSJ9n7N+OFyDtUmsjxaZazMgNhxWf/vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ui/swB8oCzMnS3EwtAbUhC5rgaGvvo4X
	jBlSo6tIw326PaS9EgA8tob3QKwD6oKT3r6DfLcffUBuB/AcMpVoBw6oiet/oIpt
	jPUL85CGOoovFqf415Va0dYrw+ATKD0VAS6fr0kyJ+1gIQBwAnhawdMqIvon/Lkw
	4y5iWdDwsmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1043EC6B6;
	Tue, 29 Jan 2013 14:34:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81755C6B5; Tue, 29 Jan 2013
 14:34:33 -0500 (EST)
In-Reply-To: <20130129190844.GB1342@serenity.lan> (John Keeping's message of
 "Tue, 29 Jan 2013 19:08:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8802664-6A4A-11E2-9506-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214962>

John Keeping <john@keeping.me.uk> writes:

> Changes since v1:
>
> - Set 3.1 as the minimum Python 3 version
>
> - Remove the section on Unicode literals - it just adds confusion and
>   doesn't apply to the current code; we can deal with any issues if they
>   ever arise.
> ...
> + - We use the 'b' prefix for bytes literals.  Note that even though
> +   the Python documentation for version 2.6 does not mention this
> +   prefix it is supported since version 2.6.0.

Do we still need to single out the 'b' prefix?  Even if it were
necessary, I'd like to see it toned down a bit to make it clear that
most of the time you can write strings as strings without having to
worry about the "is it unicode string or a string string" mess.
Like

    - When you must make distinction between Unicode literals and
      byte string literals, it is OK to use 'b' prefix.  Even though
      ...

perhaps?
