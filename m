From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] merge-recursive triggered "BUG"
Date: Thu, 19 May 2011 20:21:07 -0700
Message-ID: <7v1uzu5a70.fsf@alter.siamese.dyndns.org>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
 <BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ciaran <ciaranj@gmail.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 05:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNGHF-0002ir-DF
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 05:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab1ETDVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 23:21:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab1ETDVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 23:21:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6EA75458;
	Thu, 19 May 2011 23:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+3NrzV077s9K7elS5Ot828jwiPI=; b=aODcon
	+Qgxk9dU2tPWY2e7XpdWnS+Q/iQsy/76ZuMupvePQl2u9axt1yr0OTuvPDEVJuxZ
	QDwHYGi4CBt0RBrwMdJndnV8Apu0ZxeVaibcXvW/SmL6vsG1i4YQvEc4q2EkmXyf
	7SpeZksTcRCK4ewJEfYjxMgl7iE5ljoPlxQbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oPJ2EBHmfKQWGEcY6FHtKwFMYS8I3AZW
	niKF0XYKwyzerKqKv2kN3TUkTZDHTeEy50nt/pLRFCzLpQZUnMkRkSW4SL/3y2vI
	sDKNwHDrVhZvkZSRWABx1ZKG8J+gh+KmxDxG8h/kNDHkqf7b63IT9PiFcR1Ur9QT
	hXJxtXiDbT0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78BBC5454;
	Thu, 19 May 2011 23:23:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1EEA65453; Thu, 19 May 2011
 23:23:15 -0400 (EDT)
In-Reply-To: <BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com> (Jay
 Soffian's message of "Thu, 19 May 2011 21:14:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 837E2AD4-8290-11E0-83AD-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174035>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Mar 16, 2011 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> As a part of my today's merge, I used 'next' that contains b2c8c0a
>> (merge-recursive: When we detect we can skip an update, actually skip it,
>> 2011-02-28) to merge 'maint' into 'master' to propagate older releases up.
>>
>> It triggered a "BUG" per merged path, and I bisected this breakage down to
>> the said commit. Luckily 'master' is not contaminated with the breakage,
>> so I used it to finish today's work.
>
> I just ran into this. It's not in a repo I can share however. But, why
> did b2c8c0a make it into master with this known issue?

Because it was patched by another band-aid, and apparently it was not
enough?

You are the second person to report the same regression, so let's revert
the merge of the entire topic, ac9666f (Merge branch 'en/merge-recursive',
2011-04-28) from master for now.

Thanks.
