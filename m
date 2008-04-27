From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken
 branch imports
Date: Sun, 27 Apr 2008 07:47:37 +0200
Message-ID: <48141379.9030306@alum.mit.edu>
References: <1207100091.10532.64.camel@gandalf.cobite.com>	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>	 <1207230582.17329.39.camel@gandalf.cobite.com>	 <47F5FA79.8010604@alum.mit.edu>	 <1207590845.17329.98.camel@gandalf.cobite.com>	 <47FC2190.3070303@alum.mit.edu> <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Mansfield <david@cobite.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 07:48:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpzka-0005KS-Gy
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 07:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbYD0Fru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYD0Fru
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 01:47:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37900 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbYD0Frt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 01:47:49 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m3R5liOV005064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Apr 2008 07:47:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80411>

Ping Yin wrote:
> These days i tried to convert the cvs repository into git. I really
> want the conversion to be as accurate as possible. However, the cvs
> repository has been tagged in a very bad style which makes
> git-cvsimport or cvsps not work well.
> 
> cvs2git sounds to be the right tool i should try. Unfortualely, i
> can't touch the cvs repository directly. So is it possible to use
> cvs2git in the remote host instead of the host of the cvs repository
> just as git-cvsimport does? Yes, i know it can't now. I just wonder
> whether it is possible to implement.

cvs2svn/cvs2git itself can't work with remote repositories.  It would be
enough if you could just get a copy of the repository; obviously you
don't need to use the original.

If you can't get a copy of the CVS repository directly, you might be
able to recreate it indirectly via information read over the CVS
protocol using a tool like CVSsuck [1,2].  I have no experience with
CVSsuck, so if you try it out, please let us know whether you were
successful.

Presumably some CVSsuck-like functionality could be built directly into
cvs2git, but given that this request hasn't come up very often and that
the two tools can presumably be used in concert, it doesn't seem worth
the effort.

Michael

[1] http://cvs.m17n.org/~akr/cvssuck/
[2] http://cvs2svn.tigris.org/faq.html#repoaccess
