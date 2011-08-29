From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Mon, 29 Aug 2011 16:42:12 -0700
Message-ID: <7vfwkj4wff.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com>
 <7v1uw36fgb.fsf@alter.siamese.dyndns.org>
 <CA+55aFz9givAWhP5_SfnneY6x_0ekcN2U9HrKr+NTgY=Ot=6TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 01:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyBTC-0001Cx-O3
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 01:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab1H2XmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 19:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab1H2XmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 19:42:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 883D057FE;
	Mon, 29 Aug 2011 19:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0FUnU67SpxVSFA5y+auib2Na3dY=; b=ctaEKN
	eac6/8xkcHvtmoIf1MoJ79nuZ1byaeMFzaDOkvJ9GW8MsDsTHJQs1Iv8mbwCtfvu
	6kK7V5VqKJ1YqHQWkJawNdNOBtFBPywlr5fkbDRRtcdvdx7QPquh7V6E0DUOnUBK
	nMsrlTQ9s8qP7xiMmGmSHb+ZG/Ksf5b6GcCl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fTzUBP8FoZ7pD6wp8cRbqwSosGob8aOX
	aOCVuBwSwR8q/1qpoI+EbqCPrbIX0JfhiiiHdafHsS6mmsSXmslWcHDizDwfu0GC
	qIxGVLThmGokQ9Ol/xa8SqRJXdN6dinSfXx1t/p0SUd+ovoQKAgBl7pIm1wxGwsd
	k1CmP1Ig4vQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F4CA57FD;
	Mon, 29 Aug 2011 19:42:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E15A57FC; Mon, 29 Aug 2011
 19:42:13 -0400 (EDT)
In-Reply-To: <CA+55aFz9givAWhP5_SfnneY6x_0ekcN2U9HrKr+NTgY=Ot=6TQ@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 29 Aug 2011 15:11:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85AD285C-D298-11E0-A179-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180377>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Aug 29, 2011 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The topic started by Marat Radchenko in
>
> Ugh, that's ugly. Is it verified to solve Marat's nasty case too?

Not yet, though Marat is on the CC list of the original "this is still
rough" draft (the code is identical but it is not split up into
three-patch series) message.

Marat, if/when you have a chance could you try a patched git on your
original use case and see if it produces correct output with shorter
amount of time?

> But yeah, ack on the series.
>
>                  Linus

Thanks.
