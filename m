From: Steve Walker <steve@idibu.com>
Subject: Re: Issue updating files during a checkout from a remote push
Date: Thu, 6 Nov 2008 18:17:54 +0100
Message-ID: <09C2A669-2B99-4490-9C95-FCCD76C03D61@idibu.com>
References: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:19:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8WD-0008TX-Qy
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbYKFRS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbYKFRS1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:18:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49697 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYKFRS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:18:27 -0500
Received: from [192.168.0.198] (static-109-195-228-77.ipcom.comunitel.net [77.228.195.109])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1Ky8Uz16eH-0002oi; Thu, 06 Nov 2008 18:18:25 +0100
In-Reply-To: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
X-Mailer: Apple Mail (2.929.2)
X-Provags-ID: V01U2FsdGVkX19jmel08PbIto3RT+meJtyTIp10NCTiWoV0SgF
 9DhCwK31v2a7Q46VAToxwbL2yUUE8XSmyVzj6MxVkn2+Pwc8an
 YguhFA7S8RR8Lh5RZr/srye/wYlBb0i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100249>

Sorry to keep answering my own questions directly after posting...

I just tried with a 'git commit -f' and the files updated.

Can anyone tell me if this is good practice? I would have thought a  
normal commit would update from index to head - isnt always forcing it  
creating potentially bad merges?

Kind regards, Steve.

On Nov 6, 2008, at 6:04 PM, Steve Walker wrote:

> Hi there,
>
> Hoping someone could point me in the right direction here.
>
> The overall issue is that with files that have been pushed into our  
> repo on our server, when we then check out into local working copy  
> the new files appear, but the updated files dont update even though  
> the output suggests it has. The flow I'm doing:
>
> 1. The file I'm testing an update to is this:
>
> -rw-r--r--   1 root    www-data       0 2008-11-06 16:13 steve-git- 
> test3.txt
>
> 2. On my local box I change file, add it, commit, then push it from  
> my local box to our server repo:
>
> StevePoota:public_html steve$ vi steve-git-test3.txt
> StevePoota:public_html steve$ git add steve-git-test3.txt
> StevePoota:public_html steve$ git commit
> Created commit e29b724: testing only
> 1 files changed, 1 insertions(+), 0 deletions(-)
> StevePoota:public_html steve$ git push ssh://idibu.com/home/beta_idibu/public_html 
>  master:master
> Counting objects: 5, done.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 272 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> To ssh://idibu.com/home/beta_idibu/public_html
>   a28332a..e29b724  master -> master
>
> 3. It all looks good, on my server if i do a 'git log' I can see in  
> the latest update:
>
> oneworld:/home/beta_idibu/public_html# git log
> commit e29b7246beab458d6a7b53cb245a5596adc8c198
> Author: Steve <steve@StevePoota.local>
> Date:   Thu Nov 6 17:55:21 2008 +0100
>
>    testing only
>
> 4. So I check out:
>
> oneworld:/home/beta_idibu/public_html# git checkout master
> M	.gitignore
> M	steve-git-test.txt
> M	steve-git-test2.txt
> M	steve-git-test3.txt
> Already on branch "master"
> oneworld:/home/beta_idibu/public_html#
>
> and its telling me that file has been modified
>
> but checking my file it hasnt changed by date stamp, and looking  
> insie the file my changes arent there :((
>
> -rw-r--r--   1 root    www-data       0 2008-11-06 16:13 steve-git- 
> test3.txt
>
> I'm stumped. I tried 777'ing that file temporarily in case git  
> couldnt write to that file on checkout. What is strange is that when  
> I add new files to the system it works - for example this file I'm  
> testing no was originally added to the server via an external push.
>
> If anyone could give me some help I'd be very grateful.
>
> Kind regards, Steve.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

www.idibu.co.uk
steve@idibu.com

Sales: +44 (0)800 311 2750
Support: +44 (0)870 626 4268
Fax: +44 (0)8701 417 136

Mobile: +34 661 785 387
www.linkedin.com/in/stevejwalker
