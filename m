From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 16:47:01 -0800
Message-ID: <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
 <alpine.LSU.1.00.0802202221130.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRzbW-0005Rf-H2
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbYBUAr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYBUAr1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:47:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYBUAr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:47:26 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D17D43BB;
	Wed, 20 Feb 2008 19:47:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 28A0543B8; Wed, 20 Feb 2008 19:47:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74582>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So you mean
>
> [url A]
> 	standsFor = B
> 	standsFor = C
>
> ? ;-)
>
> This might be seen as bike-shedding by some, but I think that it is 
> actually worthwhile to kick back and forth some ideas, and pick the best 
> one.

It appears that Daniel and I disagree which one we should
consider canonical and which one substitute.  I tend to think
what you would see in the mailing list announce (B and C) are
canonical and you rewrite them to adjust to your local needs
(A).  But Daniel has a point that to the environment that needs
to access the repository as A, that name is the canonical one.

I am not very much interested in resolving which one is which.

In either case, I think a good approach to take is to find a
wording that conveys the notion "I will use A to mean what some
other people might call B or C" unambiguously.

When you have the above in $HOME/.gitconfig, it would mean 
"To me, A stands for B or C".  If you have it in .git/config of
the project, you are saying "When pushing/fetching in this
repository, A stands for B or C".  I think that is a reasonable
way to express what we want.
