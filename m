From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sun, 10 Feb 2008 13:47:02 -0800
Message-ID: <7v8x1sfprd.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
	<7vr6fletkl.fsf@gitster.siamese.dyndns.org>
	<7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802101502320.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOK1n-0007P1-LH
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYBJVrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 16:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbYBJVrY
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:47:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbYBJVrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 16:47:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CD471B47;
	Sun, 10 Feb 2008 16:47:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C101B43;
	Sun, 10 Feb 2008 16:47:10 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802101502320.13593@iabervon.org> (Daniel
	Barkalow's message of "Sun, 10 Feb 2008 15:22:17 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73420>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 10 Feb 2008, Junio C Hamano wrote:
>
>> I've tried "unexpand | expand" to Documentation/*.txt and
>> compared the formatted documentation before and after the
>> change, and as we suspected everything seems to match.
>> 
>> So I am considering applying this patch.  We may want to tighten
>> it later but as the initial set of rules this should do.
>
> I think it's worthwhile to note that some of the files under t/ have 
> whitespace that doesn't conform to the rest of the project.

Yes.  I tried to be careful with the set of attribute files I
sent out not to corrupt them.  Was I unsuccessful?

> On the other hand, I think this patch is an odd combination of stuff; 
> aren't the contrib exceptions not exceptional, since only *.[ch] and *.txt 
> gets declared as "whitespace"?

True, how about this instead?

---
 .gitattributes               |    2 ++
 Documentation/.gitattributes |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

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
