From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Mon, 10 Mar 2008 12:36:20 -0700
Message-ID: <7vwsoaid6z.fsf@gitster.siamese.dyndns.org>
References: <20080304231945.GC24131@artemis.madism.org>
 <7v63vvkplm.fsf@gitster.siamese.dyndns.org>
 <20080310084920.GA2798@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYno6-0002iX-U6
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 20:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYCJTgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 15:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYCJTgb
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 15:36:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYCJTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 15:36:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1D3A2C48;
	Mon, 10 Mar 2008 15:36:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 41AF32C46; Mon, 10 Mar 2008 15:36:22 -0400 (EDT)
In-Reply-To: <20080310084920.GA2798@artemis.madism.org> (Pierre Habouzit's
 message of "Mon, 10 Mar 2008 09:49:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76752>

Pierre Habouzit <madcoder@debian.org> writes:

>   We could of course have a .def member in the struct rev_info, and use
> the one passed to setup_revisions then if it's still NULL, but it
> doesn't really makes sense to me, and I don't really see a problem with
> saying at init time that you'll default to "HEAD". Though if you really
> dislike it that much, I squash a patch that does that on top of it.

Well, it was not liking or disliking.  Although I thought "default" that
sets a value to the default after the parser finds that the user did not
give anything (the approach you described in the above quoted paragraph)
is a natural implementation, probably more so than what you did, I do not
have strong preference either way.

When I see a change where I do not see a reason to, I get suspicious,
wondering if I am missing some bigger reason (e.g. "by moving it there
this and that would become much easier and cleaner, even though it now
forces callers of cmd_log_init() to duplicate the default values").  There
must be an obvious justification you had when you changed it, which I am
not seeing.  Hence that question.

>> Applying this to 'master' and then merging 'pu' shows that there are a few
>> topics that are cooking that would conflict with this change.  Merging
>> 'next' seems to go cleanly (I haven't checked the result), so it is not
>> too bad for me to carrry this at this moment, if we were not this close to
>> the rc freeze.  I dunno.
>
>   Well I can wait longer, I'd just like to see it merged in a not too
> far future, because I have to check for new places that would need
> conversions at each reabase :)

Yeah, that burden can be shifted to me, in other words ;-)
