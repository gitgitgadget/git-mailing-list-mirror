From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: quell the progress report from init and report on
 clone
Date: Fri, 02 Apr 2010 00:28:36 -0700
Message-ID: <7vljd6l3dn.fsf@alter.siamese.dyndns.org>
References: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
 <4462210481812dc3b720b34f59e3051a65e41336.1270159202.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:28:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbJG-0008A6-Eh
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab0DBH2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:28:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab0DBH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA71A7C64;
	Fri,  2 Apr 2010 03:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49HTuPBDYzt5g872FgGHWDiBP6o=; b=OJgnB6
	V1bAG0Y7hb279DPSglE8RvNmWPvW3zKEwly6lM9AaRXc1yPMweSs3LssoMjhknIu
	DJG8i1ONoq+NMekOnyryigSZHpLU5hpAjvfO7olt2EhrDWaKFR/1eAZq+UmjC9j6
	vHIFtgeMOsieiSfANBFuoAZEOzv6IA5uZgkgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=isYc7heh4AzccQh0zyWk8s7/nEU3GvD3
	uaNN3d55j2MQYZL6UoPrqXxa+faPESdnl63c6XfNbk8QyC8lA0YD/3LDY/iuM5G1
	TFWAyKQ8ZDD71rnyU2KYxapSn5IEO0+2XydEdBXBNOVu9FQwgH5AbYR7PQbgNm9b
	g3sJgPzJTrE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 755FFA7C63;
	Fri,  2 Apr 2010 03:28:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9F2AA7C5E; Fri,  2 Apr
 2010 03:28:37 -0400 (EDT)
In-Reply-To: <4462210481812dc3b720b34f59e3051a65e41336.1270159202.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\,  2 Apr 2010 00\:03\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CB78848-3E29-11DF-BE11-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143786>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Currently, a local glit clone reports only initializing an empty
> git dir, which is potentially confusing.

glit?

> Instead, report that cloning is in progress and when it is done
> (unless -q) is given, and suppres the init report (unless -v
> is given).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I checked the documentation, there is really no place where the output
> of git clone is documented - no documentation or test change is necesessary.

Thanks.

> I made it so that -v will restore the init message.

I wonder how that would be useful, though.  The new message already says
which directory is being worked on.  I didn't see a point of repeating
that and made it silent on purpose.
