From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 18:13:16 -0700
Message-ID: <7v7ic6tnir.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
 <200807010146.09206.chriscool@tuxfamily.org>
 <7vej6etra7.fsf@gitster.siamese.dyndns.org>
 <200807010220.44657.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 03:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDURv-00053B-JK
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 03:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbYGABN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 21:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbYGABN3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 21:13:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570AbYGABN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 21:13:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AE0019BA9;
	Mon, 30 Jun 2008 21:13:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2BDA819BA7; Mon, 30 Jun 2008 21:13:19 -0400 (EDT)
In-Reply-To: <200807010220.44657.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 1 Jul 2008 02:20:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E81FA536-470A-11DD-AB38-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86977>

Christian Couder <chriscool@tuxfamily.org> writes:

> Another option is to introduce a switch to "git bisect start", 
> perhaps --strict, to please people who always want to use good revs that 
> are ancestor of the bad revs, so they get a nice error when this is not the 
> case.

I do not see much niceness value to such an option, though.  I think such
a switch is going the opposite way from improving usability.

You cannot bisect the history with such a draconian switch when you learn
from somebody that 'maint' is Ok but 'master' is broken, and you already
know it is a regression somewhere introduced in 'master', because you know
you did _not_ fix it (or at least you do not remember fixing it) only for
'maint'.
