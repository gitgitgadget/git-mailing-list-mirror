From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Mon, 5 Apr 2010 09:42:30 -0400
Message-ID: <l2m76c5b8581004050642n2ea328f6wdbfbe3991a1f5e50@mail.gmail.com>
References: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
	 <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
	 <u2s76c5b8581004022038rf8aa0017l5dea55689c738fd9@mail.gmail.com>
	 <20100403042211.GA22150@coredump.intra.peff.net>
	 <v2i76c5b8581004032052q950584e1y603319ec6f341542@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 05 15:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NymhN-0006Lq-9R
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 15:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab0DENug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 09:50:36 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:42969 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0DENue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 09:50:34 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2010 09:50:34 EDT
Received: by pzk31 with SMTP id 31so456454pzk.33
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=RTdKaz/DvqVPT8cfp25RPW5ho4KHAyHi+tD7kjKFCOM=;
        b=SLhIrCFFqHlAVImQDGpDMpgHGunfHYZkEpzSSifC2FsGxazhy4aW5/7K48UAFuBB/P
         BnAQVO3OCTbTPDXZJRoWiyIwXr6IJVYaUqqYT7/cvUnfi36Cav5StGSqeQVm4qlVBEeH
         2MSp47quyFHyU/feum7cC7hSr9hCzIrFn2zlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=IRPLltCnQi9spyCcU71RtIOtW5tHV0yzbGfjPnH3w1rFC0TIwpbgwNTQXK9B4Nldka
         7ymBfQqAUwmWAYO9vCgRBn0uvOiv9bmKOqiNZKxbKv8z7OJ+gA1gjQxOAubCcEtBgguJ
         eoHBjYhqhnWb6CUdnFAC0cHrajnHjsbUoU18w=
Received: by 10.231.155.143 with HTTP; Mon, 5 Apr 2010 06:42:30 -0700 (PDT)
In-Reply-To: <v2i76c5b8581004032052q950584e1y603319ec6f341542@mail.gmail.com>
Received: by 10.115.29.8 with SMTP id g8mr4162719waj.211.1270474950100; Mon, 
	05 Apr 2010 06:42:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143981>

>> If you look in the .git directory, is there a file named RENAMED-REF..1?
>> I have no idea how you would create such a ref, nor why it would fail to
>> lock (perhaps because of the funny name?), but removing it should
>> probably clear up your problem at least.
>>
>> The name "RENAMED-REF" is only used by git during ref renames, and those
>> only happen when renaming branches (via "git branch -m") or remotes (via
>> "git remote rename"). So presumably the source of the problem is related
>> to one of those operations.
>>
>> -Peff
>>
>
> Thanks Jeff,
>
> i will take a look if i will be able to find this ref. The problem
> though is that i don't remeber doing any renaming of branches or
> remote in this repo. Probably somebody did and pushed it to the
> mainline where i got it from by pull... I'll tyr to check this out.
>
> Thanks,
> Eugene
>

Well, I have removed the file "RENAMEDREF..1" and it didn't resolve
the problem. But then i made a "find -name REN*" and found another
instance in logs folder. Removing this actually resolved the problem
with gc. Still - i have no idea how this ref has appeared there as i
believe there was no renaming operations done as well as no manual
creation of such ref of course...

Thanks,
Eugene
