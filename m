From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 20 Jun 2012 10:55:48 -0700
Message-ID: <7vehp9x3yz.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShP8F-00029W-Se
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab2FTRzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab2FTRzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:55:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D408B80CF;
	Wed, 20 Jun 2012 13:55:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EQ1h+oeBr/wQgxiQ2aWkvJtB6w=; b=TCr0uP
	QkOTc1K+d020zJzKVizVqzf06fJX5fk+YFeWIJ09puCSm9EQI3DfojmArGZ0VDnL
	+YBsG9lQw5H0gVWGUwn1aHg6QRu6yiRt1BPaLiXx12WTONVwAXPvYJmdDH/9r9bO
	XARp32jgOA2Nq9O76vNco76n6m/ZKSj0ks2dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AM6bZEVCiA9uwDcjvT9RFMgFHkwrw3MG
	lXkrgry8htWmScj+OZ19mH1UIpqlVqr6GoQho0pZlvmzrJEd5Aa6R12HlDx6rR5z
	I/OxEPmsgJFERxP5LHGjp3d5RC1LZ87bf2QnMnvZx0EPGo2/QcOl9uXZkUkj1vm9
	7AoEqCuXJ3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C958E80CD;
	Wed, 20 Jun 2012 13:55:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F71880CB; Wed, 20 Jun 2012
 13:55:50 -0400 (EDT)
In-Reply-To: <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
 Moy's message of "Wed, 20 Jun 2012 14:35:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BCD0026-BB01-11E1-A9B9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200309>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> In preparation for flipping the default to the "simple" mode from
> the "matching" mode that is the historical default, start warning
> users when they rely on unconfigured "git push" to default to the
> "matching" mode.
>
> Also, advertise for 'simple' where 'current' and 'upstream' are advised.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>> * mm/push-default-switch-warning (2012-06-06) 1 commit
>>  - push: start warning upcoming default change for push.default
>> 
>> Will merge to 'next'.
>> 
>> Hopwefully we can have a solidly tested series early in 1.7.12 or
>> 1.7.13 at the latest.
>
> I've made a slightly modified version of the patch which adds these
> two lines:
>
> +   "(the 'simple' mode was introduced in Git 1.7.11. Use 'current' instead if\n"
> +   "you sometimes use older versions of Git)");

I am not sure who this wants to help.  For people who want to
anticipate the future, using anything but 'simple' is not living in
the future and waiting for an additional pain coming from the
differences between current and simple.  If current and simple are
similar enough that their differences do not matter, why wait for
simple to be available everywhere and switch the default to it,
instead of using current as the default in the first place?

So if anything, I'd prefer the above message without "Use 'current'
instead" bit.
