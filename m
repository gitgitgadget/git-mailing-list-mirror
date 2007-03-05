From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 22:19:21 +0100
Message-ID: <45EC8959.1090303@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC4B55.3090505@lu.unisi.ch> <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC51C6.5080505@lu.unisi.ch> <Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKai-0006Te-Qd
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580AbXCEVT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933592AbXCEVT3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:19:29 -0500
Received: from server.usilu.net ([195.176.178.200]:48755 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933580AbXCEVT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:19:28 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 22:19:25 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 21:19:26.0018 (UTC) FILETIME=[F3D30220:01C75F6B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41488>


>> There is.  The man page says "Scanning stops when an input character 
>> does not match such a format character."  Scanning includes not 
>> processing %n elements, either.
> 
> So, if you want to be that precise, it never says that it does not touch 
> the pointers passed to it.

It cannot know that there *are* any pointers unless it goes on scanning the format string.  Since the function it varargs, it cannot *guess* that there are any without scanning that the documentation says does not happen.  Anyway...

> But it states very clearly what the return 
> value is in case of a failure.

Actually ISTR that %n is not counted in the return value and that's why I wrote the code this way.

> Yes, this is what the source does. But again, the return value is what you 
> should -- and indeed forever can -- rely on. I am not really happy that 
> dwim_ref() touches ref, even if nothing was found, but it is an 
> _implementation detail_.

It's not fair to not have any documentation in the code, force the contributor to reverse engineer the documentation, and say it is relying on an implementation detail.  In otherwise undocumented code, implementation == interface.

Paolo
