From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'simple' push check that branch name matches does not work if push.default is unset (and hence implicitly simple)
Date: Sun, 30 Nov 2014 18:21:20 -0800
Message-ID: <xmqqmw78rty7.fsf@gitster.dls.corp.google.com>
References: <1417040968.12457.78.camel@redhat.com>
	<20141127034306.GA5341@peff.net> <1417108347.18654.4.camel@redhat.com>
	<20141128045518.GB19456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Williamson <awilliam@redhat.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 03:21:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvGcF-0001Og-MK
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 03:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbaLACV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 21:21:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752526AbaLACVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 21:21:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B671A234A2;
	Sun, 30 Nov 2014 21:21:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVpq99+EX27PyyOfc8dyBA6EFpA=; b=oPw1nx
	HNnQUb6rjkTubF+vmdc5pfKCfOBzBhEX9t51pHrUIIWwJ+A14u72taWGWw7ZsizO
	PIb1ltS8YZ8ZWyGIENzKA3JpHSUzzz0Xayz7EERONFoJfOB+vb4siUQsTEE+hsCt
	0jCx6IqjRSJ5oEbnpa6cRwFfkfPKGHXuksrow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJmP/B8SXctsFhzYn2wkHDNEAakRv6ps
	MLc73iW22JYbn7qLssdfR3l/DJsBO7B8Pg/xgTWlDBYWaZp0ZSdLDCpC38YfRXKm
	DWO7xC3AR1xByi5DgNwIZbLIMAfozLlg/v6F1oBxokAIZWZphwpAcoi0V9nQA2zv
	dy/onIlEqdA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC3C8234A1;
	Sun, 30 Nov 2014 21:21:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AAD0234A0;
	Sun, 30 Nov 2014 21:21:22 -0500 (EST)
In-Reply-To: <20141128045518.GB19456@peff.net> (Jeff King's message of "Thu,
	27 Nov 2014 23:55:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDF52374-7900-11E4-97DB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260460>

Jeff King <peff@peff.net> writes:

> There is some other magic with "simple", too, around triangular
> workflows. Describing it in detail would probably be too verbose in this
> message, but we do refer to the description of push.default, which is
> probably enough.  Technically this new bit you are adding here is
> covered there, too. But since we can improve the description by adding
> such a small amount of text in this case, it seems like a reasonable
> tradeoff.
>
> I suppose we could also customize the message based on the triangular
> and non-triangular cases. I dunno.

Yeah, I vaguely recall suggesting to polish advice message further
to help users along a similar line, but probably that fell in the
cracks.

Thanks for a quick fix.
