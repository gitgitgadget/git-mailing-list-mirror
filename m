From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 16:06:33 -0700
Message-ID: <xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<xmqqha515ebt.fsf@gitster.dls.corp.google.com>
	<536adf96f37ec_3caaa612ec69@nysa.notmuch>
	<xmqqtx902k45.fsf@gitster.dls.corp.google.com>
	<536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
	<xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
	<536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 01:06:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiXOk-00085e-MO
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 01:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbaEHXGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 19:06:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54192 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbaEHXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 19:06:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B68B15FCB;
	Thu,  8 May 2014 19:06:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rWZai2PSxfDf4D2JJwNUxs6OSLU=; b=G2qlnX
	p9+Z5kl99zPP5aKMSaijhRflPKtwkODSutML40yg4MAIamglILq8Qt+3q+3wAmac
	WgDayIku05GRqINPmJ4Xf8NpNYd3Wj7jqQ20E5UMJ5W7Ne0K26PC3B6SmKbTfUqS
	r8fQJDZhiNg5ZAhndQgyeu/RJovQjKsSRtbK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVMJaumxXlOBkmJZupV4AT0GZtxDDg+p
	Z4e+Sav3DLkO3AFZvWWNym3oJZV6DBZg4XbDpK6haJJh/zJGKsAIrBpuMLmfUaQU
	R0IsV+7eHmK8chHcvjqlXCwRd58LGJYI76s1hZceIWh7jXNtKKZXLYvl3mbzwBqr
	nZOSpz7CLyc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90F3A15FC9;
	Thu,  8 May 2014 19:06:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C43115FC8;
	Thu,  8 May 2014 19:06:35 -0400 (EDT)
In-Reply-To: <536c084ecb546_4f6fd2f30cdd@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 08 May 2014 17:42:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 66DE8D0C-D705-11E3-A2ED-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248462>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I already said this multiple times, but let me be clear once more:
>
> MASTER HAS A REGRESSION (for all versions of Mercurial).

As you said, that is not a regression, isn't it?  It is an old
breakage that existed even before 1.9 (was it 1.8.3 or something?)

>> If you no longer want to have it in contrib/, I can drop it in future
>> releases (but not in v2.0), so that people can find the latest and
>> greatest directly from you.  Otherwise, queuing a fix on 'pu' and then
>> to 'next' in preparation for an early graduation for the release after
>> v2.0 (and as a fix, it may want to go to older maintenance releases)
>> is also fine by me.
>
> Are you saying that the graduation plan is going to continue and they
> are going to move out of contrib and be distributed by default?

I do not think that is going to happen.  As we discussed already, I
do see merit in unbundling it from my tree.  I can keep it in contrib/
as that is a slight benefit for you (i.e. you can be lock-step with
Git) but as long as you live in my tree, you need to follow the same
release schedule as the other contributors, which may be detrimental
to your users, compared to a case where it is unbundled.

I do not see a strong reason to move it out of contrib, either.
