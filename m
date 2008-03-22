From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 17:32:39 -0700
Message-ID: <7vtzizmwd4.fsf@gitster.siamese.dyndns.org>
References: <47E3DD28.4030302@tiscali.it>
 <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org>
 <32541b130803211057h22310557ne605e39e6b894e11@mail.gmail.com>
 <alpine.LFD.1.00.0803211105190.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, Frank <streamlake@tiscali.it>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 01:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcrfu-0002fz-T2
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 01:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYCVAcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbYCVAct
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 20:32:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYCVAcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 20:32:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C6C8208F;
	Fri, 21 Mar 2008 20:32:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DC38F208E; Fri, 21 Mar 2008 20:32:41 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803211105190.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Fri, 21 Mar 2008 11:09:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77778>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I agree, in this case the "remove files that go away first" would work 
> around the problem, and we could look into whether that is reasonable in 
> some cases, but in general it's not trivial either.

I think we have two phase "remove then create" in git-apply for an
entirely different reason (we do check before doing any removal or
creation).

> My personal guess is that it's probably better to start teaching git about 
> case-broken filesystem, even if we start it with some common special case 
> rather than getting every case right from the beginning.

Hmm.  I have to say I am not very enthused by the prospect, as I agree
with your reasoning in your earlier message why this has been lower
priority ("sane people when forced to use case corrupting systems avoid
problematic paths to make this a non-issue anyway").  My feeling is that
this falls into the "when we are bored to death and have absolutely
nothing better to do" category.
