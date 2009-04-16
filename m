From: Ben Jackson <ben@ben.com>
Subject: Re: integrating make and git
Date: Thu, 16 Apr 2009 03:50:20 +0000 (UTC)
Message-ID: <loom.20090416T034427-809@post.gmane.org>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 06:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuInF-0003lU-GH
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 06:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbZDPEAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 00:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbZDPEAI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 00:00:08 -0400
Received: from main.gmane.org ([80.91.229.2]:34965 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZDPEAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 00:00:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LuIle-0001ga-EK
	for git@vger.kernel.org; Thu, 16 Apr 2009 04:00:02 +0000
Received: from kronos.home.ben.com ([71.117.242.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 04:00:02 +0000
Received: from ben by kronos.home.ben.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 04:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.117.242.19 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116666>

E R <pc88mxer <at> gmail.com> writes:

> Now suppose that making 'lib1' only depends on the source code in a
> certain directory. The idea is to associate the hash of the source
> directory for lib1 with its the derived files. Make can check this to
> determine if the component really needs to be rebuilt.

ClearCase has "wink-ins" which are very much like this.  It knows that a given
object was produced from a certain set of sources with a particular command. 
When someone wants to recreate that object (not even necessarily the original
builder) it can "wink in" the result.  Typically a brand new "view" (a ClearCase
working directory) build will consist of winking in a ton of objects rather than
building anything.  I'm not sure how much of this is due to cleverness in
clearmake and how much is due to the view being implemented as a virtual
filesystem (which can see every repository file being read as part of a build).

--Ben
