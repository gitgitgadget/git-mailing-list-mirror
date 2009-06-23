From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 15:28:04 +0200
Message-ID: <4A40D864.8040208@gmail.com>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 15:28:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ62y-0002cz-Gx
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 15:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZFWN2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbZFWN2N
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 09:28:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:50449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbZFWN2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 09:28:12 -0400
Received: by fg-out-1718.google.com with SMTP id d23so20271fga.17
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wv+wMXP2nYNfad5sEgC49BficlppSVvUK4WwVv4pDEE=;
        b=cn4EWC4YGFrfd9Rg4kjcG55Qn2aIUQROV4f9yIpQZvKhojDECdfZZcK4WswlL+Piu6
         UNMVz9PAP415cJLxYT45o6wDN3eFVuO/rmgH0+rfptesf2S4ENmNewRht5lj25msWJcQ
         NnnUpwBJbNg+d6u50lFmF19qR8zhhhLAHqxlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HtQe86sX6eX7HD7zhmrKSA3FGRlUOGDDSulOfCX9uj6XrDXJoTt7GwVwpeVOgyQAUY
         sE2Okw6Mkgp8mLGJ7pNQE3OBQc7JdeSE//d4CJE+16fE2do9POzCkKFt1JLbsyFHxZNA
         WLk+RPJ+aTbVGjEmW/mHRVUQoq2wuTpShPrn4=
Received: by 10.86.96.12 with SMTP id t12mr130995fgb.77.1245763693873;
        Tue, 23 Jun 2009 06:28:13 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 12sm781816fgg.9.2009.06.23.06.28.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 06:28:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <20090623131131.GA7011@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122089>

Finn Arne Gangstad wrote:
> On Tue, Jun 23, 2009 at 02:59:10PM +0200, Paolo Bonzini wrote:
> [...]
>> Before going on, can you explain your use case for --push=tracking (in a  
>> case where --push=current wouldn't do the same)?
> 
> The idea with "tracking" is to push the current branch to wherever it
> would pull from, making push & pull "equivalent" in some sense.
> 
> This is different from "current" if you have/choose to name the local
> branch something else than the remote branch. This happens a lot when
> using multiple remotes.

Yes, but when using multiple remotes is it really common that:

1) I have the permission to push to them (as opposed to sending a pull 
request)?  If I have permission to push only to the mob branch, for 
example, I would still set my tracking branch to the master branch.

2) I *do* want to push to them often?  If I use tracking for my topic 
branches, push.default=tracking seems a sure way to big mess when I do 
"git push" on the wrong branch.  Instead, with push.default=current "git 
push" would just tell me "new branch created" and then I can do "git 
push branch-name:" to delete the newly created branch.

I don't remember who it was, but when I tried changing the behavior for 
"git push" someone screamed loudly that fetching and pushing are two 
different things, and making things work uniformly across the two is not 
necessarily correct.  The details probably were different, but I think 
that I am saying the same now.

Paolo
