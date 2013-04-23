From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 12:25:09 -0700
Message-ID: <7v1ua1hwx6.fsf@alter.siamese.dyndns.org>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
	<CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
	<51767290.2010208@drmicha.warpmail.net>
	<7va9opi163.fsf@alter.siamese.dyndns.org>
	<CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Joel Jacobson <joel@trustly.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 21:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUiq8-0007Jk-4P
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab3DWTZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 15:25:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757169Ab3DWTZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 15:25:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D9FA187B7;
	Tue, 23 Apr 2013 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4AAJhzakrCx6skVy7ltx5b3saDg=; b=fXMxmR
	XO2EoJEy11xdlDVwSkFvokest016gAWNmxmOyx+SHFPeFlRFdPO6d/nyCzBDJL+y
	VgD8/1p3MzONonfq3XqnbZrycky1ag1rUEsYpPGAIGQ5BSSYk/9fob2iP6AGWqgo
	TlnNkSKU09TcGPzV6QinXsEO6T46H1t2nxyt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PyH0Ede6qX3aABBpfHbazTTOK6RfkbgA
	8GNKEJDmAsccAzJmIeTdjJfHSUkZ8tZpdIXTkl3NXowcSinyuD+ahQfNgMDult27
	iP/BDknLrmhueyh1JvrDgYLW3LULdUlANIU8sh05OdE4w8T8cBqxni1+eYOxPPZG
	u4ozFf+/axo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35663187B6;
	Tue, 23 Apr 2013 19:25:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B189187B5;
	Tue, 23 Apr 2013 19:25:11 +0000 (UTC)
In-Reply-To: <CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com>
	(Joel Jacobson's message of "Tue, 23 Apr 2013 18:58:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84494EF8-AC4B-11E2-AC62-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222208>

Joel Jacobson <joel@trustly.com> writes:

> On Tue, Apr 23, 2013 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I would consider such use of "git -c key=val" a last-resort escape
>> hatch to work around broken commands that do not implement a proper
>> escape hatch designed in to help users, unless the "key" is for
>> something very obscure and not meant for every-day use (read: not
>> deserving a proper command line override).
>
> Agreed.
>
> We already have --gpg-sign[=<keyid>], so I suggest --no-gpg-sign to
> override commit.gpgsign.
>
> Sounds good?

Yup.

And then we would need to add the same option to existing callers of
"git commit" (such as "git rebase") to pass it down the callchain.

But stepping back a bit, I have a suspicion that your upstream
project _only_ cares about what you feed them (either by pushing
your work yourself to them, or telling them to pull from your
repository).  There is no reason for you to be constantly signing
your commits you make during your exploratory development that you
may throw-away in the end.

It _might_ be a better option to just teach "-S" option to "git
rebase" that tells it to replay all the commits with "commit -S",
instead of adding commit.gpgSign configuration.
