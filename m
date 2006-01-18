From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Wed, 18 Jan 2006 18:47:54 +0100
Message-ID: <cda58cb80601180947j48a5396t@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jan 18 18:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHWB-0004CW-12
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWARRym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWARRym
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:54:42 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:9406 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932481AbWARRyl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:54:41 -0500
Received: by zproxy.gmail.com with SMTP id 14so1694751nzn
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 09:54:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aJhpOaV9qJ6ZZ5FdGinq+odj92l/bg038eYA2fjslDNiwlCaUue7k8LHkyI2EKbvZK2CeMqrcWaGyZ2OPj9BhruibhiktX/ewLX2jKIPLFkjx7IryRY/7spCikZn4la25b0r7DOthBcjxJmCwROTAz9lWZDSoYMsFLbfsi0CAW0=
Received: by 10.36.38.3 with SMTP id l3mr6828312nzl;
        Wed, 18 Jan 2006 09:47:54 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Wed, 18 Jan 2006 09:47:54 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <cda58cb80601170932o6f955469y@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14846>

Hi,

Could anybody shed some light there ? It would be very nice.

Thanks
                  Franck

2006/1/17, Franck <vagabon.xyz@gmail.com>:
> Hi,
>
> I'm wondering why the "grafts" files is not involved during
> push/pull/clone operations ?
>
> Another question regarding grafting use case. Let's say I have my
> origin branch looks like:
>
>                origin ---0---1---<snip>---300 000---300 001---300 002
>
> Let's say that the 300 000th commit is where I started my work by using:
>
>                $ git-checkout -b master <300 000 shaid>
>
> I do some work on master branch and get the following
>
>                                                  a---b---c---d master
>                                                 /
>                origin ---0---1---...---300,000---300,001---300,002
>
> Now, I would like to make my own public repository based on my work
> but before pushing master branch in that repo I would like to get rid
> of all unused commits [0 299,999]. Indeed each of these commits do not
> have useful history for my work. So I used grafts things to have:
>
>                               a---b---c---d master
>                              /
>                origin 300,000---300,001---300,002
>
> But now if I ask to git for:
>
>                $ git-merge-base master origin
>                # nothing
>
> So git failed to found the common commit object which should be 300,000. Why ?
>
> In other the hand, if I use grafting to get:
>
>                                                a---b---c---d master
>                                               /
>                origin 2999,999---300,000---300,001---300,002
>
>               $ git-merge-base master origin
>               2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
>
> So now git found the common commit. Can anybody explain me why ?
>
> Do you think it's a good usage of git ? Or should I do otherwise to
> setup my public repository ?
>
> Thanks
> --
>                Franck
>
