From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: git-svn: how to connect SVN branches?
Date: Thu, 17 Jan 2008 23:42:53 +0000
Message-ID: <C3B5987D.112BA%jefferis@gmail.com>
References: <alpine.LNX.0.999999.0801171237110.3479@mojave>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <dherring@ll.mit.edu>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFeOL-0004bl-Ue
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 00:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbYAQXmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 18:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbYAQXmw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 18:42:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:25017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbYAQXmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 18:42:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409935ugc.16
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 15:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=l3zFIYzrqRIlEx9pSRADXfPHdW3/yKS6UgflS219jjk=;
        b=SkWVYp34TF54yfowePrVEtKVZ+E7nLzVKlX5P7EF1L+q7lsY9owTNKJuB9X8BrpLK5iJBTIt9aUI91DVl2sfiGwediYWsKqKpVIO8RnSVUF+0bixhxnnMecEAjuCxKAw4e1Wc8H9Rm7cdoyf7D1GgG0XXS2jaWF6rUPzjZof9vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=ga6LQXI2wAcN39yImeK52szwaGC8G5lKRsIpNMSv7gsb09YXZIgbZXcLJSW6rJbuZ8DUAiN/+07G16jbPBCIM16OUJpKq3B5/RQ5oxwdVW95VxcoelXz8to2GVFkJd5y8bDgjDtd3NUc43WKDJNm/I2bUTO8nDsLFe9gQ8wylPY=
Received: by 10.67.15.15 with SMTP id s15mr3946650ugi.27.1200613369522;
        Thu, 17 Jan 2008 15:42:49 -0800 (PST)
Received: from ?10.0.0.41? ( [85.243.108.153])
        by mx.google.com with ESMTPS id p10sm856898gvf.8.2008.01.17.15.42.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Jan 2008 15:42:48 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: git-svn: how to connect SVN branches?
Thread-Index: AchZYq1Y7BIPf8VVEdyzjAAUURoPUg==
In-Reply-To: <alpine.LNX.0.999999.0801171237110.3479@mojave>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70938>

Re connecting the two svn histories, there are some similarities to a
situation that I had.  See:

Statement of problem:
http://permalink.gmane.org/gmane.comp.version-control.git/69486

Eventual solution:
http://thread.gmane.org/gmane.comp.version-control.git/69486

Nicely formatted code snippet:
http://pastie.textmate.org/private/pv1n1nbmcmtxnxbq4zd7w

Best,

Greg.

On 17/1/08 20:17, "dherring@ll.mit.edu" <dherring@ll.mit.edu> wrote:

> Hi,
> 
> The project I'm tracking changed servers a couple months ago.  To simulate
> the svn-switch, I edited the svn-remote.url to the new location.  `git-svn
> fetch`, `git-svn dcommit`, and the like seemed to work ok.
> 
> When a new release branch came out, I tried adding
> svn-remote.branches = releases/*:refs/remotes/svn/*
> 
> `git-svn fetch` pulled the new branch.  However, it created a whole new
> history for this branch (new git commits from the beginning of the SVN
> repo).
> 
> Is there some way to tell git/git-svn to connect these two histories?
> 
> Pictorially, I have
> 
> SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
> SVN1@b---SVN2@b---SVN3@b---SVN4@b---SVNbranch
> 
> and want
> 
> SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
>                                   \--SVNbranch
> 
> Similarly, if someone cloned a git repo full of git-svn-id's (which
> indicate that an svn --switch occurred) but without any matching git-svn
> data, is there a way to `git-svn fetch` from the new SVN repo and
> autoconnect the git commits?
> 
> Thanks,
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
