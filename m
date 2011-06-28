From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone failing
Date: Tue, 28 Jun 2011 04:28:31 +0000
Message-ID: <20110628042831.GA29202@dcvr.yhbt.net>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
 <1298033812.10893.23.camel@drew-northup.unet.maine.edu>
 <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
 <1298587459.22431.19.camel@drew-northup.unet.maine.edu>
 <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
 <BANLkTine4g7LyiXmE6zYpNs7aa2FfXYGUg@mail.gmail.com>
 <BANLkTin7bxu_XZVYaVy+eXuhcJR83hXSew@mail.gmail.com>
 <1307019308.28941.4.camel@drew-northup.unet.maine.edu>
 <BANLkTikkXG95WxaDaFcJnCsQ_B5qHKUJwQ@mail.gmail.com>
 <BANLkTimoDBr+ikZ4XoW1y=1=_JNOtp_jfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Vampire <Vampire@Masters-of-Disaster.de>
X-From: git-owner@vger.kernel.org Tue Jun 28 06:32:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbPyQ-0008Sy-7J
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 06:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443Ab1F1E2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 00:28:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41724 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369Ab1F1E2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 00:28:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C811F897;
	Tue, 28 Jun 2011 04:28:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BANLkTimoDBr+ikZ4XoW1y=1=_JNOtp_jfg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176382>

Vampire <Vampire@Masters-of-Disaster.de> wrote:
> Hm, actually I found a workaround.
> If I use https instead of http, it works fine.
> But I think it should also work with http.

This could be a server configuration issue.... More below.

> 2011/6/2 Vampire <Vampire@masters-of-disaster.de>:
> > It seems to me that this happens while git-svn is searching for history.
> > As far as I have understood git-svn searches hierarchical higher paths
> > for history in other places than specified.
> > I guess while trying to access all those paths some path is tried that
> > returns 403 Forbidden.
> > My assumption is that git-svn takes this as cause to abort instead of
> > ignoring this return state what would be appropriate in this case I
> > think.

git svn should be able to avoid following old history with the
--no-follow-parent option.  There's also the --ignore-paths option
which can ignore newer history, too.  I've rarely used either (and
rarely use git-svn nowadays), but one of them should work in case
neither http nor https work

-- 
Eric Wong
