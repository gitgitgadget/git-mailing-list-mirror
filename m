From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: a few remaining issues...
Date: Wed, 10 Jan 2007 13:40:17 +0100
Message-ID: <81b0412b0701100440n6fe9e406yfe712cf236a784e2@mail.gmail.com>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050327u6bf2a716s1fb38fb62e2ebb9d@mail.gmail.com>
	 <Pine.LNX.4.63.0701101320300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 13:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ckl-0000HJ-LI
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 13:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbXAJMkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 07:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbXAJMkU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 07:40:20 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:27012 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbXAJMkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 07:40:18 -0500
Received: by wr-out-0506.google.com with SMTP id i30so29148wra
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 04:40:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MVg/qpTNYixSE9i4Iwkx+67mOX3wQwHJip6JkuoLp9Qc1ctBzjK4LUmlOqqIXbscjxxpxiXSeAf4CxwRvOCuJxoKSLZbU8NjxV0/dr7ePPvgSqy9+0V803pPpe6VANfs0H9kkCbMpxwRThNQFTi9aFiApqcFvtJISWmVgQNR0dA=
Received: by 10.78.164.13 with SMTP id m13mr67821hue.1168432817433;
        Wed, 10 Jan 2007 04:40:17 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 04:40:17 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701101320300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36505>

On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
> > > This is not meant to be an exhaustive list, and I probably will
> > > change my mind after I sleep on them, but before I go to bed,
> > > here are a handful of glitches I think are worth fixing.
> >
> > Maybe we should at least mention another cygwin quirk:
> > cygwin (or is it its bash?) treats .exe files and +x-files without
> > extension somehow stupid: it prefers the file without extension
> > to the .exe. For example, after installation of git-merge-recursive
> > you have the old python script and git-merge-recursive.exe in
> > the same directory. Guess which one is used... Right, the old
> > python script. Same for count-objects and other recently
> > rewritten scripts.
>
> I just sent out a patch in my mail "[PATCH] Makefile: add
> clean-obsolete-scripts target" which should help.

Well, you also have to give people at least notice _when_ the
target should be called. It can take long time until the victim
notices that he has git-branch (from .sh) and git-branch(.exe).
And that in two places: in the installation target directory and
in the build directory (because in windows it is not fcking
possible to remove "." from the beginning of PATH).

> But in general, it should be fine to be called just once.

Don't think so. We still have candidates for conversion
into C (git-checkout and git-commit being my favorites).
