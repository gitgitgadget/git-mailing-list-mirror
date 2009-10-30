From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 14:34:08 -0700
Message-ID: <7vljisk1m7.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3z70-0002jm-2D
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945AbZJ3VeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZJ3VeL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:34:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbZJ3VeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:34:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5D476D09E;
	Fri, 30 Oct 2009 17:34:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iuRZhNzs9BBxpw/Hbe80lcrRaz0=; b=pbe6GX
	F6Z1/YW36cNxGDROD3pBUt3EcYIUoCP00t/7MGbZbaxYPeRV8T/oW0OQ7sMEpo6e
	7AwTUxK433vVc4R/oUK301I4Oq7xmHFI2yw09ZRZg0au0u0BQh5pzIclYPABhXmr
	wg7eSwicEgFcc5kIqaKPnHYKwKMThMIzocyd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUEc+QSf+sER+ISo4S6z7dxULWArDiou
	J8A+Oi9LsPNoQvYx5JITadrVrtZCUacxPcfP1M/NsF9WZfz3B/sZG8zWiBPPkfRd
	9wpZFdFMekivxXuloN9xFahcVooG11RLPq0/PjpnwkiinF6Xpr69EfU6c3V8EPBY
	Z6VAIN8R2Jg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A75FB6D09D;
	Fri, 30 Oct 2009 17:34:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0316A6D099; Fri, 30 Oct
 2009 17:34:09 -0400 (EDT)
In-Reply-To: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> (Erick
 Mattos's message of "Fri\, 30 Oct 2009 17\:36\:34 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F741D0C8-C59B-11DE-8067-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131754>

Erick Mattos <erick.mattos@gmail.com> writes:

A patch always changes something so the title "Changed ... behavior" does
not carry enough information (besides, you write logs as if you are making
an order to the codebase to "do this!").

> The code herein changes commit timestamp recording from a source in a
> more intuitive way.
>
> Description:

Remove the above.  Instead, start with a description of what the current
code does, e.g.

    Subject: commit -c/-C/--amend: allow 'current' timestamp to be used

    When these options are used, the timestamp recorded in the newly
    created commit is always taken from the original commit.

Then the rest of your text flows much more nicely...

> When we use one of the options above we are normally trying to do mainly
> two things: one is using the source as a template and second is to
> recreate a commit with corrections.
>
> In the first case timestamp should by default be taken by the time we
> are doing the commit, not by the source.  On the second case the actual
> behavior is acceptable.

... and the reader does not have to wonder what "the actual behavior" is;
instead you can say "the current behavior" here.

> ...
> Those options are also useful for --amend option which is by default
> behaving the same.

Also the reader does not have to wonder what "the same" means here.

I agree that the issue the patch addresses is worth improving, and I think
it is sensible to default to reuse the timestamp for -C and not to reuse
for --amend.  I am not sure about -c myself, but it probably shouldn't
reuse the timestamp by default.

I however think (old|new)-timestamp is suboptimal.

We already have --reuse-message, so why not trigger this with a single
option --(no-)reuse-timestamp?
