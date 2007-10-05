From: Clark Williams <clark.williams@gmail.com>
Subject: Re: Problems using StGit and -rt kernel patchset
Date: Fri, 05 Oct 2007 12:28:52 -0500
Message-ID: <47067454.3060003@gmail.com>
References: <4703A4EE.3000002@gmail.com> <1191591921.7321.63.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 05 19:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqzE-0006PA-HM
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 19:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236AbXJER3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbXJER3H
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 13:29:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:34936 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929AbXJER3G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 13:29:06 -0400
Received: by wx-out-0506.google.com with SMTP id h31so538356wxd
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=SmSjUs8sR0Av6hamEq0STG0RU3HKn2UqvQL6/JshNr8=;
        b=SO+2OOUxVA1zLHIDnD+KQBkSrc/clC3JR4o/qWwUC3Ebh1Z42hzUI3RDbB3PtuGL8WatpqH8cKuKlBB5GWR0N9gS4lvymIGnoKdS73DaN7jG/T5En5g01Euv9PRnvodtSEbY8wtJ78wzqKX+jNAwY+ufadfwI0btdyw7+El8yB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=WUsLQAxYpzc4Rtm81JNDQHW8LGrftiv67C6vy4KNxWP9NO0bBP1o4ZVt4Wa+nX9yvlF6BLQobYFNLPuiV5XrbRTryyNQXGP/F2CbHq8pYu5R5HLNpHQ1amt9ZEQxhfQKKDFQvvGP9/tV6UwFC/5RlpChww4u6XMD4xaakaI+U1s=
Received: by 10.70.28.9 with SMTP id b9mr3674004wxb.1191605344864;
        Fri, 05 Oct 2007 10:29:04 -0700 (PDT)
Received: from ?172.16.16.136? ( [66.187.231.200])
        by mx.google.com with ESMTPS id i17sm3670555wxd.2007.10.05.10.29.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Oct 2007 10:29:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <1191591921.7321.63.camel@pc1117.cambridge.arm.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60118>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Catalin Marinas wrote:
> Clark,
> 
> What version of StGIT are you using? You might use a too new GIT with an
> older StGIT or maybe there are just some bugs in StGIT.
> 

$ stg --version
Stacked GIT 0.13
git version 1.5.3.3
Python version 2.5.1 (r251:54863, Sep 14 2007, 10:49:05)
[GCC 4.1.2 20070821 (Red Hat 4.1.2-23)]


> On Wed, 2007-10-03 at 09:19 -0500, Clark Williams wrote:
>> I've been working on the -rt patch series for the kernel and would like to to use
>> StGit to manage the patches. Unfortunately I've had limited success, so I thought I'd
>> ask the git/stgit community if what I'm doing is wrong.
>>
>> I clone Linus's tree to a common directory, then clone it locally to work:
>>
>> $ git clone -s -l /home/src/linux-2.6.git scratch.git
>> $ cd scratch.git
>> $ stg init
>> $ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc8
>> $ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc8-rt1/series
>> <fix the things quilt lets through and stg barfs on, like malformed email addresses>
> 
> If git-quiltimport behaves better with malformed patches, use it and run
> 'stg uncommit -n 368' afterwards (the 'uncommit' takes some other useful
> options as well, see --help).

Ah, I *knew* I had seen a git import command go by on the list. I may try that.

> 
>> <watch 368 patches be applied and committed>
>> <work work work>
> 
> Do you modify any of the -rt patches or you create new ones?

I've modified patches in the past, but normally I just apply patches on top of the
- -rt patchset

> 
>> <get a new patch queue>
>> $ (cd /home/src/linux-2.6.git && git pull)
>> $ stg pull
>> $ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc9
>> $ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc9-rt1/series
>> Checking for changes in the working directory ... done
>> stg import: env git-commit-tree 520b9d0db6a1142271a68b2b38cca002be40f6cb -p
>> da0a81e98c06aa0d1e05b9012c2b2facb1807e12 failed (fatal:
>> da0a81e98c06aa0d1e05b9012c2b2facb1807e12 is not a valid 'commit' object)
> 
> I'm not sure why the first import worked. It seems that StGIT uses the
> tag id (da0a81e9) rather than the corresponding commit id (3146b39c). I
> remember having this problem in the past when creating branches and I
> fixed StGIT to always get the corresponding commit id. Using
> 'v2.6.23-rc9^{commit}' as the 'branch' argument rather than just the tag
> should fix the problem.
> 

Gah, I just realized I typoed the above stg branch. It should have been named
rt-2.6.23-rc9-rt1.

Hmmm, you're saying that when I want to create a branch that's based on a particular
tag, I need to use this:

$ stg branch --create rt-2.6.23-rc9-rt1 v2.6.23-rc9^{commit}

That is, add '^{commit}' to the tag I want to base from?

>> At this point I'm clueless as to:
>>
>> 1. What I've done wrong
> 
> Probably nothing (just hidden features of StGIT :-))
> 
>> 2. How to recover/debug this
> 
> You can recreate the branch with the commit rather than tag id. With a
> sufficiently new StGIT, you could use 'stg rebase <id>' on the branch. I
> assume that no patch was pushed because import failed (though the first
> imported patch might be in an undefined state and can be removed).
> 

I'm not really sure that 'stg rebase' is what I want, since I tend to go back and
forth between -rt kernel and would like to leave them alone (i.e. not rebase the
rt-2.6.23-rt8 branch to rt-2.6.23-rt9, but just create a new branch). Possibly I'm
missing a usage for stg rebase?


Thanks for the ideas. I'll go try some out right now!

clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHBnRUqA4JVb61b9cRAvoPAJsG4Ej3J6mSuHeT6KEpiRF33+4dcgCglmvT
18DbpCixAt/x+Ug0pUn24cw=
=oL/g
-----END PGP SIGNATURE-----
