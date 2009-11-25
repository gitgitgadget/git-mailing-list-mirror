From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1200: fix a timing dependent error
Date: Tue, 24 Nov 2009 17:14:33 -0800
Message-ID: <7v7htf76di.fsf@alter.siamese.dyndns.org>
References: <20091125080808.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6T2-0000lt-4u
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734AbZKYBOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 20:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933665AbZKYBOh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:14:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbZKYBOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 20:14:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D43AF82647;
	Tue, 24 Nov 2009 20:14:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ditNqW3tvYWyvntJ/jizM6KsXxE=; b=mHRwt4
	2ek4SUwEwsOG+iPnIV81HKGidU0gdIl2ARuspqF+eEMI8EXpeUrjMUOvN6W5jYQX
	/99VnlekKJw5pIKvR2A3rL0ZSqNmwnAPGboBT6WYUgM/GfbItoj9ZVzjJDvnllfw
	K7QTttkt62hYM5+PMptVJ3bu+4ktFl+JKMOFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aNoCBxKmPY7TvYCZAiiJRQG9dMNI8iG6
	BgFMrg4xfq/Sna/1sEnTZ6Fi8hfMFxeaBejr/3beOvwpKCgpN9C2nusiogsDMBmX
	4xciCzjZ/LrJTEpBDodQ14Xh3A0Ps6bOpwy9DBwYaiVCNtg4JVFPcr9+azHIk2w8
	HcuRwkSclh4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9432D82646;
	Tue, 24 Nov 2009 20:14:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC67282633; Tue, 24 Nov
 2009 20:14:34 -0500 (EST)
In-Reply-To: <20091125080808.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 25 Nov 2009 08\:08\:08 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E76FFB84-D95F-11DE-ACF9-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133606>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> The fourth test of show-branch in t1200 test was failing but only 
> sometimes. It only failed when two commits created in an earlier
> test had different timestamps. When they were created within the
> same second, the actual output matched the expected output.

Ahh, I actually saw this breakage once, suspected it would be something
like that, but didn't have enough energy/time to dig into it myself.

Thanks.
