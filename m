From: Luke Lu <git@vicaya.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 13:41:55 -0700
Message-ID: <8644CD78-25F0-42C4-A163-BD88528594F3@vicaya.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com> <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr> <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com> <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com> <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPpT-0002rb-6e
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbXKCUmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbXKCUmh
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:42:37 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:53342 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbXKCUmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:42:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1126890rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=Esnr818XGi1onZOTCq4FnIHHjbZFQsgZIfCFKS6Uv1o=;
        b=kfdmeB9PLQ7Ln89H0IT5uTFisJMVdoa0uikazRxlZQGF6vhBK3TT7HdLtTN/HXfThmJgq6roESBLIKNfo+Mlx0K1l/E9OEZpAVgpVVRcO/msSWRQuOswlSshP1FhHFol+eCb2PV5q2BksCQpBd4QKmEOF2+dftiGv2ipGVxBbJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=Viwvyjrhg9b4BtxygfnyOvzCD4fhZ95/GZNlyHQ5pDNGdgkEh97BHv02zgO98hWbFjzmgOUcBYc8GwnRwxRrWMqlhEy4gSqjPWr+2OfX24/dALsI+xZ5KY1ddQBnAx4MXbOCQyCmN/PAweKyM1qx/oARcZptcHqjql4QrrXzVFY=
Received: by 10.140.192.9 with SMTP id p9mr1568162rvf.1194122556078;
        Sat, 03 Nov 2007 13:42:36 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id f10sm8288857rvb.2007.11.03.13.42.31
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 13:42:32 -0700 (PDT)
In-Reply-To: <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63310>


On Nov 3, 2007, at 1:32 PM, Lars Hjemli wrote:

> On Nov 3, 2007 9:01 PM, Luke Lu <git@vicaya.com> wrote:
>> On Nov 3, 2007, at 6:59 AM, Lars Hjemli wrote:
>>> On Nov 3, 2007 11:56 AM, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>>>> On Nov 3, 2007, at 9:19 AM, Luke Lu wrote:
>>>>> 2. Is there a way to add a new svn branch like that (say  
>>>>> production
>>>>> or some_branch) to an existing git-svn repository that has trunk
>>>>> cloned?
>>>>
>>>> I don't know, but that'd be great indeed.
>>>>
>>>
>>> You can simply add "fetch" lines to  the relevant "svn-remote"  
>>> section
>>> in .git/config.
>>
>> I did try to add a "fetch" line for the production branch like this:
>>
>> [svn-remote "svn"]
>>          url = svn+ssh://host/svn/project
>>          fetch = production:refs/remotes/svn-prod
>>          fetch = trunk:refs/remotes/git-svn
>>
>> which is modeled after http://lists-archives.org/git/420712-git-svn-
>> remote-tracking-branch-question.html
>>
>> But when I try to checkout the production branch like this:
>>
>> git checkout -b prod remotes/svn-prod
>>
>> I got this:
>> git checkout: updating paths is incompatible with switching branches/
>> forcing
>> Did you intend to checkout 'remotes/svn-prod' which can not be
>> resolved as commit?
>
> Did you forget to run 'git svn fetch' after modifying your .git/ 
> config?

Yes, I did. It didn't seem to do anything. $? is 0. the master/trunk  
is up-to-date but the production branch has never been fetched. If  
this is supposed to work, the fetch might be triggered upon next  
update in trunk?

__Luke
