From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 13:12:39 +0400
Message-ID: <20070329091239.GA8905@hermes>
References: <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru> <7vwt107a3g.fsf@assigned-by-dhcp.cox.net> <20070329082908.GH59098@codelabs.ru> <7v7it04fbo.fsf@assigned-by-dhcp.cox.net> <20070329085834.GJ59098@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 29 11:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWqgX-00057O-2C
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 11:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbXC2JMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 05:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbXC2JMb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 05:12:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:10569 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbXC2JMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 05:12:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so461334uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 02:12:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=CeFW4yZqpQm/AX/htxZ1iBhI00Fxe+SftguZLgz+fhDBVpSAs4igYQcYdXMjvgpmwGxAJV2+cqAVkTq/g/0FAynBKq+Nil72BdknMwsOVyL+edYzq60M71JEviepUqioRStxWXgpQv+QfQF/QowUz4k96RQ0GKpBrX75KtsLsv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=bR+SIpnukjZHEJoHTBApSDflYBi0qiUv3CK2VEBLVNWhbbFRI1cVOU0XEM8FGOtQjopzvba+Qdi/DCfC7reyKs6N2/orhaZo/0yC3kTV0glddnsUXzzAP9U53t74MACpbs6RZJ8IMKeSumdWTnHwxthlwzsqBz2k8HVwYnSNZOk=
Received: by 10.67.71.15 with SMTP id y15mr1059761ugk.1175159549072;
        Thu, 29 Mar 2007 02:12:29 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id 72sm1423424ugb.2007.03.29.02.12.27;
        Thu, 29 Mar 2007 02:12:28 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 13:12:41 +0400 (MSD)
Mail-Followup-To: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070329085834.GJ59098@codelabs.ru>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43421>

On Thu, Mar 29, 2007 at 12:58:35PM +0400, Eygene Ryabinkin wrote:
> Ah, you mean that './configure --with-tcltk=wish8.4' should also
> do the trick? It seems to be easy to achieve by just skipping
> the 'test -x' part in the configure.ac. So the semantics of
> '--with-tcltk=PATH' will be:
> "If you're telling me about the path to the interpreter, it is
> you who should take care of it. I do not mind if you will give
> me something unexecutable, unexistent and so on.". Comments?

Definitely, when cross compiling, or generating packages, you often
don't even have the program installed in the right place, so erroring
out is the wrong thing to do in this case.

  Tom
