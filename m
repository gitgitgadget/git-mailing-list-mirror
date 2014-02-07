From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Added syntax highlight support for golang
Date: Fri, 07 Feb 2014 15:01:56 -0800
Message-ID: <xmqqa9e2ttln.fsf@gitster.dls.corp.google.com>
References: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
	<xmqqiosqtwqk.fsf@gitster.dls.corp.google.com>
	<CAK9CXBXXge+ZGN_ocWMH5jkPJcTg74rhtWsDiOuqAeeGXDW_tg@mail.gmail.com>
	<CAK9CXBUewMhr19KarmymOXmoq1ijPuU2mq4hqc6a-W0TCq5SRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 00:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBuR6-0002O4-5v
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 00:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaBGXCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 18:02:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaBGXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 18:02:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BB66B9B2;
	Fri,  7 Feb 2014 18:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RN8bS2g+EL5f+bP73AyzBRbdggg=; b=GrFOed
	/S0Oj5Nm4W0rMHUv+ZiUBnme5woxfqYmXSoFGdfcpx5MnucIJ1yGEaD8bWJmFUTR
	y2lbGI5On6ZA3q9UBKJ3smxD9PvwTfKtdgyr8weMH9ZHfkys21cgHtrBYOyupJnC
	6wal+GDpa/wC/t6BoUmmXSWFgPo/dBm0drTrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLGkt8BzgO3A11wy/qxPwtAHKmowIslD
	5UMk7HcXJ9XzbFiEL3dD0rg+69YQDE7oOO7ay30XuPpz+1TR5CwGAMLoofm4F4Ir
	siJQpT6eNnLl1Urwd0McmTIKVDjcPrDOqA9T5xpLG+7F736bEvNEUR13TjNkaMb6
	qjNHVT0xY6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570556B9B1;
	Fri,  7 Feb 2014 18:01:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AADD76B9AE;
	Fri,  7 Feb 2014 18:01:58 -0500 (EST)
In-Reply-To: <CAK9CXBUewMhr19KarmymOXmoq1ijPuU2mq4hqc6a-W0TCq5SRg@mail.gmail.com>
	(Pavan Kumar Sunkara's message of "Sat, 8 Feb 2014 03:28:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8E51C78-904B-11E3-81EB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241811>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> Sorry. I misunderstood your message. Yes, I guess lazy loading the
> supported file extensions would be better. But not all highlighters
> support `-p` option. So, I think its better to leave it to the user.

Yes, those highlighters that do not support `-p` may have to rely on
the hard-coded list %highlight_ext.

But with the same line of reasoning, not all versions of highligher
supports 'go' language, so it's better to leave that to the user,
no?  The version of 'highlight' you may have may know about 'go',
and somebody else's 'highlight' may not yet.  A hard-coded list that
appears in %highlight_ext will be correct for only one of you while
the other between you two needs to customize it to his system.

Note that I was not talking about removing the configurability.
Even with lazy loading and/or auto-genearting at build-install time
when 'highlight -p' is available, the users still want to be able to
customize, and supporting that is fine.

But for those whose 'highlight' does support '-p', it will help to
lazily discover the list of supported languages and/or enumarate
them at build-install time.  They do not have to keep adding new
language (or removing it from the list we give as the upstream) to
adjust it to their system.

In any case, the comment was not about this patch from you, but
about the future direction for the code it touches in general.  In
other words, it did not mean "because it does not update the
mechanism to lazily discover the list of languages, and instead
added yet another language to the existing one, it is not an
acceptable solution to start supporting 'go'".
