From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: More help needed on merging unrelated repos
Date: Tue, 4 Nov 2008 22:08:52 +0100
Message-ID: <46d6db660811041308o19f1131dm4d49b6703fa6d22b@mail.gmail.com>
References: <46d6db660811040514qc6c9663u17bd231e1ba662ad@mail.gmail.com>
	 <4910ACCA.7080007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 04 22:10:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxTA8-0000F3-Me
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 22:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbYKDVIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 16:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYKDVIy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 16:08:54 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:22217 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYKDVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 16:08:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1277513yxm.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G4sPyNZHSguUEJnuGUTmhjhZk3ALRhbht0LMcwONKbo=;
        b=Qs4+lsIQQ1keKh6Fisu+cdZ1H7RmvgfR1pkKwV/IiEVx6MxHJHfMDnOuaDPs65Mtvg
         qDL04IP4VXG1mtndI3W+sA79/NvnO6x9+UxtqyZo6rr3wmVz/uK0oGseDmcTA9eVhIXt
         GRC2m+5Afh8JmnNXgWfsNfwFMW050skeHdslk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dXj7Sw+VZWMEDlhuA8vJXtSKo4PRFc23mYSzlPLjp635kklIDWcF0vvo4Ez4KiENFr
         Re/LjFqsRUdgkrFpY60SLCFkI/QzE29ceDh5dlorhWqo430ZoTymy61tbrAW/jXUsR2H
         IRXB2iXUslV+uotCV2/eEXYE5inPoP9ILGIXE=
Received: by 10.142.155.4 with SMTP id c4mr36254wfe.9.1225832932371;
        Tue, 04 Nov 2008 13:08:52 -0800 (PST)
Received: by 10.143.1.15 with HTTP; Tue, 4 Nov 2008 13:08:52 -0800 (PST)
In-Reply-To: <4910ACCA.7080007@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100106>

Andreas Ericsson wrote:
> Christian MICHON wrote:
>>
>> Hi,
>>
>> I previously posted here a question on how to merge unrelated repos,
>> and I was quite happy with the answer.
>> git pull repo_name repo_branch
>>
>> Yet, when I merge these repos (they're unrelated), I'd like to merge
>> all of them at once.
>>
>> How do I pull for example 2 repos in 1 command ? I cannot figure out
>> the exact syntax to use.
>>
>> I tried:
>> git pull ../i1 0.5 ../i2 master
>> git pull ../i1 0.5 -- ../i2 master
>>
>> I also tried to play with --no-commit and -s to no avail.
>>
>> Does anyone of you already use this and knows the trick ? Thanks in
>> advance!
>>
>
> You can only pull from a single repository at a time. The first way of doing
> what you want that comes to mind is:
>
>  git remote add lib1 lib1url
>  git remote add lib2 lib2url
>  git fetch lib1 && git fetch lib2 && git merge lib1/master lib2/master
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>

and apparently this strategy (which I tried before too :( ) fails when merging.

example:
repo i1 contains file 'a'
repo i2 contains file 'b'
new repo z contains file 'readme' and I want to pull repo i1 and i2 at
the same time inside repo z.

typically, I've to pull 1 repo at a time, if I use pull. If I fetch
both without merge, and then I try a merge, it fails.
maybe I'm on a wild goose chase after all.

thanks
-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
