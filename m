From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] refs.c: rename the transaction functions
Date: Thu, 11 Dec 2014 13:42:23 -0800
Message-ID: <xmqqbnn9eudc.fsf@gitster.dls.corp.google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
	<1417833995-25687-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBVM-0004h5-21
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 22:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965554AbaLKVmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 16:42:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965032AbaLKVma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 16:42:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F122245FE;
	Thu, 11 Dec 2014 16:42:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55vJ4vmq0a5oo2bhHomjS67DrSM=; b=JuYw49
	aIia68n9DTMrHcUKY0E3eZZ0tgihMaewG5leo5rCj0hU1l5e2fGSuHGjL0L1qe/m
	Lcoike8IB9MYz8NRdB3dZHELNTWFEzhQ58mjBmpa2efI2/yqk+eVHkP2qhjIEKxc
	nfYAnOw4GAoJtmWJ64UkxpveOOsZqfbI08NV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NorcJuLrgXP2t1VouFgHAGAg/b+U/aQt
	blMljEFUNdoTKTwA+Y/cZfhdMociCcQ0IG7jnCbuj6l7c5qTarYK8UjIUAKksxLQ
	B0v0Antqz9G07boWTPXG7YTmf7NXQeZEMYlxDqYHMYVYetxVDW+Y/EDoIUOYU8vO
	NHmg7JhI8P0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44503245FD;
	Thu, 11 Dec 2014 16:42:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DD60245F5;
	Thu, 11 Dec 2014 16:42:25 -0500 (EST)
In-Reply-To: <1417833995-25687-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 5 Dec 2014 18:46:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9886887C-817E-11E4-9F57-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261293>

Stefan Beller <sbeller@google.com> writes:

> Rename the transaction functions. Remove the leading ref_ from the
> names and append _ref to the names for functions that create/delete/
> update sha1 refs.
>
> The goal in the long term is to have different things running through
> the transaction api, such as the .git/config file.
>
> The dream is to...

I was trying to polish somebody else's topic that does not have
anythning to do with refs/reflogs/transactions today, and had to
suffer from conflicts from the textual difference between
transaction_begin and ref_transaction_begin, which I feel is totally
unnecessary at this moment.

I'd really prefer to see this done long after all the dust from
"ref" changes from various people have settled, especially given
that we are not doing anything for that "dream" right now.

Thanks.
