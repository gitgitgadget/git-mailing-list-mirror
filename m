From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sun, 12 Aug 2007 00:05:21 +0200
Message-ID: <37CBFBA3-6A07-44D7-BFCF-5C969C123000@zib.de>
References: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de> <7vps1tlpbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 00:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJz4h-0004iE-Al
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761458AbXHKWEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761275AbXHKWEo
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:04:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:58659 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761342AbXHKWEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 18:04:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BM4Z2J009368;
	Sun, 12 Aug 2007 00:04:35 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BM4Xqs028847
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 00:04:33 +0200 (MEST)
In-Reply-To: <7vps1tlpbb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55639>


On Aug 11, 2007, at 11:43 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Junio,
>> are you interested in such patches at this time. The patch doesn't
>> interfere with the existing code, but clutters it with ifdefs.
>
> Actually "showing HTML pages upon 'git help' request" makes
> sense even on Unixen.  I think a patch to help.c::cmd_help()
> that allows the user to specify alternate action before going to
> the codepath to call show_man_page(help_cmd) would make sense,
> like the attached patch.

So the custom command needs to have the knowledge how to find
the page (as 'man' has), based on the string 'git-<command>'.

Makes sense to me to build only the generic mechanism into
help.c and delegate the rest to core.helpcmd.


> Having said that, a patch that makes the build procedure depend
> on the presense of the html branch is unacceptable, as that
> branch does not even exist in my private build repository.

Sure, the build procedure doesn't depend on it. The executable
wouldn't do anything useful if no html is present.


> If you are building html pages from the source, it surely would
> make sense.

I'd prefer to fetch pages from your repo, at least for msysgit.
Building them requires tools that are, to my knowledge, not
present in msysgit.

	Steffen
