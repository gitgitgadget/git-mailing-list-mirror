From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Fri, 03 Jun 2016 16:47:33 -0700
Message-ID: <xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
	<20160603232653.GA24538@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:47:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yoX-0003CA-Sz
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbcFCXrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 19:47:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726AbcFCXrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:47:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F7EA1FD10;
	Fri,  3 Jun 2016 19:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RC/U7YAAedpCa3M07WBvItt6hhc=; b=tMYXFC
	pZCkkmwy8pIJBnjW62eDfeg0tLtJcRJD4IOKeM70xvk8UTUpY+AE9/wujKyTQ7nZ
	H4EDCbtE+Js9pTuXZDz2+hudssvpkaVUBaE95MXzFvq8wu9c3ylKrBsIMX9ek8ZJ
	9eglIm7aN2pR91aAUFQh021esTJckyyX7wDps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKzTiC2l5C5XBokChZW68cBd5RbIxTmF
	0LuG15iKymIioqTE6DBw6LEADWyQGnKCJ5MDojMKWSEdrrVnU72ghU1YJk9IMETr
	hdYeLClOVC9i43Sml/gIwJBvWzlaW0JEl53KQ6OHAzqcOUw+/K+N/7IKSg9j1x2P
	p3jd1tLm/KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1870C1FD0F;
	Fri,  3 Jun 2016 19:47:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 977331FD0E;
	Fri,  3 Jun 2016 19:47:35 -0400 (EDT)
In-Reply-To: <20160603232653.GA24538@glandium.org> (Mike Hommey's message of
	"Sat, 4 Jun 2016 08:26:53 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C1CA9D4-29E5-11E6-8FB1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296431>

Mike Hommey <mh@glandium.org> writes:

> In fact, the parser doesn't even reject the one that is considered
> invalid (the first).

My question was what the desired behaviour is, and if your "fix"
gives us that desired outcome.

> (Also, the discussion back then was about
> git://[example.com:123]:/path/to/repo, not
> git://[example.com:123]/path/to/repo)

I thought these two ought to be equivalent:

	<scheme>://<host>:/<localpart>
	<scheme>://<host>/<localpart>

so the distinction shouldn't matter, no?

The former's last colon is "I wanted to write a custom port, but
didn't spell it out, which is equivalent to spelling out the default
port, which in turn is equivalent to not having that :<port> at all.
