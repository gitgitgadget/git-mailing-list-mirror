From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git blame only current branch
Date: Tue, 13 Dec 2011 09:25:28 -0800
Message-ID: <7vd3bswfhz.fsf@alter.siamese.dyndns.org>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
 <d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
 <20111212165542.GA4802@sigill.intra.peff.net> <8739cpteat.fsf@gmail.com>
 <7vobvdvx9c.fsf@alter.siamese.dyndns.org> <87y5ugsguj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stephen Bash <bash@genarts.com>,
	git discussion list <git@vger.kernel.org>
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 18:25:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaW6t-0001v6-J6
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 18:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab1LMRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 12:25:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab1LMRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 12:25:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE88655F;
	Tue, 13 Dec 2011 12:25:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EP4c7e1wbzEPCL41XTuuvIy41I=; b=iZIxch
	JfRiiL+YkUYbQOjjEHdjxShNgDnRFJEIzq6CSoSLJMRl21Y9HeFJptl4bgaziJs4
	Bf4NMaL7JV23cBS3YZHKB88g6B4oP2VXWAiZjHWq1wC6Mod8dg8qzxzq3hjyvz+u
	W7E9n940NbrWif9blZtqAlugebnJ1JagSd5jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=laf8c+cfksR5B6r2MUNb9eVvIDFs6Ir7
	q4RUAB0A538CSFz8ojTDGTBjj1+U3ko5tU+VpmQd1hq1Wx3mrrWXZf6CCbLWl9NK
	pLIP1nEIJG5QFYYmsaB2HB1JTZ/e8/SZ8+aIvtW5GsKok6pdjlagl9v/KXf/OQYS
	ZvTxBDhoReo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 758D3655E;
	Tue, 13 Dec 2011 12:25:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CC94655D; Tue, 13 Dec 2011
 12:25:29 -0500 (EST)
In-Reply-To: <87y5ugsguj.fsf@gmail.com> (Vijay Lakshminarayanan's message of
 "Tue, 13 Dec 2011 19:39:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 746D1B00-25AF-11E1-8E0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187033>

Vijay Lakshminarayanan <laksvij@gmail.com> writes:

> Before the introduction of the numeral 1, I am in complete agreement
> with you for the exact reasons you've mentioned above.  Post
> introduction of "l ? 1 : 0" it warrants a refactoring.

If your main point is that "return l ? 1 : 0;", then a better thing to do
would be to use a well-known idiom to turn anything into a boolean, i.e.

	return !!l;

and your problem is solved without any renaming (we are not talking about
any "refactoring" that changes code structure).

I've seen enough bikeshedding, so I'd stop after pointing you in the right
direction by mentioning "git grep -e '<lst>'" and "git grep -e '<elem>'".
