From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push: Interpret $GIT_DIR/branches in a Cogito
 compatible way
Date: Tue, 11 Nov 2008 09:25:44 -0800
Message-ID: <7vod0m18fb.fsf@gitster.siamese.dyndns.org>
References: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7viqqv410q.fsf@gitster.siamese.dyndns.org>
 <20081111083704.GA4075@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Tue Nov 11 18:27:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzx1d-0002Yo-By
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbYKKR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYKKR0N
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:26:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYKKR0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:26:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 14C98968D4;
	Tue, 11 Nov 2008 12:26:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 724F3968C7; Tue,
 11 Nov 2008 12:25:48 -0500 (EST)
In-Reply-To: <20081111083704.GA4075@auto.tuwien.ac.at> (Martin Koegler's
 message of "Tue, 11 Nov 2008 09:37:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D54EF6AE-B015-11DD-A4B7-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100658>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> Nobody else seemd to be interessted in this topic, so its difficult to
> start a discussion.
>
> I would suggest to queue it in pu for some time and wait for other
> feedback.
>
>> While I'd personally agree matching with whatever cg-push used to do might
>> make the most sense in the end, I am not sure changing of behaviour
>> abruptly like this is a good idea.
>
> I'm open for any suggestion, how to make this change smoothly. I
> think, that doing such a behaviour change should be OK for 1.6.1 or
> 1.6.2:
>
> Until v1.5.4 (9 month ago), git-push with # was totally broken. Daniel
> Barkalow fixed the fetch case in v1.5.4. As a side effect, git-push no
> longer fails, but ignores everything after #. So in my option, the
> current behaviour was created by chance.
>
>> I am also not so sure url#branch is illogical; I'd suggest dropping that
>> line from the commit log message in any case.
>
> OK, I'll drop it in the next version.

Thanks for detailed explanation of the background.

Everything you said makes sense.  You convinced me that this is just a
bugfix that does not warrant a deprecation notice nor waiting for a flag
day release.  I'm even inclined to say that we should apply this
eventually to 'maint' (which means we'd fork a topic branch from maint,
merge that first to next and then to master and eventually to maint to be
included in 1.6.0.X, while the change will go to 1.6.1 as well).

Does the patch apply to 'maint' right now?
