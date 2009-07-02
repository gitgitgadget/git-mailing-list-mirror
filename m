From: Robert Stonehouse <rstonehouse@solarflare.com>
Subject: Re: git bisect; is there a way to pick only from the children of
 a given commit
Date: Thu, 02 Jul 2009 12:56:27 +0100
Message-ID: <4A4CA06B.8090403@solarflare.com>
References: <loom.20090701T170535-707@post.gmane.org> <BLU0-SMTP20683A1D7E5DEC1370D496AE2E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 14:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MML8w-0005B9-I8
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 14:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZGBMLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZGBMLl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 08:11:41 -0400
Received: from 216-237-3-220.orange.nextweb.net ([216.237.3.220]:36585 "EHLO
	exchange.solarflare.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZGBMLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 08:11:41 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2009 08:11:41 EDT
Received: from [10.17.20.41] ([10.17.20.41]) by exchange.solarflare.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Jul 2009 04:56:34 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <BLU0-SMTP20683A1D7E5DEC1370D496AE2E0@phx.gbl>
X-OriginalArrivalTime: 02 Jul 2009 11:56:34.0722 (UTC) FILETIME=[25AFB020:01C9FB0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122640>

Sean Estabrooks wrote:
 > On Wed, 1 Jul 2009 17:12:16 +0000 (UTC)
 > Robert Stonehouse <rstonehouse@solarflare.com> wrote:
 >> I was surprised that git bisect was asking me to test commits on the 
featureB
 >> branch. I couldn't test the build target that was broken on branch 
featureB
 >> because it wasn't present in the code at that point.
 >
 > You can exclude the featureB branch by listing at good.  Git will 
know there
 > is no need to test anything on that branch:

In my toy example it is easy to identify featureB branch as being 
independent and marking it as good - but in a real repository it would 
be much harder as they might be many more merges.

I think if I changed my usage of git bisect good and bad to:
   good => build completes
           OR a revision that does not have the new build target
   bad  => new build target fails
then I think it will converge to the problem commit. So perhaps this was 
just an issue of semantics

Thanks for your help

-- 
Rob Stonehouse
