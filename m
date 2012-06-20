From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Wed, 20 Jun 2012 11:44:25 -0700
Message-ID: <7vpq8tvn5i.fsf@alter.siamese.dyndns.org>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
 <20120619135814.GA3210@sigill.intra.peff.net>
 <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
 <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
 <20120620160607.GA12856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPtK-0002sy-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab2FTSo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:44:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757291Ab2FTSo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:44:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13AF28F7C;
	Wed, 20 Jun 2012 14:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NM8rNbTXxMIn+y50+SLQsTCjBTk=; b=B/eWjK
	CfJiEa5TR05QX6FFDcJMkXbTh0hI5jHPi5kkibylVJpkc2AMFjySgdMv6iqY5zlK
	mBKEpE6jQvYBFMtJxCrN/LLW3CtQV7cCItllj6AfaBA/lGqzro9ZruS7kv2PWmDR
	/QCK7FjbqNnnjSUJc4v8QCeu7G4tncOBoBzmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnWYrx8f4pXn7ujvEhE6qqHVktqahPPm
	VeOiqY6h1f+E37UU3Jr2t+rn1CUS8A/W/ZTSiay8WpiEjISXlF4x+fA36yuT5zbX
	v/icver7Pk1gFFuzSfI6D/dW4kBDmJ0PUHHFpTW63MfvzIxF/7jmvSD0a1nWo2Ck
	YWJW8Lmt6fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 098578F7B;
	Wed, 20 Jun 2012 14:44:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 923048F7A; Wed, 20 Jun 2012
 14:44:26 -0400 (EDT)
In-Reply-To: <20120620160607.GA12856@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 12:06:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F61D25F8-BB07-11E1-BC0D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200330>

Jeff King <peff@peff.net> writes:

> Fine by me. I think "xdiff_found_changes" is not quite accurate; it is
> really "did builtin_diff find any changes?" since we might never call
> into xdiff (e.g., for binary files). I'm not sure what the best name is.

"diffopt.found_changes" is clear enough for me.
