From: Mike Hommey <mh@glandium.org>
Subject: Re: git push to amazon s3 [was: [GSoC] What is status of Git's
	Google Summer of Code 2008 projects?]
Date: Tue, 8 Jul 2008 07:56:10 +0200
Organization: glandium.org
Message-ID: <20080708055610.GA12591@glandium.org>
References: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nick Hengeveld <nickh@reactrix.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG6CU-0008Ag-4s
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbYGHF4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYGHF4U
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:56:20 -0400
Received: from vuizook.err.no ([194.24.252.247]:54626 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbYGHF4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:56:20 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KG6BM-0001jx-KK; Tue, 08 Jul 2008 07:56:14 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KG6BO-0003KS-M6; Tue, 08 Jul 2008 07:56:10 +0200
Content-Disposition: inline
In-Reply-To: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87720>

On Mon, Jul 07, 2008 at 10:48:59PM -0700, Tarmigan wrote:
> (trimmed cc list to folks who've touched http-push.c)
> 
> On Mon, Jul 7, 2008 at 9:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Using Marek's pack generation code I added support for push over
> > the dumb sftp:// and amazon-s3:// protocols, with the latter also
> > supporting transparent client side encryption.
> >
> > I chose to add these features to jgit partly as an exercise to prove
> > that Marek's code was built well enough to be reused for this task,
> > partly because I wanted to backup some private personal repositories
> > to Amazon S3, and partly to prove that multiple dumb transports
> > could implement push support.
> 
> That sounds cool.  I've been looking into adding s3 push into cgit,
> and was looking into modifying http-push.c, but got in over my head.
> I had trouble trying to make it fit into the DAV model that http-push
> is built around, in part because s3 doesn't seem to support any
> locking and a lot of the http-push code seems to be around the
> locking.
> 
> Can you describe the s3 support that you added?  Did you do any
> locking when you pushed?  The objects and packs seem likely to be
> naturally OK, but I was worried about refs/ and especially
> objects/info/packs and info/refs (fetch over http works currently out
> of the box with publicly accessable s3 repos).

FWIW, I'm starting to work again on the http backend overhaul. My idea
is to provide a generic dumb protocol vfs-like interface, so that other
dumb protocols could be built out of it.

Mike
