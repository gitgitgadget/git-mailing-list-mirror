From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Thu, 19 Nov 2009 23:53:37 -0800
Message-ID: <7vhbsp7htq.fsf@alter.siamese.dyndns.org>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
 <20091119193913.GA25410@gmail.com>
 <19205.50406.91209.309984@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 08:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBOJl-0002ZQ-9L
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 08:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZKTHxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 02:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZKTHxp
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 02:53:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZKTHxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 02:53:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEA46815BA;
	Fri, 20 Nov 2009 02:53:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IcUKToD/4u6tIY4QnxXC5eDgCRU=; b=OGAj40
	uflYSCJkEQhLPkN67lQRreoPhBdE+qyRSY5rWADA8ezVa5B9wIFTWm4tnKZfFTkD
	cC7xEH5YO+iklMBlqXdgIZqwvWoLejBbU7Q+MLW8EiGLD2bn1sb0Bh25rv5fC+jU
	3/ayvLmjzoSD/VdSv0zSuq8Shcoq5iiqUn4Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tC0K+npVe0aMxiL/0csyINhg9XaDFRY2
	1PNu/Orusp6R+128xOKTrA1JmvPdv78i4pKQhnnttBozcj8hp693f/7gXZPZwDw2
	lNu4uluwCXH4WPkz2jzjV9bCFZj5LvakK+ylpXYenAc3PxpH7yJHIYAXhJKkDvBq
	x/gqEXlQsT4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FE4815B9;
	Fri, 20 Nov 2009 02:53:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6323C815B8; Fri, 20 Nov
 2009 02:53:38 -0500 (EST)
In-Reply-To: <19205.50406.91209.309984@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Fri\, 20 Nov 2009 09\:21\:26 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D38E87E8-D5A9-11DE-974B-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133312>

Paul Mackerras <paulus@samba.org> writes:

> I have no problem with using git difftool if the underlying git is new
> enough, I just don't want gitk to explode when it isn't.

I somehow doubt there are many users who use pre 1.6.3 git but keep their
gitk separately updated to very recent version, so personally I wouldn't
worry too much about this.

> Also, I don't think we should remove the ability for the user to
> choose which external diff tool to use.

This is a larger concern.  Does "difftool" allow use of an arbitrary tool
like how gitk does (I have a suspicion that it is not as flexible)?
