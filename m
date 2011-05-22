From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Sat, 21 May 2011 23:50:53 -0700
Message-ID: <20110522065051.GB49297@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org>
 <20110520035856.GA13582@gmail.com>
 <20110520041045.GB13582@gmail.com>
 <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
 <20110520044851.GD13582@gmail.com>
 <4DD7874A.2050604@gmail.com>
 <20110522061446.GA49297@gmail.com>
 <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 08:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO2VE-0003fr-T4
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 08:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab1EVGvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 02:51:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58242 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1EVGu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 02:50:58 -0400
Received: by pvg12 with SMTP id 12so2214050pvg.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WYs+kS3TpaUET4hlmOdV+0x4SRN+y6y9+5IDW0tlE4o=;
        b=rWyCNKmDOJe35FYwAMOY8626tPtJ1CJblKnMcBeSjxs4iOd0OCo4+KqVOQVuFDgTO8
         Lk27UxpufR4Z8dDqNRd7codXRrciI0Z4AtHVMghslauvxIDQRz/10VW9Hp2aOWMkdjrI
         qugjNK5NyMSajlHDWa8ak8+16aHz72cJDHo6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tu9kNcg7H7hWBUm597luBB/ncXNESRcit7nnBCBhIF7BRwF3lcqYgd3hWjFxaTqxF2
         Xe5r7SKIaKHkh9pC4xrCJgYAfjoNIykE082dT4yBttIGdWoYysky5mmtg+m2uxHQ7tbR
         E1vplKPT580urGR6c+hYxGqWj1XGbXZjeC4Gg=
Received: by 10.142.246.17 with SMTP id t17mr682938wfh.26.1306047058328;
        Sat, 21 May 2011 23:50:58 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id x11sm4759156wfd.13.2011.05.21.23.50.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2011 23:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174183>

On Sat, May 21, 2011 at 11:30:58PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > I think updating git-difftool--helper.sh to pass a chdir to vim
> > might be just the thing to do.  git-difftool.perl can be
> > updated to set $GIT_DIFFTOOL_PWD so that the helper can use it
> > as -c 'cd $GIT_DIFFTOOL_PWD'.  I'll see if I can whip up a patch
> > in a lil bit.
> 
> Hmm, would this benefit from sharing some concepts with 7cf16a1
> (handle_alias: provide GIT_PREFIX to !alias, 2011-04-27)?
> 
> If it helps, we might want to uniformly give this information to all
> external processes and programs, including hooks.

Yes, this would be very helpful.
Without this my patch would have to touch git-difftool.perl,
git-mergetool.sh, and git-mergetool--helper.sh.

With $GIT_PREFIX it would touch git-mergetool--helper.sh only.
-- 
					David
