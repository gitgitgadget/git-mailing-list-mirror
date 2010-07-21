From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix rebase with file move when diff.renames = copies
Date: Wed, 21 Jul 2010 14:54:18 -0700
Message-ID: <7vpqygijqt.fsf@alter.siamese.dyndns.org>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhFM-0003LD-TB
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747Ab0GUVya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 17:54:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832Ab0GUVy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 17:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2708EC6E8A;
	Wed, 21 Jul 2010 17:54:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZI0kh2squOVfGTeYa0BZx/J1Vw=; b=p6Fq+L
	iqsjgtDhrij6IXfXN32yCp1gS1PkpEfoRQkd+eQqDvPVo2O3Ng1MARZh7LmHxJxH
	ILwXx2ATbQ5hiWy4HoB74V4PopAgdYPG/lAS/0Xvvnhf2nBUHz8OggZBKQ6KLBqf
	Ct382o6XtngSccmIG/vOMQNoeZdQ0J+utW4qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQ/1NriIMXJUDxd6MOrsZ0MGw2Xln+A0
	OexONIORdaGblxO3EqJuKxWc0Ba06nLU7rH6mrlnsMrLI6dFMFQsVB0cKrqvdRDz
	gGX6RisrWEP/No1G0Kducu9k6o/36DL60x6yQsPzH1Mf5c3v9Rp6gPvfwzvhue1s
	pTozhVadLyA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A04C6E85;
	Wed, 21 Jul 2010 17:54:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DBAAC6E84; Wed, 21 Jul
 2010 17:54:20 -0400 (EDT)
In-Reply-To: <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net> (David
 D. Kilzer's message of "Wed\, 21 Jul 2010 12\:58\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 86DB245A-9512-11DF-89E0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151425>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> The bug is that git rebase does not disable diff.renames when it runs
> format-patch internally to feed into "am -3".  The fix is simply to
> include a --no-renames argument to format-patch to override any local
> diff.renames setting.
>
> Fix by Junio C Hamano.  Test case by David D. Kilzer.
>
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

Hmm, I actully do not recall doing this patch, even though I think what it
does probably makes sense.
