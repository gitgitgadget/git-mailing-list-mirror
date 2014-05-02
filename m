From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/8] CodingGuidelines: on splitting a long line
Date: Fri, 02 May 2014 13:51:55 -0700
Message-ID: <xmqqiopnaopg.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 22:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKRC-0008Pm-8m
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbaEBUwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:52:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63712 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbaEBUwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:52:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEF14125CF;
	Fri,  2 May 2014 16:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEyE3hKeKEYFOqp8h6eBM3i3jxY=; b=fm1l72
	/vhYDuwYg+vN792GpDLVXTLuPouW3mDk0c5qSBMJvlT/XzAobvIIx+WPw3inrlFp
	CgHHMTtjXvLXmwA20aaK1/x3yq/DzcHJjeqC11rSQ0DfQIrggRGoQ5Fwz2DLIf/A
	Gj7ija6mTemnmpbkU3iEQlEG2STYwZVOCjDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ncgu9gyGkx1SzJ/5JQFewM/sGugMRBL4
	tmzCbROGzDNnqA3y9+CMPhem6T1eeCyKvomVDcJbnREZbPUBTHWRIQpMCKOYGjod
	GMDhyS/2KTJxYEgQ/E0O5FinP784wmSMP1IJ85rsH/Gs9FwKRHXM57OkYSFIDEQD
	GeJ3El0X2fg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B495C125CE;
	Fri,  2 May 2014 16:51:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 231F4125CA;
	Fri,  2 May 2014 16:51:57 -0400 (EDT)
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 30 Apr 2014 14:45:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99813E36-D23B-11E3-8F23-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247975>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 02ca67c..4dd07c3 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -249,6 +249,61 @@ For C programs:
    Just do not mix styles in the same part of the code and mimic
    existing styles in the neighbourhood.
 
+ - There are two schools of thought when it comes to splitting a long
+   logical line into multiple lines.  Some people push the second and
+   subsequent lines far enough to the right with tabs and align them:
+
+        if (the_beginning_of_a_very_long_expression_that_has_to ||
+		span_more_than_a_single_line_of ||
+		the_source_text) {
+                ...
+
+   while other people prefer to align the second and the subsequent
+   lines with the column immediately inside the opening parenthesis,
+   with tabs and spaces, following our "tabstop is always a multiple
+   of 8" convention:
+
+        if (the_beginning_of_a_very_long_expression_that_has_to ||
+	    span_more_than_a_single_line_of ||
+	    the_source_text) {
+                ...
+
+   Both are valid, and we use both.  Again, just do not mix styles in
+   the same part of the code and mimic existing styles in the
+   neighbourhood.
+
+ - When splitting a long logical line, some people change line before
+   a binary operator, so that the result looks like a parse tree when
+   you turn your head 90-degrees counterclockwise:
+
+        if (the_beginning_of_a_very_long_expression_that_has_to
+	    || span_more_than_a_single_line_of_the_source_text) {
+
+   while other people prefer to leave the operator at the end of the
+   line:
+
+        if (the_beginning_of_a_very_long_expression_that_has_to ||
+	    span_more_than_a_single_line_of_the_source_text) {
+
+   Both are valid, but we tend to use the latter more, unless the
+   expression gets fairly complex, in which case the former tends to
+   be easier to read.  Again, just do not mix styles in the same part
+   of the code and mimic existing styles in the neighbourhood.
+
+ - When splitting a long logical line, with everything else being
+   equal, it is preferrable to split after the operator at higher
+   level in the parse tree.  That is, this is more preferrable:
+
+	if (a_very_long_variable * that_is_used_in +
+	    a_very_long_expression) {
+		...
+
+   than
+
+	if (a_very_long_variable *
+	    that_is_used_in + a_very_long_expression) {
+		...
+
  - Some clever tricks, like using the !! operator with arithmetic
    constructs, can be extremely confusing to others.  Avoid them,
    unless there is a compelling reason to use them.
-- 
2.0.0-rc1-355-gd6d6511
