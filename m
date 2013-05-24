From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 09:22:53 +0100
Message-ID: <20130524082253.GY27005@serenity.lan>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 24 10:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfnHd-0003rv-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 10:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab3EXIXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 04:23:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:51829 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3EXIXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 04:23:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 21484CDA633;
	Fri, 24 May 2013 09:23:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUBitSKB1KTv; Fri, 24 May 2013 09:23:04 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B3E5ECDA63A;
	Fri, 24 May 2013 09:22:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130523235711.GJ12252@machine.or.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225333>

On Fri, May 24, 2013 at 01:57:12AM +0200, Petr Baudis wrote:
>   Just to clear up on what the best practice is, I'd imagine the setup
> to be something like:
> 
> 	(a) Makefile contains inclusion of Makefile.include.
> 
> 	(b) There is a file like Makefile.include.template containing
> 	a template to be copied over and filled by the user.
> 
> 	(c) Makefile contains code that makes sure all variables that
> 	are supposed to be set are set and obsolete variables are not,
> 	since there is no mechanism to cause e.g. a merge conflict
> 	on change of Makefile.include.template.
> 
> Is there a better way to solve this?

I think the best practice would be what Git itself does ;-)

The Makefile sets default values for all parameters, some of which are
inferred based on the system.  It then includes config.mak, which allows
the user to override any of these values.
