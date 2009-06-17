From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 15:58:03 +0200
Message-ID: <4A38F66B.4050604@gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com> <20090617102332.GA32353@coredump.intra.peff.net> <4A38D408.7000302@op5.se> <4A38EACD.3050602@gmail.com> <4A38ECB2.6010100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGvfN-0002vU-0l
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635AbZFQN6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933630AbZFQN6P
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:58:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:24079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933601AbZFQN6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 09:58:14 -0400
Received: by fg-out-1718.google.com with SMTP id 16so113424fgg.17
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dKbbIoUAdQKze6d7c4D+zlQk9j03btqjz5Ukn2N68hA=;
        b=VDvcTMk9XHIouqNeZo2HBxl/Fsa1DD0uP/FMH/OkYyv6fzyB6ZP2Uh3mYu5cYgvrS5
         x7FuXbKhRbCK7sIOFCqgSvQJbdEC4+sx3DE9LutTVtWxwmwNq4/ubZXZq5Mmy7kRGGKm
         paJw6SDfYL1Y+lfuK39HExskvsvDjeozz6M/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fa3C8TGMJTrLisezlUJTm09Jc9XgVxjqyNbhwszVdTRe4VvC1pk8GKxFY/n0QxFv6D
         sns524Feol0FXxgpJ8D69yFn4alAQ46WhKgLfX8NbahBnLdgEHgIPVn7w3JTB2x5i+/J
         bYMm8d9/RAqnLOcRYc1lWwb6/FOdN84XHPMJU=
Received: by 10.86.68.10 with SMTP id q10mr553354fga.78.1245247094886;
        Wed, 17 Jun 2009 06:58:14 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id d6sm1645640fga.27.2009.06.17.06.58.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 06:58:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <4A38ECB2.6010100@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121747>


> Sounds neat. Do you by any chance have some performance measurements
> for it? If the work's already done and it provides a significant
> improvement I'm all for it ;-)

It's very very fast, but only as fast as a backtracking matcher can be. 
  I think it would trounce glibc on my regex but probably not on the 
buggy one.

Paolo
