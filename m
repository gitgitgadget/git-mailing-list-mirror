From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Wed, 13 Nov 2013 12:04:16 -0800
Message-ID: <xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 13 21:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vggfq-0004Is-0z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 21:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab3KMUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 15:04:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756278Ab3KMUEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 15:04:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD1550838;
	Wed, 13 Nov 2013 15:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jn9On8E73YAm98sAz5JDJM/fsM8=; b=GBCyXe
	IeLWxl3ayxWkSfYJjz4KKt/qovUncIeX++yvcYcXAyHTMmm74r/dtRWmtw7dT52c
	2A+KF0S4HgnKPFCVgS9dIuZK35Mhb2UJkYHue+E32Js+wSED37wdh4OE65RjxLv/
	bSMDCloBsW3ULZQfzBXx7xxSZeAdnzr/kqqu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oknHEFLEEU9QS0OTdghlatG6yeIIFvh1
	wPujp/B4u9WGTrtxjR9RrbWVjPEj1Nor+AICJ7WXGZ5vW4g73AiRQ0PlQXq345vi
	deDMEI97n/wYOsDNlk9HDPAT6b4RymCm/hb1wvhOFkz4O0vuazXcLdGFSofl0FQO
	8kyw5ocvH28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9423B50837;
	Wed, 13 Nov 2013 15:04:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8996050833;
	Wed, 13 Nov 2013 15:04:18 -0500 (EST)
In-Reply-To: <5283C701.8090400@web.de> (Jens Lehmann's message of "Wed, 13 Nov
	2013 19:37:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C76F003A-4C9E-11E3-BA04-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237801>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> If we were introducing a divider line for machine consumption, I do
>> not think it is wise to let that line even translated...
>
> Ok, but then it won't mean much to readers who don't understand
> English. I assume prefixing all diff lines with "# " is out of
> the question because of backwards compatibility, so what about
> using a descriptive text together with a scissor line? The former
> can be be translated (and won't make it into the commit message
> because it starts with a "#") while the latter serves as a robust
> divider line:
>
> # Everything below the following line is a diff that will be removed.
> # --------------------------------8<--------------------------------

Yeah, or swap them around if you are trying to protect the part
above the divider from getting contaminated by the noise.
