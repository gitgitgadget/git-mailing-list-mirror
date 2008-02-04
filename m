From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin, submodules
Date: Mon, 4 Feb 2008 12:24:32 -0500
Message-ID: <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
	 <alpine.LSU.1.00.0802032237320.7372@racer.site>
	 <47A68C01.9000600@gmail.com>
	 <alpine.LSU.1.00.0802041443420.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM548-0005q1-VD
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYBDRYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbYBDRYg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:24:36 -0500
Received: from el-out-1112.google.com ([209.85.162.181]:54288 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbYBDRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:24:35 -0500
Received: by el-out-1112.google.com with SMTP id v27so647085ele.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 09:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=78I1cgnaZsTYkIgNf3idyrMEBJPBgzohu/8itpe5gIA=;
        b=fKEdjAzQGmSamUqwnSogZmz1c/iw2B+4QdRstCgkATtO1QTullmvQW6gT9OKSOAN6bd7+3DMM6mXtscc7jytVH4j2W5+aRDooGy5XQMDN6vdRSgYzIz68PPTtxIuZEWTIhjHwXu9MlFJWqKY85R0QSJpFYVfQO1UppDKWVv+i2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bvw6TwUaZsbmbinvPZSIKr6jGg0UO95iKeVfCJn51DNDvBcjOkbwQANaTfeMQ+jUZEdw2y6GHhtTbPiU7V1TOqmK3b3I/wfkRGfKmIt/OxLWhytxBujK7MLZFLNJX59gM9ZH/0V47hpP3xKa9x046S6eY+CZj0oRIzvfPhVodok=
Received: by 10.142.108.14 with SMTP id g14mr3628612wfc.52.1202145872818;
        Mon, 04 Feb 2008 09:24:32 -0800 (PST)
Received: by 10.143.15.6 with HTTP; Mon, 4 Feb 2008 09:24:32 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802041443420.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72529>

On Feb 4, 2008 9:48 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
> Should something like core.origin still be an issue (which I doubt, for
> the same reason you do not change the _name_ of the environment variable
> $HOME), we can still continue discussing that.
>
> Hth,
> Dscho
>
>
BIG difference here:
$HOME = <name> of home directory, <name> is arbitrary. Files there are
found as $HOME/<foo> or <name>/foo, they are the same, and I am free
to set HOME=<arbitrary name>.

Currently
$ORIGIN=origin, i.e., the default is *named* origin, not the default
name is given by $ORIGIN.

Why does this matter? git stores the remote's branches under
refs/remotes/<name>/*. If name=$ORIGIN, I am happy, but the problem is
$ORIGIN=origin, and you argue (strongly) that it MUST be origin. Thus,
branches from server "frotz" *might* be in refs/remotes/frotz/*, or
they *might* be in refs/remotes/origin/*, and that is the root of the
problem.

By the same argument, you have hardcoded in your shell that $HOME=/home, right?

Mark
