From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Thu, 03 Jan 2013 11:33:56 +0100
Message-ID: <50E55E94.2090401@kdbg.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com> <7vsj6mdqeo.fsf@alter.siamese.dyndns.org> <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com> <7vfw2kbs4h.fsf@alter.siamese.dyndns.org> <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com> <7vk3rwaa3r.fsf@alter.siamese.dyndns.org> <CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com> <7v623f18ci.fsf@alter.siamese.dyndns.org> <50E55198.5080202@kdbg.org> <CAC_01E2HXSnXBgDm=Cbwgi5PbiuHp_qPpoaqT_=pdDWDMnC5jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 11:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqi7u-0003RX-VY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 11:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3ACKeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 05:34:00 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:24018 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751583Ab3ACKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 05:33:59 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 687012C4010;
	Thu,  3 Jan 2013 11:33:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 050F719F45D;
	Thu,  3 Jan 2013 11:33:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAC_01E2HXSnXBgDm=Cbwgi5PbiuHp_qPpoaqT_=pdDWDMnC5jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212580>

Am 03.01.2013 10:50, schrieb Gr=E9gory Pakosz:
>>
>> IOW, if the command was something like
>>
>>   git filter-branch ...filter options... -- v1.0 master ...
>>
>> and v1.0 is an annotated tag, then it is reasonable to expect v1.0 t=
o be
>> deleted if the commit it points to goes away. But if the commit did =
not
>> go away, but was rewritten, then it is equally reasonable to expect =
that
>> the tag is also rewritten. But I don't think that we currently do th=
e
>> latter.
>>
> When the commit doesn't go away, the tag is currently being rewritten=
 properly.

Indeed, but only if a --tag-name-filter was specified.

>> Therefore, IMO, a change that implements the former behavior should =
also
>> implement the latter behavior.
>>
> The patch in my latest email does both. (yet lacks unit tests for now=
)

If it deletes a tag only when --tag-name-filter was specified, than tha=
t
should be fine.

-- Hannes
