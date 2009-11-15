From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: get git not to care about permissions
Date: Sun, 15 Nov 2009 13:31:33 +0100
Message-ID: <200911151331.35787.trast@student.ethz.ch>
References: <26268938.post@talk.nabble.com> <200911121710.44314.trast@student.ethz.ch> <3cf217d80911121344w7d1809ebs103eaa2ac19a03a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, <git@vger.kernel.org>,
	<euguess@gmail.com>
To: Matt Schoen <mtschoen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 13:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9eHK-0005XZ-4p
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 13:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZKOMcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 07:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbZKOMcO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 07:32:14 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30317 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbZKOMcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 07:32:14 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 13:32:18 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 13:32:18 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <3cf217d80911121344w7d1809ebs103eaa2ac19a03a6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132934>

Matt Schoen wrote:
> On Thu, Nov 12, 2009 at 11:10 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> > It prints an absolute path, so the open() also accesses an absolute
> > path (though I don't know why it insists on that).
> >
> > But the above directory listing would indicate that you do not even
> > have permission to look inside your $(pwd) by absolute path...
> 
> I'm pretty sure I can.  How can I test this?  I can ls all
> subdirectories within the path, and when I navigate to the path, I
> usually do it absolutely.  After all, this is a network share, so I
> have to start with "/ad/eng/...".  Although, this is curious.  Some of
> the directories show "d---------" when I do ls -al.  They were created
> by root in the same environment (forced 700), but I can still read
> their contents, and such.

What filesystem is this?  Are there perhaps extended attributes
allowing access anyway?  I'm not exactly an expert on unix permissions
but my local path_resolution(7) tells me it should not be possible to
cd beyond a directory where you have no 'x' permissions.

> Does open() strictly require the permissions you give it?

open(2) says the permissions are modified by the umask, so that
shouldn't be a problem.


Question for the people who know git better than me:  Does that open()
require an absolute path?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
