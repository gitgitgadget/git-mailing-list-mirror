From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2 2/3] git-remote-fd
Date: Thu, 30 Sep 2010 16:44:04 +0300
Message-ID: <20100930134404.GA22521@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100930131440.GE4850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 15:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JLh-0007Lw-4P
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0I3Niy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 09:38:54 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:42766 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0I3Niy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:38:54 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 926BF8C780;
	Thu, 30 Sep 2010 16:38:52 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A043268E86F; Thu, 30 Sep 2010 16:38:52 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 845AF158A63;
	Thu, 30 Sep 2010 16:38:50 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100930131440.GE4850@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157650>

On Thu, Sep 30, 2010 at 08:14:40AM -0500, Jonathan Nieder wrote:
> Hi Ilari,
> 
> Ilari Liusvaara wrote:
> 
> > This remote helper reflects raw smart remote transport stream back to the
> > calling program. This is useful for example if some UI wants to handle
> > ssh itself and not use hacks via GIT_SSH.
> 
> Do you ever use this directly, or is it a "because we can" sort of thing?
> Whenever I try to come up with an example, ext:: seems to be easier.

I don't have any UIs that would want to override SSH, git:// or something
like that, so no. ext:: sees lots of internal use.

> > +<anything> can be any string. It is ignored. It is meant for provoding
> > +information to user in form of "URL".
> 
> Is this meant for future expansion?  Why not just use a comment in
> .git/config?

These URLs are not meant to go into .git/config.
 
> > +EXAMPLES:
> > +---------
> > +"fd::17"::
> > +	Connect using socket in file descriptor #17.
> 
> Maybe with more context?
> 
> 	socat ... "git push fd::3 HEAD" ...

More like something execing git, having open connection to some git repo.

If you want stuff like that (using socat to establish connections), use
ext::

-Ilari
