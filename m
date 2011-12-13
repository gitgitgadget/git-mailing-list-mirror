From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git blame only current branch
Date: Mon, 12 Dec 2011 21:47:11 -0800
Message-ID: <7vobvdvx9c.fsf@alter.siamese.dyndns.org>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
 <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
 <20111212165542.GA4802@sigill.intra.peff.net> <8739cpteat.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stephen Bash <bash@genarts.com>,
	git discussion list <git@vger.kernel.org>
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 06:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaLCx-0005ip-BC
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 06:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab1LMFrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 00:47:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab1LMFrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 00:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AB135DC4;
	Tue, 13 Dec 2011 00:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aik0bQ08LpXHqP3apXPxJqAegW0=; b=TiR6TW
	zyED7jUq5PHSlN0MLd/e1mbJC8Dn8mFLEvkhuTDOnIwQtOvYwDyz3inLbQiXXOvO
	43UHj77qd08TT95s0ea53ilMwHaRVfnGCJ9G0YTmkkVdPZOFUFc5Hdk0fnZXypEs
	8s6r1HaqEk4NVHBixLsWX3SRUSpccmJNsGPoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wWMdGBJqsOLV11hHH8d940ZqLBTVniPQ
	ft2hXTwhJ14wCfDOOnwqXJouePMlh3QXPEN43YibfWq2oPCfZW2B22xVz9jOPjdx
	68hXUlisewPuHkcDfUUpPxwLOwzD6RyIz3qJHgFOw46VVrKkbM/XNgkqZ5lnloJM
	EkFIYZ3Hf+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81ED45DC3;
	Tue, 13 Dec 2011 00:47:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 137B55DBF; Tue, 13 Dec 2011
 00:47:12 -0500 (EST)
In-Reply-To: <8739cpteat.fsf@gmail.com> (Vijay Lakshminarayanan's message of
 "Tue, 13 Dec 2011 07:37:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7E25CC4-254D-11E1-99B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187004>

Vijay Lakshminarayanan <laksvij@gmail.com> writes:

> The code reads fine when there's no numeral 1 around but now it doesn't
> read well.  I think refactoring
>
>     struct commit_list *l
>
> to 
>
>     struct commit_list *lst
>
> is justified.  Thoughts?

Not justified at all.

What is "lst" and why is it not spelled "list"?  It is a disease to drop
vowels when you do not have to.

If I were to name a new variable that points at one element of a linked
list and is used to walk the list (surprise!) "element" or perhaps "elem"
for short, but in the context of that short function I honestly do not see
much need for such a naming. The variable is extremely short-lived and
there is no room for confusion.
