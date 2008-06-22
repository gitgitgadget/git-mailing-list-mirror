From: John Locke <mail@freelock.com>
Subject: Usage with Subversion, externals
Date: Sun, 22 Jun 2008 14:03:01 -0700
Message-ID: <485EBE05.6070402@freelock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 23:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAWot-0005jp-Us
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 23:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbYFVVJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 17:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbYFVVJA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 17:09:00 -0400
Received: from logan.freelock.com ([216.231.62.127]:39789 "EHLO
	logan.freelock.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbYFVVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 17:08:59 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2008 17:08:59 EDT
Received: from localhost (foraker.freelock.com [127.0.0.1])
	by logan.freelock.com (Postfix) with ESMTP id DF316A0456
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 14:03:03 -0700 (PDT)
Received: from logan.freelock.com ([127.0.0.1])
 by localhost (foraker.freelock.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30946-05 for <git@vger.kernel.org>;
 Sun, 22 Jun 2008 14:03:03 -0700 (PDT)
Received: from [192.168.9.243] (router.freelock.lan [192.168.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by logan.freelock.com (Postfix) with ESMTP id BF924A0448
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 14:03:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-Virus-Scanned: by amavisd-new at freelock.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85801>

Hi,

Brand new git user, trying to get my head around how to use this after 
years of Subversion usage.

I have a project that uses svn:externals to load a dependent library. 
The external repository, dojo toolkit, has a different layout for trunk 
than the tagged versions. Right now, I've got these svn externals defined:

> john@shasta:/opt/www/auriga$ svn pg svn:externals public_html/
> dojo http://svn.dojotoolkit.org/src/tags/release-1.1.1/
>
> john@shasta:/opt/www/auriga$ svn pg svn:externals public_html/dojo-trunk/
> dojo http://svn.dojotoolkit.org/src/dojo/trunk/
> dijit http://svn.dojotoolkit.org/src/dijit/trunk/
> dojox http://svn.dojotoolkit.org/src/dojox/trunk/
public_html/dojo contains dojo, dijit, dojox, and util directories, 
tagged to the specific version. The dojo svn repository stores trunk 
versions for each of these modules in src/<module>/trunk.

The problem I'm trying to solve by switching to git is that there are 
some API changes to Dojo that break the current production version of my 
application. So I'd like to branch my application and develop it against 
the Dojo trunk, while still being able to make changes to the mainline 
code using the stable Dojo tagged version.


I've used git svn clone to copy my main application, and I'm also 
pulling down the dojo svn repository (would be happy to post this 
somewhere when it's done).


So: Question 1: how do I get public_html/dojo in my working copy to 
contain dojo/trunk, dijit/trunk, and dojox/trunk from my external git 
repository? I'm assuming I use a submodule for this, and git submodule, 
but I'm wondering how I point git submodule to a particular path in the 
other repository.

... and question 2: How do I set up a different git submodule path (in 
the same external git repository) when I work on a different branch?


I'd like to be able to git checkout the development branch and have it 
switch the dojo submodule to contain dojo/trunk (aliased as dojo), 
dijit/trunk (aliased as dijit), and dojox/trunk (aliased as dojox). And 
then when I git checkout the main branch have it switch back to 
tags/release-1.1.1 (which contains dojo, dijit, and dojox without a 
trunk subdirectory).

Any thoughts?

-- 
John Locke
"Open Source Solutions for Small Business Problems"
published by Charles River Media, June 2004
http://www.freelock.com
