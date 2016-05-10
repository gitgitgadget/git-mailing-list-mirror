From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] modernize t1500
Date: Mon, 09 May 2016 23:07:32 -0700
Message-ID: <xmqqfutqsaxn.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:07:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b00pY-0004Jl-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbcEJGHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:07:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750950AbcEJGHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:07:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A9F6E62A;
	Tue, 10 May 2016 02:07:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oBgYT02PwEOync4otY8x2SIbB9c=; b=V6hrLz
	1qqQPNL8GnegI+l4Esbeig13hDDDfbYsiBRWQblzVlI0K4pyovkYrMJe1yHkjMei
	ZuTDNYI0d/AEA6VPzm6INjXYcBOzpx9d4fjInx2KvEGhe4yMbn+Dm9VCx7Rymq1s
	yaWAHOq360PCht0kBr1NiStRI3gMR+S4bgFqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vf/TFgcOMRNL6BmtpYt4jOQcTX2z/qw7
	iR3pGERfRPdsT2FgrOx0p0vMcRQ/4wIkO35VEBIq4SBqLJMuxxT5FdMpXkrqIZMI
	Mt0H10XcH6s5U/myTE3yHJMurwBU5R9pB4w+nXUNswxbWDSvnw8RA/jYtTHfIbYp
	lYFRQDszalg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78DF8E629;
	Tue, 10 May 2016 02:07:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8D90E628;
	Tue, 10 May 2016 02:07:33 -0400 (EDT)
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com> (Eric Sunshine's
	message of "Tue, 10 May 2016 01:20:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C93CBE2-1675-11E6-911F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294098>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This series modernizes t1500; it takes an entirely different approach
> than [1][2] and is intended to replace that series.

Turns out that it wasn't so painful after all.

The only small niggle I have is on 6/6; my preference would be,
because once we set up .git we do not add objects and refs to it, to
make a copy a lot earlier before the tests start.

I'll let it simmer on the list overnight and take a fresh look in
the morning, but I think I like these better than what I had to
tweak yesterday.
