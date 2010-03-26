From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Fri, 26 Mar 2010 12:32:50 -0700
Message-ID: <7v39zmlvz1.fsf@alter.siamese.dyndns.org>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net> <7vaatxobef.fsf@alter.siamese.dyndns.org> <20100325051743.GB5784@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFHN-0002zg-Ff
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab0CZTdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:33:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0CZTdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:33:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F86A52E8;
	Fri, 26 Mar 2010 15:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n2LaBf5LOhnqgQaASIXPrObE3QU=; b=Iux3w8Kb9nU4oYy5rx8m1Id
	YDQ86bnzdYIL/DszPlxLdGxr21k2ADywmhaqPCNXVfozjc4L2lKn85v3d8YlJGON
	yVaGjk+nZAjmIlWPDcVZrI/czmaln7vDtnX1JlL78/MYntWXbYO+OJr1VK8aoLMi
	SW8JuREngXVRnOs+HuhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=N49w/Ma8Kr0zEl7NfoEuYMgtB8Ycsvd86Rej+qRXpeicdHS5N
	9No4Y1zqwwvfFW5HYpeEL/V2FjUAfAIyXyR5Y0VLcOoWcbEo5fEt5bowmgFRNaWX
	854gAROt5VeuG5Wx7s+6/sauE+nhYB2XDIbsb+ax2riod5yuu26hSdRxqs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B4D5A52E5;
	Fri, 26 Mar 2010 15:32:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 184EBA52DA; Fri, 26 Mar
 2010 15:32:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6236CF92-390E-11DF-9E22-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143273>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yes, please.  It would be more precise to
>
>   s/without a tty/with TERM=dumb/
>
> in the second paragraph but regardless this is a good description of the
> problem.

Strictly speaking, with TERM=dumb the true "vi" fell back to the ex mode
and should have been usable.  A purist might say it is a bug that we fatal
out in this case (I know that it is deliberately done to help newbies from
common confusion by not running any editor with TERM=dumb, but to a purist
in me it feels somewhat wrong).
