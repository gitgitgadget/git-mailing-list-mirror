From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to convert a subversion repo to git
Date: Fri, 18 Jan 2013 19:59:40 +0100
Message-ID: <50F99B9C.10805@drmicha.warpmail.net>
References: <CAO2=c4nr8PsbHmyKptWewQMmpqWP=YasKZSnCuB9CCkExpSF8A@mail.gmail.com> <50F97CC3.2000906@drmicha.warpmail.net> <CAO2=c4k8aexmjNUCSigGDVn_5rzVLp1a2C6ngoke-6eU=8WiWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Timothy Kretschmer <timothykretschmer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwHAX-00085T-FG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 20:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab3ARS7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:59:40 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33835 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab3ARS7k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 13:59:40 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9903B20853;
	Fri, 18 Jan 2013 13:59:39 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 18 Jan 2013 13:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=DvXcIvGcrzwGgVgIBjrodm
	Kq2Tk=; b=mLqLGlI+/Yr5m9MNopUnxQhZzChsxszTAsM1MkMsDkE7e/d3f47mY7
	cgn/AEGx5MLpDBRH0q2C4KgAFGe080aZgay2QmmquNYIRHRqT8Vq4F+jaVDUbI4f
	XTbugyDxqlhXk5aTnShI9M3Y+pFHw/SUXBpMZkJJjBLrTHKPvZUes=
X-Sasl-enc: nEM4UJJbvEKOMszZ6YySvIOgvwG4q4tIIatZn6J5RXgQ 1358535579
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 15DDD8E080D;
	Fri, 18 Jan 2013 13:59:38 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CAO2=c4k8aexmjNUCSigGDVn_5rzVLp1a2C6ngoke-6eU=8WiWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213924>

Timothy Kretschmer venit, vidit, dixit 18.01.2013 17:59:
> The exact names of the branches are "CMT_PHASE3" and
> "BlueSimViewer5.0_20110316_Branch"

Just to be sure, not to doubt you: the svn branch name is
"BlueSimViewer5.0_20110316_Branch" and thus differs from the name
reported by git-svn? Are there maybe unprintable characters/control
codes or something in the svn branch name?

Somehow, git-svn is using an improper refname.

> File system on the converting machine is ext4. SVN server is hosted on
> a Fedora 8 box , running subversion 1.4.x.
> To move forward, I commented out the problematic branches under
> .git/packed-refs. Conversion continued but skipped the troubled
> branches.
> Still on the road of finding a way to include those branches in the conversion.
> 
> On Fri, Jan 18, 2013 at 11:48 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Timothy Kretschmer venit, vidit, dixit 16.01.2013 15:06:
>>> I am seeing the following output while converting a subversion repo to git.
>>>
>>>  >Found possible branch point: <repo-url>/trunk =>
>>> <repo-url>/branches/CMT_PHASE3, 18441
>>>> fatal: Not a valid object name refs/remotes/BlueSimViewer 5.0 20110316 Branch
>>>> cat-file commit refs/remotes/BlueSimViewer 5.0 20110316 Branch: command returned error: 128
>>>
>>> The command I am running to convert the repo is
>>>
>>>> git svn clone <repo-url> -A authors-transform.txt --stdlayout bluebox-git > svnlist
>>>
>>> I am running git version 1.8.1.1 on an Ubuntu 12.10 server. I am happy
>>> to provide any other information that would be helpful.
>>>
>>> I appreciate any assistance you can provide in this matter,
>>>   -Tim
>>
>> git-svn should cope with funky branch names. What is the exact name of
>> the "CMT..." and "BlueSimViewer..." branches? Are you using a case
>> challenged file system or just some standard linux fs?
>>
>> Michael
>>
