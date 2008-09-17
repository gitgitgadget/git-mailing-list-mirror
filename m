From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Teach git status to do "git diff --name-status HEAD"
Date: Wed, 17 Sep 2008 04:04:30 -0700 (PDT)
Message-ID: <m3ej3jm3ux.fsf@localhost.localdomain>
References: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>
	<48D0C2DF.7010308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfusA-0002sH-Ez
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYIQLEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYIQLEe
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:04:34 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:53757 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYIQLEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:04:33 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1547777gvc.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=txx9avOYjEFNoqdB8kgGeuNIdK96i6/LOCDXOclgM9E=;
        b=jAK0S39mIeam7nbh58hdx5gqGs9opX3XWe2mCBt7hVEYjPv2Q8RVJo5LAkfVvSV0V0
         SHETcPaDqdUP1lyKot+SYCxj9NCMXMQVnn5tuRtHn3UiMFB/Bz9dVwu5gWJAP+0P/NVx
         scoDK8YbZfSJ0I4z5fX8PH3H/CPN2tNv/hEGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=rbeh5ODYIbtItLeRdh9z/CIVUxVISuSy4cbtGlXAYKrRdcVUMwyyONGMYfsDlT4pOP
         kLf3oJfE5QSkBVTtrXI0h6eE4dWqT1VndNgBDIYhb7TgDVC7kQiPZo4y09qtzsW/aEv5
         EmYMJ59Xl+Q2zQlERy4Rii7WFS6iH82QP70AM=
Received: by 10.103.223.9 with SMTP id a9mr1663842mur.87.1221649471643;
        Wed, 17 Sep 2008 04:04:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.250.173])
        by mx.google.com with ESMTPS id i5sm7749709mue.11.2008.09.17.04.04.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 04:04:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8HB3hix004548;
	Wed, 17 Sep 2008 13:03:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8HB3Jek004540;
	Wed, 17 Sep 2008 13:03:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48D0C2DF.7010308@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96090>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Martin Langhoff venit, vidit, dixit 17.09.2008 08:40:
> > I just did
> > 
> > $ git checkout -b mdl19-offlinetony
> > A       README.offline
> > M       lib/javascript.php
> >     (...)
> > A       lib/offline/offlinemoodle.user.js
> > 
> > I *like* this "brief status" style - takes me back to my cvs days :-).
> > Perusing the source I found show_local_changes() which in turn led me
> > to trying `git diff --name-status HEAD`. Now, including 'HEAD' in an
> > alias defined in git config is going to lead to trouble... :-/
[...]
> > I might still make an alias to `git diff --name-status`. This would be
> > a great thing to have as git status "--brief" IMHO... :-)
> 
> git status also shows untracked files. I don't know how to tell diff to
> show untracked files as well. --diff-filter=X doesn't do it.

git-ls-files?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
