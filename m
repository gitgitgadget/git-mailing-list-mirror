From: Warren Harris <warrensomebody@gmail.com>
Subject: Re: git export to svn
Date: Sat, 25 Oct 2008 13:29:50 -0700
Message-ID: <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain> <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com> <1224965564.2874.49.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:31:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtpnO-0003iw-LG
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbYJYUaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbYJYUaZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:30:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:10665 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYJYUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:30:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1398798wfd.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=YnBeACX2QogzqiW3RFCDIjIeS14AKPxwSWHggguFW5A=;
        b=ZO4xCWx40KUloRwa+97IjUiMQMQ2rZHyMnHZwnp4CvZSBW+wS59bOUnMt8Hn+/0EV8
         V9SHchsu43L6jV41/M8MrHyoc9N0hLWzVl/qTMh7fX0OiNR+Buxm/F3eL2u153IptL+3
         4d1SI8HRUtAF2NbNPry9UHqMg1EFBl3JqO1yE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=djNsWC1kKkgkS3IZKy341un17gAL078bOcj2jZ3lmESuc6Ovi9sL2+eOZ++5PWJs2v
         uFVD1Z3vptjjxilVDfLUBa/yUxPXmCQzucs0aKiPLqjCS1nRyXb2SAF+Zzr53BBZWpEa
         hBAQ1zk7vzb2k3iehZVfFJ+mJXZkvD3AaAffI=
Received: by 10.142.109.8 with SMTP id h8mr1710826wfc.150.1224966624137;
        Sat, 25 Oct 2008 13:30:24 -0700 (PDT)
Received: from ?192.168.0.31? (c-76-102-237-126.hsd1.ca.comcast.net [76.102.237.126])
        by mx.google.com with ESMTPS id 29sm3744135wfg.0.2008.10.25.13.30.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 13:30:22 -0700 (PDT)
In-Reply-To: <1224965564.2874.49.camel@localhost.localdomain>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99126>

I tried a fetch, but still no luck:

$ git svn fetch
W: Ignoring error from SVN, path probably does not exist: (175002): RA  
layer request failed: REPORT of '/svn/!svn/bc/100': Could not read  
chunk size: Secure connection truncated (https://svn)
W: Do not be alarmed at the above message git-svn is just searching  
aggressively for old history.
This may take a while on large repositories
r58084 = c01dadf89b552077da132273485e7569d8694518 (trunk)
	A	...
r58088 = 7916f3a02ad6c759985bd9fb886423c373a72125 (trunk)

$ git svn rebase
Unable to determine upstream SVN information from working tree history

$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/ 
libexec/git-core/git-svn line 425.


Looks like the only option is applying individual patches to preserve  
my history...

Warren


On Oct 25, 2008, at 1:12 PM, J.H. wrote:

> Even with init - your going to need to do a fetch so that you have a
> copy of the svn in your tree - if the git tree you've already got has
> the svn references (take a look at git-log if it seems to have an svn
> line in the log then at some point someone pulled in the svn tree into
> git) if not your going to effectively be pulling the entire svn tree
> into your git tree.
>
> The only other real way to get your changes / patches into svn is to
> dump them out as patches and them individually apply / commit them to
> your svn tree.
>
> - John 'Warthog9' Hawley
>
>
> On Sat, 2008-10-25 at 12:11 -0700, Warren Harris wrote:
>> John,
>>
>> Thanks for your quick reply. I tried that, but got the following  
>> error:
>>
>>
>> $ git clone ../test2/
>> Initialized empty Git repository in /Users/warren/projects/tmp/test2-
>> git-clone/test2/.git/
>> # ...svn test2 dir already created with subdirs trunk, tags and
>> branches...
>> $ git svn init https://svn/svn/SANDBOX/warren/test2 -T trunk -t  
>> tags -
>> b branches
>> Using higher level of URL: https://svn/svn/SANDBOX/warren/test2 => https://svn/svn
>> $ git svn dcommit
>> Can't call method "full_url" on an undefined value at /opt/local/
>> libexec/git-core/git-svn line 425.
>>
>> I then tried the hints from here: http://www.basementcoders.com/2008/9/30/git-svn-gotcha
>> , but still no luck:
>>
>> $ git merge --no-ff master
>> Already up-to-date.
>> $ git svn dcommit
>> Can't call method "full_url" on an undefined value at /opt/local/
>> libexec/git-core/git-svn line 425.
>>
>>
>> Warren
>>
>>
>> On Oct 25, 2008, at 11:43 AM, J.H. wrote:
>>
>>> The basic way you would want to do it, it attach your git tree to  
>>> SVN
>>> and then git svn dcommit - which will replay the uncommitted changes
>>> back into SVN - git svn init will do the attachment - assuming that
>>> your
>>> git / svn repositories are at least based from the same place.
>>>
>>> - John 'Warthog9' Hawley
>>>
>>> On Sat, 2008-10-25 at 11:40 -0700, Warren Harris wrote:
>>>> Is there a way to export a git repository along with its history to
>>>> svn? (git svn init seems to want to go in the other direction.) I
>>>> know
>>>> this is in some sense "going backwards" but I need to commit my  
>>>> work
>>>> to a client. Thanks,
>>>>
>>>> Warren
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
