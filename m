From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 04:48:44 +0300
Message-ID: <20091120014843.GB22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIcR-0006uc-2z
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbZKTBsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbZKTBsv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:48:51 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63913 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498AbZKTBsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:48:50 -0500
Received: by bwz27 with SMTP id 27so3006142bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0fmk5GHG4p3UzALK5CKObX4o1XZ0FjQ+4OIyQBAY63Q=;
        b=AU4poekWXYbyalZaRyOTepg1lk9WXGIgIGgxY6o7g2prWZcaxwEpR6tH7MxtBYVnxP
         eJXWj2hlUnbdsDQRQU83f1SU0lI2lqSLr4VrYgHZIBDZv1ANMEX/jYoolhKfutGPoVLB
         dYl65srkRNBvJKmtZ0SkUpOlo50wK+/JIM8LU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=us5v+gWdHzl53Ehr2fWAi80Q25nxmoksP8q95e3a4vDDTe4jHScV7SMYccWbAAGbqB
         B79yRI+demv3z8Zl1sTk78FOrvXfqK2uPu6L8M7PDtyWFtPG5uEVgl/2SPve0Qasft6H
         Saf6zxGQ3jkhV+DJAY7AFCz0h1b0KjTYCbQ8M=
Received: by 10.204.10.2 with SMTP id n2mr723338bkn.91.1258681735594;
        Thu, 19 Nov 2009 17:48:55 -0800 (PST)
Received: from localhost (ppp91-76-17-113.pppoe.mtu-net.ru [91.76.17.113])
        by mx.google.com with ESMTPS id 14sm307413bwz.5.2009.11.19.17.48.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:48:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <009401ca68bc$7e4b12b0$7ae13810$@com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133292>

On Wed, Nov 18, 2009 at 09:03:31PM -0500, George Dennie wrote:
> 
> For example, the functional notion of the repository seems well
> defined: a growing web of immutable commits each created as either an
> isolated commit or more typically an update and/or merger of one or
> more pre-existing commits. 

In Git, commits are not immutable. One thing that many Git users do
is git-rebase, which in essense is re-writing or re-ordering exising
commits. So, you can change history in Git, but you should never change
the published history. (Of course, that leads to the question what is
considered as published history. For instance, commits merged on the
proposed-updates branch are usually not considered to be "published",
so they can be re-written or discarded later).

So, the correct way to use Git is to find the right balance between
the need to clean up after mistakes (using git-rebase) and not doing
too much, so you will not lose important history or create problems
for other peoples.

> 
> The notion of a shapeless commit is curious. Intuitively, I consider a
> commit as capturing the state of my work at a transactional boundary
> (i.e. a successful unit test...or even lunch break).

No, it is not what Git commits were intended for. In Git, a commit is
a change intended to achieve some goal. Basically, you send a patch
to maintainer, and you should explain what this patch does and why it
is useful... If your explanation is "I have a lunch break now", it is
very bad explanation, thus a bad patch.


Dmitry
