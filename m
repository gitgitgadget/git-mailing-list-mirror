From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout from neighbour branch  undeletes a path?
Date: Tue, 13 Nov 2012 15:41:10 -0800
Message-ID: <7vbof1cbqh.fsf@alter.siamese.dyndns.org>
References: <20121113152341.GC6561@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:41:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQ6l-0003HV-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab2KMXlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:41:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043Ab2KMXlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:41:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9690DAF37;
	Tue, 13 Nov 2012 18:41:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=69Xa2s36lDnMXLXjX5lmvvo/zGY=; b=C0ZFwA
	Btb0OJYxr0lPH4cq891TuJWXLXqSiNkVnX1sFGjqxhoOG6VKX/CqGavrbjEivP8L
	v4d2/hsBegzHXzRR7eg5XXIGJ3EDotsWB6RAn9WBdyLIPJM0HP+qOa1hXDkUqk6N
	5kUsxuDiZCtfQD9EBQzt9X/aTc86KsfWMGeDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cf/3t412H8HfnaicE2+KKC7R/e4eG7tZ
	VZeCsV8X/uDP7uIOcmOFCZnh37BvEzoQK6zhPkNC9nlKoKxQNWwjViX+6Lxi3NwP
	7JHd+LQZsXiLrzL6mJYHSOeLoZDF3AFrrNQ6OLMPHSNSqfBxQx0nSnViwkrtFXIz
	hrggs7p8nhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84A14AF36;
	Tue, 13 Nov 2012 18:41:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1A28AF35; Tue, 13 Nov 2012
 18:41:11 -0500 (EST)
In-Reply-To: <20121113152341.GC6561@external.screwed.box> (Peter Vereshagin's
 message of "Tue, 13 Nov 2012 19:23:41 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B434278-2DEB-11E2-ACE3-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209685>

Peter Vereshagin <peter@vereshagin.org> writes:

>   $ rm -r pathdir
>   $ git checkout branch00 pathdir
>   $ find pathdir/
>   pathdir/
>   pathdir/file00.txt
>   pathdir/file01.txt
>   $

Hasn't this been fixed at 0a1283b (checkout $tree $path: do not
clobber local changes in $path not in $tree, 2011-09-30)?

Are you using 1.7.7.1 or newer?  If not, please upgrade.
