From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] difftool: don't assume that default sh is sane
Date: Sat, 19 Jul 2014 19:29:50 +0100
Message-ID: <20140719182950.GA31037@hashpling.org>
References: <1405787717-30476-1-git-send-email-charles@hashpling.org>
 <1405787717-30476-2-git-send-email-charles@hashpling.org>
 <20140719172132.GB26927@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8ZRB-0005w8-9n
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 20:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbaGSScp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 14:32:45 -0400
Received: from avasout06.plus.net ([212.159.14.18]:59824 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbaGSSco (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 14:32:44 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id UJYg1o0052iA9hg01JYhTw; Sat, 19 Jul 2014 19:32:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=WL/xXxcR c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=L6f1SxiQgHsA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=l181BH5Fa1yZAtOa53gA:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1X8ZOI-0008GA-6L; Sat, 19 Jul 2014 19:29:50 +0100
Content-Disposition: inline
In-Reply-To: <20140719172132.GB26927@serenity.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253904>

On Sat, Jul 19, 2014 at 06:21:32PM +0100, John Keeping wrote:
> 
> What's the reason for forcing `--tool-help` to be the last option?
> Wouldn't it be simpler to just change the top-level case statement to:
> 
> 	--tool-help=*)
> 		TOOL_MODE=${1#--tool-help=}
> 		show_tool_help
> 		;;
> 	--tool-help)
> 		show_tool_help
> 		;;

It doesn't make sense to use --tool-help with other parameters so issuing
an error made sense to me at the time. You've pointed out to me that I
don't error when those other options come first so I'm now unsure how
valuable this behaviour is, now. (I can't immediately see a really neat way
to give a diagnostic if other options do come first.)

Your version is good, obviously simpler.
