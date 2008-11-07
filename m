From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push and $GIT_DIR/branches
Date: Fri, 07 Nov 2008 14:27:07 -0800
Message-ID: <7vfxm3f9z8.fsf@gitster.siamese.dyndns.org>
References: <20081107082629.GA27158@auto.tuwien.ac.at>
 <7vljvvh61y.fsf@gitster.siamese.dyndns.org>
 <20081107204451.GA10394@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Fri Nov 07 23:29:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZpD-0005z2-CA
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYKGW1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbYKGW1b
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:27:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYKGW1a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:27:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CBF17A16D;
	Fri,  7 Nov 2008 17:27:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 815787A16B; Fri,
  7 Nov 2008 17:27:14 -0500 (EST)
In-Reply-To: <20081107204451.GA10394@auto.tuwien.ac.at> (Martin Koegler's
 message of "Fri, 7 Nov 2008 21:44:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 430E1BFA-AD1B-11DD-BAD8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100352>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> I asume, that you [and probably many other] are not very interrested
> in this feature. But would you accept a patch changing the push
> refspec to HEAD:refs/heads/<head>?

I believe "git-push foo" with .git/branches/foo has worked the way it does
now from day one, so the above change you suggest breaks peoples'
expectations and documented behaviour, _if_ people are using "branches"
with git-push.  It definitely is a no-go to just change the behaviour
without warning and deprecation period, but with a careful transition
plan, I personally do not think there is a fundamental reason not to
improve it (others may disagree).

I do not know what Cogito did when you told it to push with such a
configuration, though.  Its "branches" had quite different semantics from
the concept of "remote" in git.
