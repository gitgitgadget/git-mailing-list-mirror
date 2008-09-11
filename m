From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 18:01:12 +0200
Message-ID: <48C940C8.6040407@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdod6-0005AN-0G
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 18:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbYIKQBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 12:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbYIKQBU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 12:01:20 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:11053 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011AbYIKQBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 12:01:18 -0400
Received: by rn-out-0910.google.com with SMTP id k40so287400rnd.17
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=R0nqX85ncEhHpd2pemAioRGIGmra/pFCZq8Ss+Qgg38=;
        b=A/dvfMZYiYz4icPpMXkPqoclY+2MhU3LiAGlN/nieroSHLlus2aMdI6N0JhuLnQO6C
         em7ZIHp2RDHUZmAI8lXEYkS6MFvAS7v/IzTs1HDcinNuQ+39Op5Kk7dVycRMC9j9+zir
         X3vZZJO0OTLOaTGuxcb609Gc7ps1X+JHBgtOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=heuMAejxk1FvGBiTMafm61tXwI5oWpCdE0j8W++h5DfCwSUw6lXB2tBl433N2Q6UVv
         0hNkv2dBN0qQjARXnN2L0LY2owQSG5+n4SXWdkrJ9lfhnhRfRVQZMHX1esO9ZN22azr2
         /1VjbaoBsFrqojNsLdfdyzZzOvc/VI9oBZi7M=
Received: by 10.86.90.13 with SMTP id n13mr2180910fgb.50.1221148875912;
        Thu, 11 Sep 2008 09:01:15 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id l12sm10960705fgb.6.2008.09.11.09.01.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 09:01:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95617>


>> If you fetch just branches A, B and C, but not D, the origin link from A
>> to D is dangling.  Once you have fetched D as well [..]
> 
> So I just said we deleted beanch 'D', so there's no way to ever fetch it 
> again.
> 
> Get it?

Yes, but you should not have used Stephen's proposed new option to git
cherry-pick, just like you shouldn't have used the existing -x option.
"-x" would not have created a dangling reference, but it would have
created a puzzling commit message.

> The fact is, a big part of git is temporary branches. It's one of the 
> *best* features of git. Throw-away stuff. Those throw-away branches are 
> often done for initial development, and then the final result is often a 
> cleaned-up version. Often using rebase or cherry-picking or any number of 
> things.

These days I doubt people would use cherry-pick, they would probably use
interactive rebase.  But anyway, exactly for the same reason...

> "git cherry-pick" DOES NOT PUT THE ORIGINAL SHA1 IN THE 
> COMMENT FIELD BY DEFAULT.

... neither should cherry-picking create the origin link by default.
Only if requested by the user, using a new option that is basically "-x"
done in a different way.  Just like "-x", it should not be used when
cherry-picking from private branches.

But say someone does it, then what happens?  If people clone the branch,
the reference will be basically unusable.  But since "git gc" does not
delete the referenced commit, at least the origin commit is still
available in the repository where the cherry-pick was made.  It is
debatable whether it is better or worse than "-x".

Can we discuss instead a generic way to have porcelain-level metadata,
immutable or at least versioned, for the commit objects?  (This is the
same kind of metadata as the author or committer, which clearly have
nothing to do with the git plumbing.)  Do you have any proposal of saner
semantics, not for the origin link but for commit references within this
kind of metadata in general?

Paolo
