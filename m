From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Thu, 12 Dec 2013 15:41:50 -0800
Message-ID: <xmqq8uvpskld.fsf@gitster.dls.corp.google.com>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
	<xmqq38m1292g.fsf@gitster.dls.corp.google.com>
	<CAEBDL5Wb+fU=qX4eypt3SrAKQjWRqf9KkNDoutbt7fTsdk02rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Dec 13 00:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrFtG-00061c-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 00:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3LLXly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 18:41:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab3LLXly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 18:41:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4574159A4F;
	Thu, 12 Dec 2013 18:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0hnpdH9vkBV4ZMACHcqPLb9byhA=; b=bW9NHXa91sOwc2r85XNJ
	BMLZFzhUQKE3L4uYxBsC6l4cFitkmH7x3H3vXc4I4jrSw7R+AAEGVMSFUalBins5
	ZN8bxh4JaEVVUFaegRFALwxaHUhWa8sacWaWqw2vFscBT5Kq9r9yBnlNXTpMHusY
	hThE0NsNXZdsCeo/6gIuGnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fQm1LYFjlVhOFjcnaRvso7tVY/NPObOkzo8eULfHSluOTT
	dNtVnqKnM2Apa1CJHFNt33zYdlo4ZYeFM2IfS6T7E4R2O6F9fJkG8RO5AG5j10XI
	3L+zHeDvwRDbpjsZsPzpg0qyMN1w7WKM1Qltt7QjG0UoPLSReJ63D/hZioQ04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29F1559A4D;
	Thu, 12 Dec 2013 18:41:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0937E59A4C;
	Thu, 12 Dec 2013 18:41:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9E39C66-6386-11E3-B1B3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239251>

John Szakmeister <john@szakmeister.net> writes:

> On Mon, Dec 9, 2013 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
>>
>> I thought we cast without SP after the (typename), i.e.
>>
>>         gpointer *data = (gpointer *)user_data;
>
> I've found a mixture of both in the code base, and the
> CodingGuidelines doesn't say either way.  I'm happy to switch the file
> to no SP after the typename if that's the project preference.

Somewhat arbitrary and unscientific, but between

    git grep -e '[^f]([a-z_ ]* \*)[^ ]' -- \*.c | wc -l
    422
    $ git grep -e '[^f]([a-z_ ]* \*) ' -- \*.c | wc -l
    233

I see that we favor "(struct blah *)apointer" over "(int *)
apointer".  Many hits in the latter grep come from compat/
that are borrowed pieces of code we tend not to style-fix.

The leading [^f] is crudely excludes "sizeof(typename *)"; it does
not change the resulting picture in a major way, though.

Thanks.
