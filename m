From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] git checkout: don't warn about unborn branch if -f is
	already passed
Date: Mon, 01 Dec 2008 11:47:27 -0500
Message-ID: <1228150047.2643.5.camel@mattlaptop2.local>
References: <1227509722.32583.0.camel@mattlaptop2.local>
	 <7vr64yfexp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Bx5-0000xg-Er
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYLAQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYLAQrd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:47:33 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:34374 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752568AbYLAQrc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 11:47:32 -0500
Received: from [129.2.134.244] (129-2-134-244.wireless.umd.edu [129.2.134.244])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 84C4513EC0;
	Mon,  1 Dec 2008 08:47:31 -0800 (PST)
In-Reply-To: <7vr64yfexp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102063>

On Wed, 2008-11-26 at 11:46 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> > I think it's unnecessary to warn that the checkout has been forced due to an
> > unborn current branch if -f has been explicitly passed.  For one project, I am
> > using git-new-workdir to create workdirs from a bare repository whose HEAD is
> > set to an unborn branch, and this warning started to irritate me.
> 
> I doubt anybody minds this particular change per-se, but I wonder what the
> justification of keeping a dangling HEAD in a bare repository is.
> 
> After all, the primary intended purpose of a bare repository is to serve
> as a distribution point (i.e. something you can clone from), and I think a
> dangling HEAD interferes with the usual operation of clone (although I've
> never tested this).
> 
> Care to explain why?

I am taking a course with six programming projects.  I want a separate
working tree for each project, but I want all the working trees
connected to the same repository because I often copy changes from one
project to another and that makes it more convenient to inspect the
history of one project while I am working on another.  I didn't want to
put the repository inside an arbitrary one of the working trees, so I
left it bare, and I didn't want to point its HEAD to an arbitrary one of
the projects, so I left it unborn.

The upshot is that I am using a bare repository as a distribution point
for *working trees* (via git-new-workdir), not for push/pull.

Matt
