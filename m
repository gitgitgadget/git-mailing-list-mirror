From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 05 Feb 2012 19:13:50 -0800
Message-ID: <7v39aobqmp.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
 <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
 <20120206030339.GA29123@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 04:13:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuF1h-0001Mz-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 04:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab2BFDNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 22:13:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2BFDNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 22:13:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 545366BA1;
	Sun,  5 Feb 2012 22:13:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ATxUDEO4Ljg/VI3Q3vPl4BpW/tE=; b=w615TF
	7BzmIx4Uj4FQ9I7QT56B1sqZDJk0ZC3Cm1iEkJbZoP50wtlIv/D2+JwH4eNgwJxn
	NErt+hwIA9JJPV6T/VqnCrXof0IXIs5bok4JJb2Dx8aSMpon3OEEoUa9WTab1eJM
	AgbFUuiKTGQ37ewOD+VDcUoD2YvLOLrYMLPg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZfwDMVvEe4sRJ0pEjD5VfuxwL0on2x2Y
	U43Y7bfCM3t0NkTo1FZWLpRpn1KjnQ1MjRN1WgZSH/TjRSXRdvaAgXr0PBF1vMlb
	EAXdXHWZRF8q4/Uc/iKFZyFxX8RlLs2A8mP5tY0h6QEwAMf21G4j8RwAl8mKTpvc
	r2PjF2+5ijw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA766BA0;
	Sun,  5 Feb 2012 22:13:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE7616B9F; Sun,  5 Feb 2012
 22:13:51 -0500 (EST)
In-Reply-To: <20120206030339.GA29123@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 5 Feb 2012 22:03:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 983DCCD2-5070-11E1-83D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190002>

Jeff King <peff@peff.net> writes:

>> It might be a worthwhile thing to do. I dunno; I didn't look into it.
>
> Ugh, yeah. I was thinking about how it would improve this call site, but
> I don't want to get into auditing the others.

There aren't that many, though.  shortlog has one, pretty has another and
that is about it.

But both seems to care that map_user() is not a function that returns void,
so...
