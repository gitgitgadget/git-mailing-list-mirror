From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: hook for rebase --continue
Date: Wed, 09 Nov 2011 18:47:19 -0600
Message-ID: <4EBB1F17.4060907@gmail.com>
References: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 01:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROInh-0003eN-89
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 01:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367Ab1KJArY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 19:47:24 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42028 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347Ab1KJArY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 19:47:24 -0500
Received: by ywf7 with SMTP id 7so2336072ywf.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=H6oPnK8Iqx4grFoJX+nlNwBFiKVasbqUJZNP1dmXYAY=;
        b=DWMWVz32PoSZ/31AY+Bx49Em5W7mDa2p96FTwOH+dUyKIeyuVH7EyFtVtyO9gCiy+q
         V715bOZtXxEQGX9wT759hd4r8+2aZhRJr5OUgYopXEzZrDsR+BfRbID9ALEAZd0eRZhZ
         1l54sWeTlERKNqFpP1Tcd/wjcAtsAS/Ov0hiY=
Received: by 10.101.149.28 with SMTP id b28mr2409607ano.53.1320886043524;
        Wed, 09 Nov 2011 16:47:23 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id i67sm9973835yhm.16.2011.11.09.16.47.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 16:47:22 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185178>

On 11/7/2011 1:42 PM, Matt Graham wrote:
> I did some testing and it appears that during a rebase, if I resolve
> a conflict and call git rebase --continue, the pre-commit hook
> doesn't run.  This means that if I don't resolve the conflict
> correctly, our check for invalid syntax doesn't get run and creates
> the risk that someone could push code with invalid syntax, not
> realizing that the check didn't run.
>
> Does anyone else share my expectation that the pre-commit hook
> should run during a rebase? Or at least for the first commit
> following a rebase conflict?
>
> If not, is there another hook that is triggered by a rebase that I
> should be using instead?
>
You could try creating an alias (e.g. "git rebase-continue") in your 
gitconfig that runs the desired validation logic and then executes git 
rebase.  Then you would run "git rebase-continue" instead of "git rebase 
--continue".

v/r,
neal
