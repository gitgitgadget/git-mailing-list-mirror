From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:31:24 -0700
Message-ID: <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
 <20080723164614.GB5283@blimp.local>
 <alpine.DEB.1.00.0807231757550.8986@racer>
 <20080723191647.GF5283@blimp.local>
 <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
 <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
 <20080726153802.GA16868@blimp.local>
 <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
 <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org>
 <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:32:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNe4p-0006HP-Ls
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 03:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbYG2Bbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYG2Bbf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:31:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYG2Bbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 21:31:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F3AD540F91;
	Mon, 28 Jul 2008 21:31:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0FCA40F8D; Mon, 28 Jul 2008 21:31:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 28 Jul 2008 18:23:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 14246478-5D0E-11DD-8ABF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90545>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The kernel does caching really well, and the kernel is fast as hell, so 
> _of_course_ when you benchmark, using kernel data structures looks good, 
> especially if you benchmark against code that isn't well written for the 
> particular usage case.

Ok.  While I have your attention on st_ctime, let me ask you a stupid
question.  Why does "rename(old, new)" change st_ctime when you move a
regular file?
