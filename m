From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: update obsolete code.
Date: Mon, 17 Dec 2012 17:37:33 -0800
Message-ID: <7v7gogjg2q.fsf@alter.siamese.dyndns.org>
References: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com>
 <7vtxrlnuqr.fsf@alter.siamese.dyndns.org> <50CF4E05.7050103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkm82-0000ve-2J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab2LRBhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 20:37:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab2LRBhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 20:37:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6102FA52F;
	Mon, 17 Dec 2012 20:37:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SBJj59QzkNmwiMtH0lLUS11AZII=; b=NHQjud
	Z6bzBgSIQfK8K59mtxEiHPqpF3s+0va13nnDjzx99okEL0BSd+Q7enNiMvcwKhrV
	KPC7I7Y2RhYio7opK2wK0+JYfwRCWF9RmGmrKMMdffvd7TxhxT56KKukUOxb1/z0
	H1hDEqC2ME5azkEs5wJanlQ0PI3fzeUDbQWx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMBv9iGAYYflJt7O32NwKmLYJqkZQ+Fh
	TxJ8LxoWXBCLsJnhAQo+7HIsvSXTyXUXMaFOZjgodC7Irpv8+eH2hOCKyX7LnUlO
	c9ovKV6I0Vpgg7qMfB4R1ads7fGjdybvS1X87xxQX/pwjzXi4Gxdyi/OJx4eaLCd
	qxbUKMbla50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DE16A52D;
	Mon, 17 Dec 2012 20:37:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1406A52C; Mon, 17 Dec 2012
 20:37:34 -0500 (EST)
In-Reply-To: <50CF4E05.7050103@gmail.com> (Manlio Perillo's message of "Mon,
 17 Dec 2012 17:53:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F61A9B8-48B3-11E2-B613-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211727>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Il 17/12/2012 05:54, Junio C Hamano ha scritto:
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
>> 
>>> The git-completion.bash script was using the git ls-tree command
>>> without the --name-only option, with a sed filter to parse path names;
>>> use the --name-only option, instead.
>>>
>>> Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
>>> ---
>> 
>> Did you miss the different handling between blobs and trees the
>> latter gets trailing slash in the completion)?
>> 
>
> Yes, I totally missed it, sorry.
> I was assuming the bash completion script was written before --name-only
> option was added to ls-tree.

There is no need to say "sorry" here; catching this kind of mistake
is what we have the patch review process for, after all.  If
anything, "thanks" is more appropriate ;-)

And the way you stated the reasoning behind this change in the
proposed commit log message was really good.  It showed clearly that
the patch was an attempt to clean up the code, not was an attempt to
change the behaviour to drop the trailing slash or space.  If it
said "let's use ls-tree --name-only" without such an explanation on
"why", future readers of "git log" would have been left scratching
their heads, wondering "why" the change was made.

Thanks.
