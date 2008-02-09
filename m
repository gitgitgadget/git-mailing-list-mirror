From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: git log -S doesn't search stash WIPs
Date: Sat, 9 Feb 2008 15:18:51 +0000
Message-ID: <57518fd10802090718w2ab705aeg6cb1c531666d52a2@mail.gmail.com>
References: <57518fd10802080246p4a929b62tc6e260a16d3587@mail.gmail.com>
	 <alpine.LSU.1.00.0802081208580.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 16:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNrbW-0004R8-25
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 16:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYBIP0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYBIP0F
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 10:26:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:5624 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbYBIP0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 10:26:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2836210rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=QjTLwDFFBzVLPLzTLTBEW1lTT5lvZXff2SSPccHzNuI=;
        b=riqiWczLGwFZA/n+XSVryAO0a+Kmnt4RoRP3xB7qtfeqyleTBVgVvsT0Abhu10Z2ukxQ41v1gn24Ecaf8hZBtrXMOLY/b2G9225t2wCOBPgSfp7RfEwkaRX+b0bp2ngAX1L1NnuqTaduX6qPBeUdDhOCKDHYCqmNYo/lus1E+l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ai1weZAnsXpoQDVcg5fIrhcdtvMF97ycXvWLYKU1v4vpMRQfrf15iM4rq+W9rDFz3qZDXIvoxLAL2C4k9JFBBwYWr5+QiAuCupmlDovXVhyXVjuZYZaYRqKJgGV3kJGIDSE7H+JY0a05fRoomFeTn/4XT3xhzgwSYSWuwCXdybU=
Received: by 10.140.136.1 with SMTP id j1mr9311485rvd.233.1202570331297;
        Sat, 09 Feb 2008 07:18:51 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Sat, 9 Feb 2008 07:18:51 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802081208580.11591@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: c6863cbabfc77d18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73235>

On Feb 8, 2008 12:18 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 8 Feb 2008, Jonathan del Strother wrote:
>
> > "git log --all -Sfoo" doesn't find strings introduced in stash WIP
> > commits, only the stash index.
>
> It is a little unfortunate that a stash will do this:
>
> HEAD ------- stash
>     \       /
>       index
>
> In other words, the index will be "committed" as a regular commit, but the
> working directory will actually be a "merge commit".
>
> So you need to add "--cc" to see the commit.
>
> Further, the stash is not just a branch.  The stash is actually a stack of
> reflogs.  So could you try again, with
>
>         $ git log --cc -Sfoo --walk-reflogs stash


Hmmm, I'm a little fuzzy on why --cc helps, though it looks like
either or both of --cc and --walk-reflogs will do the trick.
Thanks for the help
Jon
