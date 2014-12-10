From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 14:28:03 -0800
Message-ID: <xmqqlhmff8cs.fsf@gitster.dls.corp.google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com> <20141209202738.GC12001@peff.net>
	<20141209222337.GA16345@google.com> <20141210084351.GA29776@peff.net>
	<5488A87C.4030505@alum.mit.edu> <20141210215154.GF16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:28:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xypjw-0003bv-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 23:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207AbaLJW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 17:28:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbaLJW2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 17:28:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F5B24A3C;
	Wed, 10 Dec 2014 17:28:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=St6TH86Hy0mAEDMEIaoC91MSurw=; b=TLb6ur
	p655x6LXCfH2GI7W6Rq9J7Mly5jXvb6scw/1pgqzxr3byrF8fU/mrUrOsBCl1arL
	yoPGQLDpuWbOio8yPxZjldWUC5BJ9dnw7+vhQr/roKeWkDPVnc5B50UaA3jhvUiG
	iTCNpdB43JOy8eeZlm6stxX7LjGQ0XgCW3t28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jwYQKqDHxZlh+8tLpJI2GMpblHFL0aT5
	M+VUm4w5nmtksqSztkV6N4fHKn8XoRb8vHUDWJfhcLHWPYnkIUXhI75LTWTZLANo
	b4X6u+pUlcwo1KlmiavZAnY3Fe7Q5k2MZTWhO1mDAsNJnZvF7/FEyL4FWZwBPI3y
	fdZGtzZVZRo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A17724A3B;
	Wed, 10 Dec 2014 17:28:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDFB624A37;
	Wed, 10 Dec 2014 17:28:05 -0500 (EST)
In-Reply-To: <20141210215154.GF16345@google.com> (Jonathan Nieder's message of
	"Wed, 10 Dec 2014 13:51:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFAA5734-80BB-11E4-A7B5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261251>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Haggerty wrote:
>
>>                              I would find it a pity for that work to be
>> squashed into Documentation/technical/api-*.txt, where in my opinion it
>> is less discoverable and more likely to fall into disrepair.
>
> I think we're in violent agreement and keep repeating ourselves.

Hmph, I am confused.

I somehow had an impression that the "move to doc and remove from
header" patch was to illustrate how unpleasant the result will be as
a whole (i.e. results in a nice documentation as a starting point,
but we can see that it will be hard to motivate and help people to
keep it up to date during further development).  Which would suggest
that you are in favor of moving the other way around, to keep the
header rich with documentation only at the higher level.  Am I
reading you correctly?

> All I said is that api-strbuf.txt is currently the most readable
> documentation of the strbuf API I can find.  The patch to move the
> text to strbuf.h looked rough and incomplete.  Therefore I don't think
> it's ready to be applied as is.  If you'd like more details about why
> I say that, feel free to ask.
