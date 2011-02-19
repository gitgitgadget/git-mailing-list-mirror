From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 16:31:45 -0800
Message-ID: <7v39nkooem.fsf@alter.siamese.dyndns.org>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <4D5F0A7C.1080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqak9-0003JB-Hw
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab1BSAcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:32:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1BSAcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:32:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37729358F;
	Fri, 18 Feb 2011 19:33:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vH99yB0w2C9DgoupzwjnnvuRh8o=; b=MpXlV7
	j3j5cxQJAW33BlBGb75Lj3rLGH7Xdetv+sdSiVYxGA5YqRqbFMGl2TZIySPvG6R2
	K1T+OIAZpqu79dJrF+aqdTha380aKLP4BXtlIrXBjKVh+LHYBYN7LvGVMb23uxzk
	QBGRvzRdhhxrUwK5hNpqx+7FlASl2lCoROQ8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SN7cIctR9NzBTgZg+6+fTiLnBg7/0xoS
	6NiVTcbU+FlFqNBpYzxShVnP7GxazaCZTIzz2Tzyl4DJ09hYwUhgl/0hojBkXEAx
	n+HqUn8LeSqRRqq0kmU1UDsI+llwyjBHKRVi5J8ttzm+/j7KoWVmOkyTGKswHAAa
	f5tpPDi8GZI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C90953589;
	Fri, 18 Feb 2011 19:33:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0ECDE3588; Fri, 18 Feb 2011
 19:32:55 -0500 (EST)
In-Reply-To: <4D5F0A7C.1080507@gmail.com> (Piotr Krukowiecki's message of
 "Sat\, 19 Feb 2011 01\:10\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D022808C-3BBF-11E0-893C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167237>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> My suggestions - put each category in their own dir/name space:
>
> - sources - developer related files you can hack 
>
> - technical/developer documentation like format descriptions, 
>   coding guidelines etc.
>
> - end user documentation like command documentation, howtos, faqs etc

Mild nak.  We are talking about a source tree; there is no end-user
documentation.  Only the sources to it.

> - build result - objects, final binaries, generated documentation etc 
>   The advantage besides unclutterting is possibility to have sources on
>   read-only medium.

This is somewhere between a meh to mild nak.  "git grep" knows to ignore
untracked cruft, so this does not help nor hinder "finding" at all. Even
though I personally tend to value seeing frotz.o sitting immediately next
to frotz.c, some people may value read-only source tree more than that.
