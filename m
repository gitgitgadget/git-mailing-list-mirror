From: "Tim Newsome" <nuisance@casualhacker.net>
Subject: a partial git-svn checkout
Date: Thu, 28 Feb 2008 11:43:41 -0800
Message-ID: <b930b3f10802281143j7be7398eg5ec5fdf5a288cfbc@mail.gmail.com>
References: <b930b3f10802280848g4c11960fx800f71761287e2f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUog2-0007gQ-2q
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 20:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbYB1Tnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 14:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbYB1Tnq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 14:43:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39152 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760099AbYB1Tno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 14:43:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so480986ugc.16
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=x0BzZwA/nPgEMClHsCbmODfoaLZ5hVmDq58I7XQW99o=;
        b=MThGV8pHWhRbYrKJ9Dx+aKRGTZ4eF+UMVfeTQYgR+rsNLN+mwGrSTs6CgbibKUyvNkZo3dIIQ0FyOPuorM7JvEY7MgbVm+HZRCDpkAy072IaDuCmA4aUfs074hc36okgXcQp+FoE6vi15awL2BwVt+DIUjAB90PZK8aRSrN6CGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RV3Ry3tqe7miuI1Y9L8itzrhtn3+P8FpO4FBRP14i/S/4K/PeKuvdO3EuFayJS5voxT4hTRnOmvA0T9eDEuwztkH3eXgPJJpnHh+5hPFx4qYQmWVcTKZERb9yEAWrhJbL/NZLU6wZj3tvH99oVQniN3NDuKMl8ajvpFfkbyR/CQ=
Received: by 10.66.251.20 with SMTP id y20mr3395893ugh.53.1204227821376;
        Thu, 28 Feb 2008 11:43:41 -0800 (PST)
Received: by 10.66.254.18 with HTTP; Thu, 28 Feb 2008 11:43:41 -0800 (PST)
In-Reply-To: <b930b3f10802280848g4c11960fx800f71761287e2f1@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3c539e42b5b03009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75437>

I'm trying to make git-svn only grab a couple of top-level directories
from the svn repository. I can only see how to grab the entire
repository, or a single subdirectory. Is this possible? How?

A little more background info:
At work we have a giant repository. A full checkout is about 8GB,
because it contains several projects and some cruft. So nobody makes a
full checkout. Specifically, there are 3 kinds of directories in
trunk/
1. development directories, which I personally do work on
2. library directories, which I need to build but don't actually work on
3. irrelevant directories, which I never need

Right now I just manually checked out all of 1, made symlinks for 2,
and added that to git. That's a workable checkout size. However, I'm
finding myself writing some scripts to deal with that, and I keep
thinking: git-svn already does this (and better), except that I don't
know how to tell it which directories to grab.

I don't really care about correctly importing tags and branches from
svn, although it would be a nice bonus. Is there a good solution for
this scenario already?

Tim
-- 
Tim Newsome  nuisance.at.casualhacker.net http://www.casualhacker.net/
