From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Tue, 29 Apr 2008 01:16:28 +0200
Message-ID: <20080428231628.GD22815@cuci.nl>
References: <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness> <20080428204323.GA22815@cuci.nl> <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness> <20080428210003.GB22815@cuci.nl> <alpine.DEB.1.00.0804282209230.19187@eeepc-johanness> <20080428211328.GC22815@cuci.nl> <alpine.DEB.1.00.0804282222150.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:17:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqcb1-0001rQ-RM
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 01:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967806AbYD1XQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 19:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967575AbYD1XQb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 19:16:31 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44422 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967089AbYD1XQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 19:16:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id DD8BC545E; Tue, 29 Apr 2008 01:16:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804282222150.19187@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80632>

Johannes Schindelin wrote:
>On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
>> >I can do better than that.  I attached to the process, and like I said, it 
>> >hung in close().

>> On which descriptor?  (I.e. what does the descriptor point to?)

>Sorry, that I don't remember, but I strongly suspect the syslog 
>descriptor, since the backtrace showed "syslog()" a few levels up of 
>close().

AFAICT, sending SIGHUP to syslogd doesn't cause the /dev/log pipe to be
closed, therefore there shouldn't be any closing of that /dev/log pipe.
So if you can reproduce it, please report which filedescriptor it is
trying to close.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
