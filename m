From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Mon, 7 Jun 2010 21:32:26 +0200
Message-ID: <20100607193226.GA19789@localhost>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
 <20100606164642.GA10104@localhost>
 <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
 <20100607185439.GB17343@localhost>
 <vpqzkz6fy9m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 07 21:34:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLi5a-00035V-BT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 21:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab0FGTeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 15:34:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49934 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab0FGTeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 15:34:20 -0400
Received: by fxm8 with SMTP id 8so2384120fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5V7sH6+sUJoPpHrLmM7ZfaE7TkYafYZ2wHRIlVqtvRg=;
        b=cmVIlRidFFRxclns+wvZ426tXj0VnH0PAw9vOsB8UVQL2Sjt4bMKnVcu2IMR7L1w4o
         rtuQ4hanQkiyNmUg15HNVmOytxE6V0+ClI08HRTttsT/Y50o5uQhtvUXDK65cpiwdPM0
         KfmIsDYOFoBLrLosjpM5fVDcRLfloJ5YE47tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ADKBYMdwzlQME+iPz5lbVii6Auq82WaEe+4akM7lbxhQOARgScXF2Xd+s/prPk+qyK
         HKbNiLKqZaAZ2Y144mGg+ADX7uy11FvfueBdE6XyzSNHO3b7UH28h28z1dzmC/h4Sgfb
         CsyPDyWsg5StmWoFTmYLT2h8X90K1e16qy4Q4=
Received: by 10.223.25.74 with SMTP id y10mr15545444fab.81.1275939258991;
        Mon, 07 Jun 2010 12:34:18 -0700 (PDT)
Received: from darc.lan (p549A5B93.dip.t-dialin.net [84.154.91.147])
        by mx.google.com with ESMTPS id u12sm21673828fah.4.2010.06.07.12.34.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 12:34:18 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLi3e-0005Az-OE; Mon, 07 Jun 2010 21:32:26 +0200
Content-Disposition: inline
In-Reply-To: <vpqzkz6fy9m.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148619>

On Mon, Jun 07, 2010 at 09:17:25PM +0200, Matthieu Moy wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > But this is supposedly a feature which helps users who type "git
> > checkout <branch>" by mistake, when they really wanted to do "git
> > checkout -t <remote>/<branch>".
> 
> Not sure what's the argument here, but aren't the two commands
> equivalent? Do you prefer the second syntax "git checkout -t
> <remote>/<branch>"? It's already a DWIM for "git checkout -b <branch>
> -t <remote>/<branch>", and I find this one far more confusing:
> 
> git checkout    <remote>/<branch> => detaches HEAD
> git checkout -t <remote>/<branch> => creates a local branch automatically

The intent with -t is clear. It is used only when you create a new
branch. Also, you specify the remote branch you're going to create
a new branch from.

"git checkout <branch>", on the other hand, will create a branch
based on a remote branch, even though you neither asked for a new
branch, nor did you specify any remote at all.
