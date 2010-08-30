From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin/merge_recursive.c: Add an usage string and
 make use of it.
Date: Sun, 29 Aug 2010 23:04:42 -0700
Message-ID: <7vk4n8hc05.fsf@alter.siamese.dyndns.org>
References: <20100830024259.GC4010@burratino>
 <b58adc6cdfd6a5753fac1dde3371b3745b1f58b1.1283138840.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 08:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpxUw-0000oW-GF
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 08:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0H3GFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 02:05:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab0H3GEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 02:04:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E4B5D1040;
	Mon, 30 Aug 2010 02:04:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QzoPmA2GCYNafIv0toa/CZpXDT8=; b=aGiE+d
	Fa3qi3jLxmtUW2bYny+wk6GLgIP3YGGjtHFn+SI/dYjAEHDtyTveUO+x4KRG6yH9
	r0/9lACjBYRlHSHHXg051ulVFNleC6CgPvhdCXguu9v8pRJfHoX/LBCmD+HiHjH3
	a9uBNitzESkze2C2K0MhIwkQeEYcujDHgCTSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QRFoUwKV3245uVP467sNH3CqkqVxeuKO
	5T3z4rGYBAIjM6C6vbJ82CD5Z0e6oeQlP090tS1I8jlx8eBSqqlCHQ02+TgT05NA
	Rbl9ckPlB8oD8LBlOanzDA2Pu8Bcojg+t4lupzuhosBujhiGW+rabDDcKZDdJ8YK
	Gnd4i0PJPAU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4FB6D103F;
	Mon, 30 Aug 2010 02:04:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0A63D103B; Mon, 30 Aug
 2010 02:04:43 -0400 (EDT)
In-Reply-To: <b58adc6cdfd6a5753fac1dde3371b3745b1f58b1.1283138840.git.tfransosi@gmail.com>
 (Thiago Farina's message of "Mon\, 30 Aug 2010 00\:30\:22 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F02F114-B3FC-11DF-A9DC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154768>

Thiago Farina <tfransosi@gmail.com> writes:

> Since cmd_merge_recursive is used to handle four different commands we need
> the %s in the usage string, so the following example:
>
> $ git merge-subtree -h
>
> Will output:
> usage: git merge-subtree <base>... -- <head> <remote> ...
>
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>

Hmm, why isn't this a single liner

> -		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
> +		usagef("git %s <base>... -- <head> <remote> ...", argv[0]);
