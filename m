From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 21:14:02 +0100
Message-ID: <e5bfff550712111214p189945e5g38e85e11bf7af68@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
	 <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
	 <Pine.LNX.4.64.0712111428040.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Berlin" <dberlin@dberlin.org>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BUs-0008Ln-7r
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbXLKUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbXLKUOH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:14:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:26523 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbXLKUOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:14:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4185858wah
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OpJ501zRDO4Ym/yDlEXKWQzHJ9QRZywDyQKK8nUMPHE=;
        b=rYSs7ZmYss2YJON9Vtdji4/pucddzUgo5hknmzbKxc+2wYkMgGsYk1F8e1A2i2gdmPMnMkMGq7t2nGw9UAoCvl1EWFxCTdbDua6NtRK2C9bsQgrWIpMdMiCyBjSLuLFEN1IzzcMolmeRXXveQCCE5PCyBCYuIXrxZC0NeTZPSdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AICZOqn8OmPUao50JOOkedLFCX1i1VRIQQ0N+yWRhr9SGMMz/dqbpvPeKolVM/T8/+EoKn0CAzY2lACvK49lVrTddb9DFuj350Xp/BJOHO5jte9MjHw/6vsH/6dazRwovFz31yLBM/95plNHkCaRM2U9PJ+aK3pwVr8PQZR7Tk8=
Received: by 10.140.148.3 with SMTP id v3mr456200rvd.1197404042926;
        Tue, 11 Dec 2007 12:14:02 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 12:14:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712111428040.5349@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67929>

On Dec 11, 2007 8:46 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 11 Dec 2007, Daniel Berlin wrote:
>
> > It is stored in an easier format. However, can you not simply provide
> > side-indexes to do the annotation?
> >
> > I guess that own't work in git because you can change history (in
> > other scm's, history is readonly so you could know the results for
> > committed revisions will never change).
>
> History in git is read-only. It's just that git lets you fork and move
> forward with something different. Each commit can never change (and, in
> fact, you'd have to badly break SHA1 to change it), but which commits are
> relevant to the history can change.
>

Well, revisions never change, but history intended as revision's
parent information could and do changes when you use a path delimiter.
So does the graph that is a direct visualization of parent
information.

For a single revision (that modifies say 3 files) you can have at leat
3 different histories and acutally more if you want to visualize also
the history of the directories trees that owns the modified files.

You end up with a quite big number of different histories all showing
your revisions in different ways, according to the path delimiter you
use.

Perhaps the intended meaning of "changing histories" is this, and in
any case is this the reason you cannot (or has no sense to do) "save"
a single file history in git.

Marco
