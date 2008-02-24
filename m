From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http-push: add regression tests
Date: Sun, 24 Feb 2008 20:14:55 +0100
Message-ID: <20080224191455.GA20884@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 20:15:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTMKF-0000b2-6q
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 20:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbYBXTO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYBXTO4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 14:14:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:44322 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbYBXTOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 14:14:55 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1005336fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 11:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=myynKL7/k0gXgCA/m0DrQCkp11OkqF35Jr3cOZm3g6A=;
        b=PFzGtyFJbhTHUeL42hEOxgsLBeW7jDx1XzvnhVb/NZGyH7dGqy4WfAEgTezTvTX1q/hm6o14Zz5Z/v4Etyb0KTlgxr9vJRNwFtB443KPd0RxYlYx53pJbNSQuexjGHJ35obeGPCWPxuKSLvFwvynO6ZPHwmAHg0zLl7oik+yKXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=DAC38KgDEKUFnaJLl5g/sdSBFkaZ+Sde7+DRdW/EtmpImDiEyNWuF6Oo3079asIB3kCE5y0xure/gFoadFYYKbhyhtrekbQJfOXd0q/OamX29i5OJeo5cVuqYym0b1MEutBUfHMShe0NXaSnZFS+qosa25F//cOhU0ogkwQdKCM=
Received: by 10.86.81.14 with SMTP id e14mr1947192fgb.42.1203880494027;
        Sun, 24 Feb 2008 11:14:54 -0800 (PST)
Received: from darc.dyndns.org ( [88.117.114.241])
        by mx.google.com with ESMTPS id d6sm5163923fga.9.2008.02.24.11.14.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 11:14:52 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JTMJM-0005UC-09; Sun, 24 Feb 2008 20:14:56 +0100
Content-Disposition: inline
In-Reply-To: <20080224184832.GA24240@glandium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74954>

Hi,

On Sun, Feb 24, 2008 at 07:48:32PM +0100, Mike Hommey wrote:
> I took a quick but deeper look to your script, and I think it would be
> better to have a httpd.conf with proper <IfDefine> directives, and
> toggle the proper defines on the httpd command line.

I wanted to avoid that because I thought it would make it harder to adapt the
script to different web servers. However, the script turned out to be very
apache specific anyways. I'll have a look at those IfDefine's.

> Note the ServerRoot is used when paths are relative, so only the
> ServerRoot need to be set, and it could be set with the -C argument to
> httpd, avoiding the need of a .in file. If necessary, modules path could
> be made relative to the ServerRoot by means of a symlink.

I see.

> Avoiding to have logs, dav lock, ssl mutex, etc. in the document
> root would be better, too, but that is nitpicking.

True. Maybe we should also make a separate working directory for the clones.

Clemens
