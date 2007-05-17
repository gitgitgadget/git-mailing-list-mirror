From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 01:10:35 +1200
Message-ID: <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
	 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
	 <Pine.LNX.4.64.0705161232120.6410@racer.site>
	 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
	 <Pine.LNX.4.64.0705170152470.6410@racer.site>
	 <vpq8xbnlmdv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 15:10:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hofkh-0002ep-7e
	for gcvg-git@gmane.org; Thu, 17 May 2007 15:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXEQNKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 09:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbXEQNKh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 09:10:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:60661 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbXEQNKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 09:10:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so533865wxd
        for <git@vger.kernel.org>; Thu, 17 May 2007 06:10:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ulv5e3jfP54FlU7B0wiaPtyS9G/V3TNoYHmnm/v5IKH4WWz7TPq11vjmidG7b6ECUP/reswYC7GyWFIqdGwWG0Qd5Hlm/wDyI9CfzVs5/iQ1LSt0fi6pDqnyZPrZfgsyup9n4F0udbRHqDezDn3NLIY6RekBHAtg7PgAu5H/UHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tT6GfW1/S9P5zDZap8z6aPNI9qqGl/D/O5RnQP9ergyqysTW8U7hrOg9a88f20ZrM1RHnrS+VSLvt7FMC35co4UALoPyhtKvr2n8O0EGEtqaMcfvDQtzi1ZFSqnaRwu2PeigWXShT6eeqi1uhLq2xESrXyMPm/QbFGyoCVxaMkA=
Received: by 10.90.52.18 with SMTP id z18mr416170agz.1179407435774;
        Thu, 17 May 2007 06:10:35 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Thu, 17 May 2007 06:10:35 -0700 (PDT)
In-Reply-To: <vpq8xbnlmdv.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47519>

On 5/17/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> FYI, bzr uses HTTP range requests, and the introduction of this
> feature lead to significant performance improvement for them (bzr is
> more dumb-protocol oriented than git is, so that's really important
> there). They have this "index file+data file" system too, so you
> download the full index file, and then send an HTTP range request to
> get only the relevant parts of the data file.

That's the kind of thing I was imagining. Between the index and an
additional "index-supplement-for-dumb-protocols" maintained by
update-server-info, http ranges can be bent to our evil purposes.

Of course it won't be as network-efficient as the git proto, or even
as the git-over-cgi proto, but it'll surely be server-cpu-and-memory
efficient. And people will benefit from it without having to do any
additional setup.

It might be hard to come up with a usable approach to http ranges. But
I do think it's worth considering carefully.

cheers,



m
