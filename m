From: "Steven" <redalert.commander@gmail.com>
Subject: Re: git revert ignore whitespace
Date: Fri, 10 Sep 2010 16:54:11 +0200 (CEST)
Message-ID: <15732.91.183.48.98.1284130451.squirrel@stevenleeuw.kwik.to>
References: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
    <20100910142114.GB6936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 10 17:05:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou5A8-0005En-TT
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 17:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0IJPFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 11:05:06 -0400
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:1860 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753670Ab0IJPFE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 11:05:04 -0400
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvIaAEbliUxbsdtz/2dsb2JhbACELZ0Tcq5KiE8uiB+DAQiCNAQ
Received: from 115.219-177-91.adsl-dyn.isp.belgacom.be (HELO debian.LAN) ([91.177.219.115])
  by relay.skynet.be with ESMTP; 10 Sep 2010 17:04:58 +0200
Received: from localhost ([127.0.0.1] helo=stevenleeuw.kwik.to)
	by debian.LAN with esmtp (Exim 4.63)
	(envelope-from <redalert.commander@gmail.com>)
	id 1Ou4zT-0001aV-Po; Fri, 10 Sep 2010 16:54:11 +0200
Received: from 91.183.48.98
        (SquirrelMail authenticated user steven)
        by stevenleeuw.kwik.to with HTTP;
        Fri, 10 Sep 2010 16:54:11 +0200 (CEST)
In-Reply-To: <20100910142114.GB6936@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155933>

On Fri, September 10, 2010 16:21, Jeff King wrote:
>
> In theory there is no reason we couldn't support "-w", but I don't think
> there is a way to do it currently.
>
> You could just manually do the revert. Something like:
>
>   git diff-tree -p $commit | git apply --ignore-whitespace
>   git commit -m "revert '`git log -1 --format=%s $commit`'"
>

Thanks for the tip Jeff.

I had to modify the commands a bit to get it to work.
Here they are:
git diff-tree -p <commithash> | git apply --reverse --ignore-whitespace -C0
git add <file(s)>
git commit -m "revert '`git log -1 --format=%s $commit`'"

The --reverse is necessary to revert a patch, I needed the -C0 parameter
as well because the line above changed as well.
This was a fairly simple example, but I imagine it won't work at all with
a larger history, especially with more changes in the relevant sections
and additions/deletions. I believe git revert does take these into
account?

Kind regards,
Steven
