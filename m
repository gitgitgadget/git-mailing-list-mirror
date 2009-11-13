From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 08:10:40 +0900
Message-ID: <20091114081040.6117@nanako3.lavabit.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
	<20091114071946.6117@nanako3.lavabit.com>
	<4AFDE421.5050307@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:15:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N95M3-0000kO-K8
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 00:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbZKMXOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbZKMXOr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 18:14:47 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56999 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbZKMXOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 18:14:46 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 112A511B884;
	Fri, 13 Nov 2009 17:14:50 -0600 (CST)
Received: from 1998.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id L74JMFZG4F5B; Fri, 13 Nov 2009 17:14:50 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=5RsQiqSJ/ZHhprgj2oDpQ2aP1ZvX6PMLs9vQ4TwFOkuHM1OPFZRGT/hW/dgTjB8DIoyjU1kOy2hYfHICZus9ichoWALPDDXSddhIZlJm8qZckpaOaB6UH8MTtaP4rGa7vBXz+E5ZisLtBfuRXq+XW4Z/4ZGBVd7Ec4rz0O8oq5g=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4AFDE421.5050307@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132850>

Quoting Raman Gupta <rocketraman@fastmail.fm>

> Nanako Shiraishi wrote:
>>  .Update maint to new release
>>  [caption="Recipe: "]
>>  =====================================
>> -* `git checkout maint`
>> -* `git merge master`
>> +* `git checkout maint`
>> +* `git merge --ff-only master`
>>  =====================================
>>  
>> -This 'should' fast forward 'maint' from 'master'. If it is not a fast
>> -forward, then 'maint' contained some commits that were not included on
>> +This should fast-forward 'maint' from 'master'. If it is not a
>> +fast-forward, then 'maint' contained some commits that were not included on
>>  'master', which means that the recent feature release could be missing
>> -some fixes made on 'maint'. The exception is if there were any commits
>> -that were cherry-picked to 'maint' as described above in "Merging
>> -upwards". In this case, the merge will not be a fast forward.
>
> I noticed you removed the discussion I added about the situation in
> which maint will *not* be a subset of master i.e. when the user has
> cherry-picked commits from other branches. This type of cherry-pick is
> described as a valid operation, though one to generally be avoided
> earlier in the man page. If we tell users that the occasional
> cherry-pick to maint is ok, then shouldn't we explain how that affects
> the release process?

It is irrelevant that you can cherry-pick to 'maint'.

You can, and Junio does, cherry-pick some commits from master to 
maint from time to time. But even if you have such cherry-picked 
commits on the maintenance branch, the result, with zero or more 
other maintenance commits on top, is always merged back to the 
master branch (you can look at "gitk origin/maint origin/master" 
to see yourself).

So when Junio tags the release from the tip of the master branch, 
it is a superset of the maintenace branch; it is irrelevant if 
maint has some commits that are cherry-picked from master.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
