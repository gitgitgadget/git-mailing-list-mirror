From: Christian Himpel <chressie@googlemail.com>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 16:08:38 +0200
Message-ID: <20091012140838.GB29984@lamagra.informatik.uni-ulm.de>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLgT-0007WX-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbZJLOJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbZJLOJS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:09:18 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:44254 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbZJLOJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:09:18 -0400
Received: by bwz6 with SMTP id 6so3125740bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=MYx1QlDI2PfVBMFue3ShDjb6bwKwbcxw7zldPC3fx4o=;
        b=r171FFmCHqSwYr8FCs8o8HORpaZVeqnRWsWuRevI69boXWQgNjCUgq/qpkFtNYeNX0
         BgCyEHP7HCTNw1o/17JDsG8vjELjaaRLWii0XaEcw/Hl61mFjlK/4aQU3uKoPHjc+dOr
         k7pp41hOU4BqGSYeU/l/AMAM3GjRoajIkCWX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e2AYPT4EcLmmZLpIagzc+m/h2Tu0XdvYF9pnSULksGZ9Xykd6yQr/UvcsEuGlA9cAE
         ifvTR4qupDpJ3gSwGkhMZ+hjyJUnVOXrfBNoJpsF1J2rOrL032S260k+8DJ3x5HdcL/h
         D+Ua/+IPQtq/v415pPZUv3FdCl/Z1Tg4zYR5c=
Received: by 10.102.149.9 with SMTP id w9mr2452619mud.77.1255356520873;
        Mon, 12 Oct 2009 07:08:40 -0700 (PDT)
Received: from localhost.localdomain (lamagra.informatik.uni-ulm.de [134.60.77.31])
        by mx.google.com with ESMTPS id u9sm254346muf.31.2009.10.12.07.08.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 07:08:40 -0700 (PDT)
Received: from chressie by localhost.localdomain with local (Exim 4.69)
	(envelope-from <chressie@localhost.localdomain>)
	id 1MxLZn-0000nb-07; Mon, 12 Oct 2009 16:08:39 +0200
Content-Disposition: inline
In-Reply-To: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130012>

On Mon, Oct 12, 2009 at 08:41:15AM -0500, Israel Garcia wrote:
> Which is the simplest  way to backup a git repository after every commit?

Using githooks(5) you can put a simple post-commit script in .git/hooks.

Maybe something like:
-->8--
#!/bin/sh

cp -a `pwd` `pwd`.`date +%s`
--8<--

Don't forget to make the script executable.

Regards,
chressie
