From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: point to related commands from
 gitignore
Date: Thu, 11 Nov 2010 11:05:08 -0800
Message-ID: <7vwrojfzq3.fsf@alter.siamese.dyndns.org>
References: <1289387440-8509-1-git-send-email-sitaram@atc.tcs.com>
 <20101110185555.GA12365@burratino> <20101110190048.GC12365@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcSi-0002kW-AW
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab0KKTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:05:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0KKTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:05:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76FA73F9C;
	Thu, 11 Nov 2010 14:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gx5qL4ZqwygK0Y8a+duT04OI9Hk=; b=CNmjKj
	BeZeLKDVI5QJLMeqHjshGy1nD4Ri3kP3bzrpEjIi0pR/XflBwPX8PIe2n6j8aTHd
	pACpFzejM2bsVOew3MASBfv9vOPvWb5azMmg0+394BVc72HC37tIn8MkI0R5vY9T
	lgTyzibDK8R7482jt09w/lEmkliiXuZcq5Cj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TKWRJ0qGU4DTdmeF4GlvUB++QxqdLOxw
	zMEbpwIa0uK5PikMlmGQP7CR/jteQ6forVu5qAJ6Y5+YorLWsJSHfaQdUUygEwBJ
	44iXSgG2G65fs+UXZuhYbG5xAtm99wwN+vXakoEYfpzSWOK53I7U9oV/bpja9F0c
	Sqzw3CRzLXQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36D3C3F95;
	Thu, 11 Nov 2010 14:05:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D27603F8D; Thu, 11 Nov 2010
 14:05:16 -0500 (EST)
In-Reply-To: <20101110190048.GC12365@burratino> (Jonathan Nieder's message of
 "Wed\, 10 Nov 2010 13\:00\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A202E29C-EDC6-11DF-ACE4-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161294>

Jonathan Nieder <jrnieder@gmail.com> writes:

> While at it, move a reference to update-index --assume-unchanged from
> the DESCRIPTION to lower down on the page.  This way, the methodical
> reader can benefit from first learning what excludes files do, then
> how they relate to other git facilities.

Looks sensible.

> +To ignore uncommitted changes in a file that is already tracked,
> +use 'git update-index {litdd}assume-unchanged'.
> +
> +To stop tracking a file that is currently tracked, use
> +'git rm --cached'.

I am not very happy with the wording "to do X, use Y" above, though.  For
example, "rm --cached" is a good starting point, but that needs to be
followed by a commit some time in the future to take permanent effect.
The realization that "rm --cached" is a good starting point would come
only with an understanding of what "rm --cached" does (i.e. it removes the
path from the index, preparing for its removal from the future history).

"to do X, see Y" might be a good compromise, because what I am suggesting
by the above is that ideally to say "to do X means doing Z so using Y is a
good way to achieve it", but "... means doing Z" part is explained in the
manual page of Y.

In any case, will queue.  Thanks.
