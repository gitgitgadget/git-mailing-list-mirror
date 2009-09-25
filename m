From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 1/2] add support for core.logAllRefUpdates configuration parameter
Date: Sat, 26 Sep 2009 00:45:20 +0200
Message-ID: <200909260045.21171.robin.rosenberg@dewire.com>
References: <D35B4A582834DC418CCF9AF41AB69B70016953F62F@DEWDFECCR04.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Halstrick, Christian" <christian.halstrick@sap.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJXk-0007fV-AD
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZIYWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 18:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZIYWpU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:45:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:16939 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbZIYWpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 18:45:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AD4D7147DB2B;
	Sat, 26 Sep 2009 00:45:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xkyyn9jiRGCH; Sat, 26 Sep 2009 00:45:22 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 078A0139D880;
	Sat, 26 Sep 2009 00:45:21 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <D35B4A582834DC418CCF9AF41AB69B70016953F62F@DEWDFECCR04.wdf.sap.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129129>

onsdag 23 september 2009 18:42:29 skrev "Halstrick, Christian" <christian.halstrick@sap.com>:
> From: Christian Halstrick <christian.halstrick@sap.com>
> 
> JGit should understand configuration parameter logAllRefUpdates and should
> only log updates of refs when
>   either the log file for this ref is already present
>   or this configuration parameter is set to true
> Before this commit JGit was always writing logs, regardless of this
> parameter or existence of logfiles.

A few minor things:
Format the comment nicely and space betwee paragraphs.
Start the comment with a capital letter
A cover letter for multiple patches is nice, though in this case you could
actually just squash there patches into one patch.

and one major.
RefUpdateTest broke.

Probably because of this.
> +		logAllRefUpdates = rc.getBoolean("core", "logAllRefUpdates", false);

According to the git-config man page logAllRefUpdates is true by default for non-bare
repos and false for bare repos.

I had some trouble applying these patches as git-am did not like them. Apparently
git-am doesn't like base64. Could you set your mailer to use a more plain-ish format
or use git-send-email. 

-- robin
