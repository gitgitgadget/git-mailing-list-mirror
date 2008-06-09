From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] git-branch -m cannot rename remote branches
Date: Mon, 9 Jun 2008 09:06:50 +0200
Message-ID: <200806090906.51937.jnareb@gmail.com>
References: <200806082257.20833.jnareb@gmail.com> <alpine.DEB.1.00.0806082357470.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 09:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5bRM-0005Ek-6U
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYFIHD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 03:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYFIHD4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 03:03:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:44004 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYFIHDz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 03:03:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1413583fgg.17
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+PCvkXnvJggTvcYXjDxxZjrfLbISOc+heufaL2wXdXU=;
        b=YVBQl8exs58Uy1REEe58ndnWRHUfc+7iOgvqyl3hvC1xd97qpyoP0ecpFzIadUNDfK
         9iBP7Celp9ndn6mu+YD9trmwtLb+/MDODrLbgDgbfPZoSDvia2W71qGAB8jAAys3wciM
         Fjn7f0I/Gu2cIFxFVIafK6F/n8ItHEleKGI8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Rp3bC9H0GR+QMpNMJqpR86/JiWqttoxPuUhaZqyTK52GLJGcqjXid68+OXtAIomM3y
         pHztw6yR5JFG2SCwkV15X4pbyM7J5g3c8AQWlbb6WsUnWh8fuAU8zbJ4N5abG6roq4i3
         guVKTeVsnBKr1rPahniFXetAd25JyiX4iwqjo=
Received: by 10.86.73.3 with SMTP id v3mr3782340fga.68.1212995033380;
        Mon, 09 Jun 2008 00:03:53 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.243.230])
        by mx.google.com with ESMTPS id 4sm10489866fge.5.2008.06.09.00.03.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 00:03:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0806082357470.1783@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84364>

On Mon, 9 Jun 2008, Johannes Schindelin wrote:
> On Sun, 8 Jun 2008, Jakub Narebski wrote:
> 
> > I cannot rename remote branch (possibly packed, and possibly with
> > reflog) using "git branch"
> 
> That is very much by design; a next fetch would get them with their 
> current name anyway.  A "remote prune" should get rid of any stale 
> branches.
> 
> So yes, "branch -m" with remote branches does not make sense.

What I really wanted was "git remote rename <old-name> <new-name>",
together with renaming branches and moving reflogs.  I can do first
part by editing config file ("git remote rename"/"git remote mv"
probably would want to assume that user wants to move branches if
they follow remotes/<old-name>/* calling convention; ask user if it
is not the case?).  I thought that I could use "git branch -m" for
the other... I was left with editing packed-refs file (BTW. is leaving
empty directory 'xx' when packing 'xx/name' branch by design?) and
moving reflog by hand.

-- 
Jakub Narebski
Poland
