From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/19] Rename struct git_attr_check to git_attr_value
Date: Tue, 02 Aug 2011 08:46:16 -0700
Message-ID: <7vsjpjg6k7.fsf@alter.siamese.dyndns.org>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
 <1311828418-2676-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 02 17:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoHAn-0003GJ-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab1HBPqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:46:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab1HBPqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:46:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347DA401B;
	Tue,  2 Aug 2011 11:46:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eI0Xapi86b6N9XThbdyCd6gjmMA=; b=gMOn26
	K5stu0VzL9I/uPWKlXzLReIw4Xb1QVCTcJbvT95dkJhLzBNZocybN5ShamcVKRm7
	yZvc05IFbI5AUY1URzNugL6vR3EI1cvPQTpp4JsiX64p+q/l+LyP3M9vmYIZsgAi
	AFs3TfDDFtwZvtTr+wQAoCg6EsTrQgIYbJRCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5W03jixborNridZd0RcckelBkweKiWQ
	WlQKHmrp7SRnTXXLVbw4udlWyn5sYTAQeogT1QvClVYXuHAhoXBooI/COsRlKK7Y
	yW47pZ7cdxMMvuxzd+znWlmA9EvK/Obie2OH5uOdmuQ9L+SW3uV4yR7YB1914mDm
	ZL/DJP2B5/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C0034019;
	Tue,  2 Aug 2011 11:46:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1DDF4018; Tue,  2 Aug 2011
 11:46:18 -0400 (EDT)
In-Reply-To: <1311828418-2676-20-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Thu, 28 Jul 2011 06:46:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9038473C-BD1E-11E0-8F01-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178478>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This described its purpose better, especially when used with
> git_allattrs().

You probably meant s/described/describes/ but more importantly does it
really? It is a structure used to probe into the attributes system for the
state of various attributes on a path, and the set of possible states
includes "there is no value" (aka unset), so it feels actively wrong to
call it attr_value and that is why I didn't call it in the first place.

I also think git_all_attrs() (i.e. word-break underscore after "all") is
more in line with the naming throughout the codebase, after looking at
output from

  $ git grep -e _all'[a-z]' --and --not -e alloc -e _all_ -- '*.c'

Other than these, and the earlier comment about the copy&paste done from
git_checkattr (which by the way should probably be "git_check_attr"), it
seems that the series mostly consist of good clean-ups and an addition of
a new and (probably) useful feature that is straightforward. Nice.

Thanks.
