From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Stash during incomplete merge
Date: Wed, 29 Feb 2012 13:34:25 -0600
Message-ID: <4F4E7DC1.1050700@gmail.com>
References: <4F4A7BC7.5010702@cisco.com> <4F4D377B.2000206@gmail.com> <4F4D5408.3060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2pIC-00088p-TB
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569Ab2B2TeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 14:34:23 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64165 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab2B2TeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 14:34:22 -0500
Received: by yenl12 with SMTP id l12so1514031yen.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 11:34:21 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.186.1 as permitted sender) client-ip=10.236.186.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.186.1 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.186.1])
        by 10.236.186.1 with SMTP id v1mr2761571yhm.4.1330544061994 (num_hops = 1);
        Wed, 29 Feb 2012 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8S/IqKphcAkxwOgZEdc09G+5FYuhjGubHK4Z9NehBZc=;
        b=TuHt4qlHbISnS9thQx04sU8Njxyn6qt0oZxFQM66kb0fWFhF/aNvXCMuCJtqkOUQLf
         8R0F4T5wl5Z2Xo0K5LsYGTCqg1AlUCZ8nJSthvYRoYakCjODPMkx2zK/EJK1adfpAcC3
         8rVaW0CpIie/wx7IDqDB/pRqZhiBgP3L6Nwss=
Received: by 10.236.186.1 with SMTP id v1mr2194727yhm.4.1330544061955;
        Wed, 29 Feb 2012 11:34:21 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id r68sm58256745yhm.18.2012.02.29.11.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 11:34:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F4D5408.3060505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191848>

On 2/28/2012 4:24 PM, Neal Kreitzinger wrote:
> On 2/28/2012 2:22 PM, Neal Kreitzinger wrote:
>>
>> You may also want to consider the --keep-index option on your "git
>>  stash save" if your "testing" workflow doesn't involve adds or
>> commits before the git stash apply/pop.
>>
> the very limited case I had in mind (and probably incorrect
> assumption) about your "testing" workflow was:
>
> hack merge-conflicts $ git add conflict-resolution
> (conflict-resolution is in worktree and index) hack
> conflict-resolution with extra stuff (original conflict-resolution
> is still in index) uh-oh, i got carried away and started doing extra
> stuff (evil merge) and forgot to finish testing just the
> conflict-resolutions (pure merge-commit) $ git stash --keep-index
> (conflict-resolution is still in index and now back in wokrtree)
> finish testing just the conflict-resolutions (merge-commit-to-be)
> (conflict resolutions worked (I knew they would)) $ git stash pop
> (original conflict resolution is still in index, but extra-stuff is
> back in worktree) $ git commit (commit the
> conflict-resolutions/merge-commit) $ git add foo $ git commit (new
> foo stuff committed after merge commit)
>
This imaginary scenario I proposed for --keep-index can get a
merge-conflict on the pop so its invalid.  Please disregard it.  Sorry
for the bum scoop.

v/r,
neal
