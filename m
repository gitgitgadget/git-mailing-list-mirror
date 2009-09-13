From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 19:44:29 -0700
Message-ID: <7vfxar5zsi.fsf@alter.siamese.dyndns.org>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 04:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmf53-0007M8-Fz
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 04:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbZIMCoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 22:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZIMCog
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 22:44:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZIMCog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 22:44:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CFDB30DE3;
	Sat, 12 Sep 2009 22:44:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzkeA4i31Xk5NIJHum4UmhBDLr4=; b=l3v7Ca
	mhDwf0WBEkSNLUObEUlrlzCoi9xTG00OYHTjsb5aXpy9PI15ScndVfikitkqoj3k
	JJZGRtLHNRujOfz0DhPrlMRNdp6OX2MkjoJwYk8XLGv3p3oXKbR1aM0RMAEUpAMI
	jG2UtZMNOnZ9Qkg+eq85xJ15AkWhAVTMN5NLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wdZgeLQCB3VJhTvYfpmsSxmB6jlJ5fUg
	TwyagVTG6g3bhu0hTu5QhOR6ec0e413U4AvxCoq37FuA7scmCLDCbLpH/t2foC3k
	H8x9VgromDoZfL6lNIggZuXOxaJRafBPGRaR3Jn3q6TgGXV+LixXMwKzdjChMgP7
	JV5midYyiUU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F4630DE2;
	Sat, 12 Sep 2009 22:44:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC7030DE1; Sat, 12 Sep
 2009 22:44:31 -0400 (EDT)
In-Reply-To: <1252800302-26560-1-git-send-email-nelhage@mit.edu> (Nelson
 Elhage's message of "Sat\, 12 Sep 2009 20\:05\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 605A19C4-A00F-11DE-8F41-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128325>

Nelson Elhage <nelhage@MIT.EDU> writes:

> '-n' is the standard way to specify a dry run for other git commands,
> so make 'git-push' accept it as well.
> ---

Sign-off?

Indeed -n is used in many places for --dry-run, but it is not _the_
standard way.

commit, push (as you identified), reflog, and send-email have --dry-run
but -n is not a synonym for it.  Some of them even use -n as a shorthand
for a more often used option than --dry-run.

So the justification should be more like "push does not any other option
that deserves a short-and-sweet -n better, it will not have any such
option in the future, and --dry-run is very often used that it deserves to
use -n as its short-hand."

I tend to agree with the first two points, but I am not sure about the
third point.  Do people dry-push that often?
