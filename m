From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT RFC PATCH(was Re: egit problem with sym linked eclipse project dirs)] Add some support for symlinked projects.
Date: Wed, 18 Mar 2009 22:09:16 +0100
Message-ID: <200903182209.17493.robin.rosenberg.lists@dewire.com>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <200903120756.07853.robin.rosenberg.lists@dewire.com> <p06240820c5e6c6a7d62a@[63.138.152.192]>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk32L-000625-PS
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbZCRVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZCRVJY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:09:24 -0400
Received: from mail.dewire.com ([83.140.172.130]:29768 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbZCRVJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:09:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0303F1391389;
	Wed, 18 Mar 2009 22:09:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enZ76ZQ4nv9f; Wed, 18 Mar 2009 22:09:19 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.16])
	by dewire.com (Postfix) with ESMTP id 849D1139137A;
	Wed, 18 Mar 2009 22:09:19 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <p06240820c5e6c6a7d62a@[63.138.152.192]>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113665>

onsdag 18 mars 2009 17:02:15 skrev Stephen Bannasch <stephen.bannasch@deanbrook.org>:
> At 7:56 AM +0100 3/12/09, Robin Rosenberg wrote:
> >torsdag 12 mars 2009 03:57:09 skrev Stephen Bannasch 
> ><stephen.bannasch@deanbrook.org>:
> >>  OK ... I'm a bit confused now because I no longer have Git listed as
> >>  a repository type for Team Sharing.
> >>
> >  > I deleted the existing org.spearce.* eclipse plugins
> 
> ...
> 
> >  > The new plugins are there:
> >>
> >>     [eclipse]$ ls plugins/org.spearce.*
> >>     plugins/org.spearce.egit.core.test_0.4.0.200903112237.jar
> >>     plugins/org.spearce.egit_0.4.0.200903112237.jar
> >>     plugins/org.spearce.egit.core_0.4.0.200903112237.jar
> >>     plugins/org.spearce.jgit_0.4.0.200903112237.jar
> >>     plugins/org.spearce.egit.ui_0.4.0.200903112237.jar
> >>
> >>  Quit and restarted Eclipse.
> >>
> >>  When I select a project with an existing git repository and try to
> >>  enable team/sharing only CVS and SVN are listed.
> >
> >You don't have the a matching feature. That could be it, but I'm not sure.
> >You can also try starting eclipse witth the -clean switch. Looking at the
> ><workspace>/.metadata/.log could also give you some hints.
> 
> I figured out the problem I had when testing the patched egit plugin. 
> If I had installed egit from the update site I had to do more than 
> just delete the jars -- I had to delete the whole feature from within 
> Eclipse -- and then install the new plugin built from source.
> 
> In figuring this out I ended up testing the original problem with the 
> master branch from earlier today and didn't see the issue I 
> originally reported.
> 
> Did you already integrate the experimental patch?
> 
> Here's a documentation patch:
> 
>  From feb1ae0ccf7f671506853f4f49e9041950404b3d Mon Sep 17 00:00:00 2001
> From: Stephen Bannasch <stephen.bannasch@gmail.com>
> Date: Wed, 18 Mar 2009 11:51:56 -0400
> Subject: [PATCH] clarify how to delete egit plugin when installing new build

Thanks. Deleteing from the update manager deletes the feature from the features
directory plus configuration data.

> >For debugging/testing in general it is often easier to launch Eclipse from
> >eclipse (Run As) without reinstalling.
> 
> As part of this test I need to switch to another workspace and I 
> couldn't get that working with "Run As".

I do it all the time. Come to think of it, just selecting Run As requires that an appropriate
plugin project is selected in the package explorer. Select the org.spearce.egit.ui project
and then Run As > Eclipse Application. You can modify which workspace to open in
the launch configuration. If you want to work on an existing workspace you have to 
modify the launch configuration since the launched eclipse won't let you (maybe it
does, but not by default).

-- robin
