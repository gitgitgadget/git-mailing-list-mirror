From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] advice: Document that they all default to true
Date: Sun, 18 Dec 2011 21:35:01 -0800
Message-ID: <7vhb0xnmyi.fsf_-_@alter.siamese.dyndns.org>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
 <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:35:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcVsU-0005oh-9G
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 06:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab1LSFfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 00:35:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab1LSFfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 00:35:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87B9D6C06;
	Mon, 19 Dec 2011 00:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+D5IuPgSXaT8amkW2CLD+0fP/8=; b=mXwT5K
	ftWC1rI30A2UEsO6iE66AGRkObIm85uX/dCOW4PzZ25fOv9lruLZwPkFP8GmCvTo
	9AGMHv/nyo3CWSVg26MsVDTpCvXJtL62p2xiHG77eUhQ+uthpcaShIA2Jm8lkqcC
	nxVLgSboqix26LFxXXOrefRMI5iYxx8sB075M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYwMfIXXTh3kTprCFdj3h8NOhilRT3rK
	tfLvDXOlusidbJKBY6pSPbvnHmikRj/BSoJjbz/T64NXrvumwzO/71ZrnVNkGbq4
	7GYjXFqewFq1fL/XAwRr168T2eIfF9YgLZxn0KNz60nPuF9YMrmA0VT0zKCY669u
	sTcxqD3q9vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FE136C05;
	Mon, 19 Dec 2011 00:35:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD0676C03; Mon, 19 Dec 2011
 00:35:02 -0500 (EST)
In-Reply-To: <7vliq9nn0l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 18 Dec 2011 21:33:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3324FF7A-2A03-11E1-AAB7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187436>

By definition, the default value of "advice.*" variables must be true and
they all control various additional help messages that are designed to aid
new users. Setting one to false is to tell Git that the user understands
the nature of the error and does not need the additional verbose help
message.

Also fix the asciidoc markup for linkgit:git-checkout[1] in the
description of the detachedHead advice by removing an excess colon.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8a7d2d4..9be7106 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -115,35 +115,32 @@ in the appropriate manual page. You will find a description of non-core
 porcelain configuration variables in the respective porcelain documentation.
 
 advice.*::
-	When set to 'true', display the given optional help message.
-	When set to 'false', do not display. The configuration variables
-	are:
+	These variables control various optional help messages designed to
+	aid new users. All 'advice.*' variables default to 'true', and you
+	can tell Git that you do not need help by setting these to 'false':
 +
 --
 	pushNonFastForward::
 		Advice shown when linkgit:git-push[1] refuses
-		non-fast-forward refs. Default: true.
+		non-fast-forward refs.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
-		when writing commit messages. Default: true.
+		when writing commit messages.
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
-		Default: true.
 	resolveConflict::
 		Advices shown by various commands when conflicts
 		prevent the operation from being performed.
-		Default: true.
 	implicitIdentity::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
-		domain name. Default: true.
-
+		domain name.
 	detachedHead::
-		Advice shown when you used linkgit::git-checkout[1] to
+		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
-		a local branch after the fact.  Default: true.
+		a local branch after the fact.
 --
 
 core.fileMode::
-- 
1.7.8.370.gb3269
