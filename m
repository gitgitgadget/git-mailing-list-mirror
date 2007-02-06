From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 14:01:52 +0100
Message-ID: <81b0412b0702060501u41a3f707pea4bfc58220fd862@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <eq6tj6$80m$2@sea.gmane.org>
	 <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
	 <20070205194508.GD8409@spearce.org>
	 <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
	 <20070205225505.GA9222@spearce.org>
	 <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
	 <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 14:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEPxS-0005pc-Vo
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXBFNBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXBFNBz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:01:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXBFNBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:01:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1596388uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 05:01:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XszDyB2GwWrCHSX5QtrUHeMxewxj22GApt1uj7MxkDuNcCU+E/4I9vk+wdRIK95+R8TzxtNfSo6tY/k8QMi8FonYBGn1eIzgpL8zW/t8sZ9nlSJ8gUarPv/aACSadcnKFXvHFec3lNrpbt7GpJU/2Vb7z8U7xt5MJrrESQ95deQ=
Received: by 10.78.17.4 with SMTP id 4mr1638226huq.1170766912304;
        Tue, 06 Feb 2007 05:01:52 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 05:01:52 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38835>

On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > `git gc` is your friend.  It automatically trims the reflogs, keeping
> > > only the last 90 days worth of entries.  You can tune this with the
> > > `gc.reflogexpire` configuration parameter.
> >
> > git gc (repack -d of it) is too dangerous in a shared repo: it breaks
> > the repos which depend on the master repository, have sent (by some
> > means) some objects over to the master, and accidentally removed
> > the reference, and were pruned afterwards.
>
> We no longer call git-prune automatically in git-gc. You have to say
> "git-gc --prune" to trigger that behaviour.

no. You'd have to stop calling repack as well.

I mean the objects that generally have to be removed and just
accidentally was not pinned in the shared repo.
Or did you mean that repack will leave unreferenced objects
behind in objects/??/files?
