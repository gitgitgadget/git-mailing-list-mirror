From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git push" silently fails, says 'Everything up-to-date" when
 it's not.
Date: Tue, 29 May 2012 11:53:31 -0700
Message-ID: <7vipfe4y50.fsf@alter.siamese.dyndns.org>
References: <1338206011.11518.115.camel@shinybook.infradead.org>
 <vpqipfgec9k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 29 20:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRY2-0001QT-Of
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2E2Sxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab2E2Sxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFA57845A;
	Tue, 29 May 2012 14:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9wF5nCG/wkjllUyOlPAFKB+IE8M=; b=BRW1b+
	wzctLVftKYgazkqJFVHW9Q1eE527EXYhqWRt1jJBWGtJJcIp/E7EXQn4NHAug+x3
	JGY5mcfHYvESMPowiqU69mRmEKk3id4m3lIAKew4BP3rt3j9McUl8eADKxrviS/d
	oea/ubRM/P3iHwtp39L7Wo4kAz2oEWCXQLtkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qz0wca4SzMAbee7yau9hpdo33BTzBPJf
	mnNtdXLV/bxlRuUSyAneaj5pHE1yd1POXFuOEWjDB3S+XjWu51gaoj2Z9oDcQJEd
	KgURjGuRMwYF0fLcEZSda7RwBmV4WrRuEfV8CdTkj/zx+Gp9/gsrzswIKD2CUQws
	fb2GiRYFlt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A666F8459;
	Tue, 29 May 2012 14:53:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B5E38458; Tue, 29 May 2012
 14:53:33 -0400 (EDT)
In-Reply-To: <vpqipfgec9k.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 28 May 2012 14:11:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96D9E8D2-A9BF-11E1-9A01-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198751>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I don't know what can be done to improve the case of detached HEAD with
> push.default=matching. Perhaps Git should warn when HEAD is not pushed
> (detached HEAD, or HEAD points to a branch that doesn't exist remotely)?

Please don't.  For those whose workflow clearly separates local
history building (checking different branches, making commits, etc.)
and publishing the result (git push), "git push" is *not* a way to
say "I am done with the work I have been doing on *this* branch",
but is a way to say "I am done for the day, and all the branches I
push out are in good order". It does not matter what branch the user
happens to be on when "git push" is run for them (including me).
