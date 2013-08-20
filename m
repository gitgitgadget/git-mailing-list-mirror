From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 12:45:03 -0700
Message-ID: <7v7gfgkuyo.fsf@alter.siamese.dyndns.org>
References: <5213873A.6010003@windriver.com>
	<xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
	<5213B95D.3040409@windriver.com>
	<xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com>
	<20130820151554.6afbcb7f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrre-0007C0-R5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3HTTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:45:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab3HTTpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0799A3A1D1;
	Tue, 20 Aug 2013 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cadJLJeVHMmToA63vfBCXM4NeBY=; b=aS5tRC
	tbrclVGPV0zJR/Rns5v4dWKoQ1QuoEpachf09bvGPYfdl4ms9NZeVgAUE81lDjDR
	1V8saKjTZtfULggr/cLYUKhcKhweX66N3OrPPjo5nPOe4ML9xocZG24Iu/CGDLEB
	n7OlWtgR6b65OvptU0WJ0UmXivPoKv/iW6CBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dq4kI0IE1YgSocY6A61zPue3sb2ACjan
	01WeC1Ewhg4DlqPG4yxI/sBHPJ/Jg7aADZZWpK0luh7FJXlk80itqRZ4EVzeAdal
	Nk9xPl28Uo5zUzXTJj5X1sVJMasu69wzo9OvPWKqntkd6gkaga+71Ke4StB3vcch
	v//5mEMoqOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECDB43A1CF;
	Tue, 20 Aug 2013 19:45:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24A2C3A1CA;
	Tue, 20 Aug 2013 19:45:05 +0000 (UTC)
In-Reply-To: <20130820151554.6afbcb7f@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 20 Aug 2013 15:15:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02D4FCA8-09D1-11E3-8D08-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232640>

Steven Rostedt <rostedt@goodmis.org> writes:

>> I do not think it is necessarily a good idea to assume that people
>> who are learning "git apply" know how GNU patch works.
>
> Linus told me that "git apply" was basically a replacement for patch.
> Why would you think it would not be a good idea to assume that people
> would not be familiar with how GNU patch works?

The audience of Git these days are far more widely spread than the
kernel circle.  I am not opposed to _helping_ those who happen to
know "patch", but I was against a description that assumes readers
know it, i.e. making it a requirement to know "patch" to understand
"apply".

>> But I do agree that the description of -v, --verbose has a lot of
>> room for improvement.
>> 
>> 	Report progress to stderr. By default, only a message about the
>> 	current patch being applied will be printed. This option will cause
>> 	additional information to be reported.
>> 
>> It is totally unclear what "additional information" is reported at
>> all.

In other words, your enhancement to the documentation could go like:

	... By default, ... With this option, you will additionally
	see such and such and such in the output (this is similar to
	what "patch --dry-run" would give you).  See the EXAMPLES
	section to get a feel of how it looks like.

and I would not be opposed, as long as "such and such and such" are
written in such a way that the reader does not have to have a prior
experience with GNU patch in order to understand it.

Clear?
