From: John Keeping <john@keeping.me.uk>
Subject: Re: Formatting error in page http://git-scm.com/docs/user-manual
Date: Fri, 25 Sep 2015 13:59:35 +0100
Message-ID: <20150925125935.GN17201@serenity.lan>
References: <CAOq7JjbYP=fGB0aqbrMz_ibfWHor-v-Y-BsO316H4dHpfSYS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Valentin VALCIU <axiac.ro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 14:59:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfSbS-0006x3-Is
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 14:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbbIYM7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 08:59:50 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47213 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbbIYM7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 08:59:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3B398CDA5F7;
	Fri, 25 Sep 2015 13:59:48 +0100 (BST)
X-Quarantine-ID: <DRnfrxf91fKz>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DRnfrxf91fKz; Fri, 25 Sep 2015 13:59:45 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BE6B8CDA618;
	Fri, 25 Sep 2015 13:59:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAOq7JjbYP=fGB0aqbrMz_ibfWHor-v-Y-BsO316H4dHpfSYS-w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278659>

On Fri, Sep 25, 2015 at 03:38:02PM +0300, Valentin VALCIU wrote:
> There is a formatting error in the source code of page
> http://git-scm.com/docs/user-manual that makes almost half of it be
> rendered in a <pre> element displaying the page source in the original
> markup language instead of being converted to HTML.
> 
> The issue is in the paragraph that stars with "The index is a binary
> file (generally kept in `.git/index`)..."

It looks like the header underline isn't quite accurate enough to keep
Asciidoctor happy.  The patch below should fix it.

-- >8 --
Subject: [PATCH] Documentation/user-manual: fix header underline

Asciidoctor is stricter than AsciiDoc when deciding if underlining is a
section title or the start of preformatted text.  Make the length of the
underlining match the text to ensure that it renders correctly in all
implementations.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 68978f5..1b7987e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3424,7 +3424,7 @@ just missing one particular blob version.
 
 [[the-index]]
 The index
------------
+---------
 
 The index is a binary file (generally kept in `.git/index`) containing a
 sorted list of path names, each with permissions and the SHA-1 of a blob
-- 
2.6.0.rc2.198.g81437b7
