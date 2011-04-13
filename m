From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/format-patch: summarize patch-sending
 workflow
Date: Wed, 13 Apr 2011 15:38:38 -0700
Message-ID: <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8iF-00011L-AV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758443Ab1DMWi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 18:38:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652Ab1DMWi5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 18:38:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5117643EB;
	Wed, 13 Apr 2011 18:40:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M5pUoSBxCNee
	OdOumBUMJGROKko=; b=Obz7NQ2Kgc7gCUBLieydIRaKbMsPEWrzOUQUeRb8qQcR
	5+iZyo+5OAeLoWsz7QBfwj1NeGnwz84Yk8N5t03CLUheW7XlroyMmkXRGxLPD2j/
	o2xCZJCr+DiWBs0on1izfFip8F5jIy1PZmvSr/KlrANg09+TQSgNsGOPmDJrv2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JquEjr
	0OaAN4nraPjzyWOkJ9sxN4SuS1cInVX96r2cqxmcvlC2SgRFo+IyghsbTCOX5ayT
	9odCLL5bfyGiCELcVyvFMjIBaml04svdZVVhXwoTazT5uA8TWl9EUDeKq+TRbqoH
	kLss5Mc/bILe+uAbxnIOTcDNY8yzfegcQTHMw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E212A43E5;
	Wed, 13 Apr 2011 18:40:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0CEA43E2; Wed, 13 Apr 2011
 18:40:39 -0400 (EDT)
In-Reply-To: <20110413221736.GA773@elie> (Jonathan Nieder's message of "Wed,
 13 Apr 2011 17:17:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1382C4C0-661F-11E0-A926-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171495>

Jonathan Nieder <jrnieder@gmail.com> writes:

> + ...
> +'git am --scissors' accepts an alternative format with the patch
> +inline in the message:
> +
> +------------
> +...
> +> So we should do such-and-such.
> +
> +Makes sense to me.  How about this patch?
> +
> +-- 8< --
> +From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> +Subject: Makefile: extract Q_() source strings as ngettext()
> +
> +The patch adding the Q_() wrapper function around ngettext[1] didn't
> +....
> +------------

It still is preferred to remove the magic "From xxxx Mon Sep 17 00:00:0=
0
2001" we placed to help somebody who is inclined to write an /etc/magic
entry to detect files of format-patch output type if you use the scisso=
rs
format.

One thing that we probably would want to clarify is use of the "From:" =
and
the "Subject:" fields after the scissors in such a context.

"How about this patch?" is most likely to be written by the same person=
 as
the message is coming from, so I think you would rarely need a "From:"
after the scissors.  On the other hand, in such a message, you would co=
me
up with a potential solution to a problem raised in a discussion, and t=
he
original subject would likely to be about a description of the problem =
or
a request for help, while the patch title would be about the solution, =
so
it is very likely that you would want to have a "Subject:" line after t=
he
scissors.

Scissors can run in either direction; I am right handed and tend to wri=
te
them as "-- >8 --", but your example is for a left handed person.  Eith=
er
is fine.

Other than that, looks good to me.
