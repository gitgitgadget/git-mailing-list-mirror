From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Retroactively change email signature?
Date: Wed, 02 Jan 2008 13:17:00 -0800 (PST)
Message-ID: <m3ejczordw.fsf@roke.D-201>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAAxx-0003Xx-5x
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 22:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbYABVRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 16:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbYABVRF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 16:17:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:16288 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbYABVRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 16:17:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2569144ugc.16
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=VOKd5PElr8DSVcmOhlJrS9wVkb+5CsX4csWTcuL2Ybw=;
        b=JAi13UURmvg2SLcmzdtOGxMjcJ1Wsvj6P0vSKER8ISGHKIC0cvEe2MLDt5f+6FoqPD5cNJXvGRYyAefpZ1chDx69U8e/uxcdfb2d6FvEVSvpVyk2c76/nvyQJ9GKiD5px3rlGWimcgnVKryNtp8Ui5ukwyHYe9kakM/G7vVTxJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Hwnzj9iF6D2OJZPmUzOxzA4B7S8z5LmrHXjUGuXzZgIWciavyBK0Ztd5BMJM0j2CLsD12oRYk3RGnJ9kjeAORK4kLcHz84z3kaT89LtawncPth8+rE5R43s1tnSZ4rN5c0ohttiASCkPh9mi+aSPHDIJp3FrcgJOGW3py/XwL/A=
Received: by 10.67.26.7 with SMTP id d7mr14455243ugj.23.1199308621393;
        Wed, 02 Jan 2008 13:17:01 -0800 (PST)
Received: from roke.D-201 ( [83.8.196.6])
        by mx.google.com with ESMTPS id 28sm15933347ugc.21.2008.01.02.13.16.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Jan 2008 13:17:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m02LLXJp014125;
	Wed, 2 Jan 2008 22:21:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m02LLWAU014122;
	Wed, 2 Jan 2008 22:21:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69491>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

> I imagine that changing old commits is considered one of the great
> evils of source control, but I have a small problem:
> I have a habit of testing my code on several different computers and
> operating systems.  Sometimes when setting up a new computer for
> testing (and thus, for development, since testing always results in a
> few commits), I have forgotten to use git-config to configure my name
> and email address.
> 
> Since git doesn't warn when I've forgotten to do this, my git-log is
> now sprinkled with various email addresses, some which are just my
> username@hostname.  This is completely useless to people who might
> view my public repository.

This most certainly should get addressed IMHO.
 
> Is it possible to retroactively change the author and email of several
> commits?  Perhaps some sort of search-and-replace for the commit
> metadata?  Even for older commits, I'd like to change the email
> addresses to my current address.
> 
> If it's not possible it's not the end of the world, but I thought it
> wouldn't hurt to ask.

You can use git-filter-branch(1), but please remember that it is
practically rewriting whole repository, so you should do this _before_
you publish any changes.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
