From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Wed, 25 Jul 2012 15:09:45 -0700
Message-ID: <7vwr1ra3x2.fsf@alter.siamese.dyndns.org>
References: <1343239412-26780-1-git-send-email-szager@google.com>
 <7vipdbbs0b.fsf@alter.siamese.dyndns.org> <50105C60.4050303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Stefan Zager <szager@google.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9mC-0007Ak-Va
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab2GYWJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:09:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab2GYWJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:09:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8117E7F80;
	Wed, 25 Jul 2012 18:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJI59uxL6snxKIdmtVGD42q/wNs=; b=nH+yXs
	q1bCuTpPUYEjyLH0ljhtzLkAfDcGRrRLuIly06dDgEupEBVxTNd0n+tWQTAzAJVe
	G2+JKXW5yto1bx/uxxKSTAI9QHopOZL81RHzSpP23aU81+LEWZSJF/IavWaSR5+X
	FNVRGSBTRBPYlj5+BLXHvgE0wg0pOj47T9QVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3Bc9tJLFQm+BzmpcTVYkrM9l+EaYDso
	arPW1ns9PbsxfepEx5LaufnAQ8cJVv5mrIxdwRVnu88I3rI5nV5x+gTfAYbkkQJH
	TZJVr6jn6efHvQoVkjC81osyA7Xk9CNkqijN7RSRtUs8BTpJfnWI/VIiezz8tswG
	0kagEJ0X5HI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F5787F7F;
	Wed, 25 Jul 2012 18:09:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7C557F7C; Wed, 25 Jul 2012
 18:09:46 -0400 (EDT)
In-Reply-To: <50105C60.4050303@web.de> (Jens Lehmann's message of "Wed, 25
 Jul 2012 22:51:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71FE3BFE-D6A5-11E1-8BF9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202209>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 25.07.2012 20:44, schrieb Junio C Hamano:
>> Stefan Zager <szager@google.com> writes:
>> 
>>> Currently, it will only do a checkout if the sha1 registered in the containing
>>> repository doesn't match the HEAD of the submodule, regardless of whether the
>>> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
>>> strong indicator that the state of the submodule is suspect, and should be reset
>>> to HEAD.
>>>
>>> Signed-off-by: Stefan Zager <szager@google.com>
>>> ---
>> 
>> Looks sensible (again -- see http://thread.gmane.org/gmane.comp.version-control.git/197532
>> for the original discussion).  Can submodule folks Ack it?
>
> I like it. Still I'd vote for amending the documentation like the
> original thread proposed and would appreciate to have a test or two,
> but apart from that I have no objections.

OK, then I'll queue this so that we won't forget about the topic for
now, and docs and tests can be done as follow-up patches to the
topic.

Thanks.
