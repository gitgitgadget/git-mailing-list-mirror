From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and
 non-copies
Date: Mon, 03 May 2010 00:30:47 -0700
Message-ID: <7viq75tpaw.fsf@alter.siamese.dyndns.org>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 03 09:31:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8q7N-0002Mt-QY
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 09:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0ECHa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 03:30:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0ECHa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 03:30:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A28AEA40;
	Mon,  3 May 2010 03:30:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFod34i50mM4G9HyFiK/8jeLYo8=; b=KjF7VO
	oyaPcBs8/po4KQX89TeIt1JGUGr6nl7KHZoP/WiuxPaHP6E1sKw77SrboChwlbCr
	L7WUKIZyZ+g8FqAjizyQLL8AnlW/unGgB4uwjzTBUhDt+qEk65P6J+JqDF2piMpt
	Fm1rqbZwHKy42g/83FzQvzRhWk4wuDdGx15sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sus5KqOCB5VS0wUH6jsB391NlmeZsIIy
	4ZbR/gqEbNbDcCLU+FKK3wIoWehK2MPQdu3wi6VD7QxdHfVEqzTAu2XQDh1zTtnY
	gdTdk43D6OB4arYRHBUl4DvFUXu3jDw5BYhWKll4XuJsUg7rEkhny1JDBjNaSoM+
	CUm7oX0VsXI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6411EAEA3F;
	Mon,  3 May 2010 03:30:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB886AEA3D; Mon,  3 May
 2010 03:30:48 -0400 (EDT)
In-Reply-To: <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Mon\,  3 May 2010 08\:27\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD8CFAC0-5685-11DF-859E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146219>

Sorry, but none of these configuration variables are acceptable as-is.

Many scripts (the ones shipped with core-git, in contrib, or written by
users) depend on their invocation of "git diff-*" family without any funny
command line arguments like --no-prefix nor --src-prefix to produce a
patch that can be applied without giving a custom -p value to "git apply".

Letting the user break that promise is already bad, and not giving the
scripts any way to protect themselves from these configuration variables
by overriding from the command line makes these doubly bad ideas.
