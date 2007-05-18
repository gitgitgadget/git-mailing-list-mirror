From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 14:08:04 +0300
Message-ID: <20070518110804.GD4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180857.18182.andyparkins@gmail.com>
	<200705181043.09203.Josef.Weidendorfer@gmx.de>
	<200705181021.30062.andyparkins@gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 13:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp0Jd-0006Z6-6u
	for gcvg-git@gmane.org; Fri, 18 May 2007 13:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbXERLIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 07:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbXERLIF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 07:08:05 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:37068 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbXERLID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 07:08:03 -0400
Received: by py-out-1112.google.com with SMTP id a29so1119402pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 04:08:02 -0700 (PDT)
Received: by 10.64.250.7 with SMTP id x7mr6084365qbh.1179486481794;
        Fri, 18 May 2007 04:08:01 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id e19sm3785953qba.2007.05.18.04.07.59;
        Fri, 18 May 2007 04:08:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200705181021.30062.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47592>

> Quoting Andy Parkins <andyparkins@gmail.com>:
> Subject: Re: [3/4] What's not in 1.5.2 (new topics)
> 
> On Friday 2007 May 18, Josef Weidendorfer wrote:
> 
> > It all depends on how we construct the default URL out of the subproject
> > identifier. Options:
> > (1) do not try to construct a default URL at all. Error out without a
> > config (2) use a configurable rewriting scheme like s/(.*)/git://host/\1/
> > (3) automatically detect a senseful rewriting scheme
> >
> > Let's start with (1). We can invent convenient default schemes later on.
> 
> All good; except let's start with 
> 
>  (1) if no config, try using the key itself - error out if that fails
> 
> Then everybody is happy - if you want to use your system where the key is not 
> a URL, then don't - you'll get the error you want.  If the user chose to use 
> a URL then magic will happen.

I don't want an error. No one wants an error.

I want to be able to clone a super project, a subproject,
and use my copy of both instead of the original - including
cloning my copy, pulls between such clones, being able to verify
that they are identical.

What I *don't* want is a situation where the fact that original repository
resides in north america necessarily means that everyone who looks at *my* clone
of it will do a round trip to north america too.

And this means that URLs must be out of tree, but does *not* mean that
git-daemon should not serve them for user's convenience.

How about an ability for git-daemon to get commands with git-config?

-- 
MST
