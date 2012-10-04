From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 14:28:11 -0700
Message-ID: <7vvceqvses.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtj5-00033L-8A
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946471Ab2JDV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 17:28:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946409Ab2JDV2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 17:28:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF6A78310;
	Thu,  4 Oct 2012 17:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6y2pVFQqDg/HLH6U7NDhaXCJ7M8=; b=mqHEev
	G/RAoMGRbAFGsEM6QS5b5kcE7KyTOD+LRXCHK1+xYbScjt2HMlJ5nrAmEA31+0BO
	LEUBtcB2cgH1qXaag6JrJFyYgFMMz/UBqnH5BSmhxwZTww0d7953PPd77KunG25X
	gQenXDZ5ofs1TrT3dtq1qApgoxUkQm3j+LGJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mVkXiITY8/lR128fDr5I+sNHeLthYB8s
	cGlTG020vyfMjLFBqR2UCrjcbDs448EO5vsPCpztGnbFje5I196mieOMqieBsgGl
	8KRHg7ZjVHC4pToHy+IEjZ435G/94/uJCRJKQd26AtLTihZQMhlkq0eymZdPSNEU
	yvVgnvuJSrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB05F830F;
	Thu,  4 Oct 2012 17:28:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27044830E; Thu,  4 Oct 2012
 17:28:13 -0400 (EDT)
In-Reply-To: <7v391ux7im.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 14:16:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66FC76C4-0E6A-11E2-B080-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207036>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
>>
>>> with current trunk I get the following on an up-to-date Linux tree:
>>> 
>>> markus@x4 linux % time git pull
>>> Already up-to-date.
>>> git pull  7.84s user 0.26s system 92% cpu 8.743 total
>>> 
>>> git version 1.7.12 is much quicker:
>>> 
>>> markus@x4 linux % time git pull
>>> Already up-to-date.
>>> git pull  0.10s user 0.02s system 16% cpu 0.740 total
>>
>> Yikes. I can easily reproduce here. Bisecting between master and
>> v1.7.12 gives a curious result: the slowdown first occurs with the merge
>> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
>> of its parents is slow. I don't see anything obviously suspect in the
>> merge, though.
>
> I think the following is likely to be the correct solution to this.

No, it is not.  Sorry for the noise.
