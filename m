From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Sat, 19 Dec 2009 11:13:09 -0800
Message-ID: <7vskb6bwvu.fsf@alter.siamese.dyndns.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net>
 <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
 <20091219153046.GG25474@genesis.frugalware.org>
 <vpqeimq51pq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, Moe <moe@signalbeam.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Dec 19 20:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM4lO-0006Pp-0B
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 20:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbZLSTNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 14:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZLSTNY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 14:13:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZLSTNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 14:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F1DAA8EB4;
	Sat, 19 Dec 2009 14:13:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xd8BCWplu71tudY62fLgnes+GpY=; b=CqToWk
	QQ4vV3oYxYE32FzQ0v+2UOWmBxTlDjq0qeH+jGSSgM/YcH7FGxJ2+PsC5qphHjKX
	5Fv+gULzC9tT8niyBY5kTXgpp095CfjFCyGiVTMzEUCpTq/7GPZZvgBvzWQTyaNJ
	VZ2o6ciSAdwVowhGaTIDIIzhsdN1sPF2E5PVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dXSpjLEe9rlKBAk1gBPPksBAdSU5Rr2S
	TkrA4uMzzZ9yyWJZFYzlDXAIxzKAyHXql1vCOOWADDyzgY/PsLFFr0ftmA/3zHK9
	vaFJc27nS0v7GK6ZtLHpQw0fJFQSG952Ce1MT1h8Cjpy5XzMpGJIhqysnQq19bvD
	A7FG+bu50WI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEB63A8EB3;
	Sat, 19 Dec 2009 14:13:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6830DA8EB2; Sat, 19 Dec 2009
 14:13:11 -0500 (EST)
In-Reply-To: <vpqeimq51pq.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 19 Dec 2009 18\:10\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8FC7C9B2-ECD2-11DE-868A-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135496>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html
>
> It solves the same problem ("set on environment variable, and change
> my whole Git config"), but
>
> * It's a standard. It's really nice to be able to ...
> * It avoids hidden files. With $GIT_CONFIG, a user doing

I think the above are actually three bullet points (i.e. you lack line
break and bullet before "It's really nice").  And the third bullet is more
or less a small subset of the second one, since you need "ls -a" without
making them non-dot,  And I personally don't care very much about that
second "It's really nice to be able to" point.

As to the particular "standard" cited, I don't know how relevant it is to
us at this moment, or in this topic.  Judging from the fact that it
doesn't even define the scope of the standard (e.g. what classes of
applications are expected to follow it, for what benefit do they follow
it, how are they expected to handle differences between their historical
practice and the new world order it introduces, etc. etc....), I suspect
it is a very early draft that will be heavily copyedited before final,
once professional standard writers start looking at it.
