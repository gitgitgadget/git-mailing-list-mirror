From: Luke Lu <git@vicaya.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 13:01:28 -0700
Message-ID: <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com> <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr> <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPCK-00023P-Lx
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761AbXKCUCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756956AbXKCUCL
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:02:11 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:1094 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbXKCUCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:02:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1120448rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=SDu/TrlwnitYmMSGI/yO5C1/fSx83mYKc1gUoXCExJY=;
        b=WlWCE+3dYnavSTImldWaP7TL0QUljOBLiEzDULYG2wzsblt40tzaThKWPsO5FRDvyohyn2SUFDWxZw6spJoit2q8eNOgydJ1d1UqB4oH82EsG9COK7iJ27p0AvYj7TwONujFnIbMzoGTL8zjnojvsUlNGaWs43Uxx5L1U3PYN84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=SXQP8R9Oi3UAGdS+lGVFTSicWseQYtEOKiBP9OFSXuXCmmSMtb5n5v/qwYl9TAvr2v+GQzM5xMK5mizUMvBbivOoY8Uk7twUNQItBZz445GrQnj/H1l3CmNT/TC55kX5P1klSAHbsZsEQ5O6J2kxJUf0v7cElZOiR/s5v9lJFJQ=
Received: by 10.141.34.12 with SMTP id m12mr1567173rvj.1194120129509;
        Sat, 03 Nov 2007 13:02:09 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id g1sm9635115rvb.2007.11.03.13.02.04
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 13:02:05 -0700 (PDT)
In-Reply-To: <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63307>


On Nov 3, 2007, at 6:59 AM, Lars Hjemli wrote:

> On Nov 3, 2007 11:56 AM, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>> On Nov 3, 2007, at 9:19 AM, Luke Lu wrote:
>>> 2. Is there a way to add a new svn branch like that (say production
>>> or some_branch) to an existing git-svn repository that has trunk
>>> cloned?
>>
>> I don't know, but that'd be great indeed.
>>
>
> You can simply add "fetch" lines to  the relevant "svn-remote" section
> in .git/config.

I did try to add a "fetch" line for the production branch like this:

[svn-remote "svn"]
         url = svn+ssh://host/svn/project
         fetch = production:refs/remotes/svn-prod
         fetch = trunk:refs/remotes/git-svn

which is modeled after http://lists-archives.org/git/420712-git-svn- 
remote-tracking-branch-question.html

But when I try to checkout the production branch like this:

git checkout -b prod remotes/svn-prod

I got this:
git checkout: updating paths is incompatible with switching branches/ 
forcing
Did you intend to checkout 'remotes/svn-prod' which can not be  
resolved as commit?

Can you shed some light on this? (git version is 1.5.3.4)

Thanks!

__Luke
