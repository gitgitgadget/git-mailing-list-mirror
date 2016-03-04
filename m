From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t5510: do not leave changed cwd
Date: Fri, 04 Mar 2016 10:38:31 -0800
Message-ID: <xmqqoaauytp4.fsf@gitster.mtv.corp.google.com>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
	<f6499302a5dfb52bf6c9430581103da9569434a3.1457088499.git.git@drmicha.warpmail.net>
	<20160304115255.GB8355@sigill.intra.peff.net>
	<56D987D0.5030208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abucZ-0003T7-PI
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519AbcCDSif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:38:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757489AbcCDSie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:38:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3063B468B5;
	Fri,  4 Mar 2016 13:38:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOW7L8asOkE1fuHLM0BBmRKav0c=; b=GwIwYM
	EwowM8mjk3TzN4uBYWlcWfr5elie5X+ZOwOi7MGv7b2WwNZHtfLp0O5vEbv/fOAB
	k83RrPkJt0Jfr10xgruNAoX0cdbyqNrzdNyDyOAJL0YCQxnmFbRDRE0SaOSGV67X
	nb8aeNVnoxBDeup0Ij8Mq/h7rEGwvKv9SkXmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxJ9Y88Bi/5nv01Yl3IvcFSHzgalOlpU
	jwg+X9v28ykPhwQo0XtZ/16aVxH17kB5KGpVpCj9MohvK8hms51CxKpmWwwzruw7
	ej5wmzY8InqQRLJ9HEfVOkyV+quOpa8FPbJjsOhlLC5t2IpzK8da6vrAencCDYEq
	upndtM7uA10=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19501468B4;
	Fri,  4 Mar 2016 13:38:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58C76468B3;
	Fri,  4 Mar 2016 13:38:32 -0500 (EST)
In-Reply-To: <56D987D0.5030208@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 4 Mar 2016 14:04:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BE1A01C-E238-11E5-8394-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288266>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 04.03.2016 12:52:
>> On Fri, Mar 04, 2016 at 11:53:50AM +0100, Michael J Gruber wrote:
>> 
>>> t5510 carefully keeps the cwd at the test root by using either subshells
>>> or explicit cd'ing back to the root. Use a subshell for the last
>>> subtest, too.
>> 
>> I doubt this caused the heisenbug you saw, as we should have an absolute
>> path for the trash-dir, and we "cd" to its containing directory before
>> deleting it. But this is definitely a good thing to be doing anyway, to
>> prevent surprises for new tests added to t5510.
>
> Absolutely ;)

I'll take this one; thanks.
