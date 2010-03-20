From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 13:57:56 -0700
Message-ID: <7vbpeibtij.fsf@alter.siamese.dyndns.org>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5kK-00022S-4J
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604Ab0CTU6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:58:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0CTU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0829A3484;
	Sat, 20 Mar 2010 16:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZdsQKCPAVY8YqjonleCKr8G6Nfk=; b=fWaA74
	ZmG0EcDNCbM5j/KlmXpIvTpzsrtjjhUwtFskvntviG+IWVGE9R5DRj6BqNZ57heM
	wYzVkWTk+qoXtjMHX2WGJ+xBce4DK1Npr2caXGYmhIX41pELPj2cTUTJcoXUnOX2
	LBNqJ+aZNSj3kzdN/VEQXG6PEe4DG6MLrW2N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnuoFroL7/bhQKiAl+wYpV1+zpIunvlR
	g6eXpJYXmqw4GaM8VknbOsk7zSw7RG/u+5o6e3nAwsALhJVCM97YopTlvbdyurWJ
	BBETkQGZZPxZQSKPJMZX7ikyyGbhcPVe/oCkiOYzcw0u/q3bcktjxlDYULgBcEbj
	V9ZfviU7wYQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5766EA3482;
	Sat, 20 Mar 2010 16:58:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 346A1A3481; Sat, 20 Mar
 2010 16:57:57 -0400 (EDT)
In-Reply-To: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 (Alex Riesen's message of "Sat\, 20 Mar 2010 21\:35\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45494CDE-3463-11DF-A096-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142751>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Sat, Mar 20, 2010 at 10:18, Bo Yang <struggleyb.nku@gmail.com> wrote:
>> <line range>
>> Its format should be <start pos>..<end pos> or just a <line number>.
>
> You might want to reconsider the line range syntax. Exactly the same syntax
> is already used to specify a commit range, so reusing it may lead to confusion.

I would actually recommend you take a look at -L option from blame.  What
I use most often and find very handy myself is this pattern:

	blame -L '/^void some_function()/,/^}/' -- path

as I do not have to count the line numbers.

There also was a discussion on allowing more than one -L to blame, which I
think is applicable to this feature.  Check the list archive for the past
few months.
