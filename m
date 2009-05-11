From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests
Date: Mon, 11 May 2009 20:04:25 +0000 (UTC)
Message-ID: <loom.20090511T195910-370@post.gmane.org>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 22:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bk4-0002AZ-C3
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZEKUEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZEKUEn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:04:43 -0400
Received: from main.gmane.org ([80.91.229.2]:45516 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbZEKUEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:04:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3bju-00008g-7W
	for git@vger.kernel.org; Mon, 11 May 2009 20:04:42 +0000
Received: from l3-128-170-36-124.l-3com.com ([128.170.36.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 20:04:42 +0000
Received: from ebb9 by l3-128-170-36-124.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 20:04:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118838>

Don Slutz <Don.Slutz <at> SierraAtlantic.com> writes:

> 
> This is a patch set to do the work from mail message:
> 
> http://kerneltrap.org/mailarchive/git/2007/8/7/254415
> 
> It is split into 6 parts.  This is because the tests do not work on
> Linux if autocrlf=true.
> 
> 1) The change to autocrlf=true by default for cygwin

I help maintain the cygwin packaging of git, and I don't particularly like 
patch 1/6.  Cygwin very much recommends that users stick with binary mounts, 
where cr's are not inserted/stripped by default, and enabling autocrlf in that 
situation is asking for problems (namely, the same set of problems as you would 
have on Linux with autocrlf=true).  While adding an environment variable is 
useful for the case of a user building git on cygwin with the intent of using a 
text-mode mount, it goes against the grain of cygwin's recommendation of not 
using text-mode mounts in the first place.  I would rather see the default 
remain false, even on cygwin, unless the person building git takes steps to 
activate it themselves.

-- 
Eric Blake
