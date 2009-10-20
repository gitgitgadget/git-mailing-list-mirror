From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 11:08:34 +0200
Message-ID: <237967ef0910200208t290d7ba2l15c75081da5448de@mail.gmail.com>
References: <4ADD6026.8070203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, ftpadmin@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 11:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Ahu-0007Ac-OI
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZJTJIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 05:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZJTJIc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:08:32 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36531 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZJTJIb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 05:08:31 -0400
Received: by ewy3 with SMTP id 3so4566062ewy.17
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=sLs/a66pyS7FLICOJ9vJqlFxI5s+eruSoGRANNDanxQ=;
        b=LyT0862+x8bGW2rOjmN6jRZ61lu0EJ2ZTYcCUnIxw5XXAYab4y3IjeOdVKxWl38K1q
         /mbL7hmTSiJ+ZTzwss/jDLRwS5eh/HcMhcTQvg3XBlxGo3GLKSMS4qry3TYmfzo1yM0x
         I+MjZBdM9VBe0QtXTA7MLSXqNKaAql1z/emPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LjVqK3BMEQ8GWy/fjQ4q8s3BVGMb0+VjVsoEmh77N6hPzs7TjA8UutQmKni/BbOg0a
         pW147m3srv7PhEbWO+00qgBxsYvHlT70lmJ/Jaa1tPSl6/q4GLB45qAv3blfk1/OrnaH
         xGMOoWO3eHtN7uuwz5gKGXpvhiIyC/h+VWKAA=
Received: by 10.211.141.15 with SMTP id t15mr6933991ebn.59.1256029715027; Tue, 
	20 Oct 2009 02:08:35 -0700 (PDT)
In-Reply-To: <4ADD6026.8070203@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130777>

2009/10/20 H. Peter Anvin <hpa@zytor.com>:
> We have run into two major problems with git on kernel.org.  We have
> discussed workarounds, but I believe they are generally major problems which
> will affect other sites, and really need to be fixed upstream.
>
> 1) git receive-pack doesn't run git gc --auto.
>
> This cause repositories which people thought were being autopacked to not be
> so.  This can be done via a hook, but that is way too painful for people to
> do -- in fact, it's hard enough just to get people to enable the post-update
> hook for http fetching.
>
> 1b) as per the above, a way to make "git update-server-info" at post-update
> time a configurable option rather than needing to be done via the hook would
> be very nice, since a configuration option can be enabled sitewide.
>
> 2) When pushing to a repository, it apparently doesn't honor new objects in
> alternate repositories.  This causes massive unnecessary duplication.
>
> I believe these are major issues that need to be addressed.  If we are
> *mistaken* on these, then we would appreciate being corrected.

I don't know how you create repos on kernel.org, but by default both
git init and git clone uses /usr/share/git-core/templates for the new
repo, for example I put a symbolic ref h -> HEAD there to save some
typing. You can enable whatever hooks you want there, but they would
only take effect for new repos.

-- 
Mikael Magnusson
