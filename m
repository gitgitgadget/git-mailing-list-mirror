From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git citool/gui bug
Date: Wed, 30 Jul 2008 20:23:37 -0700
Message-ID: <20080731032337.GA1860@spearce.org>
References: <20080730185306.GV7616@integratech.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Leandro Lucarella <llucarella@integratech.com.ar>
X-From: git-owner@vger.kernel.org Thu Jul 31 05:24:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOOmS-0006aT-Is
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 05:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897AbYGaDXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 23:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757799AbYGaDXk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 23:23:40 -0400
Received: from george.spearce.org ([209.20.77.23]:42082 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbYGaDXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 23:23:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 353DC383A4; Thu, 31 Jul 2008 03:23:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080730185306.GV7616@integratech.com.ar>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90889>

Leandro Lucarella <llucarella@integratech.com.ar> wrote:
> Hi! I think I've hit a really silly bug in citool/gui:
> 
> git citool shows:
> 
> new file mode 100644     # black
> @@ -0,0 +1,5 @@          # blue
> +                        # green
>  ===============         # orange
> +Hello World!!!!         # green
>  ===============         # orange
> +                        # green

Hmph.  Don't put 7 = on a line together.  Or 7 < or 7 > for that
matter.  It confuses some git related tools like git-rerere,
the template pre-commit hook, and git-gui.

In this case we think these are the lines between two hunks in a
merge conflict, so we are showing them specially to you.  Just in
case you staged a conflicted hunk by accident during a merge you
want it to stand out to help you notice the error.

Yes, it would be nice if git-gui knew this wasn't actually a merge
conflict but was instead proper text.  Sadly it isn't that smart.

-- 
Shawn.
