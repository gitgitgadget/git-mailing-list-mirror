From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 4 Jan 2012 21:40:17 +0100
Message-ID: <20120104204017.GC27567@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 21:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiXlH-0004L1-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 21:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab2ADUsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 15:48:35 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59862 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756853Ab2ADUse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 15:48:34 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 45917A7EB8;
	Wed,  4 Jan 2012 21:49:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187943>

On Wed, Jan 04, 2012 at 10:00:07AM -0800, Junio C Hamano wrote:
>
> >> >> +	# kill git-daemon child of git
> >> >> +	say >&3 "Stopping git daemon ..."
> >> >> +	pkill -P "$DAEMON_PID"
> >> 
> >> How portable is this one (I usually do not trust use of pkill anywhere)?
> >
> > I read that it is supposed to be more portable than skill or killall.
> > But I have no way to research this. I have implemented a workaround
> > using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.
> 
> Yuck, that patch looks even uglier X-<.
> 
> Do you really need to kill the children but not the daemon?

If I kill just the parent "git daemon" command, then the actual
git-daemon (started by run_command) will be left behind.
