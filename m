From: Warren Harris <warrensomebody@gmail.com>
Subject: Re: git export to svn
Date: Sat, 25 Oct 2008 12:11:16 -0700
Message-ID: <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:14:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtoaH-0000Yz-Rk
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 21:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYJYTLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 15:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYJYTLv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 15:11:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:58996 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYJYTLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 15:11:50 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1378426wfd.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=2K8N7OHYweqe4lr6KCwhzu4QL+rYbzCoLhc6LNAAKJ8=;
        b=gMB/rCS9S9Fi7uGX8T13HZRJw2FyGjAQVQbC0Hoh+QLIADKeAQV02tvRibBCCCXZ9z
         NqEUxMrFEGQnAmVahoTRxrkci6hqq2t4I1DtrVa3v8KxMSzXzr6CHWCfu22jSSM+VmLP
         aUz/QGu9EKgECskrYoa+jmTUb3eE6fxAo+USw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=wdh+sHfy65K1+wWwjYioBTcesxotyhrFGoc/t58IXSJoU/+5iwX/DcF4Mph/9NieXn
         XmG0Pgya8N2BZPy+l8H+0W6W3hKf+2Lr6G9xcumDLC4zB2gJtNTHp/ne9ATTh/zgiS4X
         sexPhmxUdzEAoNq4J4YZnRdVOgti4zFKoAUHk=
Received: by 10.142.240.9 with SMTP id n9mr1681228wfh.6.1224961909764;
        Sat, 25 Oct 2008 12:11:49 -0700 (PDT)
Received: from ?192.168.0.31? (c-76-102-237-126.hsd1.ca.comcast.net [76.102.237.126])
        by mx.google.com with ESMTPS id 9sm3608230wfc.19.2008.10.25.12.11.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 12:11:48 -0700 (PDT)
In-Reply-To: <1224960205.2874.11.camel@localhost.localdomain>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99119>

John,

Thanks for your quick reply. I tried that, but got the following error:


$ git clone ../test2/
Initialized empty Git repository in /Users/warren/projects/tmp/test2- 
git-clone/test2/.git/
# ...svn test2 dir already created with subdirs trunk, tags and  
branches...
$ git svn init https://svn/svn/SANDBOX/warren/test2 -T trunk -t tags - 
b branches
Using higher level of URL: https://svn/svn/SANDBOX/warren/test2 => https://svn/svn
$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/ 
libexec/git-core/git-svn line 425.

I then tried the hints from here: http://www.basementcoders.com/2008/9/30/git-svn-gotcha 
, but still no luck:

$ git merge --no-ff master
Already up-to-date.
$ git svn dcommit
Can't call method "full_url" on an undefined value at /opt/local/ 
libexec/git-core/git-svn line 425.


Warren


On Oct 25, 2008, at 11:43 AM, J.H. wrote:

> The basic way you would want to do it, it attach your git tree to SVN
> and then git svn dcommit - which will replay the uncommitted changes
> back into SVN - git svn init will do the attachment - assuming that  
> your
> git / svn repositories are at least based from the same place.
>
> - John 'Warthog9' Hawley
>
> On Sat, 2008-10-25 at 11:40 -0700, Warren Harris wrote:
>> Is there a way to export a git repository along with its history to
>> svn? (git svn init seems to want to go in the other direction.) I  
>> know
>> this is in some sense "going backwards" but I need to commit my work
>> to a client. Thanks,
>>
>> Warren
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
