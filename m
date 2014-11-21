From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Fri, 21 Nov 2014 18:32:46 -0500
Organization: PD Inc
Message-ID: <1B02B87E88254A4A95EE138C9D2C4B8B@black>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net> <546FC446.50101@whonix.org>
Reply-To: <git@vger.kernel.org>,
	  "Patrick Schleizer" <patrick-mailinglists@whonix.org>,
	  "Jeff King" <peff@peff.net>, <whonix-devel@whonix.org>,
	  <mikegerwitz@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Patrick Schleizer'" <patrick-mailinglists@whonix.org>,
	"'Jeff King'" <peff@peff.net>, <whonix-devel@whonix.org>,
	<mikegerwitz@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 22 01:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xryh5-0004gx-F5
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 01:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbaKVAgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 19:36:51 -0500
Received: from mail.pdinc.us ([67.90.184.27]:57650 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbaKVAgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 19:36:50 -0500
X-Greylist: delayed 3838 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2014 19:36:50 EST
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sALNWk4e031642;
	Fri, 21 Nov 2014 18:32:46 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <546FC446.50101@whonix.org>
Thread-Index: AdAF3x5s3RniRofpT+KNXRMA7ZR5ewAA0SmA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Patrick Schleizer
> Sent: Friday, November 21, 2014 18:01
> 
> Dear git developers!
> 
> Jeff King wrote:
> > On Sun, Nov 16, 2014 at 03:31:10PM +0000, Patrick Schleizer wrote:
> > 
> >> How safe are signed git tags? Especially because git uses 
> SHA-1. There
> >> is contradictory information around.
> >>
> >> So if one verifies a git tag (`git tag -v tagname`), then 
> `checksout`s
> >> the tag, and checks that `git status` reports no untracked/modified
> >> files, without further manually auditing the code, how 
> secure is this
> >> actually? Is it only as safe as SHA-1?
> > 
> > Yes, it is only as "safe as SHA-1" in the sense that you 
> have GPG-signed
> > only a SHA-1 hash. If somebody can find a collision with a 
> hash you have
> > signed, they can substitute the colliding data for the data 
> you signed.

The whole issue is a lot better than this makes it sound. Yes it is just a SHA1 hash, but it is a hash of a structured data format.

You have very observable parts of that well structured data providede to the hash.

The commit message, the directory contents, and lastly the files themselves.

For a collision to occur, the commit message would have to likely have garbage in the message of a large nature. To generate a colision by commited file contents is unlikely because the file contents is reduced to a hash in the directory structure, which is in turn reduced to a hash in a commit structure.

This would be noticed.


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
