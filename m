From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 22:05:29 -0800
Message-ID: <7vpq0rxis6.fsf@alter.siamese.dyndns.org>
References: <1359183058-51835-1-git-send-email-davvid@gmail.com>
 <20130126121202.GH7498@serenity.lan>
 <7v8v7fz0ii.fsf@alter.siamese.dyndns.org>
 <CAJDDKr5cCbNi5q5_Ds-yohXR56ZfVs7YBTgJP3THjRx1=EgG9w@mail.gmail.com>
 <CAJDDKr692zbg+PiFWx1y81yn=s2e=C0pFhsup4z0uTRNOTMPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 07:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzLNK-0001T4-GT
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 07:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab3A0GFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 01:05:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755727Ab3A0GFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 01:05:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D17779C4A;
	Sun, 27 Jan 2013 01:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/SlxaOsiDY1oFHYTIAlhuqUiOU=; b=ury57L
	62HuBtfTADojH5YKViIiNo6w2x9sG6Ej2T/nqWJdi4odDBiLn9iYXj+H86oTKDuo
	PjZVxbRbGONkxKBkZkqWcn6925uOw0Z2cJJtXOU1kcOV3Njhqkvh3oUAQo6yp0Xk
	iuQKX19ah3j2dV1gvfmOzL3TP/wBXUOg1jsnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5iELXcEMzgsjr6PXGQ+8oxmFUmPiLzx
	8Z2+Gb6SU6fbxOJEqwLltd13vUQIAvqZggseqArIjfiVbCZS+wbULsgMJ2FOWo/i
	Sl2TZCY1Yoq2htVWsbyCQk7ZVnN+Up2hRAU1dQm+XNvIwUnTsZ4TzyWltbeNkJUd
	ckeUl5/bu/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64D59C49;
	Sun, 27 Jan 2013 01:05:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A8EA9C48; Sun, 27 Jan 2013
 01:05:31 -0500 (EST)
In-Reply-To: <CAJDDKr692zbg+PiFWx1y81yn=s2e=C0pFhsup4z0uTRNOTMPwg@mail.gmail.com> (David
 Aguilar's message of "Sat, 26 Jan 2013 21:35:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E4B1C76-6847-11E2-B061-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214682>

David Aguilar <davvid@gmail.com> writes:

>> I think that's much better.
>
> Would you like me to put this together into a proper patch?
>
> You can also squash it in (along with a removal of the
> last line of the commit message) if you prefer.

I was lazy and didn't want to think about rewriting your log
message, so I just queued it with this log message on top.

    mergetools: remove mergetools/include/defaults.sh
    
    This and its containing directory are used only to define trivial
    fallback definition of five shell functions in a single script.
    Defining them in-line at the location that wants to have them makes
    the result much easier to read.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

But as you said, removing the last line of your log message and
squashing the change into it would be more preferrable.  Let me do
that later.

Thanks.
