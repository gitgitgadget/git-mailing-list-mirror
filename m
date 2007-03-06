From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 14:37:19 +0100
Message-ID: <81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com>
References: <20070306063501.GA24355@spearce.org>
	 <81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com>
	 <Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOZrA-0006T2-MT
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 14:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbXCFNhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 08:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934122AbXCFNhY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 08:37:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:17047 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934120AbXCFNhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 08:37:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2476137nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 05:37:20 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8G7mkYWcTDtr/W3aiwckwzVowlDZ8SHbSAe4oTLIAVXIbuK7dKwP892qaU5fYvgUPtV4RiGJEEEm9Tb9/TyPoALFGPUpw/ipNLCkTTmdrPDRldAp+5+Z4+RKIuljga+0zbw9QxQib5fjDARJQ399g44RUsGQLJG5PsLFDrUYE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5RoWCZWwX9CX3r6Bs9Px9t56PjDgPHYhfIW9b8choHZJ5jA7GUae+FSBJa79cfLlnkoK6Ls21lCKDq6Ubocejr8cs1HS4Sckv/wEN0cYlYQND9GJD1vuYF70ww91Uns3BpGhcz95Xx1uR5lPQPCpiRmyjmLH7qRD5r93c43V4U=
Received: by 10.78.142.14 with SMTP id p14mr788012hud.1173188239648;
        Tue, 06 Mar 2007 05:37:19 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 05:37:19 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41584>

On 3/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > ...
> > >     CC builtin-grep.c
> > > builtin-grep.c:187: warning: 'external_grep' defined but not used
> >
> > Can I suggest printing the resulting object file instead of source?
> > It is useful if you want rebuild just one file by mouse-copy-paste it
> > into command line (the source file name for editor in case of
> > error is already in error message).
>
> I don't understand.

Right. Because I was suggesting to output something like this:

$ make
...
     CC builtin-grep.o
builtin-grep.c:187: warning: 'external_grep' defined but not used

Notice "builtin-grep.o" (the ".o", not _.c_). IOW, we already
see builtin-grep.c when we need it (in the error/warning message),
BUT the builtin-grep.o is missing (and is useful for mouse-copy-paste).
