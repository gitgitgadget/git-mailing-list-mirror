From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Teach git-remote to list pushed branches.
Date: Wed, 21 Mar 2007 00:27:32 +0100
Message-ID: <200703210027.32307.johannes.sixt@telecom.at>
References: <200703182134.46450.johannes.sixt@telecom.at> <200703192016.46894.johannes.sixt@telecom.at> <7v648wg8sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 00:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTnjw-0003mw-9Q
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 00:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933931AbXCTX1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 19:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933929AbXCTX1h
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 19:27:37 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:54049 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933931AbXCTX1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 19:27:36 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id ED5C797289;
	Wed, 21 Mar 2007 00:27:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8970B4B634;
	Wed, 21 Mar 2007 00:27:32 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7v648wg8sy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42765>

On Monday 19 March 2007 23:36, Junio C Hamano wrote:
> *1* Actually I think the refspec list on "Push: " lines should
> be split out into separate array elements, because
>
> 	Push: A B C
>
> is equivalent to
>
> 	Push: A
>         Push: B
>         Push: C
>
> This does not apply to "Pull: " lines, as
>
> 	Pull: A B C
>
> and
>
> 	Pull: A
> 	Pull: B
> 	Pull: C
>
> mean quite different things.
>
> This distinction does not matter to the current callers, but I
> was hoping that somebody would build "interactive" mode to edit
> Push and Pull list, and when that happens, having A B C as
> separate entries in @{$hash->{$name}{'PUSH'}} would be handier
> to code.

The patch does just that, I think. It is only that everything is *printed* on 
one line, just like the tracked branches.

BTW, the .git/remotes parser does not allow multiple refspecs on one 'Push:' 
line, if I understand it correctly (I'm looking at get_remotes_uri in 
builtin-push.c).

-- Hannes
