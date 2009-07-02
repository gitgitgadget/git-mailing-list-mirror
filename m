From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace  differences
Date: Thu, 02 Jul 2009 12:45:44 -0700
Message-ID: <7vhbxu6f87.fsf@alter.siamese.dyndns.org>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 21:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMSEE-0000E7-L9
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 21:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbZGBTpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 15:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZGBTpm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 15:45:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60564 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZGBTpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 15:45:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702194545.UYGC17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Jul 2009 15:45:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id B7lk1c0094aMwMQ037lkUz; Thu, 02 Jul 2009 15:45:44 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=SK8bdSSw-t4A:10 a=pGLkceISAAAA:8
 a=_19rZtNrHiMOo2YxpWEA:9 a=2hU45b3lbyaHigd9OS0A:7
 a=I6w09kYei0Y37WPhvmGqRu9pbwkA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 2 Jul 2009 21\:28\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122667>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Sorry for repying to myself here, but I'm not convinced again. Or to
> be more specific: I think this kind of refactoring is totally out of
> the scope of this patch. So although I agree with you in priciple, if
> you don't mind I'll keep the first two patches simpler and less
> invasive. I'll look into the refactoring as a third step.

I am not interested in applying "this adds a broken ignore-whitespace
option, but as long as you do not use it, it does not hurt the carefully
crafted apply-with-context-whose-ws-breakage-was-fixed codepath."  For
example, I am not convinced at all that your patch does not break the 
update_pre_post_images() nor do I know what text the final pre/postimage
will happen to end up with.  In other words, I do not see a clear logic in
the change.

Also about the broken "only prefix matches" loop, I do not understand why
you would want to consider this preimage from the patch

	"this  has extra whitespace and other stuff\n"

matches the target line

	"this has extra whitespace\n"

only because the prefix matches.

For that matter, I do not think I understand why the leading whitespaces
of s1 and s2 are skipped only when they both begin with a whitespace,
either.

I do not want to be looking at this series until it gets into a bit more
reviewable shape, which I would expect to take at least a week if you are
not working on this full-time (and I presume nobody on the git list is).

Please do not Cc me in the meantime, but please do ask for help from other
people interested in this topic on the list.
