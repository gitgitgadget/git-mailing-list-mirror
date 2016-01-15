From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] shortlog fixes and optimizations
Date: Fri, 15 Jan 2016 14:11:18 -0800
Message-ID: <xmqqpox2fq7t.fsf@gitster.mtv.corp.google.com>
References: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKCab-0005g8-R4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 23:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbcAOWLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 17:11:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751825AbcAOWLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 17:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 645FC3B776;
	Fri, 15 Jan 2016 17:11:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/BoFerMXwS7uThczTf0bq3PB4+0=; b=DipCRR
	zG32WR0OS4g0dC601h3sFkllgQt6FqcQEw+63TTRLnXqvsxzFkynuiFxCn242Y2x
	EZXWh3+Ccup0y7hyh2nCqaBH0s4yrLJCbyB8NMA0d/9LE6PspniML40zEdTSL45H
	AluAt8GMgSnKZbl2vNTZMjc70TSA1NxB7j6w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gnB3leR7xVi9lznH9FHNRxtBU/ZRswTH
	X7yg4OYJKouK9S3OxsLJtVTYq+KmuNPKd7AyMU5biGUd8Em5L2c0LwXob3F4QEg1
	saQLHxARnd8giNuZGs0dX/IPlt5LPNYn/l/f7LL2AG+i9+rAGOSTf/wgWG7oiypG
	sJ0ZjWBCN0U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 554153B775;
	Fri, 15 Jan 2016 17:11:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C51013B771;
	Fri, 15 Jan 2016 17:11:19 -0500 (EST)
In-Reply-To: <20160115170627.GA20983@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jan 2016 12:06:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7A105D6-BBD4-11E5-AD19-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284224>

Jeff King <peff@peff.net> writes:

> These are split out from my the shortlog-trailer series I sent a few
> weeks ago. The "trailer" parts still need some re-working, but there is
> no need to hold these fixes hostage.
>
> I also dropped the early part of the series, adding skip_prefix_icase().
> After digging into the history, I ended up reworking the first patch
> here to do a more thorough parse, so we don't need it anymore.
>
> Thanks to Eric Sunshine for review on the first iteration; this
> incorporates his comments.
>
>   [1/6]: shortlog: match both "Author:" and "author" on stdin
>   [2/6]: shortlog: use strbufs to read from stdin
>   [3/6]: shortlog: replace hand-parsing of author with pretty-printer
>   [4/6]: shortlog: optimize "--summary" mode
>   [5/6]: shortlog: optimize out useless "<none>" normalization
>   [6/6]: shortlog: optimize out useless string list
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/283091

Thanks for resurrecting these patches.  They all look good.

[PATCH 2/6] is a bit unfortunate timing-wise, but I think we can
manage ;-).
