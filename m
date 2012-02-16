From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Thu, 16 Feb 2012 12:10:46 -0800
Message-ID: <7v8vk2zghl.fsf@alter.siamese.dyndns.org>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:11:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry7fP-0003pt-0h
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab2BPUKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:10:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab2BPUKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:10:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C6E7E8A;
	Thu, 16 Feb 2012 15:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CsygR948hxmZfJcXu8YkzuGfJ7M=; b=bBnDH3
	5q42RxCdS0are/8jCuTtl2qvonxbNVb/YMi1mRYKpiMEgknj9DnE1l9nvoOdY7EH
	8I+hwh+kxelR9/ivTV9iWaHC9de8/PGrkbce92uPRprtiDPo1tD0GOkgvOIEi2S+
	n4hXzVDbHHPneK/Sb3bQGDkXccsolVvIqm1AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gkgSVQAJeorT2iJfOqarXqpmmq8E/ZFP
	3T9n7KiJUgLCVk3EoryiJM7nKhT9OVE2mCK3/82hzMqt0Etnh8nBz3vRyJXr8sqf
	2/CLZExApxCl4KcPspYVVz/Lk2dW7cfX1lgfJsqaUNS5jkICyheiVv8H+Arlx8m1
	qAHxugBlCPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291EF7E89;
	Thu, 16 Feb 2012 15:10:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B116C7E88; Thu, 16 Feb 2012
 15:10:47 -0500 (EST)
In-Reply-To: <vpq39abrxav.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 16 Feb 2012 09:34:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50ABB9FC-58DA-11E1-A0AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190904>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tim Haga <timhaga@ebene6.org> writes:
>
>> While testing your script on my office machine i discovered that the
>> following might be a problem:
>>
>>> +if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
>>> +    xpdf "$pdffile"
>>> +fi
>>
>> Xpdf is not installed on all machines (e.g. it's not installed on my
>> office machine), so maybe it would be a good idea to use a environment
>> variable instead?

Honestly speaking, this is looking more like an "useful application for
latex users who happen to use git to store their document source", and not
a "useful addition for all git users", to me.

These two viewpoint suggests completely different evolution path for this
program.  Imagining what the first major new enhancement intended for
people outside the original audience <git,latex> will be, I have this
suspicion that "this new version will help people who have their documents
stored in Mercurial" would be much more realistic (and the end result
being useful) than "this new version will help git users who do not write
their documents in latex but in asciidoc".

For that reason, I suspect that in the longer term, the tool will benefit
more if I do not take this patch and the tool lives standalone.
