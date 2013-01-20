From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] INSTALL: git-p4 doesn't support Python 3
Date: Sun, 20 Jan 2013 11:54:38 -0800
Message-ID: <7vd2wzljep.fsf@alter.siamese.dyndns.org>
References: <20130120110620.GJ31172@serenity.lan>
 <7vwqv7lm6b.fsf@alter.siamese.dyndns.org>
 <20130120192831.GB7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0yt-0002cz-7U
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3ATTym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:54:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317Ab3ATTym (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:54:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CCA5A193;
	Sun, 20 Jan 2013 14:54:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3YkbEgM6Qdq1DHo1DVH5d82yXJ8=; b=SGnaDD
	Mza8dXXZ4G1QYZVG2hvgxijEE3q3ra50ekYqWshZ7ESvP7rstB7SmAa4MD2YQn8V
	btKfH1vQl2QpOwyfKOhNYsPocGze4mGIAstbnsDysad0YnNBQG4JLwkFYmUcN+q/
	B3s4Zl0KW1otNkQdvrS+37AniStkwMDb8LC5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WG1RT6gp8SIAdIgJdkzGpYbdhHU//4ux
	taeCM6rfjyfb17PYIM627JTxhzF7gnKXh3ePh1BbPPVMVOuJYJqvOlLuPpUcrjc+
	5Q4704Iym7fQ10j5N1Pg7+SQkSYAphnp3igTWXu9lJZKWQLr57HsTZ+llvlCm0Dg
	AZhWJBhXgts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3243EA191;
	Sun, 20 Jan 2013 14:54:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 840ACA18F; Sun, 20 Jan 2013
 14:54:40 -0500 (EST)
In-Reply-To: <20130120192831.GB7498@serenity.lan> (John Keeping's message of
 "Sun, 20 Jan 2013 19:28:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A37D6DA-633B-11E2-9C33-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214041>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 20, 2013 at 10:54:52AM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>>> git-p4 supports Python 2.6 and later versions of Python 2.  Since Python
>>> 2.8 will never exist [1], it is most concise to just list the supported
>>> versions.
>> 
>> Thanks; Eric's patch recently updated git-p4.py to require 2.4 I
>> think. Shouldn't it also be updated?
>
> I haven't done a thorough audit to check what the actual minimum
> supported version is, this is just the minimal change to say "not
> Python 3".
>
> Personally, I'm not sure of the value of having version checks at the
> top of the Python scripts, I would rather set a project-wide minimum
> supported version (as in my recent CodingGuidelines patch) and check it
> once in the Makefile.

OK; I'll leave that for later a day (Cc'ed Eric but stakeholders of
other Python scripts may want to express their opinions), and will
apply this patch as is.

If we end up deciding to rip out the "prerequisite per file", that
will be a tree-wide change that is independent from your patch we
are discussing in this thread.  If we end up not doing that, then we
would instead be updating git-p4.py to set a higher floor to the
prerequiste but that can come as a separate patch.

Thanks.
