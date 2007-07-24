From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 08:31:07 -0700
Message-ID: <31e9dd080707240831u1625ea70m629ea325f2101e8b@mail.gmail.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
	 <200707241134.31950.robin.rosenberg.lists@dewire.com>
	 <7v8x96glca.fsf@assigned-by-dhcp.cox.net>
	 <200707241457.53414.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org, raa.lkml@gmail.com
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDMN5-0002JY-Tt
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 17:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241AbXGXPba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 11:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759121AbXGXPbT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 11:31:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:28411 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbXGXPbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 11:31:08 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1268390wra
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 08:31:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LBrzYHrM/f9PtOo4UrCTNwl3SLE+KXgx+zOP4fwOAoMR7YFMro6+cTlaLdmJ9fc9R4pnfYQQNCfPKUsJWpNZhsU9p65QTgceyvJxyrwM+Xv/Eyic22hGTgJAQxVH8TfRTez8hbm2+JhUIv+lrRRyTnJvJBnHBl8oUVpvukDFTCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MEt7ghPEEEBOizs9sjnS0CekOHYpHrtqcvj2O6SdA0VrI2dSy3gLEUQbiHQjoajXPKPzjZ+y7279WjMZB1x+HrGf1qmvpXtX3pWv0Vxu8zDTapgye+p/lfMY5laJnKpOPiBQXO4qmTbpTYVHj33G9hjqzvt9NrTZYiffBg199+c=
Received: by 10.90.74.1 with SMTP id w1mr3246049aga.1185291067394;
        Tue, 24 Jul 2007 08:31:07 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Tue, 24 Jul 2007 08:31:07 -0700 (PDT)
In-Reply-To: <200707241457.53414.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53609>

Fedora 7
Kernel 2.6.22 (SMP)
CVS 1.11.22
ext3 (unsure of version or how to discover version)

As one would expect from the above, the 'granularity' test you gave my
reveals 1-second granularity.

On 7/24/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdag 24 juli 2007 skrev Junio C Hamano:
> > > Here CVS sleeps. The amount varies between invocations since it
> > > only sleeps enough for the seconds to wrap.
> >
> > Makes one wonder what it would do if you are on a filesystem
> > with coarser-than-a-second timestamp resolution.
>
> Like fat, but then the last test fails on FAT, which wasn't the case. Any other reasonable file
> systems that comes to your mind?
>
> Jason, could you provide us with some more information on OS, fs, cvs version etc.
>
> Whether timestamp granularity is larger than a second or not can be checked with this line, I think:
>
>         touch a && ls --full-time a && sleep 1 && touch a && ls --full-time a
>
> Sample output where the timestamps are roughly one second apart.
> -rw-r--r-- 1 me me 0 2007-07-24 14:15:47.330927250 +0200 a
> -rw-r--r-- 1 me me 0 2007-07-24 14:15:48.338990250 +0200 a
>
> -- robin
>
