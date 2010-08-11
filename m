From: David Ripton <dripton@ripton.net>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Tue, 10 Aug 2010 21:05:36 -0400
Message-ID: <4C61F760.4050409@ripton.net>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 03:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oizlr-0007gn-RW
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190Ab0HKBGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 21:06:15 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:34335 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758170Ab0HKBGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:06:13 -0400
Received: from homiemail-a49.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id ECC6B178C17
	for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:06:11 -0700 (PDT)
Received: from homiemail-a49.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTP id 669495E0069;
	Tue, 10 Aug 2010 18:05:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=ripton.net; b=
	CYF6PWIorFbcISXNhcvy4txU/AAXXZv4j/PxxZ6NSdq6l7ffNIeg7bk7BXsV2Ub4
	7cGVlJioy71O5pLN7YkTwd8DyZ/y5xQ4J4UDfZnqsTFGLTFtQ2Tu3Dl9JVD2qD8q
	i47Tf5A+6X/soWen6nAf9X1UDFE76hgPG8RW/QyO+Ng=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=ripton.net; bh=U3AveD
	6v7hM1tMvuNrbucpIV1NA=; b=3v+8H+2huG7lPw7y/tCTDJMLH67TwsoybHKBFc
	8DHnG2HYNla579Fdpg48ZxoEmV8IYX36v4aAXzKtnLeAKQN2JIy1TgT6aAk1nPh8
	pM2iXu6s94/6uGiPiMY6fd+ukS+RaiARLvRXIof7otOG/d7wa9UrqNAfDSjCYMRO
	w/dNE=
Received: from [192.168.2.175] (pool-98-118-245-254.clppva.fios.verizon.net [98.118.245.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTPSA id 129535E005F;
	Tue, 10 Aug 2010 18:05:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100808 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153181>

On 08/10/10 15:02, Bradley Wagner wrote:
> I realize there are a lot of different Git workflows but I'm wondering
> how others in this community do it.
>
> We're using our "master" branch from our central repo (Beanstalk) as a
> dev branch and we have stable branches for various release versions of
> our software.
>
> We've not made as heavy use of feature branches yet as we should have.
> Once we do start using them more regularly, what kind of stuff is ever
> committed directly to "master" or is master typically the place where
> things are merged into from other stable/features branches?
>
> Is "master" really even unstable at that point?

If your repo is accessible to the public then I think it makes sense to 
have master be stable.  Because that's what people will see by default 
if they clone your repo, and you want to make a good first impression.

If it's a private repo that only insiders are allowed to see, then it 
doesn't matter as much.

Our team uses unstable master, which anyone on the team can push to.  If 
someone pushes to it then a build and tests automatically run, and if 
they succeed then that commit gets automatically pushed to the stable 
branch.  We let anyone create shared branches on the server if they want 
to collaborate on a feature.  We make a tag for each release, but we 
don't make a maintenance branch until we actually need it.

-- 
David Ripton    dripton@ripton.net
