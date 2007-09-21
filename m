From: Christian von Kietzell <cuboci@gmail.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 17:46:56 +0200
Message-ID: <1190389616.16219.1.camel@caladan.dune>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	 <Pine.LNX.4.64.0709211208440.28395@racer.site>
	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
	 <alpine.LFD.0.9999.0709210912120.32185@xanadu.home>
	 <fbe8b1780709210635l5803456aof3757418dc9653e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 17:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYkin-0000C5-QA
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 17:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbXIUPrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760029AbXIUPrG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 11:47:06 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:15897 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122AbXIUPrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 11:47:04 -0400
Received: by hu-out-0506.google.com with SMTP id 19so306602hue
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:subject:from:to:cc:in-reply-to:references:content-type:content-transfer-encoding:date:message-id:mime-version:x-mailer;
        bh=bZBZvYr7XZ0SiDDGvrOdtH+mCyCOavP6BugpKSZZvAc=;
        b=pKIby1yV1fGDTPMm3ZvU/RS9QH4C4KtFp6lWJyj2ZHVZVciF6PfjG8Bv6eWuXIHhlpYEld8HD9Nb8ZPHWjmsd8Q1UwSV06XaZFCamSIHCf3+WT9pggZZ34qYhSGYb7G6rLjlWQLUcaOCK8KGCgkIhFbWEbkhv+Aqf9Ynpi12atI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:content-transfer-encoding:date:message-id:mime-version:x-mailer;
        b=XapFTc9BrZ5NxhuyAUfDmhOWzoEdhTKhSjkIrgSZtxd65O/Y3YWIwLJxFEUMkf7r7dVfMUQ5fGlw/QrlanI+V64hY0g4dacrd+YFDfruN/q+1sBLd5PepKmP/RmTgnkQC+zJcqH8svfAAcyRVkR5cL44yusuhMHPWtRmCR6akR0=
Received: by 10.66.221.18 with SMTP id t18mr2104008ugg.1190389620745;
        Fri, 21 Sep 2007 08:47:00 -0700 (PDT)
Received: from caladan.dune ( [88.72.42.104])
        by mx.google.com with ESMTPS id k7sm1053999nfh.2007.09.21.08.46.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2007 08:46:59 -0700 (PDT)
Received: from chris by caladan.dune with local (Exim 4.67)
	(envelope-from <cuboci@gmail.com>)
	id 1IYkiW-0004MY-NZ; Fri, 21 Sep 2007 17:46:56 +0200
In-Reply-To: <fbe8b1780709210635l5803456aof3757418dc9653e7@mail.gmail.com>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58861>

Am Freitag, den 21.09.2007, 15:35 +0200 schrieb Peter Stahlir:
> > > I wonder how big a deltified Debian mirror in one pack file would be. :)
> >
> > It would be just as big as the non gitified storage on disk.
> >
> > The space saving with git comes from efficient delta storage of
> > _versioned_ files, i.e. multiple nearly identical versions of the same
> > file where the stored delta is only the small difference between the
> > first full version and subsequent versions.  Unless you plan on storing
> > many different Debian versions together, you won't benefit from any
> > delta at all. And since Debian packages are already compressed, git
> > won't be able to compress them further.
> >
> > So don't waste your time.
> 
> The 252GB stem from the fact that there are more than 10 architectures.
> I guess the /usr/share/doc of all architectures could be deltified (as could
> be all files that are architecture-independent)
> 
> Right?

I don't think so. Architecture-independent files are usually separated
out into separate packages (think of the -doc and -data packages) that
get architecture "all" and land in the Debian archive only once. So you
probably won't save too much there.


  Chris
