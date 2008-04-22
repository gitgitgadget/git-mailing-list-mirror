From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 13:45:05 -0700
Message-ID: <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
References: <20080409200836.GA19248@mithlond>
 <20080409203453.GA10370@sigill.intra.peff.net>
 <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local>
 <20080416034823.GA11727@sigill.intra.peff.net>
 <alpine.LNX.1.00.0804161126280.19665@iabervon.org>
 <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
 <20080422105658.GA11238@sigill.intra.peff.net>
 <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
 <20080422200550.GB29313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:46:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoPNU-0004q2-BT
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 22:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbYDVUpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbYDVUpX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 16:45:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYDVUpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 16:45:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE31E1F78;
	Tue, 22 Apr 2008 16:45:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C73D91F77; Tue, 22 Apr 2008 16:45:12 -0400 (EDT)
In-Reply-To: <20080422200550.GB29313@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 Apr 2008 16:05:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80165>

Jeff King <peff@peff.net> writes:

> No, the proposal is:
>
>         "git push $there $commit:$name", when $name does not begin with
>         refs/, is interpreted as "git push $there
>         $commit:$prefix/$name", where $prefix is determined by resolving
>         $commit and pulling off its first two directories.
>
> (or maybe this should just be picky and DWIM only for refs/heads and
> refs/tags). So "git push v1.0" is the same as "git push v1.0:v1.0",
> which is the same as "git push refs/tags/v1.0:refs/tags/v1.0".

Where is $there in your example?

Funny but I recall recently running "git push ko v1.5.5.1" and it all
worked as expected...

I thought the original poster's example was

	git push $there $commit:branch2

where $commit happened to be "branch1".  Would we dwim

	git push $there branch1~4:this_is_known_ok

to refs/heads/?
