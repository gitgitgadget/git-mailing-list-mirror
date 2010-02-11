From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 15:13:35 -0800
Message-ID: <7vk4ujs6w0.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
 <7vpr4c200i.fsf@alter.siamese.dyndns.org>
 <20100211210445.GA8819@coredump.intra.peff.net>
 <20100211211937.GA12752@coredump.intra.peff.net>
 <76718491002111505u2935381erc376cea862e15801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiET-00084N-G5
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab0BKXNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 18:13:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab0BKXNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:13:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 902549932D;
	Thu, 11 Feb 2010 18:13:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tiHAbxT9we3yPv+fOJHsfhBFTyk=; b=lhsx9W
	jqhIqeA5KBPSB4NmINiU6KEP43efPYL/pJQMlCroU0cbRBxhObq08j+ikp7u9+zW
	PNpH/76q1QLW8TF7QlX5Q9dJYb6aC7XJ9YbUrjjk+sTOwkKaK0pO7u0JPfiSVCCM
	7dR/aGMluN3QPAfinhYo929+T2aBBVGDjaHnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkaK5zzAFybnwy2hvBHg3QAPDvpq7xZq
	BxhTvPKBlaxoMCalqlM+T/zZEORPlVRWVqrbULAuiWq0XZ+2kWVE9fzjWW84skYj
	zXFhKeMqS6FsZnQcCU6WS6ym4akgQWsoE23AjCkq9ZPGI48NhLoBBvaHLClaR3cy
	zlbWeoduNeQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50F669932B;
	Thu, 11 Feb 2010 18:13:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4818999325; Thu, 11 Feb
 2010 18:13:37 -0500 (EST)
In-Reply-To: <76718491002111505u2935381erc376cea862e15801@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 11 Feb 2010 18\:05\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18FF3E6C-1763-11DF-B039-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139639>

Jay Soffian <jaysoffian@gmail.com> writes:

> Blech, how is this an improvement? Why can't I just say "git
> cherry-pick --continue"?
>
> If I've still got the message in my terminal, it's no harder to use
> the SHA1. And if I've lost the message in my terminal, HEAD~23 is lost
> and I've got to dig the SHA1 out of my shell history anyway.

Maybe it doesn't look like an improvement to you, but I usually do my
editing in other terminal and come back to the shell, so this is a huge
improvement.  It depends on the user.

I don't think Peff meant this change as the sole replacement for --cont
anyway, so I don't understand why you are so upset about it.
