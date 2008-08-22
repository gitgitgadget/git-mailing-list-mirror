From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Fri, 22 Aug 2008 14:09:35 -0700
Message-ID: <7vzln492pc.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Alex Riesen <fork0@users.sourceforge.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWduK-0005TN-5x
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbYHVVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYHVVJu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:09:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYHVVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:09:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0836865363;
	Fri, 22 Aug 2008 17:09:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3E1E165361; Fri, 22 Aug 2008 17:09:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6FC6302-708E-11DD-97EB-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93365>

Jeff King <peff@peff.net> writes:

>> For git commit --author abbreviations at least I would typically need
>> only very few entries (be it per repo or globally), which means they can
>> be much shorter (than my mua aliases) in order to be unique, and I don't
>> really want an extra file for that.
>
> I think this depends on your situation. In your case, it sounds like you
> want to configure a few names that frequently have --author fields for
> your specific workflow. For me, even though only 1% of the people in my
> mua's alias file might send me patches, 99% of the people I would want
> to use --author on are in my mua's alias file.
>
> So while there are may only be a few needed entries, they are already
> there for me. Of course, I don't really use --author much, since most
> people I talk to are already git users. ;) So I am extrapolating a bit.

Another potential source of this information is the existing commits.  If
you are communicating with the same set of people already, you already
have the information in your repository.  I suspect Michael's "selected
few co-workers that would comfortably fit in a small list of config
entries without need for any external text file" use case would be better
served by an approach to look into existing commits.

I often use "git who Jeff" alias to fill the recipient of my e-mails with
this alias:

    [alias]
        who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"
        one = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\" \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9][0-9][0-9]$/)/\"' -"
