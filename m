From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 06 Apr 2012 10:14:15 -0700
Message-ID: <7vobr4236g.fsf@alter.siamese.dyndns.org>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 19:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGCjx-000563-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 19:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab2DFROT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 13:14:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756945Ab2DFROS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 13:14:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFBDB786F;
	Fri,  6 Apr 2012 13:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYvpwUgqJ0LdmJlumZza8uv3t8I=; b=b7oAev
	dW1VetWEXwt3XjhrOyEAZ4DDUO4+jsJvjZKvEWArKxb7e0KjxwrBHTgYvqP6ffI2
	nUPQ2/je/bLfNWpFYIJM22dwJ72rigFwfVO/4OlMWsIuaOeeAstm9wYcmlA6PqVH
	3GKmD7Ais7dPIi+ii/rD+PpgJYSMhKSTdnkM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTMHd9IndR4hElJ0QPwWHeo0e/Odhhal
	Ss/o8hXhkP09l7i9ldU5wk3/W/QW67VnolEuYomMHkyhMeMmAbMtxFgkzlJVk2PB
	5cRr2NqTCKrLNxMMPiKixziaaLUPWIwy1/MUvx9Brp4H3VmkMjLwjSnU3593R9Do
	S5zGZyqdug8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B53FC786E;
	Fri,  6 Apr 2012 13:14:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469A0786D; Fri,  6 Apr 2012
 13:14:17 -0400 (EDT)
In-Reply-To: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Fri, 6 Apr 2012 15:21:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0F2DB40-800B-11E1-B5E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194883>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
> while applying the patches, the author has to be fixed manually.
>
> This option allows to always specify the author of the commit in the
> body of the message, even if the committer is the author.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I wouldn't say that the existing option names to send-email are great, but
I have to say that the one added by this is simply horrible ;-)

The first paragraph of the proposed commit log message states the problem
it tries to address very clearly, which is good, but is "From: " the only
thing that needs this?  I am wondering if this should be named and behave
more like "--duplicate-header" or "--in-body-header".
