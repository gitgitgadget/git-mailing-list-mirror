From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Nasty git corruption problem
Date: Wed, 26 Jul 2006 17:57:03 +0200
Message-ID: <4d8e3fd30607260857v17bde4afqbe68fde583d2f15f@mail.gmail.com>
References: <1153929715.13509.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-From: git-owner@vger.kernel.org Wed Jul 26 17:57:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5ll0-0000vc-Fl
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 17:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGZP5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWGZP5G
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 11:57:06 -0400
Received: from hu-out-0102.google.com ([72.14.214.205]:36252 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWGZP5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 11:57:05 -0400
Received: by hu-out-0102.google.com with SMTP id 34so1248687hue
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 08:57:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KsiIriaNPMj2O8Wxv9VnBtEVd3lhWe4/YVxxaT/l8T9B7eMBVq3kj4DjGmxraprr9AhdPYD5fSYV7Bz49Y4C8tm22mUoopPZSgOPcXOPUDcYIBwGpfEh1HIcEtgNwvVI7viPTiyQqeu63V61iu7oqTL0NTN/ZK7D8G2E3RvOIkM=
Received: by 10.78.195.9 with SMTP id s9mr3217834huf;
        Wed, 26 Jul 2006 08:57:03 -0700 (PDT)
Received: by 10.78.121.12 with HTTP; Wed, 26 Jul 2006 08:57:03 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <1153929715.13509.12.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24223>

Just added the git ML where you can have better support for this problem.


On 7/26/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Just hit a real nasty, although I suspect its not a common case but it
> does seem to show a problem git has other version control systems don't
> (so far anyway)
>
> During a git rebase my machine crashed. Git claims that the rebase is
> complete but contains none of the outstanding 30 odd patches. There is
> no .dotest directory and git-fsck-objects produces some warnings about a
> few dangling objects, but these objects aren't the relevant ones (at
> least directly)
>
> CVS and SVN in crashes don't lose old stuff, though they are pretty good
> at losing the last commit or two. Git rebase appears to be able to lose
> two weeks of old changes even though they were stable on disk, which is
> not good at all.
>
> Doing
>
> for i in *; do (cd $i; for j in *; do git-unpack-file $i$j; done; );
> done
>
> shows that lots of the changes are still somewhere in the object tree
> but there seems to be no tool for fixing rather than moaning about
> objects dangling, and also no obvious way to fix it. Also curiously many
> of the objects appear linked somewhere but don't show up in the git-log
> for the afflicted branch at all.
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Paolo
http://paolo.ciarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi
