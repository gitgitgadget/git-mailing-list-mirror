From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC] statplot: a tool for mining repository statistics.
Date: Thu, 1 Mar 2007 22:36:23 +0100
Message-ID: <81b0412b0703011336p324b3202k1ccabb7899238acd@mail.gmail.com>
References: <20070301072953.GA8730@spearce.org>
	 <81b0412b0703010158i1a3963f4wabda2f72c1fd0bc4@mail.gmail.com>
	 <20070301183004.GB8858@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMswx-0004r4-7O
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbXCAVg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbXCAVg0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:36:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:6894 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030297AbXCAVgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:36:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so485992uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 13:36:23 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BrTCWvrXGkt+CQZTtQxZjOZ8nBJhivaRURQoW1Ms2Y5GGMy+eR9N5vMVdg8BiXZ9pVSuTnJQ/NXy0lJf3prvhnPw3bkQR7/CbIEntn5s+oogq5rvo5Kk4zBOOF+P9oxGf0c1J2c4InXKNwwAy+5l8jFxAEqjI3sPzDUTHVZxGc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tg3Mf6JX14m1E10r5lNybWgGScQIDJmWZws+UjHq7NJcpZHFDu6Yx8tmW5v74uZyYzqSifm4AA9VzcgJnYzXFSwf6TzjsiqsP7zRDizLKVGDJJGJxzxbKVnXZrBXnL1Jhsh+Ijb10qUg19BpNY/NVCeDlda9bxSc/cOp4kiZ8JQ=
Received: by 10.78.195.9 with SMTP id s9mr200072huf.1172784983474;
        Thu, 01 Mar 2007 13:36:23 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 13:36:23 -0800 (PST)
In-Reply-To: <20070301183004.GB8858@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41127>

On 3/1/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Tried it on my repo but the program produced some records with
> > all zeros. I.e.:
> > 2005-11-10 6 222 235 463 1785888
> > 2005-11-11 3 34 2 39 9729
> > 2005-11-12 0 0 0 0 0
> > 2005-11-13 0 0 0 0 0
> > 2005-11-14 6 227 330 563 716230
> > 2005-11-15 3 121 209 333 1162839
> >
> > What could this possibly mean?
>
> There were no new objects attributed to 12 and 13 of Nov, 2005.
> The program allocates a zero'd array for every day in the entire
> range, then increments each day with the number of objects introduced
> by commit(s) on that day.  It then just prints the entire array,
> rather than only printing the non-zero lines.  ;-)

oh, ok.

> Horribly simple code.  Maybe too dumb for inclusion in git.git.

I still think it's good for something (I used it to quickly find days
for weekly and monthly report).
