From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 11 Mar 2014 12:32:37 -0700
Message-ID: <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
	<5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
	<5110DF1D.8010505@alum.mit.edu>
	<CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
	<7v4nhpckwd.fsf@alter.siamese.dyndns.org>
	<CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
	<7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
	<CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
	<20140311014945.GB12033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:32:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSPt-0005ql-On
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbaCKTcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:32:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbaCKTcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:32:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A9CC74CBA;
	Tue, 11 Mar 2014 15:32:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXWBRaPIhDGLOZ9P49tmmVPXI44=; b=AFhKwq
	ri6t8aMBu2yr6Rirdwk/m4ztnJeC7FmPZgvSsJVjcAHoGaXQ1vC0aETMfzHCF3tl
	0nDL7nRQKRuMSVAwuyPiXcdqu1K0jQoBrGN3+luMpSg334KFlsOm4yrmUBgsxRwp
	syvr/s+yF0aRXt0xkR1Qg7+qPlJ7rg6G/Gfvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A4wdcAZ+/phopb2zw4wW4/Pth/WbMIAi
	sHJ2T+phWAzTOO2l33cYy6S13gsb6yfI6zV6koIeeyCC1jihpBVNKsVrc7dPJxus
	6p+MWYzdVmBzw9rzMRp/trms3GWUMSldYxNp0OrhhvUb1ZSrxRYKS2xOeOyt6Qjn
	nqiT5g2+qcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7666974CB9;
	Tue, 11 Mar 2014 15:32:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0A2274CB6;
	Tue, 11 Mar 2014 15:32:39 -0400 (EDT)
In-Reply-To: <20140311014945.GB12033@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 21:49:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E86C4E5C-A953-11E3-84A8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243883>

Jeff King <peff@peff.net> writes:

> I think the main flag of interest is giving an fnmatch pattern to limit
> the advertised refs. There could potentially be others, but I do not
> know of any offhand.

One thing that comes to mind is where symrefs point at, which we
failed to add the last time around because we ran out of the
hidden-space behind NUL.
