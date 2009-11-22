From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sun, 22 Nov 2009 09:54:10 -0800
Message-ID: <7v6392h2d9.fsf@alter.siamese.dyndns.org>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
 <20091121193600.GA3296@coredump.intra.peff.net>
 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
 <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 18:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCGdl-0001LR-LP
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 18:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbZKVRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZKVRyO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 12:54:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbZKVRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 12:54:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ADE982DC4;
	Sun, 22 Nov 2009 12:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+XS7Qe/96ofZygihVnL4+8utb4=; b=SYIAn+
	scrHv6p/OMPcpNiJMkamAalz+PZTxop4yVuHuk34Ty+e1BbxskUkUKCeCwPEKTWf
	YQnTVeCFcZzjjJrZ+D2Nt2nMvJmZetTSDK6tlH2vSiodKzBg0NiRBXIarRxKaNmT
	Blh6rH+DhYmD3Ll94fqNNnc+ElYH8NRWEtbro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHnl+kxpZDrlErj34fSlO4JDSws0tTYG
	tUxf2GK3I9UqDBJiZWBRi4oKVrQGXtbCcQKnm1ziMylatXFWUDdNZNHCTvKwNPA3
	Ndh7XsytlpA2yXIpyTOBpFbVqZFq+AplyjzkQnWddeEGJA0Gn1aB9X9yRS44I/lQ
	IZkYGK0DW58=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 251F282DC3;
	Sun, 22 Nov 2009 12:54:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39DBC82DC2; Sun, 22 Nov
 2009 12:54:12 -0500 (EST)
In-Reply-To: <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
 (Felipe Contreras's message of "Sun\, 22 Nov 2009 14\:03\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D0100C2-D790-11DE-B128-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133449>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Maybe I should wait until somebody adds the tests to --envelope-sender
> before pushing this patch.

You can say that if you want to be difficult to work with, or you can be
that somebody yourself and make a difference.

Let me show you that we can be constructive for a change ;-)

How about something trivial like this?

-- >8 --
Subject: [PATCH] t9001: test --envelope-sender option of send-email

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84a7f03..004e81c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -95,6 +95,23 @@ test_expect_success \
     'Verify commandline' \
     'test_cmp expected commandline1'
 
+test_expect_success 'Send patches with --envelope-sender' '
+    clean_fake_sendmail &&
+     git send-email --envelope-sender="Patch Contributer <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+'
+
+cat >expected <<\EOF
+!patch@example.com!
+!-i!
+!nobody@example.com!
+!author@example.com!
+!one@example.com!
+!two@example.com!
+EOF
+test_expect_success \
+    'Verify commandline' \
+    'test_cmp expected commandline1'
+
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
