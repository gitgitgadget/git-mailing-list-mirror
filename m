From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating
 an mbox.
Date: Thu, 10 Jun 2010 09:12:27 -0700
Message-ID: <7vhblan9xw.fsf@alter.siamese.dyndns.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org>
 <7vljaorhjq.fsf@alter.siamese.dyndns.org>
 <87eiggiy8g.fsf@yoom.home.cworth.org>
 <7vaar3nds1.fsf@alter.siamese.dyndns.org>
 <87pqzyhpl2.fsf@yoom.home.cworth.org> <87mxv2hola.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 18:12:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMkN5-00007L-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 18:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759490Ab0FJQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 12:12:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab0FJQMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 12:12:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0265BA4F7;
	Thu, 10 Jun 2010 12:12:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJIMts64cPXG4Th2K1RzVDdXvt0=; b=Fc1YIM
	tkY/XNKhaTZtd3c3YuE6Ok/wwefs0iWp7Wq1tugiLtA8ZOYxGwU4MfM4EEFGzaCE
	DyiEMSD8FCHA/Rm7lxE8kGy0+B3BUqSMV4GjxVQ7vNmRDzBQ2vlaYw9pBZKqXeaH
	CeaAXuERV+GFWemYkBaQEprGZmTqVDgzi5U8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQAIBPSPEZ2DRmPP0s1+0/jHxYoiNIzB
	tg9TIAfVis8Fx3puEe/GcNX3Z+T3JfyKWvgZnc0wYTBtzSUlC29oJ615KsGaYjOr
	0g47F9fHHDmOprpLCWnIlzB6gh0QvFJkVCUHON6dxVkxkWfJYXVqbWAuYAxoIQef
	hWC+8eerc+g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64DF8BA4F5;
	Thu, 10 Jun 2010 12:12:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EC0FBA4EF; Thu, 10 Jun
 2010 12:12:28 -0400 (EDT)
In-Reply-To: <87mxv2hola.fsf@yoom.home.cworth.org> (Carl Worth's message of
 "Thu\, 10 Jun 2010 08\:52\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9816E3E-74AA-11DF-AA55-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148887>

Carl Worth <cworth@cworth.org> writes:

> Another option would be to just emit RFC2822 messages unless the user
> passes an explicit option to format-patch (such as --mbox, which would
> be implied by --stdout). Then git would generate legitimate (unqoted)
> messages and legitimate (quoted) mbox files.
>
> I'd leave it to you to decide whether the --mbox option should be on by
> default or phased in with a warning or whatever.
>
> What do you think?

It sounds like that one good way to transition is to phase in --mbox as an
optional feature and at a revision bump later make that the default (which
would mean that we might need a --not-a-mbox option).  I haven't thought
things through though...

Thanks.
