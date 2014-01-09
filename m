From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 09 Jan 2014 13:24:41 -0800
Message-ID: <xmqqob3kalwm.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
	<xmqqeh4iavn2.fsf@gitster.dls.corp.google.com>
	<20140109182024.GA30970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 09 22:24:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1N5u-0005n1-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 22:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbaAIVYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 16:24:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbaAIVYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 16:24:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB3962F2E;
	Thu,  9 Jan 2014 16:24:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aL4rFNTH39Hxzosf90EuoVQHgVU=; b=FHNprn
	0/tJAautRxL6l3F2qAC/GSjPKeVUDqKUf9w8ADeOwOzoeUAlHAHrBeP12ckbgD20
	nudCWLhpGZXZF5wK/TSBe8gmWpdTNB5rRttLz/yf+wDkktRDQg3C550+mV6xUoIA
	kzqSvlxQBngKBdQnaazor8HVSk8Z7hepH8Kzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLqtZNKfxf4A8FS4uqLq4vfeqjU0T1Kg
	NOmXUILWFi3cj8brFJxubd/IMDDEI0WcTwz+bNBXkJAduJWPhpppnxLi/OllWo74
	GRzmqyw08OLGAsjB4GsqIceqelH947K47Bz31sjSNI0bPYUeZlpXYXefhjogr5NH
	lwl5TWll8vU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB9162F2D;
	Thu,  9 Jan 2014 16:24:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 171DA62F2C;
	Thu,  9 Jan 2014 16:24:43 -0500 (EST)
In-Reply-To: <20140109182024.GA30970@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2014 13:20:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7538384C-7974-11E3-8103-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240273>

Jeff King <peff@peff.net> writes:

>> Or is @{p} already taken by something and my memory is not
>> functioning well?
>
> It is my brain that was not functioning well. I somehow thought "well,
> @{u} is already taken, so we must use "@{pu}". Which of course makes no
> sense, unless you are middle-endian. :)
>
> We may want to be cautious about giving up a short-and-sweet
> single-letter, though, until the feature has proved itself. We could
> also teach upstream_mark and friends to match unambiguous prefixes (so
> "@{u}, "@{up}", "@{upst}", etc). That means "@{p}" would work
> immediately, but scripts should use "@{publish}" for future-proofing.

I recall we wanted to start only with "@{upstream}" without "@{u}";
justification being "if the concept is solid and useful enough, the
latter will come later as a natural user-desire", during the
discussion that ended up introducing them.

I am OK with the "unambigous prefix string".

Thanks for sanity-checking.
