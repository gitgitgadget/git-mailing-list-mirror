From: "Peter Stahlir" <peter.stahlir@googlemail.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 15:35:39 +0200
Message-ID: <fbe8b1780709210635l5803456aof3757418dc9653e7@mail.gmail.com>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	 <Pine.LNX.4.64.0709211208440.28395@racer.site>
	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
	 <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYifb-00039D-Sr
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbXIUNfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757579AbXIUNfm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:35:42 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:35056 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbXIUNfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 09:35:41 -0400
Received: by hu-out-0506.google.com with SMTP id 19so293027hue
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k4h1SJcCnf/dG62ZpTgYeJmzNXmM6zbDKqjlTSFPiTc=;
        b=Q2n2va4BWA5pDuEYeTnoazlNevo07O6m3g/dcrj3vzT/OECQvnvk/3ClZ3eeEBvkBRgFGmDxyem3sxVMZDl47ke51bOHecA2cm6K3akge9RvhPWCrI1E8LABuK03rTTjKXNmV+sAQnGkZ+YvRgcWBtr8toRIPMqXaEc0xgPgG7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IWw47eqOqfkg64TTv2WzV2d9//VDigjpT1LViPU6HNqaBTFDu9LM7tmmkegTL/BHHYo7I7xqj5z5Cx6m3RB2tTKYVPG1ZBx4M4fPj1BKwIZU/EzCmv+5rrhR7DY4oFR4x5owZB/bnfUW8vYZSg/gcpI/P4aFUkfAOq8t+t1RJnM=
Received: by 10.78.204.7 with SMTP id b7mr2016834hug.1190381739772;
        Fri, 21 Sep 2007 06:35:39 -0700 (PDT)
Received: by 10.78.140.12 with HTTP; Fri, 21 Sep 2007 06:35:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58851>

> > I wonder how big a deltified Debian mirror in one pack file would be. :)
>
> It would be just as big as the non gitified storage on disk.
>
> The space saving with git comes from efficient delta storage of
> _versioned_ files, i.e. multiple nearly identical versions of the same
> file where the stored delta is only the small difference between the
> first full version and subsequent versions.  Unless you plan on storing
> many different Debian versions together, you won't benefit from any
> delta at all. And since Debian packages are already compressed, git
> won't be able to compress them further.
>
> So don't waste your time.

The 252GB stem from the fact that there are more than 10 architectures.
I guess the /usr/share/doc of all architectures could be deltified (as could
be all files that are architecture-independent)

Right?
