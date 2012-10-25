From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Thu, 25 Oct 2012 17:16:00 -0400
Message-ID: <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRUmo-000103-L1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687Ab2JYVQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 17:16:04 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42075 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965575Ab2JYVQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 17:16:02 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1011125bkc.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dtZ6Y/vsueAx0+EvjeGEGnP79w9uYEVsVt6GsG6gYUQ=;
        b=O+sGR0orPkrVJVqNe61/ILVo7fEC8sU+8UNA/bI5WI+Uuz5WhT204UQcVC0HD+64C5
         t611hNutrrndXA1lffv/WLKH2gbnMyNZHitPfRb9fpR+d9fGGWGg+EmYWR/C7C63lLO1
         amvdVgnPMrpmOstHuXm3n5ETEm4enSG7lPt6iyUOAVbTnFA4lRPbqp6RFIDe/Kvp1431
         Fbyxll1Pyi8yUc48NSlpiD/u8tKnFqRki9bmQ8BE3639M7RPjU09mmjJhExXzoXV4AhU
         v0gDY7FfULCkWfDieeQgrNTF/HIEP2bUrqVoJedyk0R856DcWqx5foOUaJkgHlCIMaaJ
         nRGg==
Received: by 10.204.9.3 with SMTP id j3mr6709421bkj.15.1351199760949; Thu, 25
 Oct 2012 14:16:00 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Thu, 25 Oct 2012 14:16:00 -0700 (PDT)
In-Reply-To: <CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208418>

On Thu, Oct 25, 2012 at 3:05 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
---At 13:19 on Oct 25, 2012, Drew Northup wrote: [added for clarity]
>>Tags have many uses. Some of those uses are harmed when tags change
> and some aren't. That's a philosophical argument
>
> I agree, but in this case the computer does not provide any means to
> implement the same strategy on tags as it does instead on local
> repositories. Why I must force a change on a tag in the local
> repository and instead I can change it without any forcing in a remote
> one?

Changing the tag in the local repository is a tag modification
operation. Pushing that change to a remote repository DOES NOT execute
"git tag...." in the remote. Plain and simple the two are different
operations.

> Are remote repositories less protected than the local ones? I
> think that to be consistent, the same strategy should be used on all
> repositories, i.e. rejecting changes on tags by default, unless they
> are forced.

So here we come to the core argument. Is sounds to me like you want
changes to remote tags to work differently from push updates to ALL
other references. The required change, if I'm not mistaken, would be
for tags to not permit fast-forward updates while all other references
would be pushed normally. From my brief and un-enlightened look at the
push code I can't see that being as easy as it sounds.

In any case, I think your complaint stems from thinking that "git tag"
is the operation being performed on the remote when in fact it is not.
Given the mayhem that changing this may involve I'm not going to claim
it to be a good idea.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
