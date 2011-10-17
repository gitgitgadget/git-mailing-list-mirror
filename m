From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use test number as port number
Date: Mon, 17 Oct 2011 13:57:00 -0700
Message-ID: <7vobxfl4kj.fsf@alter.siamese.dyndns.org>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20111017020103.GA18536@sigill.intra.peff.net> <20111017195547.GB29479@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 17 22:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFuFA-0007RP-MB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab1JQU5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 16:57:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab1JQU5C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 16:57:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA25E4A80;
	Mon, 17 Oct 2011 16:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ov9Vhbno6svJKf4lW5aomnq7CE=; b=jtJYXT
	m8zcTaRif1bQR17RB3hQyEnu1NMf+PIH29TrUrcBcB8Hqf0ukcrlYrxrm6bYvpfJ
	xiyzIQWlVbZFeKW8AuGDeQQ61dLwX3o/ydo8TQj/DpBRSyK46V42ZU9yIJ33teGw
	NDiyIeD2uQWZhWQ6R0u2sevIWbLxtraKk6GF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsXEXrKfTxQbYYm7W+tmJhLI9+CSz31z
	X5qgDywkuiyAHC+rSpmKO/vax/8VPY/ZlUE3PPvdHz46mfpENvSCPCGCsCZhPgSP
	qGXTO+jOHBiA5wUawm+VgSu4HCT/7AyxzmiRh3sz62G21o/xbwj+9FsXSN379XT+
	AS5lnvp2i8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1C704A7F;
	Mon, 17 Oct 2011 16:57:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C4D14A7D; Mon, 17 Oct 2011
 16:57:01 -0400 (EDT)
In-Reply-To: <20111017195547.GB29479@ecki> (Clemens Buchacher's message of
 "Mon, 17 Oct 2011 21:55:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F89D268-F902-11E0-BDE7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183822>

Clemens Buchacher <drizzd@aon.at> writes:

> Test 5550 was apparently using the default port number by mistake.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>
> On Sun, Oct 16, 2011 at 10:01:03PM -0400, Jeff King wrote:
>> 
>> LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'5570'}
>
> Thanks, I missed that.
>
> Clemens
>
>  t/t5550-http-fetch.sh |    2 +-
>  t/t5570-git-daemon.sh |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
> index a1883ca..8a77750 100755
> --- a/t/t5550-http-fetch.sh
> +++ b/t/t5550-http-fetch.sh
> @@ -8,8 +8,8 @@ if test -n "$NO_CURL"; then
>  	test_done
>  fi
>  
> -. "$TEST_DIRECTORY"/lib-httpd.sh
>  LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
> +. "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd

Good eyes. This is the only one in the 55xx series that gets the order
wrong.

I'll drop the patch to 5570 for now as that should be done in the change
that is still not in 'next' that adds 5570.

I've fixed and queued the previous one as aa0b028 (daemon: add tests,
2011-10-17); does that look good enough?

> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index e6482eb..a92d996 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -3,6 +3,7 @@
>  test_description='test fetching over git protocol'
>  . ./test-lib.sh
>  
> +LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'5570'}
>  . "$TEST_DIRECTORY"/lib-daemon.sh
>  start_daemon
