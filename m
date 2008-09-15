From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Mon, 15 Sep 2008 16:36:55 -0700
Message-ID: <7v63ox9e20.fsf@gitster.siamese.dyndns.org>
References: <200809160048.31443.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:38:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfNe4-0002XN-Rf
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 01:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYIOXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 19:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYIOXhI
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 19:37:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbYIOXhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 19:37:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55C1761269;
	Mon, 15 Sep 2008 19:37:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9848D61267; Mon, 15 Sep 2008 19:36:57 -0400 (EDT)
In-Reply-To: <200809160048.31443.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 16 Sep 2008 00:48:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32904070-837F-11DD-B786-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95956>

Thomas Rast <trast@student.ethz.ch> writes:

> The merge says
>
>   Trying simple merge with 5b3e4bb1c2d88d6967fb575729fbfc86df5eaec9
>   Simple merge did not work, trying automatic merge.
>   Auto-merging foo
>   ERROR: Merge conflict in foo
>   fatal: merge program failed
>   Automated merge did not work.
>   Should not be doing an Octopus.
>   Merge with strategy octopus failed.
>
> So far so good.  However, 'git status' claims
> ...  This behaviour is
> identical for 1.5.6 and 1.6.0.2, so it is not caused by the merge
> rewrite as a builtin.  Shouldn't it either really clean up, or really
> leave the repo in a conflicted merge state?  (I'm following up with a
> patch that turns the above into a test.  Octopus doesn't really have
> many tests, does it?)

Your analysis is correct --- this has been the correct/established
behaviour of Octopus from day one.

Read the second from the last line of what you were told by git.  Run "git
reset --hard" after that, perhaps.
