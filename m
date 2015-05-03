From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Sat, 02 May 2015 19:15:08 -0700
Message-ID: <xmqqpp6iwgnn.fsf@gitster.dls.corp.google.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
	<1430519737-6224-1-git-send-email-sbeller@google.com>
	<20150501224334.GB1179@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 03 04:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojR6-0006WA-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbbECCPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:15:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255AbbECCPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:15:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 251C14E8A2;
	Sat,  2 May 2015 22:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kMGnKWPBBjkTj8+sQyDrUl4hv+k=; b=UtFiYk
	m3Jp/Tybe6t24FCJ674nznGd5M8rHPbuuQ/Tin0fwG98YMzpHjzQKs8nBjcTultR
	E6f/Qhkm60jz6jXcWKhmcM6O2Ka1bvtTDytWQYzT9i7wAoUKyAA9as4YaDh5kpr9
	jPPEUgsQBgkVfu5hR9WYurcCFMfSUeFMEw31M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSqV7Oxoe44uYp6xKndPAT3lY4AaRe2k
	CP9DqkMYhPpAErFxPwMwKCSjUaBlH+IimV5+NQvwJupMDDk0Bv9BKMuyIoIIJVMz
	kxI0tFeGogIwe0HRiZFvGdmiwD4xvtAxApwPHPKZVJoKeO0fXaxVMMJopj89ecAh
	ZaFbAqdGRoY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 110EB4E8A1;
	Sat,  2 May 2015 22:15:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80AF14E8A0;
	Sat,  2 May 2015 22:15:09 -0400 (EDT)
In-Reply-To: <20150501224334.GB1179@peff.net> (Jeff King's message of "Fri, 1
	May 2015 18:43:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 390C193A-F13A-11E4-8B28-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268250>

Jeff King <peff@peff.net> writes:

> On Fri, May 01, 2015 at 03:35:37PM -0700, Stefan Beller wrote:
>
>> Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
>
> Looks like the patch has expanded beyond checkout-index.c. Maybe:
>
>   unconditionally free result of prefix_path
>
> would be more descriptive? I usually like the "area:" prefix, but I
> think here the common thread is not an area, but that they are return
> values from prefix_path.

Sure, the prefix could even be "prefix_path(): $message", I would
think.
