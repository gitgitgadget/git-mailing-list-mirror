From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 11:19:39 -0700
Message-ID: <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	<20150430033725.GB12361@peff.net>
	<xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	<5541E3D4.7040207@alum.mit.edu> <1430417023.22711.8.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynt3s-0001TB-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbD3STo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:19:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751918AbbD3STn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:19:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D67CC4DE73;
	Thu, 30 Apr 2015 14:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3VrYaeijTw5t5aR6Yi2Fhmt2Am0=; b=PSEKKK
	y9oXmxvO7Tx8oD5b27T7cD2dmbxu9RRC3vkvko1cj0sCxTYyaFa+JIIzH7J8B94K
	+mrfyr7yKtNDCM2McQWP9NZLtzWmg09zM7p3bI8vRFIwEZMfr6d9SXIX5ELBoS5H
	7CfyGHQpJ45Zs1GZWWbYEOc+/dqHvhy84tx7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUKIs6Ep3xua4YRlq9CHY/aZzdeZ4Gc1
	ImuxPCHp0UVgdoeEeLihN2w4uuVA2U+QisI9YvtR0umsCIIVMW/qltZVxj4ur+dI
	9SnEpMiw6t3kMJlwuRP5JBUuwIh/M9as3GDsPSPEvbDGyybgsaVEQ89iysfQmW2S
	dMKWdLjOu/M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF67C4DE72;
	Thu, 30 Apr 2015 14:19:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59F614DE70;
	Thu, 30 Apr 2015 14:19:40 -0400 (EDT)
In-Reply-To: <1430417023.22711.8.camel@ubuntu> (David Turner's message of
	"Thu, 30 Apr 2015 11:03:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7783B29E-EF65-11E4-A504-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268086>

David Turner <dturner@twopensource.com> writes:

> In no case did we do a ls-files command,...

"ls-tree -r" is what I would have imagined you would be using, as
somebody needs to have the full repository in order to resolve the
symbolic links _anyway_, and that somebody does not need to have a
checkout in order to do so.
