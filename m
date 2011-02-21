From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Mon, 21 Feb 2011 15:52:09 -0800
Message-ID: <7vpqqlgd3q.fsf@alter.siamese.dyndns.org>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=CseZLobCoq+Li0AexHR+eaZpe84DG5hGzWHzR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfYG-00021f-WD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab1BUXwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:52:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1BUXwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:52:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72DE241BC;
	Mon, 21 Feb 2011 18:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AoFDtzIfqd8bV3d0vAKUhPeU9pc=; b=E3XKv6
	gmViNMW/XVOS3Y51GOO+miAzjc9/hukCOjjkeaQJpWyS4A8MB02+N11/gdC9hm7w
	kIbc/bl2PcN95+MPbggJaVYk0FTm/+6sRtpuVb5Ef59Y4MSJm7uHB46T75ASGyH2
	AsP/kARlgmHFyOHvdPugrauOxgtvAS0OrN66Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixHAU2pP7TXVQeaRqVLiJ/8La6MAB7FP
	ZsY/ZI5R7q70w+3xTIKQZeH84Av6ucx8SBOfXz56CQTepHhXWHboJI8rOx8/6lrM
	y6V903/uYbErLokbwLKyNlzQw3+ciaYvre54s0gi87WMSJozRDDWPJBks/VSq2px
	ntQAdlpRrk4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4161E41BB;
	Mon, 21 Feb 2011 18:53:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CD7841BA; Mon, 21 Feb 2011
 18:53:22 -0500 (EST)
In-Reply-To: <AANLkTi=CseZLobCoq+Li0AexHR+eaZpe84DG5hGzWHzR@mail.gmail.com>
 (Jay Soffian's message of "Mon\, 21 Feb 2011 12\:48\:51 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6D4AE3A-3E15-11E0-AC0F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167515>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Feb 21, 2011 at 12:21 PM, Christian Halstrick
> <christian.halstrick@gmail.com> wrote:
>> I would like to create a tag which full name is not starting with
>> refs/tags. Is that possible with 'git tag'?
>
> Nope.
>
>> If not, is there any other command to create such tags?
>
> If it's just a light-weight tag, you can use the low-level (plumbing)
> command update-ref to create an arbitrary ref:

That is a very unfriendly answer.  You shouldn't be answering everybody
who ask "How do I shoot my foot off?  git-foo command does not seem to let
me do so" with "Here is how to do that".

> $ git update-ref refs/blargh HEAD

At least, please say "that thing is no longer a tag, many git commands
would complain because refs/blargh does not have two-levels, and do not
ever think about starting that thing without 'refs/', or your 'gc' may end
up losing that object" when you give a potentially dangerous hint like
that (the last one being the most important).
