From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Wed, 27 Jun 2012 00:54:47 -0500
Message-ID: <4FEAA027.7050307@gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com> <4FE4C0F7.2080309@gmail.com> <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com> <4FE50411.8080800@gmail.com> <CAE1pOi24EVq__XzxtBoAryzQ+F=sAy8-hY23M-P4YoQFXdpSSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 07:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjlDM-0005bJ-OS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 07:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab2F0Fyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 01:54:53 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51535 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2F0Fyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 01:54:51 -0400
Received: by gglu4 with SMTP id u4so630051ggl.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 22:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=46oP0TInAjcW5dwkCFvFHDx46MfZmybiNdH6zsMfz7c=;
        b=sWTVbnvtyelGOGKkA02ZWgwadCy2UX7uyF/CoRwfGaMOCfFVckv9oPmIBT6eBnwZEM
         4Z6O4rE7pHU+otSjgiyLqxbK4UtQtsKWh4CCMFZryTmL4p8+j+5bNWUlyH3c6Ua4ghJp
         ti9YP/LZOGubrS8sVDiM2P/sqvtAvF4Sz6V3k9EzLklpFFzsLi/bJRqO/reN+FafYe0+
         F9+C1RRDld47OG0/ss0ETekiq8GuEiBoQJZl2rfq0WNNb22KFGb7EM75fL3xnL3hPEzx
         RpRdCSRui1j55Y54NuKSv6ZrEMbZxzDoH0OpE3hDr8dH0OpE8n/d25YbEwTzSNIBLo2+
         3/hA==
Received: by 10.101.87.7 with SMTP id p7mr6265066anl.52.1340776490738;
        Tue, 26 Jun 2012 22:54:50 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p3sm62491117ano.11.2012.06.26.22.54.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 22:54:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAE1pOi24EVq__XzxtBoAryzQ+F=sAy8-hY23M-P4YoQFXdpSSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200702>

On 6/25/2012 9:49 PM, Hilco Wijbenga wrote:
> On 22 June 2012 16:47, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
>> On 6/22/2012 3:18 PM, Hilco Wijbenga wrote:
>>>
>>> On 22 June 2012 12:01, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
>>>> On 6/22/2012 12:53 PM, Hilco Wijbenga wrote:
>>>>>
>>>>> One of my developers managed to push something that somehow "diverged"
>>>>> origin/master from everyone else's local master.
>>>>>
>>>>> A --> B --> C --> D (everybody's local master)
>>>>> |
>>>>> \--> B' --> C' --> D' --> E (origin/master)
>>>>>
>>>>> (i.e., A is the commit where things diverged; everyone's local master
>>>>> points to D but the new commit (E) that was pushed to origin/master
>>>>> uses different SHA1s for B, C, and D)...
>>>>>
>>>>>
>>>>> Now running git pull creates a merge commit joining D and E.
>>>>>
>>>>> ...Does anyone have any idea as to what might have happened? Perhaps if
>>>>> I
>>>>>
>>>>> understand how this happened I might be able to prevent it from
>>>>> happening again.
>>>>>
>>>> Some ways you can prevent it from happening again:
>>>
>>>> (2) have your devs do git pull --ff-only
>>>
>>> Is this something that can be set in git config? I looked but didn't
>>> see anything obvious.
>>
>> OTTOMH, you could change the git fetch config for master and take away the
>> leading '+' sign which would not allow non-fastforward fetches of master.
>>   That in turn would prevent merging such a non-ff remote tracking branch of
>> master into your branch master.
>>
>>
>> Actually, I guess what I really want is
>>> something for git push, right?
>>>
>> Some ways to do it:
>> (1) I think you could have rebase and commit hooks locally that prevent
>> someone from rewriting history on master.  That in turn would prevent
>> someone from pushing a rewritten history.
> Yes, I have been thinking about that.
>
> How does one create "portable" hooks? I have to deal with GNU/Linux,
> OS X, and MS Windows. We all have Java installed so I first thought of
> using JGit but I am not clear on how well JGit supports using it in a
> hooks. Should I make Ruby a required part of the dev environment and
> use Ruby hooks?
I don't know about java, ruby, or JGit (yet).  I make hook updates easy 
with this alias:

get-hooks = !rm -f .git/hooks/pre-commit && git init 
--template=/opt/mydir/git-templates/dev/templates

I update the master copy of the pre-commit hook (in this case) in the 
template and then have the users run git get-hooks.  All my users are on 
the linux server.  Maybe this idea is helpful to you in some way.
>
>> (2) When merging topic branches to master use git merge --ff-only.  Then
>> when you push it to remote master you know it's a fastforward and not a
>> history rewrite.
> Given how hard it is to teach devs to only push fast-forward merges, I
> am not sure how well this would work.
>
You could create an alias 'git merger' and have them run that and it 
will do the --ff-only option.  Maybe post-merge hook and/or pre-commit 
hook.  I don't think --ff-only was part of your requirements so you can 
probably ignore this since I got off track by suggesting it.  I think 
your problem is history rewrites and not merge commits.  I think (1) 
--ff-only denies merge commits altogether, and (2) denyNonFastForwards 
allows merge commits but denies history rewrites so they (1 and 2) are 
not really the same though they both use the term 'fastforward' they 
have different definitions of what that means.  Someone please correct 
me if I'm wrong because this does seem a bit confusing now that I'm 
saying it out loud.

v/r,
neal
