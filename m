From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 20:47:34 -0700
Message-ID: <451B45D6.1010006@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 05:48:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmsZ-00061q-Er
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031349AbWI1Drl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031352AbWI1Drk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:47:40 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:61047 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031349AbWI1Drj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:47:39 -0400
Received: by py-out-1112.google.com with SMTP id n25so557737pyg
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 20:47:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pTtZKw8WAxyQUv80OnrHUO40T112I3thSC6qUbht2EYS8Zb4vYgktuBdgW6Z+cqNPAB0qxgj+7LM4LJ/Gbegn/bqkvPWX1qKKkp6H0Wqd3aa4iwtPrOc8dOlW9UZr9eUPGcOE9QkYU/1aT+FIzS1x4asuVJMNvtquc5XiYmlw2Q=
Received: by 10.65.121.9 with SMTP id y9mr1131959qbm;
        Wed, 27 Sep 2006 20:47:38 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id q14sm1606633qbq.2006.09.27.20.47.36;
        Wed, 27 Sep 2006 20:47:38 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Jeff King <peff@peff.net>
In-Reply-To: <20060927173335.GC2807@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27977>

Jeff King wrote:
[...]
> One thing that I believe some people have requested for subprojects is
> to avoid downloading files/history for subprojects you're not interested
> in.  I think this could be faciliated in this scheme by only cloning the
> heads of the subprojects you're interested in (there would need to be
> special machinery to handle this at the root level if we want to allow
> making root commits without necessarily having all of the subprojects).

In what I'm suggesting, commits are local to a project's working 
directory repository and are pushed somewhere else to be recorded long 
term. Since projects are stand alone, possibly with dependencies, 
working on a (sub)project without having other associated (sub)projects 
is accomplished by checking it out.

> A first step to this would be an argument to git-clone to allow cloning
> only a subset of refs.

Something like this?

	git-init-db
	git-fetch <repository> <refspecs>
