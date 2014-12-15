From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Add a flag to push atomically
Date: Mon, 15 Dec 2014 14:33:57 -0800
Message-ID: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0eDN-0007Zk-BX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 23:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbaLOWeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 17:34:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796AbaLOWeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 17:34:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D06527991;
	Mon, 15 Dec 2014 17:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/aW/z/skcjEENOXUv4NdvW3xAcY=; b=PjGplm
	HDX9m8CxgrAtFiL/gsfoMkhfqM/0WW2vmEH6+jkndn67pVP4UkBZOc123quW8sNZ
	Rcej+tS40ogDbyJQL+JelhU+ZRHC+v2jZh/0ViL6BZhW91nBxZKumxHVchlFdEjp
	jOAhw68O5vRo9PMZpJxyLOQt25rguRpkY0Rn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mqm6ghK5ukqEmMYgrx6n418k2ypvAQWf
	jtyoa3avijW8N4XaC9eSQoTkJK5EwVOoD00K2Xx2WBI4MM1kqLYUhwtkfPkGJlB3
	owyQZTuu1yUZVutWy8Jod2Lfdh1rTeVVNCfdwL+4HeXPImvb+4kwOLHAag96Ndrt
	98U4w+Obh3I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 742B427990;
	Mon, 15 Dec 2014 17:33:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00EBA2798F;
	Mon, 15 Dec 2014 17:33:58 -0500 (EST)
In-Reply-To: <1418673368-20785-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7630D3D4-84AA-11E4-A765-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261431>

Stefan Beller <sbeller@google.com> writes:

> This patch series adds a flag to git push to update the remote refs atomically.
>
> It was part of a longer patch series[1].
> This series applies on top of origin/mh/reflog-expire
> It can also be found at [2].
>
> Change since picking the series up from Ronnie.
>   * other anchor point (i.e. where the series applies)
>   * more tests for this feature, specially testing failures
>   * drop the patch to rename ref_transaction_* to transaction_*_ref
>   * slight rewording of the additional documentation
>
> [1] http://www.spinics.net/lists/git/msg241214.html
> [2] https://github.com/stefanbeller/git/tree/atomic-push-v1
>
> Ronnie Sahlberg (4):
>   receive-pack.c: add protocol support to negotiate atomic-push
>   send-pack.c: add an --atomic-push command line argument
>   receive-pack.c: use a single transaction when atomic-push is
>     negotiated
>   push.c: add an --atomic-push argument
>
> Stefan Beller (1):
>   t5543-atomic-push.sh: add basic tests for atomic pushes

Thanks.  I think I like where it is going.
