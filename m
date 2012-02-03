From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 (version B)] gitweb: Allow UTF-8 encoded CGI query
 parameters and  path_info
Date: Fri, 03 Feb 2012 13:09:12 -0800
Message-ID: <7vzkczmxon.fsf@alter.siamese.dyndns.org>
References: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
 <201202022357.29569.jnareb@gmail.com>
 <20120203083935.5d9d4b18@mkiedrowicz.ivo.pl>
 <201202031344.55750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:09:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQNj-0000EJ-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab2BCVJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 16:09:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab2BCVJP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 16:09:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B40D768D;
	Fri,  3 Feb 2012 16:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BTozGAJH3B7l
	fQxCRI9keBjU+js=; b=treCFASNtuFsV4NjfSjdd+Sug83FIfLh1s2DHJJh+KHr
	6r1XFgk8Z66hSTBrxdUlSt1PtKpVvYTEZQ30skCTMdo0Kp89Do9WoDKbFCzYUlWe
	vIP2axUBMPGgvESBkWWCciN5SOTuOuyqcQnMyFcBmJQNLg7hSjpucuncX9S/vzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vzQbdI
	M1cBEEh4LkE7UlMWMbTAO8dC6hfwjpz/siw2Gh0DZC+7WXktaZVjE0jmLQjp9CpH
	P01H64Iv6bkNnDEaODUrPg9vBGSIBiSUPhEGUkbBIqeM9qicoAIurukcfQg5YZPz
	UeL1wQpG5xp9oPk7D8zYChsY40Nwi7q7LGQzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22AD5768C;
	Fri,  3 Feb 2012 16:09:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC6C8768B; Fri,  3 Feb 2012
 16:09:13 -0500 (EST)
In-Reply-To: <201202031344.55750.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 3 Feb 2012 13:44:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53071798-4EAB-11E1-AD22-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189802>

Jakub Narebski <jnareb@gmail.com> writes:

> Gitweb tries hard to properly process UTF-8 data, by marking output
> from git commands and contents of files as UTF-8 with to_utf8()
> subroutine.  This ensures that gitweb would print correctly UTF-8
> e.g. in 'log' and 'commit' views.
>
> Unfortunately it misses another source of potentially Unicode input,
> namely query parameters.  The result is that one cannot search for a

I think two lines should suffice instead of the above two paragraphs.

        Gitweb forgot to turn query parameters into UTF-8. This results=
 in
        a bug that one cannot search for a

> string containing characters outside US-ASCII.  For example searching
> ...

The remainder explains the problem and the solution very well modulo mi=
nor
typos.

> Noticed-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---

We can add "Tested-by:" to this now.  Will queue.

Thanks.
