From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Wrong conflicts on file splits
Date: Mon, 4 May 2009 09:42:25 -0400
Message-ID: <9e4733910905040642h5932e80ds5c467db90e03f40d@mail.gmail.com>
References: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
	 <49FEED2C.8010501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 04 15:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0yRI-0005Wq-P9
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 15:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZEDNm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 09:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbZEDNm2
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 09:42:28 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:47577 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803AbZEDNm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 09:42:27 -0400
Received: by ewy24 with SMTP id 24so3920100ewy.37
        for <git@vger.kernel.org>; Mon, 04 May 2009 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r5qXIK6EFlmLAdvAdCpxYM146XHBE1UabHy/jIE9mXY=;
        b=XOHPNul/ZU/SX/QkDCYi+BRttc9W9ig8uss6/VtK/0PjBM2Fo37Lkjq4t5w4kQ4eHg
         OdzooUnWqYzurMMNmE93Ob5mp3JmObGAhR5x3XvwNXhNAc2YIEEAMlryE82VRs/D+Abu
         SCa8wskkAkUGXV6WW4D1tS+eXfssCy0DkpR0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HuGeKXTLDJcbpi7ysmgirufHSfXMxWsmphdkS7MkpXSNxmGYHJzJBAjYPlB55EJTgP
         B4x16RFdcZ8muf5wJbqvXcmDHYrsHODyCgNYoj8RVzovMAmzSBssp7RVzvvl6jY/jKbY
         /3yZLKUe6al5f82kY7aUI/2vsUr/1g9UZlosg=
Received: by 10.220.74.20 with SMTP id s20mr9404159vcj.36.1241444545807; Mon, 
	04 May 2009 06:42:25 -0700 (PDT)
In-Reply-To: <49FEED2C.8010501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118234>

On Mon, May 4, 2009 at 9:27 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
>> I keep running into this problem, is there anything I can do to make
>> it better? I'm using stgit but this is a problem in git itself.
>>
>> I have a patch that splits file A into two files, A and B.
>> Now I merge with another tree and bring in a one line fix to A.
>> The fix touches the pre-split file A in a section that is going to end up in B.
>> Next I re-apply the patch that splits A into A and B.
>>
>> This results in a large conflict in the post split file A.
>> And no patch being applied to file B which is where the fix belongs.
>>
>> Repeat this process with a multi-line fix and the whole automated
>> merge process breaks down and I have to carefully figure everything
>> out by hand.
>>
>> The merge process seems to be unaware of the newly created file B. No
>> patches or conflict ever end up in it.
>>
>
> Can you provide a test case or at least a list of commands which you are
> issuing? You complain about "merge", but you say you are "applying a
> patch". Are you merging that patch from another branch, or are you
> really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?

What git command does stgit use internally on push/pop?

It's the stg push of a patch creating a split on top of a change to
the section that is going to end up in file B that causes the problem.



>
> Cheers,
> Michael
>



-- 
Jon Smirl
jonsmirl@gmail.com
