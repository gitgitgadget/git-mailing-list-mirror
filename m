From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not segfault when -f is used
Date: Sat, 17 Oct 2009 00:44:19 -0700
Message-ID: <7vzl7qforw.fsf@alter.siamese.dyndns.org>
References: <4AD8791A.8060500@viscovery.net>
 <1255702405-7050-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 09:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz41O-0005Rw-8p
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 09:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbZJQHo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 03:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbZJQHo0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 03:44:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZJQHoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 03:44:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 935395C17C;
	Sat, 17 Oct 2009 03:44:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=EsZMxDfi/jIYZDaBCUPJDE3tl1Y=; b=isxEMHfjozoFLmrxEamrXW9
	TkqS404vQDlX8tskdtvUc71rBtM6QUDAt0j855SoxY72lOYuO4o8BJwCQETQRzKi
	4fPGXr72im/HmElnTpWc6CCJNVySS4E8+ErNH8IbHTwkYWRUvSbL8LFd4WhtFQyR
	XaoLbUlcRK3aG1/oOiWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Goih/4H3SnkhgqSGqtW4ZzBT8K4kFZ7auZoXTyBuc6mq8Ffda
	S/U/1xiuR9ofl5IvFhaVLN7gbYMOfAvcHxp8sRSH4tozAJdPoHp0nbaImehumZMj
	6of9oPyBug1Kh0Um4Y0RtiGjWFCIMX+tWV4z2WaKjYWdxeXnZ5Hmz3BoCA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B42B5C178;
	Sat, 17 Oct 2009 03:44:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA14C5C177; Sat, 17 Oct
 2009 03:44:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4F8F690-BAF0-11DE-B402-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130548>

Matt Kraai <kraai@ftbfs.org> writes:

> "git grep" would segfault if its -f option was used because it would
> try to use an uninitialized strbuf, so initialize the strbuf.
>
> Thanks to Johannes Sixt <j.sixt@viscovery.net> for the help with the
> test cases.
>
> Signed-off-by: Matt Kraai <kraai@ftbfs.org>

Thanks, both of you.
