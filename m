From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [LHF] making t5000 "tar xf" tests more lenient
Date: Sat, 05 Jan 2013 11:43:31 -0800
Message-ID: <7vwqvrpg9o.fsf@alter.siamese.dyndns.org>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E8722B.8010408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 05 20:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrZer-00057b-FI
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 20:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab3AETne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 14:43:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab3AETnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 14:43:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 171CDB505;
	Sat,  5 Jan 2013 14:43:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LChVH8CbfWW7
	TbD9Rbr7+S2Tn7g=; b=SqsOXGpE/leG9xDJH1fmfwQI0Fart2af5b+604XU6+Tm
	SZA48QdNWwJwXSNlXBwxHyFfev9jz6WWbADZiTfYlsdIFUglyuiQpZ3SuPy4kHM7
	tqwVwkX0caeLEbJq2OozGn6Z0aBtapQjbCjQz7sCNatLfUzRq6q9IrrZkNWEKFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dpwTpm
	6E1Q6Hbu0+6i5xakdZ8rA31nuGJrA+SZ9Kp3atwKiI2yirCeEff4JbvHRwxgPEGd
	ZYL6SnPqzeEOjCAoTdwX5KHZf24JGuvZB9ILXjOI9Q5KvDaxMbKLJOnd/yj/UGjE
	j+x7fGmN1xEKfe4pdpg9uU5i8PAbgPVIQXtRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06ECCB504;
	Sat,  5 Jan 2013 14:43:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 779A2B502; Sat,  5 Jan 2013
 14:43:32 -0500 (EST)
In-Reply-To: <50E8722B.8010408@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 05 Jan 2013 19:34:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FD4D976-5770-11E2-A525-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212708>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Anyway, I don't think the pax headers are to blame here.  The patch b=
elow
> fixes the tar failures for me, but I'm not sure why.  There must be
> something special about some (not all!) directory entries with traili=
ng
> slashes after directory names.
>
> Several ZIP tests still fail, however, because NetBSD's unzip doesn't
> seem to support (our flavour of) symlinks and streamed files.

Just FYI, I found that unzip that comes with base distro and the one
you can add via pkg_add (or pkgin) are different, and the latter
seemed to behave better.
