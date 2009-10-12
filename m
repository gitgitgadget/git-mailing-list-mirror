From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Filesystem has no item: Working copy path [...] does not exist
 in repository at /usr/bin/git-svn line 3856
Date: Mon, 12 Oct 2009 23:26:04 +0200
Message-ID: <1255382764.15646.5.camel@localhost>
References: <9accb4400910120848n6a1e4036l5e45ce3882deb5aa@mail.gmail.com>
	 <20091012182018.GA14143@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSYL-0004he-Ps
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbZJLV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbZJLV1N
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:27:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:42417 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbZJLV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:27:12 -0400
Received: by ey-out-2122.google.com with SMTP id 4so2006380eyf.19
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=kTgDEtK1dT2lq5RlYXqixputJeGXQ2va0jjMRucGft0=;
        b=Al4Cy6lfYeO7o77J9tAAT4/wwvIuwbIgHTpIM2oBdW2MNcDQQJMYeuED7FDMu6gfjb
         a8NoT79EoU9ujwyfJicrAb3/OLuMu8TUvq2eOM+CJDc93xeSVSqegcORYW2lG82u1Avw
         fr5iny8juY5adC4/CnUXDFc1hkawgjKg5qXts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HtziKXC9JMQfNNPAHkZ4mOg5XqPYe81ZxtkBtj0x6usayHuUbp54SeGUZ0Zs3Ku1K9
         JILj2zZA6ocfubkWYGK/l1qL4PeVzno0FXYOfX0RkiEmj13NSCb+BBBx4x8E/ChigKSP
         lA5ipvE6zSWN3+fvoxmcmSpbWUwS3wPBScpfI=
Received: by 10.210.7.23 with SMTP id 23mr4657567ebg.38.1255382763989;
        Mon, 12 Oct 2009 14:26:03 -0700 (PDT)
Received: from ?192.168.1.2? (host185-1-dynamic.48-82-r.retail.telecomitalia.it [82.48.1.185])
        by mx.google.com with ESMTPS id 5sm1280664eyh.4.2009.10.12.14.26.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 14:26:02 -0700 (PDT)
In-Reply-To: <20091012182018.GA14143@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130077>

Il giorno lun, 12/10/2009 alle 11.20 -0700, Eric Wong ha scritto:
> First I thought this was a problem fixed in
> 83c2fcff214fe89649fcd88e095d9961a36b53dd (git v1.6.2 or later),
> but then I tried running it just to make sure.

thank you for taking the time

> This is a namespace conflict, the "trunk" ref is conflicting with a
> (what seems to be a miscreated) branch named "trunk".  I anticipated
> this problem originally but figured it was rare/uncommon enough that I
> didn't want to burden users by prefixing all branches with something:
> 
>   ------------------------------------------------------------------------
>   r25364 | michael.hashimoto | 2009-01-21 14:06:53 -0800 (Wed, 21 Jan 2009) | 1 line
>   Changed paths:
>      A /plugins/branches/trunk
> 
>   Created directory 'plugins/branches/trunk'.
>   ------------------------------------------------------------------------
>   r25365 | michael.hashimoto | 2009-01-21 14:07:15 -0800 (Wed, 21 Jan 2009) | 1 line
>   Changed paths:
>      D /plugins/branches/trunk
> 
>   Removed plugins/branches/trunk
> 
> Since it looks pretty obvious that "trunk" was miscreated here from the
> revision history, you can skip these two revisions in your import by
> recontinuing the clone with "git svn fetch -r25365:HEAD"

I thought it could be a problem like this but I asked before re-fetching
all the repository (just to be sure)..

unfurtunately I already deleted all the .git directory so i'll have to
start again...


> Replace:
>   [svn-remote "svn"]
>     branches = plugins/branches/*:refs/remotes/svn/*
> 
> With:
> 
>   [svn-remote "svn"]
>     branches = plugins/branches/*:refs/remotes/svn/branches/*
> 
> I didn't do this by default since I figured very few people would create
> a branch named "trunk" (and those who did, did it accidentally as it
> seems to be the case here).
> 
> Hope that helps.

Yes it really help...

But I'll change it like this instead:
  [svn-remote "svn"]
    url = http://svn.liferay.com/repos/public
    fetch = plugins/trunk:refs/remotes/svn/master
    branches = plugins/branches/*:refs/remotes/svn/*

I think it will do as long as they didn't created some branch named
"master" :)


In this case the repo was public, what should I do to debug some git-svn
issue like that if I encounter a problem with a non-public repo?
May be there is some debug flag I could enable? Or I had to
guess/explore the svn tree?

thank you Eric

regards,
Daniele
