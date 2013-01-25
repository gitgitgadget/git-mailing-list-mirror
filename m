From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 20:21:32 -0800
Message-ID: <7vmwvx7v03.fsf@alter.siamese.dyndns.org>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125040856.GA30533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyanc-00076F-De
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab3AYEVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:21:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3AYEVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:21:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A24DCEB5;
	Thu, 24 Jan 2013 23:21:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ue+kywaHtb1P1y4pfFq404LS5p8=; b=rH/CyW
	tvBt5M17W2JUz+r4eFqpzFpd6OlTmQH+dBRpcoJO5XsEZwXQgUrMaPf+ytwPxC/X
	dfKYeXT/9v5Tfx+wZY95YP9QJ/wYpfUFgktw28Iee2ZOEMI1ukHwPZQJUI+r3Y+B
	tMzC0Yo7oWTFNVOOKBSWSIfLFgyEwILxbnXzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dj1KLgMva8ZAciffZ1Qw++tq6pZPv5eF
	arB4GJFk86T5+jrhzSiWKHQbftj7e4JO4hmsgVpyMQ4lX6z6AnLvuNknP9lrCoqp
	xF4XxjPOhCs+HVwNejk9GPeKLMV3hmXOjZv9ES7xk3GjRid5vgC+mM/dlmg4lu9r
	BN9zEmlqM+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8DACEB4;
	Thu, 24 Jan 2013 23:21:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D9EACEB2; Thu, 24 Jan 2013
 23:21:33 -0500 (EST)
In-Reply-To: <20130125040856.GA30533@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 23:08:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B37466B2-66A6-11E2-99EF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214490>

Jeff King <peff@peff.net> writes:

> ... I know it gets the job done, but in my
> experience, macros which do not behave syntactically like functions are
> usually a good sign that you are doing something gross and
> unmaintainable.

Yeah, it is a bit too cute for my taste, too, even though it was fun
;-)
