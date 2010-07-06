From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle
 missing  list argument to for loop
Date: Mon, 05 Jul 2010 19:36:27 -0700
Message-ID: <7v630t72vo.fsf@alter.siamese.dyndns.org>
References: <80typu1ozt.fsf@tiny.isode.net>
 <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net> <4C31796E.9050109@viscovery.net> <7vy6dpyeqf.fsf@alter.siamese.dyndns.org> <AANLkTin0h8DUWo3sfhRdA7NCCCPLKXfQzSDvWX7p1OPq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy1l-0006vh-QG
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab0GFCgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab0GFCgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 571BEC2B3F;
	Mon,  5 Jul 2010 22:36:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/ah3ejVUCtm/dTz7BCLGjMdLAkU=; b=A1sHLMA5qMu4Dpu+pDrWEGi
	DvnxW/1+sVLk/NSUcKpigcZ4kAo4aNnCEdNFwKg7W5vmGdsXwPFsmUPNpmxABX5X
	PKyTX4gzLhT5oXhiiLkPxAahcEmGDzxdZhQIhytE4NXhCUCwbLLwazuMxZk8Uk62
	OMMpObeidO9+ijnW+NF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=A32VGvR7EgiI53LrGHq0kqKWhvtAeepLI0NnTmpiu4bNDt4re
	pA8m/Euo3AlU+WPPs7ZjP3RJeQVqfbY0XVio341O8DhA9BEVLkrz/n5LAH+IobDD
	857DD0qVioazWX/PKuhD9fR6kElREKomjcNgkr3tMblBf6iGm76NhiGjZk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BA50C2B3E;
	Mon,  5 Jul 2010 22:36:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E5C0C2B3B; Mon,  5 Jul
 2010 22:36:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E17030E-88A7-11DF-89A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150314>

Brandon Casey <drafnel@gmail.com> writes:

> $(foreach) works too.  I only avoided it because it has already caused a
> problem once before by creating a command line that exceeded the
> maximum argument list length on IRIX.

Ok, fair enough.

> REMOTE_CURL_ALIASES only has 3 items in it right now, and probably
> won't grow much larger, if it grows at all, so there is little chance of
> exceeding the maximum argument list length on IRIX.  So $(foreach) is
> fine with me if you think that reads better.

Well your patch fixes the issue, and I would actually prefer it as long as
it is explained well ;-).

Thanks.
