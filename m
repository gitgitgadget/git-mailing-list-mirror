From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Sun, 26 Sep 2010 22:24:15 -0700
Message-ID: <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
 <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
 <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 07:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P06CT-0008Ly-HJ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 07:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab0I0FYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 01:24:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab0I0FYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 01:24:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC7DAD95D9;
	Mon, 27 Sep 2010 01:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6pkzdsFm67mbxEh8Qc3KUnOVvoc=; b=cKKcqN
	1IEH78Gs7ldNGoD07CWv21LWzKMVPd7/cvI9JmNrIM+b2RpXhDXOOWO+q3srcqLm
	lK7ei83C9nA8Uy5WqCwOzi/UQtpEgdYTnIHGFO+mZtJM5WIM6toeVSR2SQ2opiLk
	6nDYYwKL0mTKrA3YgTjuZsg5jLV50UnJLxi9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NwvZzcGlw6zqMWQlmMd/fkSs+GHWRafN
	9xXYN6y7FBbOeiB1gX5/LD4l7m6XEZpoX0WBYWLoSwBExegJhyyI1GLeW2inKN5m
	lV7GyonkeXkPIWFCNxz5n5oUvq8E4wDJ58P72mrUehHoacGMiGySyovkj02Op/BG
	SoWNCRwvLdo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E86D95D4;
	Mon, 27 Sep 2010 01:24:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18B38D95D2; Mon, 27 Sep
 2010 01:24:16 -0400 (EDT)
In-Reply-To: <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org> (Kevin Ballard's
 message of "Sun\, 26 Sep 2010 22\:04\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB6978A-C9F7-11DF-A61F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157301>

Kevin Ballard <kevin@sb.org> writes:

>> At the end-user level, this new option to merge-recursive has exactly the
>> same meaning as existing -M given to "diff" family; people would probably
>> want to see it made available as a synonym to "diff" family as well, no?
>
> You mean so you can type `git diff --rename-score=50% foo`? A reasonable
> suggestion, but then what do we do with -B and -C? It doesn't make much
> sense to give a longer name to only one of the three options. This patch
> was concerned with simply exposing the functionality to the merge
> strategy and doesn't attempt to address the problem of providing long
> names for this trio of options.

I would call them --break-threshold and --copy-threshold respectively.

I have been happy without long option names when we originally had only
short names, but some people seem to be able to be more explicit, so...

While we are at it, would it make sense to have "merge-recursive -M20" as
a shorthand as well?
