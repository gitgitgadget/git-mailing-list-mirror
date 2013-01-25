From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 4/4] git-difftool: use git-mergetool--lib for
 "--tool-help"
Date: Fri, 25 Jan 2013 09:19:18 +0000
Message-ID: <20130125091918.GV7498@serenity.lan>
References: <cover.1359057056.git.john@keeping.me.uk>
 <b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
 <CAJDDKr4ZpQr029FW0v8LzwvhXZYmvAONbbZNuOq_E=Q1UzufvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfbI-0001lO-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3AYJ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:29:11 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:47300 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3AYJ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:29:09 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2013 04:29:09 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1EBC022FE9;
	Fri, 25 Jan 2013 09:19:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbmLwhv-Jarr; Fri, 25 Jan 2013 09:19:23 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 5ED6A231C1;
	Fri, 25 Jan 2013 09:19:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr4ZpQr029FW0v8LzwvhXZYmvAONbbZNuOq_E=Q1UzufvA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214525>

On Thu, Jan 24, 2013 at 09:29:58PM -0800, David Aguilar wrote:
> On Thu, Jan 24, 2013 at 11:55 AM, John Keeping <john@keeping.me.uk> wrote:
> > The "--tool-help" option to git-difftool currently displays incorrect
> > output since it uses the names of the files in
> > "$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
> > git-mergetool--lib.
> >
> > Fix this by simply delegating the "--tool-help" argument to the
> > show_tool_help function in git-mergetool--lib.
> 
> Very nice.
> 
> One thought I had was that the unified show_tool_help should
> probably check TOOL_MODE=diff and skip over the
> !can_diff entries.
> 
> The current output of "git difftool --tool-help" before your
> patches has the problem that it will list tools such as
> "tortoisemerge" as "valid but not available" because it
> does not differentiate between missing and !can_diff.

list_merge_tool_candidates does this for us, so it should Just Work
since we use that to generate the list of tools that we loop over.


John
