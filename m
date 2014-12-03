From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 03 Dec 2014 13:43:17 -0800
Message-ID: <xmqqiohswgsq.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
	<xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
	<20141203201808.GA6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:43:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHho-0001Ix-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaLCVnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:43:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639AbaLCVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:43:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DE8223CBC;
	Wed,  3 Dec 2014 16:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z3aN4XC7VT0Wgtg/uQgj4muVR1o=; b=FyJxAq
	87pvAW9dEAqKm/yTnSYd0XsSB3dSlYXySCzfNSVn9ZRzG9Xi/sJRQ4ObOB0rk7Ux
	yvT1ffmapY/SL3pdPvjWuWSOhpGsAYWaqXYiG/yPwDjDTK9BOIGboqnJ9TcyjXLV
	Ju0Zcn/t4imx6IbBd+dDlxpLDaG178mrX+AGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1jq867pIdEWxVQGEVzye2tNNVKXIZa7
	fNB5CR5ytfM0VDr3f2a9GAPMDT/7VB3p1FfxVFrpeEoHRjfFIIq29UouzJ7uZ7aY
	tMxxPMq2R1ySP0OGpafgi3vv0ED4CmTercdGzYfHnKj+HSvpilPWHKgyRmL1Bxb8
	sRcyPzy8zRg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7410723CBB;
	Wed,  3 Dec 2014 16:43:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7BA423CBA;
	Wed,  3 Dec 2014 16:43:18 -0500 (EST)
In-Reply-To: <20141203201808.GA6527@google.com> (Jonathan Nieder's message of
	"Wed, 3 Dec 2014 12:18:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6539EECC-7B35-11E4-9AFB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260696>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> By the way, this seems to address the same thing as sb/copy-fd-errno
>> topic that has been cooking in 'pu'?  Should we drop that other
>> topic and use this one instead?
>
> Yes, please.

OK.

It felt strange that two people in a same office stomping on each
other's toes, which I interpreted as an apparent lack of
communication, but perhaps there was an off-line communication
between you two with an understanding that this will supersede the
other one, which I probably failed to spot in the cover letter.

> I'll give it an hour or two to collect more comments and then send a
> reroll reflecting them.

Make that one revolution of earth, perhaps?

e.g. http://thread.gmane.org/gmane.comp.version-control.git/259831/focus=260349
