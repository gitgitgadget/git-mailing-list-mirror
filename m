From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Sun, 7 Nov 2010 18:20:56 +0530
Message-ID: <20101107125054.GB16474@kytes>
References: <20101107112129.GA30042@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 13:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF4jV-0003CU-Id
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 13:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab0KGMvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 07:51:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32899 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0KGMvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 07:51:04 -0500
Received: by iwn41 with SMTP id 41so2848242iwn.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CEXSoom6KD+I1AtaT44Q+v0/4C/ePkMolKclG7qSHyY=;
        b=qV+Rxf1BKYUL0QU8tqV2iuaj+LrzGnu8q7QsxaxUOTjFbmTPxFdc2uVqK/fiXZbVsF
         IwNgv21HfKVsySD+d5p2r+lAZ6Y+1+TL4WCbx9pZk+LppYW2OVwytJ4NfgEBevgUcKPy
         lgzCpcEPxMtKwDPOsFNct8XgYB+UnFsLHgHKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eNgkenQlGtCYfoG0tkrnUF2W2Y/VF/wchWsN3CDBKMVxw8tR/HFhYxtyNN8oVhToi7
         l6gUUoSRuGp9LrXS5f5v5QFquZJgXv4nR9mqRotoOzH/SDzAVjtu9lztZMbggPhYhRHY
         zOTBq8b9itL8aFzgYjI8Iwf6cB547b9yJgUlU=
Received: by 10.42.176.200 with SMTP id bf8mr346482icb.286.1289134263741;
        Sun, 07 Nov 2010 04:51:03 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d21sm4510164ibg.3.2010.11.07.04.50.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 04:51:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101107112129.GA30042@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160879>

Hi,

Jonathan Nieder writes:
> The svn remote helper project still has a long way to go.  In the
> meantime, the svn-fe plumbing and Tomas's scripted prototype are
> usable.
> 
> Here are some topics that might be roughly in their final form.  If
> you would like to build on one of them, please let me know so I can
> refrain from rewriting that piece of history.
> 
> A merge of these branches is available as
> 
> 	git://repo.or.cz/git/jrn.git vcs-svn-pu

Thanks for doing this! Now we have an up-to-date index that tracks all
our work :)

A note to the others: If we merge too early, we will be forced to
either stick with bad decisions we made prematurely, or revert
them. Therefore, we have decided to develop this on the side, while
reporting progress on the list.

> * jn/svndiff0 (2010-11-06) 24 commits

Yeah, this requires some rigorous testing with real-world deltas. I'll
probably get some EC2 instaces to churn on it after my $EXAMS are over.

> * db/fast-import-cat-blob (2010-11-07) 3 commits
> As David says: "it has some significant consequences".

rr/remote-helper already uses this, but there might be a better way to
do it- we should wait and see.

> * db/svn-fe-dumpfile3 (2010-11-07) 6 commits

You earlier said that it might be possible to justify merging this now
provided we supply a wrapper script to make it easy to invoke.

> * rr/svnfe-tests-no-perl (2010-11-07) 1 commit

Ok.

> * jn/wrappers-no-libz (2010-11-06) 7 commits
> * xx/wrappers-no-libz-svndiff0 (2010-11-07) 2 commits

These two are fairly independent of the rest of the series, no? Maybe
get these merged separately?

> * db/branch-mapper: $gmane/158375

I've have some mapper ideas from the discussion thread following
sb/svn-fe-example. I'll finish it after $EXAMS.

> * tc/remote-helper-usability: $gmane/157860

It has some good ideas that I'm re-using in rr/remote-helper.

> * rr/remote-helper: http://github.com/artagnon/git

First, it's the wrong approach: I've hardcoded FD 3 into run-command
to mean backflow. This ugly inelegant design must be thrown
away. Second, it's very messy, and half the commits aren't even
used.

Anyway, I hope it gets the idea across- there's some functionality I
intend reuse from tc/remote-helper-usability. Also, the "fetch"
command works so long as fetching from revision 0 is requested. So the
immediate priority is to get svn-fe to support incremental imports.

> * sb/svn-fe-example: $gmane/159054

The discussion thread following this has some good observations/
ideas.

-- Ram
