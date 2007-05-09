From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 22:38:26 +0200
Message-ID: <8c5c35580705091338r63acc7aaw43248ad246670e8b@mail.gmail.com>
References: <11787000032830-git-send-email-hjemli@gmail.com>
	 <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
	 <20070509185440.GB3141@spearce.org>
	 <8c5c35580705091301s19dcd2e0q20a4c84e3dd23d82@mail.gmail.com>
	 <20070509201105.GF3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlsvi-00026D-95
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbXEIUi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754353AbXEIUi3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:38:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:17205 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbXEIUi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:38:28 -0400
Received: by nz-out-0506.google.com with SMTP id o1so341942nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 13:38:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JotwipZqZzfHXDsq/rZnwbPuDu+vf3dJFOIk1MU9icxSkHa2bjQ8Opa5pXcErFDqlyMNcz9CU4q8VgzhTME/eZYOCdJYAtDMwGiiGp2r5LtRN8n/9ZoYpgnughZc4KZPsxGFOHQKcMBGBzwvs22CteKiIRFRisSaVbgXs/v+J24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fbYH6Njgp12uQ8CWmf+JUaZdb5hTTcq+X/PK3L8yeILCvJxMX/WT6EDlXCknFvd1cql6BSFCt7rVtK7W84W9m0AelV+gIMF8KxbAxfx9SbNIAX8Arhn14plFLrByMkdufpSTF9VitrRDapOlYdcCFXWBlUEjBjnhKmg+XRjoM1o=
Received: by 10.114.181.1 with SMTP id d1mr303224waf.1178743106586;
        Wed, 09 May 2007 13:38:26 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Wed, 9 May 2007 13:38:26 -0700 (PDT)
In-Reply-To: <20070509201105.GF3141@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46786>

On 5/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > On 5/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >If you are building "porcelain" to sit over Git and offer up a pretty
> > >view of things, I would encourage you to avoid the stock porcelain.
> > >Don't use git-checkout, its stock porcelain.  Instead go right to
> > >the plumbing.  The plumbing doesn't really change behavior as often
> > >(if ever).
> >
> > Thanks, I probably will (also to avoid the shell scripts, since my
> > porcelain is aimed at my co-workers who are stuck on windows)
>
> Are you building a strictly Win32 native GUI?  Or something else?

It's mono/.net, so I can test it on my linux box and push the binary
directly to the poor souls on windows :)

> Can I ask what sort of features you are going after?  (And if
> there's a git repository available, feel free to just point me at
> it and ignore my questions.)

The features I'm focusing on are mostly trivial day-to-day operations
of your average coder: status, diff, commit, push, fetch, merge,
checkout, log. This should be enough to support our (planned) workflow
of one public repo per developer + a shared integration repo with
restricted push access + active use of topic-branches.

We currently use subversion, so real branches + real merges are killer
arguments for a switch to git. But we also use tortoisesvn, and the
"simplicity" of the gui must be met by some tool. Hence me playing
around....

If/when it becomes useful, I'll put it up on http://hjemli.net/git/


> I'm just curious.  We seem to have a lot of user interface projects
> going on at once right now (Eclipse plugin, git-gui, gitk, qgit, tig,
> gitweb, blameview) and everyone's been learning from each other.

Heh, I actually considered calling it yagg (but it doesn't deserve a name yet)


> I think the competition is good, there's no clear right way to do
> things here.  As the primary author of git-gui, I do want to try
> and keep current with what the others are up to.  ;-)

Absolutely, nice work btw.


-- 
larsh
