From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] tests: Allow customization of how say_color() prints
Date: Mon, 17 Dec 2012 17:42:30 -0800
Message-ID: <7v38z4jfuh.fsf@alter.siamese.dyndns.org>
References: <50CCCB86.5080701@ramsay1.demon.co.uk>
 <7vobhuqzdc.fsf@alter.siamese.dyndns.org>
 <50CF9D4C.9080706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkmCo-0003Ib-66
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2LRBmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 20:42:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab2LRBmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 20:42:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BC4AA94E;
	Mon, 17 Dec 2012 20:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTHw0xOhAbWpXBaOO7SCu6QlsI0=; b=BXDhfA
	7cOg00BBCTR7WAA71vDB5iWnxC4+jeqPlx4eQc7HAacaE4oFB+iZJgOODYTewN98
	HU1hp4/LwOwqtJup7HeYamm+6GBG7r32D5ndw+ljzFb5SmvCLe8By4OPfCV61Q+a
	2IBpvOQH5PF8TnFHUmmElZRDfMNYR2yMZFJ20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xpFsB6WC0zqQ1z5N9xxNBoQXx5gn6V0w
	gNWrMtYDhH2DJP/q0yCB1L8yJnPS2TGX8gKirQfV0nMqLy8wE3WfnXh9J9AvReBl
	7fgUsafG4eAAQ0yJqJ00bHzii6LX1pLtyoC6JktC2FxQyZzsdM6htr2s/venifx7
	mEMpTEXbgFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480F8A94D;
	Mon, 17 Dec 2012 20:42:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1B4AA94B; Mon, 17 Dec 2012
 20:42:31 -0500 (EST)
In-Reply-To: <50CF9D4C.9080706@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon, 17 Dec 2012 22:31:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 305E988E-48B4-11E2-AE65-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211728>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
> ...
>> Why does your printf die in the first place???
>
> I really don't know. ...
>
> Sorry for wasting your time.

Not a waste. I was hoping somebody (not necessarily you) may be able
to come up with a cleaner solution.  Unfortunately it hasn't
happened (yet), but discussing issues on the list is often not a
waste.

We could introduce git_test_print and git_test_println shell
functions that default to the current "printf", and let the users
override these by including a custom scriptllet from t/test-lib.sh,
or something.
