From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 22:43:23 +0200
Message-ID: <20080428204323.GA22815@cuci.nl>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:44:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqaCw-0002Zn-0Y
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbYD1Un0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbYD1Un0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:43:26 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:36492 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbYD1UnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 16:43:24 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BC9AF545E; Mon, 28 Apr 2008 22:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80607>

Johannes Schindelin wrote:
>since you seem to be very new to this list: we really appreciate a 
>Reply-to-all here.

I see.  I normally consider that bad form (maybe my age shows ;-);
but if people insist here, no problem.

>On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:

>> >> I have no idea, but other programs must have the same problem.  I 
>> >> should

>So do you have any ideas what is happening there?  It seems that after 
>logrotate does its thing, syslog() is stuck in the close() call.

Erm, just so I understand the problem:
- git-daemon is configured to use syslog(3) to log
- git-daemon uses openlog(3)
- git-daemon logs happily for a while
- rotatelog rotates logfiles in /var/log and communicates with syslogd
  to make sure syslogd starts new logfiles in /var/log
- And then git-daemon hangs on which system/library call?
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
