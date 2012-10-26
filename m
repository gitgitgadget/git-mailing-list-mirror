From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Doc format-patch: clarify --notes use case
Date: Fri, 26 Oct 2012 09:26:57 -0400
Message-ID: <20121026132657.GH1455@sigill.intra.peff.net>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org>
 <1350855250-2844-4-git-send-email-philipoakley@iee.org>
 <20121025102527.GO8390@sigill.intra.peff.net>
 <7427D8D31835443F96156C24D3EB6A5A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Blake <eblake@redhat.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRjwQ-0002nb-9a
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343Ab2JZN1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:27:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37859 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256Ab2JZN1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:27:00 -0400
Received: (qmail 22539 invoked by uid 107); 26 Oct 2012 13:27:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 09:27:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 09:26:57 -0400
Content-Disposition: inline
In-Reply-To: <7427D8D31835443F96156C24D3EB6A5A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208440>

On Thu, Oct 25, 2012 at 11:48:04PM +0100, Philip Oakley wrote:

> >+the commit that does not belong to the commit log message proper,
> >+and include it with the patch submission. While one can simply write
> >+these explanations after `format-patch` has run but before sending,
> >+keeping them as git notes allows them to be maintained between
> >versions
> >+of the patch series (but see the discussion of the `notes.rewrite.*`
> >+configuration in linkgit:git-notes[1] to use this workflow).
> 
> Should the notes.rewriteRef also be mentioned (not part of .*), which
> is at the end of the notes configuration and that it must be set may
> be missed by readers? Perhaps "the 'notes.rewrite' configurations",
> dropping the .* and making it plural?

Yeah, I think just saying "notes.rewrite" is better. The notes.rewrite.*
entry does point to rewriteRef, but there is no point in giving the user
a trail of "see also" breadcrumbs when we can just point them to the
area as a whole.

I updated it to this:

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 066dc8b..259dce4 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -196,13 +196,12 @@ The expected use case of this is to write supporting explanation for
 	after the three-dash line.
 +
 The expected use case of this is to write supporting explanation for
-the commit that does not belong to the commit log message proper
-when (or after) you create the commit, and include it in your patch
-submission.  But if you can plan ahead and write it down, there may
-not be a good reason not to write it in your commit message, and if
-you can't, you can always edit the output of format-patch before
-sending it out, so the practical value of this option is somewhat
-dubious, unless your workflow is broken.
+the commit that does not belong to the commit log message proper,
+and include it with the patch submission. While one can simply write
+these explanations after `format-patch` has run but before sending,
+keeping them as git notes allows them to be maintained between versions
+of the patch series (but see the discussion of the `notes.rewrite`
+configuration options in linkgit:git-notes[1] to use this workflow).
 
 --[no]-signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
-- 
1.8.0.3.g3456896
