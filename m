From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be
 used
Date: Sun, 05 Apr 2009 23:14:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904052311020.6741@xanadu.home>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
 <20090404180601.GA14888@coredump.intra.peff.net>
 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
 <20090404232505.GA26906@coredump.intra.peff.net>
 <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
 <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
 <alpine.LFD.2.00.0904052220060.6741@xanadu.home>
 <449c10960904051934l54d2d504w1af867dc53ef7dd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_yAOV99uNB3jQNf7xKK7+yg)"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 05:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqfJb-0001UU-It
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 05:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbZDFDOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 23:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZDFDOY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 23:14:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZDFDOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 23:14:23 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN0089USY2N4P1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Apr 2009 23:13:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <449c10960904051934l54d2d504w1af867dc53ef7dd7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115756>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_yAOV99uNB3jQNf7xKK7+yg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 5 Apr 2009, Dan McGee wrote:

> On Sun, Apr 5, 2009 at 9:31 PM, Nicolas Pitre <nico@cam.org> wrote:
> > The number currently displayed has real meaning: this is the number of
> > threads git is allowed to use.  The number of threads it will actually
> > use is variable and it changes with time.
> 
> Would something like this be more ideal then? I wouldn't be so
> persistent here if the current text wasn't misleading in a case like
> the following:
> 
> dmcgee@galway ~/projects/devtools (master)
> $ git push origin
> Counting objects: 13, done.
> Delta compression using 4 threads.
> Compressing objects: 100% (8/8), done.
> Writing objects: 100% (8/8), 1.28 KiB, done.
> Total 8 (delta 6), reused 0 (delta 0)
> To archlinux.org:/srv/projects/git/devtools.git
>    bcb0e39..ea73c2b  master -> master
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 9fc3b35..99181fd 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1612,7 +1612,7 @@ static void ll_find_deltas(struct object_entry
> **list, unsigned list_size,
>                 return;
>         }
>         if (progress > pack_to_stdout)
> -               fprintf(stderr, "Delta compression using %d threads.\n",
> +               fprintf(stderr, "Delta compression using up to %d threads.\n",
>                                 delta_search_threads);
> 
>         /* Partition the work amongst work threads. */

This I have absolutely no issue with.

Acked-by: Nicolas Pitre <nico@cam.org>


Nicolas

--Boundary_(ID_yAOV99uNB3jQNf7xKK7+yg)--
