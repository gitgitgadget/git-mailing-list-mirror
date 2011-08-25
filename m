From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow multiple calls to submodule merge search for the
 same path
Date: Thu, 25 Aug 2011 16:22:14 -0700
Message-ID: <7vwre1gjq1.fsf@alter.siamese.dyndns.org>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <7v39gqo2fn.fsf@alter.siamese.dyndns.org> <20110825211144.GA67523@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwjFn-0001pg-7c
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab1HYXWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:22:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab1HYXWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:22:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410DF5BFA;
	Thu, 25 Aug 2011 19:22:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sTabPuo/U+euw9zibiOg/0QXstw=; b=SNQ8dz
	SUHvMlgZgCjNa1rTTPhqQ/hMY0JMmoKYxiedcMuyeKWUN6nrmdoCAO4YrrEcEBvD
	KwCi7q6arB2OFdZt/7Y+fKo9GOOYktX9/2s4S7XGO11/9Qf7ioGBqK6mk/SifW5S
	fisFkFocY8tWMdgIhbf0gKjRjPXwhe98zme2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t0XLDRK9y4TZK6+d4Xs1FVXfO51qW7Mt
	kUyBmrDAVwMRZ+jZv+7JEpropVJdkUUVHHWyFSd2nhuRt9DSTf5c2vW1e5qZwCJc
	g92xoFrW7JYpwM6IcQE81VUao9bpChOSDdHpPHwEl7eL2lQyeVz3C1MPQxAqYtWM
	MLwNVG1QTdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 383DC5BF9;
	Thu, 25 Aug 2011 19:22:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C57BA5BF8; Thu, 25 Aug 2011
 19:22:15 -0400 (EDT)
In-Reply-To: <20110825211144.GA67523@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 25 Aug 2011 23:11:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11CFCC02-CF71-11E0-9B0D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180136>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
> index 8f6f2d6..603fb72 100755
> --- a/t/t7405-submodule-merge.sh
> +++ b/t/t7405-submodule-merge.sh
> @@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
>  '
>  
>  # merge should leave submodule unmerged in index
> -test_expect_failure 'recursive merge with submodule' '
> +test_expect_success 'recursive merge with submodule' '
>  	(cd merge-recursive &&
>  	 test_must_fail git merge top-bc &&
>  	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&

What is this patch based on?
