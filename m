From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 04 Jun 2008 11:00:41 -0700 (PDT)
Message-ID: <m363spyta3.fsf@localhost.localdomain>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
	<20080604154523.GA25747@kroah.com>
	<7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xIr-0004b7-1e
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYFDSAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbYFDSAq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:00:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:9194 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbYFDSAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:00:45 -0400
Received: by ug-out-1314.google.com with SMTP id h2so345687ugf.16
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=PmAAWV9nYDU20zglKj8bUEo/g6DkRKSFtxCNU8mmnqA=;
        b=DVn75hDykZyea+ya32+DV5LY0W6mXbGaSVZqLB4WZBkNcBHyYcvjDSZuQgXFdqCT6/
         zhZVdVUUov3YWTkuZa+2RVUXMrFhxiQCA9k7YnYqzCCRasghbKO1uSpznBN3Cjt8P1aV
         EwYAg+X4328wNjTPMdjEfR7djGdqv8Xoabiqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=UkPSYxwsal8KwKnOXAgeS4JQ4J7rx7XsBOSRLlzK81IpQ80zHyV0o9kE/XoR3O3nVv
         QBy3YZm6m5PABTi2Q1CJmuN5rn7I31kZ0P2A3fxHWcSmZ1clhzMRNeg9bTsu64Vm0VOu
         tPXbJgfU602LVVvOXzdnKckyur8AEx2kvKKM0=
Received: by 10.210.18.8 with SMTP id 8mr222691ebr.80.1212602442088;
        Wed, 04 Jun 2008 11:00:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.131])
        by mx.google.com with ESMTPS id k5sm2287990nfd.22.2008.06.04.11.00.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 11:00:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54I0dNp012743;
	Wed, 4 Jun 2008 20:00:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m54I0b9o012740;
	Wed, 4 Jun 2008 20:00:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83800>

Junio C Hamano <gitster@pobox.com> writes:

> Greg KH <greg@kroah.com> writes:
> 
>>> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>>> error: Unable to find fdcce40226d7d4273a08cc4ef84bb25755a710a4 under http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
>> ...
>> It looks like git over http isn't following the link somehow to the main
>> repo?
> 
> Yeah, see above.  www.kernel.org does not like to serve /home/ftp/pub/scm
> path; it wants to serve it as /pub/scm/linux instead.
> 
> Your objects/info/alternates in 2.6.24.y points at /pub/scm/linux/kernel/git/torvalds/...
> but in 2.6.25.y it has extra /home/ftp in front of it.
> 
> A quick fix is obviously to remove the extra prefix but it makes me wonder
> how these two "stable" repositories were prepared differently.  Could this
> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
> repository slightly differently between them?

Errr... isn't it the case for objects/info/http-alternates ?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
