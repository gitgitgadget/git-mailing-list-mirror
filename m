From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Complain in the tests about git config not failing
 with, keys without a section
Date: Mon, 05 Mar 2012 11:29:10 -0800
Message-ID: <7veht626ex.fsf@alter.siamese.dyndns.org>
References: <4F50A79E.5060206@philosof.dk>
 <7v8vjiethh.fsf@alter.siamese.dyndns.org> <4F547261.7000506@philosof.dk>
 <20120305103714.GA30463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rune Philosof <rune@philosof.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4daw-0003bL-En
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab2CET3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 14:29:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757428Ab2CET3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 14:29:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F08327B82;
	Mon,  5 Mar 2012 14:29:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DgcPzTYY9FyxAlXDywTkft8FbUM=; b=EUJD9c
	GjXsh4AY3O7M4E2IO9nwv+xy5zbpvYUr/1mFscNKT8V3c1yNJlwMBmJHreavCDVE
	iqyi11JMKHYb/7PCEeLV1TR2hs3vWnSq+42+z2dZULTY2l8kzr2cYZlQM4vgR48A
	1+2NNGjvcBLA2IpRGgUAN6nNKykw3tVy7osgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLWZKMBVe7LnipxzYmxcHWQ1TZO380O9
	Qxn0SwxJOBv0Yw9ky8S7WcTy8SEBHPb8R9qa9tIxNok2EnMtW7V7QhUI8g1YAzwH
	U8jpiTlogF4J+KTzqoBzL+eGeUad9XgT8heLujFTV8MR7urIH8NfoTrgsgkM6E3W
	mVSQPxE7k/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E839B7B81;
	Mon,  5 Mar 2012 14:29:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 811D17B80; Mon,  5 Mar 2012
 14:29:11 -0500 (EST)
In-Reply-To: <20120305103714.GA30463@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 5 Mar 2012 05:37:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C41AF90-66F9-11E1-A90A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192264>

Jeff King <peff@peff.net> writes:

> For "git config --list", as you noticed, we include it in the output. I
> suspect we should simply omit it as cruft. But we could also issue a
> warning, and/or die.

A new warning might be worth if we were to suddenly start omitting
them from --list output, but dying won't fly well.

People have been happily lived with their config with such lines
that do not affect what git does, but a new version of git starts to
"die" on them.  For what purpose?  Whom is such a change designed to
help?
