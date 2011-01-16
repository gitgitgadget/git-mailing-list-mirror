From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Optionally parse author information
Date: Sun, 16 Jan 2011 09:02:57 +0530
Message-ID: <20110116033253.GA22707@kytes>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
 <20110113032300.GB9184@burratino>
 <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
 <20110114080554.GA1735@kytes>
 <20110114082931.GC11343@burratino>
 <F0299861-B36C-459C-972E-856212A92615@kth.se>
 <20110114101636.GA22970@kytes>
 <AANLkTi=ddJYT8YiUDYy80xobkxJnvuREN-09=464P_vB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Love =?iso-8859-1?Q?H=F6rnquist_=C5strand?= <lha@kth.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Joe Corneli <holtzermann17@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 04:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeJM5-0007Jl-2Z
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 04:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab1APDcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 22:32:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35896 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1APDcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 22:32:07 -0500
Received: by iyj18 with SMTP id 18so3649755iyj.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 19:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=68rAdcx7w8MbCydMs25uCshDni1vZzWrUsLwtoq6F/4=;
        b=Qbo8YQe3sVsY7inZUcPxZ8nPJCGGv5U0SExHWPN7HNbuRmKO8AkTdVa4wXMI8bZWEy
         sWGZRYjx2LOXGPGngHE6VB2HUozsqeDFsDM9UtW4rSrtUC3igKuSt8ZJ5zN/F34Ehxh3
         z7UtaQAHfIerpWUW5ZZAcOf1DDxkGBQtaMmEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lC+I25P7MRxbX+XYYLzjvRSoGNzj4LHm4mP+Vr7yx9iKcRGiSImA9YX8o6PBQyXxfh
         ycpiyN5b6LZM/MH2pdg0LlEV5ntCEOoTYFPr1p4NDtZHqPgWX2PISTqx+OdvsZlpNK/v
         LICm7pZMLnQR4PhwkBeHk3ISbbt5FlU6ceyqI=
Received: by 10.42.164.194 with SMTP id h2mr2719493icy.197.1295148727149;
        Sat, 15 Jan 2011 19:32:07 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id k38sm2288062ick.9.2011.01.15.19.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 19:32:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ddJYT8YiUDYy80xobkxJnvuREN-09=464P_vB@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165158>

Hi Joe,

Joe Corneli writes:
> I tested it, and it seems to use email handle instead of author name
> (perhaps that's intentional, though in my case it's not so desirable)
> but, quite critically, it gets the dates wrong:

Yes. I didn't change it's core behavior- it used to extract the
information from the committer's email address previously; I just
changed it to use the author's email address. For dates, it uses
committer dates again, and this is probably desirable: author dates
aren't necessarily monotonic, and this can break some functionality in
SVN.

Ofcourse, a lot more is possible with an patch that allows users to
configure all these things. Until then, I recommend that you just edit
the source to achieve the desired results.

-- Ram
