From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 20:14:41 +0100
Message-ID: <e5bfff550712111114s4e9c31cxb7aed4da70d23382@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
	 <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AZy-0008Cj-91
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbXLKTOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbXLKTOn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:14:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:2730 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbXLKTOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:14:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4160553wah
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qnFz2g4wDJ3Hp5NdYhRMC+OMH+zoXePJE+hPb1M/Hqg=;
        b=DD8INT8K8dQihNHbzs1IRqUWSh8fOqo/gCqjUvFfewe+0A6Pg8ReB426Eciiws0H/Ws6XRS73yYUVW5XHEyqRlcYrcHm8sdg9V0Upxji5UK8P7tyGdf3syiBGUUT2cAqOikECOAD89tVWuDC5Mtp9QKrFMACVmItfSiOUtFQuPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rvG/xSE61ARy9w3kLICVutRfAedISyUNHVQWiBKhfA09SPhMD0n8wo5G3Q2YI7G+WFP1pehG5gUqpUeT9J6Vi8vnQQ5KiR+886+Gis89qwVfvyr7fWi6u5qdu5S7hiesB6IxEWyu+xZmVWtQLwGt8LveCBlgeRib8NC3X1ehpV4=
Received: by 10.141.115.6 with SMTP id s6mr2240229rvm.1197400481624;
        Tue, 11 Dec 2007 11:14:41 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 11:14:41 -0800 (PST)
In-Reply-To: <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67909>

On Dec 11, 2007 8:03 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
>
> > I don't know *how* file history is stored in the others scm, perhaps
> > is easier to retrieve, i.e. without a full walk across the
> > revisions...
>
> It is stored in an easier format. However, can you not simply provide
> side-indexes to do the annotation?
>
> I guess that own't work in git because you can change history (in
> other scm's, history is readonly so you could know the results for
> committed revisions will never change).
>

As Linus pointed out annotation in git is "much slower and much more
costly than just
having a local history view to begin with".

Indeed to annotate say kernel/sched.c

the time is spent by git while executing

git log -p -- kernel/sched.c

could be also 10X higher the the following annotation processing time
starting from the git log output.

Unfortunately my knowledge of git internals falls far far shorter then
guessing what could be done to increase the *one file* history case
that _seems_ to be the common one.


> > I would be interested in cold start and warm cache start (close the
> > annotation tab and start annotation again).
>
> I will try to do this.
>

Thanks. Very appreciated.
