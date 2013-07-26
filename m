From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 15:06:02 -0400
Message-ID: <20130726190602.GC29799@sigill.intra.peff.net>
References: <51EFA9A9.4010103@gmail.com>
 <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
 <51F12BE6.80606@gmail.com>
 <51F13A8F.9040400@xiplink.com>
 <51F23706.5040009@gmail.com>
 <51F2375E.1080003@gmail.com>
 <51F28D08.8050507@xiplink.com>
 <51F2AFBA.4020602@gmail.com>
 <51F2B2CD.1030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 21:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2nL9-0003Os-H5
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 21:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3GZTGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 15:06:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:59876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab3GZTGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 15:06:04 -0400
Received: (qmail 2403 invoked by uid 102); 26 Jul 2013 19:06:04 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 14:06:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 15:06:02 -0400
Content-Disposition: inline
In-Reply-To: <51F2B2CD.1030004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231196>

On Fri, Jul 26, 2013 at 07:33:01PM +0200, Daniele Segato wrote:

> stress the difference between the two with suggestion on when the user
> should use one in place of the other.
> 
> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>

The intent of your patch seems reasonable to me. There are a few minor
language and typographical mistakes, and the patch itself is
whitespace-damaged.

I also do not know that it is accurate to say "most git commands ignore
lightweight tags". It is really only "naming" ones like "git describe".

Here is a re-send of your patch with the fixups I would recommend.

-- >8 --
From: Daniele Segato <daniele.segato@gmail.com>
Subject: [PATCH] docs/git-tag: explain lightweight versus annotated tags

Stress the difference between the two with a suggestion on
when the user should use one in place of the other.

Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-tag.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 22894cb..c418c44 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -42,6 +42,17 @@ is used to specify custom GnuPG binary.
 GnuPG key for signing. 	The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
 
+Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
+tags; they contain a creation date, the tagger name and e-mail, a
+tagging message, and an optional GnuPG signature. Whereas a
+"lightweight" tag is simply a name for an object (usually a commit
+object).
+
+Annotated tags are meant for release while lightweight tags are meant
+for private or temporary object labels. For this reason, some git
+commands for naming objects (like `git describe`) will ignore
+lightweight tags by default.
+
 
 OPTIONS
 -------
-- 
1.8.3.rc1.30.gff0fb75
