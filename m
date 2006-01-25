From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] diff-tree -c: show a merge commit a bit more sensibly.
Date: Wed, 25 Jan 2006 13:35:22 +0100
Message-ID: <871wywzdrp.fsf@mid.deneb.enyo.de>
References: <7vwtgqas0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 13:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1jrz-0005cf-Qt
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 13:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWAYMfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 07:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWAYMfZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 07:35:25 -0500
Received: from mail.enyo.de ([212.9.189.167]:22928 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751159AbWAYMfY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2006 07:35:24 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F1jrv-0001on-B4
	for git@vger.kernel.org; Wed, 25 Jan 2006 13:35:23 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F1jru-0004ZS-GK
	for git@vger.kernel.org; Wed, 25 Jan 2006 13:35:22 +0100
To: git@vger.kernel.org
In-Reply-To: <7vwtgqas0y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 24 Jan 2006 01:34:21 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15128>

* Junio C. Hamano:

> A new option '-c' to diff-tree changes the way a merge commit is
> displayed when generating a patch output.  It shows a "combined
> diff" (hence the option letter 'c'), which looks like this:
>
>     $ git-diff-tree --pretty -c -p fec9ebf1 | head -n 18
>     diff-tree fec9ebf... (from parents)
>     Merge: 0620db3... 8a263ae...
>     Author: Junio C Hamano <junkio@cox.net>
>     Date:   Sun Jan 15 22:25:35 2006 -0800
>
> 	Merge fixes up to GIT 1.1.3
>
>     diff --combined describe.c
>     @@ +99,18 @@
>        }
>
>     -  static void describe(char *arg)
>      - static void describe(struct commit *cmit, int last_one)
>     ++ static void describe(char *arg, int last_one)

Maybe it would make sense to include a lines like these?

      #  0620db3... (Merge branch 'fix')
       # 8a263ae... (GIT 1.1.3)
      ## fec9ebf... (Merge fixes up to GIT 1.1.3)

This would make more clear which columns corresponds to which parent.
