From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git fetch,git merge and git rebase
Date: Thu, 10 Feb 2011 14:00:17 -0600
Message-ID: <4D5443D1.9000904@gmail.com>
References: <1297315789338-6010561.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Akash <bcakashguru@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 21:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pncj6-0004sn-CW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 21:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab1BJUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 15:02:44 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50929 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1BJUCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 15:02:44 -0500
Received: by gxk9 with SMTP id 9so764412gxk.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 12:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Vu0NhK8u+JqiwAzkq6rvyWl+doZ/sqpqWcXbbVmBI/8=;
        b=m5f48VgpoSAk87j+f3uaWjRnJcJLif6LIek3Ih7sgpqrlWESW486JqkMDEtfWVtqgO
         6YmnfsQDM5582I3PB9EcVkzLzgvCq4LHkhPKJlzR4dLg6JcUD3VJaSL0NoDeIkLQJBLQ
         V3S2uyO8SeGMWUaCYBS2TXY4zWduS7d2ZG+H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=e379oDtvSLiZ195iZjZJk/wroF4+v4/rrKFkXsuSMvZQHnmT57WSb4AlgKSGB1a3Y0
         xFLs2RNFmao6yAe69K9oRE8oXl/rJi7MZhT+k5l5+6AOGPx8EMowJ+q/jOcdHkTEW6qK
         STHy2aIsoLx14GxEHvWFF2oc63AS5Zz9mLodY=
Received: by 10.90.232.6 with SMTP id e6mr3194919agh.52.1297368162236;
        Thu, 10 Feb 2011 12:02:42 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id z12sm376128anp.39.2011.02.10.12.02.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 12:02:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1297315789338-6010561.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166497>

On 2/9/2011 11:29 PM, Akash wrote:
>
> Hi,
>
> I am new to git .Can someone explain in simple terms what git fetch,git
> merge and git rebase do?..I tried googling but was very confused after going
> thro it.
>
> Also, can someone prescribe a link which explains git in detail right from
> scratch.
>
>
git fetch:  retrieve the latest version of a branch and store it in the 
/remotes/* "remote tracking branches" of your local repo.  you can view 
these branches with "git branch -a".  Once you have that local copy, you 
can merge it into other branches, checkout objects from it, and run 
diffs against it.  You are not supposed to EVER make commits on a 
remote/* branch.  its sole purpose in life is to maintain an image the 
the corresponding branchs that its tracking in the remote repo.  you 
update that image by performing git fetch.  see man-page for details.

git merge:  merges branch(s) into your current branch.  see man-page for 
details.  lots and lots of details...

git rebase:  takes all the local commits you've made on an old history 
and rewrites them on-top of the new history.  it makes it look like you 
did your work based on the new history instead of the old history.  it 
keeps your history 'linear' instead of having all these merge DAG's in 
your history like git-merge produces.  see man page for details.  lots 
and lots of details are not easy to understand at first...

hope this helps.

v/r,
neal
