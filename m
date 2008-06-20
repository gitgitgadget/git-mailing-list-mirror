From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 01:46:57 -0700
Message-ID: <7v3an8o5mm.fsf@gitster.siamese.dyndns.org>
References: <20080620082034.GA24913@elte.hu>
 <7v7icko61g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9cHx-0007gk-RQ
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYFTIrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYFTIrO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:47:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYFTIrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:47:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 70A2F1EA73;
	Fri, 20 Jun 2008 04:47:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A288A1EA72; Fri, 20 Jun 2008 04:47:05 -0400 (EDT)
In-Reply-To: <7v7icko61g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 20 Jun 2008 01:38:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78942E7A-3EA5-11DD-9560-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85608>

Junio C Hamano <gitster@pobox.com> writes:

> Ingo Molnar <mingo@elte.hu> writes:
>
>>     a) -R is not recognized by git-diff (so i cannot just standardize 
>>        myself on -R and have to waste neurons on remembering the 
>>        distinction ;-)
>
> Huh?  Have you actually tried "git diff -R"?  My copy of git 1.0.0 knows
> about it.  What year are you still in ;-)?
>
> If you apply the output of
>
> 	git diff -R HEAD^..HEAD
>
> to your tree, you can revert the tip commit.  It is the same as
>
> 	git diff HEAD..HEAD^
>
> If you want to write a forward diff in an obscure way, you could say
>
> 	git diff -R HEAD..HEAD^

By the way, not linking --reverse (traverse the history normally and then
show the commits in the reverse order than usual) to -R (show diff in the
opposite way while showing the change each commit introduces) allows you
to even say "log --reverse -R", which did not come from a conscious
design, but being able to say this _is_ a conscious design:

	$ git fetch j6t
	$ git log --reverse -p ..j6t/for-junio

When I review a branch somebody else offers me, I may want to view the
commits on them in reverse order (so that they build a bit by bit on top
of my tree), but I _certainly_ do not want to view the patch in reverse!
