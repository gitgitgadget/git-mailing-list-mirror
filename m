From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 18:01:39 -0400
Message-ID: <AANLkTinrUWtqx34U3-FFnyAXXYFkQiwrXc6USXJYR2xE@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com> 
	<20100527210328.GN16470@spearce.org> <AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 00:02:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHl9k-00060P-BD
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 00:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234Ab0E0WCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 18:02:05 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:61858 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231Ab0E0WB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 18:01:59 -0400
Received: by ywh36 with SMTP id 36so158735ywh.4
        for <git@vger.kernel.org>; Thu, 27 May 2010 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=7EvCq8BdChlM+VlCsfo9M/QYcrZCrZRast7QlaZfUgo=;
        b=Hs3EIvc7T1lwNBhpnuBlyK6WtCbTroQ8zhiU3dPW4ffwE+1oKIf8cCwctYlsTkl5/j
         iJ5z0lZrrL8RGnsusxosZpyI1OkFmo9LFhKpjVvU/LkTdUHqvDpXkB0EirH7fNlCqHm4
         aGE90Vhqqx02yfMFuHJOTzfBkcywByiAcAIWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AH+lf50boVtdPkTObKIRjp7fTqiqNC8q5mkHI+gjBClyk1Fh9DtaQd5IbxGaTxc2kJ
         ozeDXM71snRc3grytliWFj0TOh+ACgiEeqbLPKjBdkaescqUH+EpK5lGJn/ErCuTE7do
         muOQlfzMHF6zWXpnk8BAnXHJUN+9OOIzQZo+Q=
Received: by 10.150.238.17 with SMTP id l17mr697631ybh.310.1274997719249; Thu, 
	27 May 2010 15:01:59 -0700 (PDT)
Received: by 10.150.54.20 with HTTP; Thu, 27 May 2010 15:01:39 -0700 (PDT)
In-Reply-To: <AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147902>

On Thu, May 27, 2010 at 5:57 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Well it _looks_ detached in gitk I can't see any merge commits. I've
> tried git gc but no joy. Maybe I need to tell it to be a bit more
> thorough.

Why is it showing up in gitk at all?  Does it have its own branch
name?  gitk will normally only show commits that are attached to
something, unless you list a particular commit id explicitly on its
command line.

Once the commits are "detached" correctly, saving the disk space is
kind of unnecessary.  (Most likely the old commits are being held in
the reflog at least, which usually expires in 30 days or so for
safety.)  Moreover, most of the space is probabably space occupied by
the actual files in the revisions, which will be needed when you port
the patches "correctly" anyhow, so there's no point in going through
extra effort to recover the space just so you can use it again.

Have fun,

Avery
