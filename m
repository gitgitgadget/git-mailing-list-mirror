From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Thu, 21 Nov 2013 14:23:17 -0800
Message-ID: <xmqqsiup2y3u.fsf@gitster.dls.corp.google.com>
References: <528D385F.2070906@web.de>
	<xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
	<528E7A6E.8080603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 21 23:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjcek-0000IN-A4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab3KUWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 17:23:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab3KUWXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 17:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 746FD520FC;
	Thu, 21 Nov 2013 17:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IuY5eilp0+SAGuDwgNpMkds87x0=; b=ZybkIW
	JnmNE8XYzA58rIYLX5IrGxodFg+yBfU9zyodAze5IBMwIYnbC6Pb/MgFyZ5E6y5k
	ezlzDZDJ3MUMOfnwZhDJM89o+azhzxTHhMyGyXAsYWwAXp5UxV9kUP103oUInB7n
	TP2KLXKq1UXUQ5jpTXlgd5C3Dk5lZauYDfzOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QOhFL/m3olEIU1TMUj+MNVXI4Pn3vk0T
	c5Gpbcif2ELEUfjB2JcQRK1LDV0qK+1ojuryMM95++vdDGG488FKK5bqJ7PXlBMo
	d1Tbvb2iIebP7M7Uhcqy/Be4GQngnM+3+NglLeFFRkWtOA1A6Vo+DIOr5l7Xftff
	ZnnWWbzbzhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 602F3520FB;
	Thu, 21 Nov 2013 17:23:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85604520F8;
	Thu, 21 Nov 2013 17:23:20 -0500 (EST)
In-Reply-To: <528E7A6E.8080603@web.de> (Jens Lehmann's message of "Thu, 21 Nov
	2013 22:26:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86F2A59E-52FB-11E3-85AC-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238159>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> But what about this:
>
> 	struct strbuf cut_line = STRBUF_INIT;
> 	strbuf_addf(&cut_line, "%c %s", comment_line_char, wt_status_cut_line);
> 	p = strstr(buf->buf, cut_line.buf);
> 	if (p && (p == buf->buf || p[-1] == '\n'))
> 		strbuf_setlen(buf, p - buf->buf);
> 	strbuf_release(&cut_line);
>
> That is shorter can easily be adapted to a comment line string later.

Sure, that would work fine.

Thanks.
