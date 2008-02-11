From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sun, 10 Feb 2008 19:34:01 -0800
Message-ID: <7vk5lcb1zq.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
	<7vr6fletkl.fsf@gitster.siamese.dyndns.org>
	<7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802101502320.13593@iabervon.org>
	<7v8x1sfprd.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802101724170.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 04:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOPRe-00069B-S6
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 04:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYBKDe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 22:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYBKDe0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 22:34:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYBKDe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 22:34:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB2033DB;
	Sun, 10 Feb 2008 22:34:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D9A533D9;
	Sun, 10 Feb 2008 22:34:19 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802101724170.13593@iabervon.org> (Daniel
	Barkalow's message of "Sun, 10 Feb 2008 17:34:17 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73463>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 10 Feb 2008, Junio C Hamano wrote:
> ...
>> True, how about this instead?
>
> That makes things more clear, although I'd still like a t/.gitattributes 
> that meant that, regardless of the project's policies in general, t/ files 
> may care about whitespace, so we don't have to worry about that in future 
> changes to the top level .gitattributes.

Ok, that's sensible.

This is what I'll apply.  We can tighten and/or loosen per type
of the contents as we discover glitches.

--

 .gitattributes               |    2 ++
 Documentation/.gitattributes |    1 +
 t/.gitattributes             |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes
 create mode 100644 Documentation/.gitattributes
 create mode 100644 t/.gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..6b9c715
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,2 @@
+* whitespace=!indent,trail,space
+*.[ch] whitespace
diff --git a/Documentation/.gitattributes b/Documentation/.gitattributes
new file mode 100644
index 0000000..ddb0301
--- /dev/null
+++ b/Documentation/.gitattributes
@@ -0,0 +1 @@
+*.txt whitespace
diff --git a/t/.gitattributes b/t/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
