From: Phil Lawrence <prlawrence@gmail.com>
Subject: Re: [PATCH] git-gui: Append ampersand to Target of lnk files created 
	by do_cygwin_shortcut.
Date: Mon, 9 Mar 2009 15:57:16 -0500
Message-ID: <530ac78e0903091357v248895ack63588ae6e5e6b57a@mail.gmail.com>
References: <530ac78e0903091022s2585231br9ef11d91851250f4@mail.gmail.com>
	 <alpine.DEB.1.00.0903092109360.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgmg9-0003qJ-Im
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZCIVEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 17:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZCIVEr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:04:47 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:13902 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbZCIVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 17:04:46 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1188936yxm.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KUH8wDnMpQkyIGEBTYnIfgUzqHKuPrmWXHY8fxkDaDg=;
        b=u+E1JsWHknjqEHB6WvoVPWAAbYSTwHRQtAFlvQj1NQUBaRWfaknzbRyRKKR4MXJamO
         b5toYx7uONH7a9VLHeJEwVCi7653b90hstHQkS+muReJRTzthLFB7g306HdCxoFdi6e8
         S2iYP7a4baK8Pss38f+XfDfJXsDuScRSlTK4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bfq4PfxNhk2kDExIaleGbFSWVtCKGlst5JVke/OqPBoxB5esLZJMRvqmVfY82JlufZ
         JyVk9q7mfbGSoYMc/9C4i1yX/8KrVAfdXdvkM5uTznBcChAIulTYtWVg2i9vSiAw3Z7t
         tDX5m61HVwzpNc5UdBj1ZhEtXQoBVZC1yxq/M=
Received: by 10.231.14.196 with SMTP id h4mr1535627iba.15.1236632236552; Mon, 
	09 Mar 2009 13:57:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903092109360.6358@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112742>

On Mon, Mar 9, 2009 at 3:13 PM, Johannes Schindelin wrote:
> Hi,
>
> <snip!>
>
> A few comments.
>
> Usually we try to use that subject as the subject of the mail, and we also
> try to keep the subject shorter than 77 characters (so that "git log" on
> an 80-column display does not need to wrap lines).

> Also, we like authors to provide Signed-off-by: lines.

OK, thank you.

> Now, with the technical stuff out of the way: are you not changing
> behavior?  It seems that Linux users expect an program called by a menu
> item to block the application until the program returns, so that an error
> can be caught.

The menu item in question is "Repository | Create Desktop Icon".  It
does not launch a program, but rather creates a shortcut (.lnk file)
on the Windows desktop.

The purpose of the created shortcut is to make it easy for a user to
launch git-gui for a particular repo in the future.

> Maybe the expectation is different on Windows?  But then, we'd still like
> to catch errors and warn the user about it, right?

I believe a windows user would expect to see git gui launch when they
click the shortcut; they would not expect (nor want) to see a cmd
window open and remain open in the background.

msysGit avoids opening a command window altogether when it's Git GUI
shortcut is used.  Ideally git on cygwin would also have shortcuts
that simply open the GUI, but as a first step I saw we could at least
make the command window politely disappear.

Phil Lawrence
