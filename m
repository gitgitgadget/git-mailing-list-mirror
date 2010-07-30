From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "clean" filter breaks git-svn
Date: Fri, 30 Jul 2010 14:21:33 -0700
Message-ID: <7vwrscpswy.fsf@alter.siamese.dyndns.org>
References: <AANLkTikp6PgHyj2ujbuD52884ny88hMyxR1CpsbNAVCJ@mail.gmail.com>
 <20100730203111.GD2448@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Wozniski <godlygeek@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 23:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oex1b-0002Kf-0T
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 23:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab0G3VVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 17:21:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0G3VVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 17:21:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C810C7F78;
	Fri, 30 Jul 2010 17:21:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s3trVwWs5Fv/iRfdpQIZ7Ljq86w=; b=N8poKa
	CwrUb1+TwvMFOqqWRHcagc3XDDaYPy3+dXyjXpBOKvQIVQjDAd83991DEL56yM+g
	rKLDtHH5giMKuQnOMm0aS967ErW3fEku9CRyeHvgCnoz9KxPjq8z/RXjmc3KZ1vF
	Mm+Hbz8zIxqC8pekYxqbNraP3H3Sz2+lDvw4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jKs5P8HlW1c1ZfJhvcXxjfZBmZ2uPL+w
	SiTk/7PJTV7x6tfM6bon/0l63QMvBcwiivpqpJz0LQrPbipQEB7eY6qSfXS4CjX7
	jX5Agv+Hu3ajEOamsDM+uasKOxMKyE7ofUpDzKLgMId0F9qAH35QSHm+fyqaB75d
	su4idpy0Qd4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05116C7F77;
	Fri, 30 Jul 2010 17:21:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CF85C7F76; Fri, 30 Jul
 2010 17:21:35 -0400 (EDT)
In-Reply-To: <20100730203111.GD2448@burratino> (Jonathan Nieder's message of
 "Fri\, 30 Jul 2010 15\:31\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70CF2D90-9C20-11DF-B2A2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152267>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Interesting.  Yeah, that sounds like a bug.
>
> I am not convinced cleaning fetched files is the right thing to do in
> the first place (why not just trust the SVN repo?),...

My knee-jerk reaction was that it isn't even about _trusting_, but
mirroring what happened on the other side of the world faithfully.

If you clean what you got from the other side, and then build on top of
that result, how are you supposed to send your contributions back to the
other side which does not have the same clean-up?
