From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] git-add -i/-p: learn to unwrap C-quoted paths
Date: Tue, 17 Feb 2009 10:09:17 +0200
Message-ID: <878wo55vte.fsf@iki.fi>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
	<87tz6vr0g4.fsf@iki.fi>
	<2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
	<87prhjqzwb.fsf@iki.fi>
	<20090216033634.GA12461@coredump.intra.peff.net>
	<7v63jbf2v0.fsf@gitster.siamese.dyndns.org>
	<7v3aeda6lw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZL3g-0008Gw-AN
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZBQIJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbZBQIJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:09:28 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:39327 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbZBQIJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:09:28 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88052D971E; Tue, 17 Feb 2009 10:09:21 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LZL13-0001fY-OC; Tue, 17 Feb 2009 10:09:17 +0200
In-Reply-To: <7v3aeda6lw.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 16 Feb 2009 23\:02\:35 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110327>

On 2009-02-16 23:02 (-0800), Junio C Hamano wrote:

> The underlying plumbing commands are not run with -z option, so the paths
> returned from them need to be unquoted as needed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

According to my quick tests this seems to work. You may want to squash
this patch in:


diff --git i/Documentation/git-add.txt w/Documentation/git-add.txt
index 7c129cb..6c79a87 100644
--- i/Documentation/git-add.txt
+++ w/Documentation/git-add.txt
@@ -263,13 +263,6 @@ diff::
   This lets you review what will be committed (i.e. between
   HEAD and index).
 
-Bugs
-----
-The interactive mode does not work with files whose names contain
-characters that need C-quoting.  `core.quotepath` configuration can be
-used to work this limitation around to some degree, but backslash,
-double-quote and control characters will still have problems.
-
 SEE ALSO
 --------
 linkgit:git-status[1]
