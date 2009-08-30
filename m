From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: git svn pointing at svn branch instead of trunk?
Date: Sun, 30 Aug 2009 22:30:39 +0200
Message-ID: <1251664239.31273.11.camel@localhost>
References: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 30 22:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhr39-0001mh-2t
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbZH3Uap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060AbZH3Uap
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:30:45 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34014 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbZH3Uao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:30:44 -0400
Received: by ewy2 with SMTP id 2so3496803ewy.17
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=QoyTcTvpH3XaWdel2LDH1vYXR8ElrV1dJ5vBav0MQKw=;
        b=ZjYaY9Bou8d+GdOT50yD1bEU4SII2ummPzxw8Au2wDOmP+xSB/VrdEt7kFE8oj6k+a
         zLUF/L99zSEHMF9tH7ZGU62lhh5tI8XkkSEUebe2VqMLpZ3jXc1CbQakU/60+387AHkD
         jlOKiOamYr55BjrNxbUbw2/vvhGqdgTLhaIdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sjV1+gDGW2RY/CEt9+9LWe3mEolFRjWafD0VqDjb/17evRoaRFhyR8KPU4ADJjTTlI
         8f9Ib+X9LklNUTuru3gP6MU2VOzrfd0ipmtlHiH0cVO4pIsBHftIo93kXEh4nskwV6oQ
         cJioh0TBxJai899RasRPbbDW17d+fSAVrl+FQ=
Received: by 10.210.135.7 with SMTP id i7mr3442996ebd.6.1251664245768;
        Sun, 30 Aug 2009 13:30:45 -0700 (PDT)
Received: from ?192.168.1.2? (host185-69-dynamic.2-87-r.retail.telecomitalia.it [87.2.69.185])
        by mx.google.com with ESMTPS id 10sm704187eyd.4.2009.08.30.13.30.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Aug 2009 13:30:45 -0700 (PDT)
In-Reply-To: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
X-Mailer: Evolution 2.24.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127431>

Il giorno sab, 22/08/2009 alle 11.40 -0700, skillzero@gmail.com ha
scritto:
> When I used git svn to clone a repository, it ended up pointing master
> at a tag in svn instead of trunk. For example, git svn info shows the
> URL for the tag instead of trunk. git log master also shows the most
> recent commit is the creation of that tag in svn, but then the next
> commit is the most recent commit to trunk. It's like it's mixing
> things from the tag with things from trunk. The most recent commit in
> svn was to create the tag that master is now pointing to in case that
> matters.

I had the same problem a while ago.

When git-svn is done cloning you find yourself in the "master" branch
(check by executing git branch) and it's content is the last svn-commit.
If the last svn commit is a tag or in a branch you'll end up in that
tag/branch

> Is there something in the svn repository that might cause this? What's
> the correct way to reset what git svn thinks master should point to?
> And how should I get rid of the commit on master that created the tag
> without messing up git svn (e.g. can I just git reset or will that
> confuse git svn later?).

execute:
git branch -r

it will list all the remote branches:

usually one will be "trunk"

if you now execute:

git reset --hard remotes/trunk

it will reset your current local branch (master) to the remote trunk and
will start to truck that remote branch (trunk)

I'm a git newbie, so if i said something wrong I hope someone will
correct me.

Cheers,
Daniele
