From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone --reference not working
Date: Thu, 17 Nov 2011 09:40:17 -0800
Message-ID: <7vvcqimyv2.fsf@alter.siamese.dyndns.org>
References: <20111116234314.GF3306@redhat.com>
 <7vobwbpnzr.fsf@alter.siamese.dyndns.org> <4EC4926D.5050004@alum.mit.edu>
 <7vr517nvi7.fsf@alter.siamese.dyndns.org> <4EC52088.3030308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrea Arcangeli <aarcange@redhat.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 17 18:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR5wp-0000e8-W2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 18:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab1KQRkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 12:40:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab1KQRkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 12:40:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B1EE5935;
	Thu, 17 Nov 2011 12:40:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21tQT3ZWUSerGRFVDPjwsONBYJc=; b=vcu5+K
	gCsTFoq74hl1PF7FyOQa152w5GOggpi38W2RsFSf+GUElpJEzgRk2XyQa9913IvA
	XK837uCFa0qw4nXfugxcb2AI/0V0T7FAsemSCy3HDn19j4KA6MnpRonwOTyhYphW
	N9gL477THS0gaJo7LU7unk/V00n3VBIfQfN6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGnpUG3z2XqBzYAa4IKdDgYgJpxbANUb
	qaFhB3SFq1K3ilQ9x6kjuxO8APbtOTOWFtWDrCQI0fbOcaoe67wf6YsVUACSETDl
	El+0fniLB43jVekSCpPD1KHGStqGVpBBwl/D2uNqrIBd2xqkdMYKHSpCDjiZL/pz
	w39PFUxbFqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2175E5934;
	Thu, 17 Nov 2011 12:40:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E435932; Thu, 17 Nov 2011
 12:40:19 -0500 (EST)
In-Reply-To: <4EC52088.3030308@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 17 Nov 2011 15:56:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37DE3960-1143-11E1-8991-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185601>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/17/2011 06:55 AM, Junio C Hamano wrote:
>> As a tentative measure, for tonight's pushout, I am inclined to queue an
>> equivalent of this patch on top of both mh/ref-api-2 and mh/ref-api-3
>> topic and merge them to 'next' and 'pu'. I'd appreciate if you can double
>> check the two merges on master..pu after I push them out in a few hours.
>
> I checked the merges in the following...

Sorry, what I meant was eyeballing these two merges

  aee9699 Merge branch 'mh/ref-api-3' into jch
  9f8b195 Merge branch 'mh/ref-api-2' into jch

in "git log --oneline --first-parent master..pu" to see if I screwed them
up.

Going forward, I think after 1.7.8 final is tagged, when rewinding and
rebuilding the 'next' branch, it would be ideal to rebase these two topics
(actually, -3 builds on top of -2, so rebasing only the lower one should
be sufficient) on top of 1.7.8 that will include the fix in the patch that
started this thread.
