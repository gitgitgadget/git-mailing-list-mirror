From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Fri, 17 Aug 2012 11:02:41 -0700
Message-ID: <7vy5ldtn0e.fsf@alter.siamese.dyndns.org>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com>
 <1341693962-17090-2-git-send-email-hordp@cisco.com>
 <7v8vetmzgz.fsf@alter.siamese.dyndns.org>
 <CABURp0rrTvQcjHLsVwXC5hfBOuRmFG4AzSj6ZQwM=MXn0FAUCQ@mail.gmail.com>
 <7vehn6zedz.fsf@alter.siamese.dyndns.org>
 <CABURp0rdZ2N6exE0gpJncSnTzGB0Hbr+RuO4G5F6zb=z8Qb0Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Qsk-0002rD-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 20:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab2HQSCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 14:02:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2HQSCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 14:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E58D77F43;
	Fri, 17 Aug 2012 14:02:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I4m1+UI1ahcY7Bg2cwwVB6rwZq4=; b=d17wwH
	B0kshWQS8bSwivN7Dc7uczdT369V6Dk3/BzLrM44Pix8Q1nnHI6umQeJ08neyIeo
	7soROa3QNk8LQdFhIfDumF0oMPkdhxQOdf6cLWn2AmsQEFkkNjp2iqPnIfK2rKXR
	5MU5OnyBiWi96Z9MJG10NTGGGcQhQwNLZnPQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iIYHoZtRc3RhCYz38Twr51UkDDvqLUYO
	8tbSHDIwQH6XYOg0mx6PzSyalvwRCrso8AFTK7r0pqdqk7ynLi2alOwKKuabEY12
	6X9FAOIrhbJAd9zkgr+mdJ1hsMTE55qWsSGlzAzCgEXGwg4A8lQMtAFjoRngf8iA
	MF+VQ19b/dM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2D397F42;
	Fri, 17 Aug 2012 14:02:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EBB87F41; Fri, 17 Aug 2012
 14:02:43 -0400 (EDT)
In-Reply-To: <CABURp0rdZ2N6exE0gpJncSnTzGB0Hbr+RuO4G5F6zb=z8Qb0Sg@mail.gmail.com> (Phil
 Hord's message of "Fri, 17 Aug 2012 13:52:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDEC8DDE-E895-11E1-B31F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203636>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Aug 16, 2012 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Phil Hord <phil.hord@gmail.com> writes:
>>
>>> So, the next roll will remove the tests for MERGE_RR and will be more
>>> explicit about the potential for mergetool confusion and/or the fact
>>> that it is not explicitly tested here.
>>>
>>> I'll wait a little longer for any further comments.
>>
>> Mild ping to a seemingly stalled topic.
>
> I was going to say the same thing.
>
> Patch v3 series is here:
> http://permalink.gmane.org/gmane.comp.version-control.git/201282
> http://permalink.gmane.org/gmane.comp.version-control.git/201283
>
> I assume these were missed because I sent them during some critical
> point in the release cycle.  But maybe it was because I missed some
> step in the submission-revision protocol.  If the latter, please let
> me know and I will try to learn to do better next time.

Thanks; they were just lost in the noise of the traffic.  Will
replace and requeue.
