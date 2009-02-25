From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push
Date: Tue, 24 Feb 2009 23:01:38 -0800
Message-ID: <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 08:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDnc-0000Cu-84
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZBYHBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 02:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZBYHBw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:01:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbZBYHBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 02:01:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 67E739D0BF;
	Wed, 25 Feb 2009 02:01:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 646049D0BE; Wed,
 25 Feb 2009 02:01:42 -0500 (EST)
In-Reply-To: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
 (John Tapsell's message of "Wed, 25 Feb 2009 06:38:41 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29D41668-030A-11DE-9A19-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111379>

John Tapsell <johnflux@gmail.com> writes:

>   Following the idea of 'least damage', what do people think of making
> "git push" only push the branch you are currently on?

Having an easy way to ask to push only one branch (typically the currently
checked-out one) is a good thing.  You can obviously say "git push origin
master" (or whatever branch you are on).  We also added "git push origin
HEAD".  I thought we even added "git push HEAD" or "git push --current",
but I may be mistaken.

But if you are talking about changing the default when "git push" is run
without any parameter, I have to say it is a terrible idea, for two
reasons, and one is too obvious to state so I wouldn't repeat it and talk
only about the other one.

I've noticed that people who ask for such a default tend to push too often
and worse they tend to push before they have their act together.  Surely
their other branches may not be ready, but it is likely their current
branch isn't either ;-)

If you shoot for the least damage for such people, the sanest default for
"git push" would be to do nothing.  You *always* say what to push where,
then there is no risk of pushing something you did not intend to.  Perhaps
"push.default = never" configuration may not be such a bad idea?
