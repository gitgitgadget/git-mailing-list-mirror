From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 4/4] git-difftool: use git-mergetool--lib for
 "--tool-help"
Date: Fri, 25 Jan 2013 10:47:22 +0000
Message-ID: <20130125104722.GY7498@serenity.lan>
References: <cover.1359057056.git.john@keeping.me.uk>
 <b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
 <CAJDDKr4ZpQr029FW0v8LzwvhXZYmvAONbbZNuOq_E=Q1UzufvA@mail.gmail.com>
 <20130125091918.GV7498@serenity.lan>
 <CAJDDKr5Xd4-e6VO-iO=EmwOcg0RimJHyO4ey-dFk6aENt+qZBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tygp4-0002Rr-JO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab3AYKr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:47:29 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:41239 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab3AYKr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:47:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 0FD442324E;
	Fri, 25 Jan 2013 10:47:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGG7Gq5BomIC; Fri, 25 Jan 2013 10:47:27 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 96CCC2321B;
	Fri, 25 Jan 2013 10:47:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 88DB8161E5A6;
	Fri, 25 Jan 2013 10:47:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgy-cdtA+3Xp; Fri, 25 Jan 2013 10:47:27 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 943B5161E569;
	Fri, 25 Jan 2013 10:47:24 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5Xd4-e6VO-iO=EmwOcg0RimJHyO4ey-dFk6aENt+qZBQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214543>

On Fri, Jan 25, 2013 at 01:55:03AM -0800, David Aguilar wrote:
> list_merge_tool_candidates() has a bunch of other special cases
> for $EDITOR, $DISPLAY, $GNOME-something and such so I think
> we should keep using it only for the guess_merge_tool() path.
> 
> I honestly want to remove list_merge_tool_candidates every
> time I read it, but I recognize that it does serve a purpose
> for users who have not configured anything.

Actually, I'm not sure it does.  I asked one of my colleagues whether
he used git-mergetool the other day and he said no because he couldn't
understand the OS X FileMerge tool and was happier to edit things
manually in vim.  I don't think he'd realised that he could configure a
different mergetool.

Perhaps we're trying to be too clever by guessing what the user wants
and should instead exit with a message saying:

   You have not configured a merge tool to use.  Please select one of
   the following tools and configure it using:

        git config merge.tool <tool>

    These tools are availalble on your system:
        ...

    These tools are supported but unavailable:
        ...

This may be too much of a regression for current users though.


John
