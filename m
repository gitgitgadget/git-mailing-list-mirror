From: Jeff King <peff@peff.net>
Subject: Re: git-gui blametool
Date: Mon, 12 Feb 2007 12:54:00 -0500
Message-ID: <20070212175400.GB30669@coredump.intra.peff.net>
References: <45D07A76.1070009@gmail.com> <45D095B1.9070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGfNQ-0002IN-BR
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXBLRyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbXBLRyE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:54:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1877 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965038AbXBLRyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:54:03 -0500
Received: (qmail 6266 invoked from network); 12 Feb 2007 12:54:06 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Feb 2007 12:54:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 12:54:00 -0500
Content-Disposition: inline
In-Reply-To: <45D095B1.9070308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39422>

On Mon, Feb 12, 2007 at 09:58:33PM +0530, Aneesh Kumar K.V wrote:

> Sine i don't have a tcl/tk reference around i update blameview to show 
> the above. The patch is attached below in case you are interested.

It certainly looks better, though the whole thing is still horribly
ugly. You might play with replacing the main List widget with something
a bit more compact.

> NOTE: How do i resize the widgets in perl-gtk ? I wanted the commit 
> window to be a bit larger. Any help ?

Something like this?

-Peff

diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
index 67a0714..fd174eb 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -51,6 +51,7 @@ $vbox->pack_start($commitwindow, 1, 1, 0);
 my $commit_text = Gtk2::TextView->new();
 my $commit_buffer = Gtk2::TextBuffer->new();
 $commit_text->set_buffer($commit_buffer);
+$commit_text->set_size_request(1024, 200);
 $commitwindow->add($commit_text);
 
 $fileview->signal_connect (cursor_changed => sub {
