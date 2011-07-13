From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Multiple projects with Gitweb
Date: Wed, 13 Jul 2011 10:12:31 -0400
Message-ID: <1310566351.5205.9.camel@drew-northup.unet.maine.edu>
References: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mathieu.Pogeant@renesasmobile.com
X-From: git-owner@vger.kernel.org Wed Jul 13 16:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh0BH-0003pi-6O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 16:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab1GMOMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 10:12:46 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:54727 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab1GMOMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 10:12:45 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6DECZSJ020126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Jul 2011 10:12:35 -0400
In-Reply-To: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6DECZSJ020126
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311171156.22498@pqqz4dhSqahFHGy1epVo7g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177040>


On Wed, 2011-07-13 at 13:10 +0000, Mathieu.Pogeant@renesasmobile.com
wrote:
> Hello,
> 
> I'm trying to have this with GitWeb.
> I have a repo under /project1 and a repo under /project2 on my Git server.
> I would like to access these 2 repo via Gitweb like that: http://mygitserver/project1 and http://mygitserver/project2.
> The problem is that gitweb.conf permit to use just one repo with directive $projectroot.
> 
> Did someone face the same problem?
> If needed, I can share configuration file.

Mathieu,
There is no requirement that gitweb only be provided by the HTTPd server
once per machine or virtual host. It is entirely reasonable to set up
two subdirectories (project1 and project2) in your virtual host's home
and serve gitweb from each of those separately using an instance-local
configuration file. That way each instance can be customized.

The /etc/gitweb.conf file is not meant to provide for that
customization. The way that gitweb is currently constructed, if you use
a local configuration file for an instance it will completely ignore the
system-wide configuration file (I didn't make that decision, as it
doesn't make much sense to me either), so you will have to make sure
that ALL settings required are set in each instance-local configuration.

I plan on re-submitting my touch-ups to that documentation now that a
have a minor window of sanity here at work (not that I expect that to
last).

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
