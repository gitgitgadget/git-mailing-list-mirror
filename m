From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 08 Feb 2010 16:45:21 -0800
Message-ID: <7vk4un1bku.fsf@alter.siamese.dyndns.org>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
 <7veikv2r50.fsf@alter.siamese.dyndns.org>
 <7vaavj2qu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:45:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeEQ-0006Wd-KV
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab0BIAp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:45:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab0BIAp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:45:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BA639815C;
	Mon,  8 Feb 2010 19:45:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ODP0lyzPy/QGhrPISOaNb8W+NnI=; b=CIRZpD
	EcKjUQAfcApzm14+cb2/P8CFv8jRsJmMKEGhh3k/dbGSVUdcfOkYIbXLdkWAyYdV
	BFXKWmQPbFSLEbtLkzlvhGKqCyPs8RD2cfcHyrmKVAVMDjXq9fNyTm20d6gKf7br
	J5o99/dpIxk3j6hF1c52j1qXdfBixOyf8JJdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d6fbotP9LIRqmf7NOJXxyHz3IzReFkim
	39g2uAZfkiLZmLNXkU8eqlk2pfPH9tEqGNC851jCTo23p7BptPl4U0Nnne2WMgw7
	LSJDucCeCfR4Wvsgu4j1CE/Z9w6GXyVHJXEsuvuDft50mZa9CV2kgyHwOwO+YFW3
	fQmL1riPK5Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 325199815B;
	Mon,  8 Feb 2010 19:45:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7429A9815A; Mon,  8 Feb
 2010 19:45:22 -0500 (EST)
In-Reply-To: <7vaavj2qu1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 08 Feb 2010 16\:30\:30 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69210F66-1514-11DF-8DC2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139343>

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, http://www.methods.co.nz/asciidoc/newlists.html labels the
> syntax as "new in 8.3.0", and Debian 5.0.X and Fedora 11 both use AsciiDoc
> that are older than that (8.2.7 and 8.2.5).
>
> I'll flatten the description into prose for now.

Actually, we  already use another syntax for nested enumerations, namely
double-semicolon, in config.txt, so let's mimic that.

-- >8 --
Subject: git-push: document all the status flags used by --porcelain output 

We didn't talk about '-' (deletion), '*' (addition), nor '+' (forced).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 73a921c..bd79119 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -176,12 +176,17 @@ If --porcelain is used, then each line of the output is of the form:
  <flag> \t <from>:<to> \t <summary> (<reason>)
 -------------------------------
 
+The status of up-to-date refs is shown only if --porcelain or --verbose
+option is used.
+
 flag::
-	A single character indicating the status of the ref. This is
-	blank for a successfully pushed ref, `!` for a ref that was
-	rejected or failed to push, and '=' for a ref that was up to
-	date and did not need pushing (note that the status of up to
-	date refs is shown only when `git push` is running verbosely).
+	A single character indicating the status of the ref:
+(space);; for a successfully pushed fast-forward;
+`{plus}`;; for a successful forced update;
+`-`;; for a successfully deleted ref;
+`*`;; for a successfully pushed new ref;
+`!`;; for a ref that was rejected or failed to push; and
+`=`;; for a ref that was up to date and did not need pushing.
 
 summary::
 	For a successfully pushed ref, the summary shows the old and new
