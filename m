From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] diff --stat: use less columns for change counts
Date: Tue, 01 May 2012 07:30:14 -0700
Message-ID: <7vobq8as95.fsf@alter.siamese.dyndns.org>
References: <1335818338-3657-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	peff@peff.net, pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 16:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPE5y-0004qE-I0
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 16:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab2EAOaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 10:30:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab2EAOaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 10:30:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59DEB77A8;
	Tue,  1 May 2012 10:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=lGp98owtwtFL6PMRtlGAdQZpi
	vY=; b=JSUOais86AVOco7YAhqUSWFJ7cuK6ZrZTf9RsOssEKxckQkjFFwzCUDAQ
	ae0vZZbLz3+4QG1JabORt7IO8W5u7fy/dd5cyY0tfocjZoZ8Gqvc2KYn6swlP7Zs
	dn0HUg27sYqappYOn4VABtmk7W+eUjcRXmt/wQcLHRSIBSbf4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=jJ6NkvffJ62iM2IPEU3
	Ip4/diNagQ1EYuaN60gZfRzwQQdkjIfttTpWsWVRW6ZxXLXsTX1f9WlbzyRkCDC9
	OYYyg9IlPUvhVAndcjRiBoi6cAz1/OwYc8Atq0uPg25iPoTljuzMS6N/Ztigs8DP
	g7OO7h7Q2xdb29erw+QedyLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51F6477A7;
	Tue,  1 May 2012 10:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C917277A4; Tue,  1 May 2012
 10:30:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B4A3B7A-939A-11E1-841A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196682>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> This resend applies and tests cleanly against both current next and p=
u.

Thanks; will queue.

> old diff-stat:
>  Documentation/gitcore-tutorial.txt                 |    4 +-
>  diff.c                                             |   48 ++++++++++=
++++++----
>  t/t0023-crlf-am.sh                                 |    2 +-
>  t/t1200-tutorial.sh                                |    4 +-
>  t/t3404-rebase-interactive.sh                      |    2 +-
>  t/t3903-stash.sh                                   |    2 +-
>  t/t4012-diff-binary.sh                             |   19 ++++++++
>  ...
>
> new diff-stat:
>  Documentation/gitcore-tutorial.txt                 |  4 +-
>  diff.c                                             | 48 ++++++++++++=
+++++-----
>  t/t0023-crlf-am.sh                                 |  2 +-
>  t/t1200-tutorial.sh                                |  4 +-
>  t/t3404-rebase-interactive.sh                      |  2 +-
>  t/t3903-stash.sh                                   |  2 +-
>  t/t4012-diff-binary.sh                             | 19 +++++++++

Having said that, given the above miniscule differences, I am not reall=
y
sure if it is worth 2300+ lines worth of code churn, though.
