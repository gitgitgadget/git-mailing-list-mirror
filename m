From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git locate
Date: Thu, 3 Jun 2010 15:39:50 +0200
Message-ID: <20100603133950.GA30826@localhost>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
 <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
 <m3zl49bk0o.fsf@localhost.localdomain>
 <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
 <4B579BA8.8050000@gmail.com>
 <fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
 <AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
 <AANLkTil38OLw3J6ZPvv2wNu98QuTXJKtNwRZP0NDZPWn@mail.gmail.com>
 <80y6ex3f8b.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 15:40:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKAfK-0005aO-OX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 15:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0FCNky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 09:40:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:23352 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0FCNkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 09:40:53 -0400
Received: by fg-out-1718.google.com with SMTP id d23so442844fga.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=H3TEkNT83lZP47nAtH7GTRVguSvrI2Jw2fnDtGBCLB0=;
        b=p1JJynoK6kr6J7AXlko1VCv3MroP5aaWg6UCH8X9at4gJNrteYrmmb6nrbUgRTSQaI
         01C3XhDnvxH9oWtzCHTTRM4c1czqct2ewPz6HENXSwb6AvLag7ro3ajaEi0zzi5TsZTI
         KtoJKL9ZxO2mvI6U3GS5q+9/yoi/Kvj6QlnoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=u4dVgwsFVQp4m1J0x518jmNEvAR5MSGOU41yfzX5MHGjMeWOK+28eMeMUK5keCga4S
         RCN7lpv1EsYG3YTPfziELJnw/HmdMx2UNV2cCYIf1ttqQmfsjiMqcXuMn/heBDHV/TWI
         aGHCNCf6/OZbv2siA0CPbm3u4yMEs9xKe8D78=
Received: by 10.87.37.3 with SMTP id p3mr9855951fgj.27.1275572451454;
        Thu, 03 Jun 2010 06:40:51 -0700 (PDT)
Received: from darc.lan (p549A3E4B.dip.t-dialin.net [84.154.62.75])
        by mx.google.com with ESMTPS id 18sm70957fkq.34.2010.06.03.06.40.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 06:40:50 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKAeE-0003Z0-Bd; Thu, 03 Jun 2010 15:39:50 +0200
Content-Disposition: inline
In-Reply-To: <80y6ex3f8b.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148317>

On Wed, Jun 02, 2010 at 11:23:32AM +0100, Bruce Stephens wrote:

> Something like this is probably part of the answer, which allows an
> alias like this to work:
> 
> 	locate = !cd $GIT_CWD && sh -c 'git ls-files "*$1*"' -
> 
> That doesn't give you all the files (just those below where you are).

Once relative path support for ls-files is done (patch pending) you
can do git ls-files $(git rev-parse --show-cdup).

Clemens
