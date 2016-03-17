From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Thu, 17 Mar 2016 16:49:53 -0700
Message-ID: <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
	<1458219254-16343-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, durham@fb.com, mitrandir@fb.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:50:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aghg4-0001xf-G7
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbcCQXt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:49:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752629AbcCQXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35BB14D477;
	Thu, 17 Mar 2016 19:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aY8ux3q7ZwNuuBVDNOjx8D1nNjw=; b=GjANQm
	6Dl5evtosDArdzuAXkQhpaZOuYPsOobAHZ8+h/KEVNkR74TWE20VQFnRWtsHeprN
	X+MmDQv7aIp3yEhuVSGrnTVYC/1z8kuh7DBCf9y/xbs+XokWioAry1qY+mAWckSq
	8AvjjQQd++RlYdoHth4yw2/6NRvnpVxRWlmIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPMhcqkxfLOt9nzu8kkzSit7g4L3s+T1
	/WFkjGf8D/J71m6Bm3AMr9xdRd25v9n4NU0STXz5ayoZtI0nHWbeeEi3ZECrzlLK
	Wk7sqnsNqgnwpzUHHvAdjx5nLN5UQpgMAqcntS/kEJAZOlWQuWka//qzIRYDoXuY
	XGm7i89uecE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D52B4D476;
	Thu, 17 Mar 2016 19:49:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA46B4D475;
	Thu, 17 Mar 2016 19:49:54 -0400 (EDT)
In-Reply-To: <1458219254-16343-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 17
 Mar 2016 19:54:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2C9D6BC-EC9A-11E5-9F14-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289172>

Thanks for these 5 patches, two of which need to be discarded ;-).
I think you can pick either one of 1/2, pick the one that says
"non-NULL" (as opposed to "something") in the log message for 2/2.

Durham, does it fix your issues if you apply the 1/2 and 2/2 (but
not 3/2) on top of 2.8-rc?

Duy, how comfortable are you with the idea of including this two in
2.8 final?  We have long passed the final -rc, and while it is
probably OK to prolong the cycle and do another -rc, we cannot keep
going like "oops, there is another thing discovered by somebod new"
forever.

Thanks.
