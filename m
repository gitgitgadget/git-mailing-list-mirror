From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 10:52:29 -0700
Message-ID: <7vobc09sf6.fsf@alter.siamese.dyndns.org>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfwAO-0002gy-J6
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab3EXRwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:52:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab3EXRwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:52:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C09E120BB0;
	Fri, 24 May 2013 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u5jcUPWtokT9TSrnljXB4lGzuzE=; b=oX3KoU
	2hNrEaPDa/3ujBfBFZfsD4or6tIl0mwjXPrE82QiAd6qRXG9s8AUQn0efLUBxxG/
	BWDt0+ofwG4qtIuviXDD+QqbCBd/PJ08v8oMYyxuDNXJBznQDDxGvqPiE8i82VzP
	0CqFjqI8mLIE9/gzLW6s9Z2P2XXeNmVFCxWvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDlGIwqqpoDrT3MLEx4XQIX2JjwuaKOk
	ZaTsjStAIkC2QBoEX1WyMJgzoZfXNu5w1R/3ncNsheMBkWxOjg7uXW4yxxQ9yvRl
	O0G459f7kZRmLCR7el3wMOMeM3HwWuVLkNw+3K6neNEo4hvXf34GIomvLvxLBRzL
	JkQuw/h/NjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4CD220BAE;
	Fri, 24 May 2013 17:52:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E7A720BAC;
	Fri, 24 May 2013 17:52:31 +0000 (UTC)
In-Reply-To: <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 24 May 2013 22:27:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4C4FAC0-C49A-11E2-B7CC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225388>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, May 24, 2013 at 9:19 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> There is no need to use a hammer and coerce everything into an atom,
>> or throw everything out the window and start from scratch to conform
>> to pretty-formats perfectly.  Let's extend the existing format to be
>> _useful_ sensibly.
>
> Usefulness is one thing. Another is maintenance and in that regard I
> still think we should be able to remove -v and -vv code (not the
> functionality) with this topic.

Yes, the aim of the topic should be to make the machinery flexible
enough so that we can lose -v/-vv implementation and replace them
with calls to the new machinery with canned set of output format
templates.

By the way, I do not think "useable git-branch" is a good title,
though.  The expression has unnecessary venom in it, as if what it
currently does is not usable.  More flexible would be fine.

I am having this feeling that we see more and more of this line of
bad behaviours from some on the list recently to call something that
is working in which they find itch using unnecessarily derogatory
terms, and it makes people simply avoid any discussion that starts
with such an attitude.

Unnecessary negativity is not productive and it has to stop.
