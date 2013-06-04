From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/README: test_must_fail is for testing Git
Date: Tue, 04 Jun 2013 09:50:12 -0700
Message-ID: <7vppw195x7.fsf_-_@alter.siamese.dyndns.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
	<CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
	<CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
	<51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com>
	<CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com>
	<7vk3mcnwlj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjuRB-00019Q-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab3FDQuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:50:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966Ab3FDQuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:50:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2046E2510D;
	Tue,  4 Jun 2013 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U2UE7Iu2nWuSf4gZ7Sxn1pLcdjQ=; b=UttDSY
	YnlEneNz2lphGaTP833DKsEaWEUtXPc8IHaXjivWuBF+Y3Fel+d4s+GAOxUcrttv
	KHFsq3VWtTFIbJ7MG49AzYgZk1Ct8rZXyvJL8IpQixs1Fwl5KotoNN7qzUZ8sjxr
	PPRZfelRB4wp2Kllk6StlIDTERqAZPd0tyBK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYygpLEwobtJP6e829oO9P7FU7bQCNjM
	MPS//2b4jyN0/1ULxFlLDiS9ZWsW1x0k5l4O0EK5wzHOZPWjABjMQttKx92uTfZs
	PH3UbWODeu8QA0OARcHT4kijEyQuk6oPs7UXZvILXjAB90k8ieyQ0bFGycBG1+Tp
	hWVcow8HKjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 147952510C;
	Tue,  4 Jun 2013 16:50:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DF8A2510A;
	Tue,  4 Jun 2013 16:50:14 +0000 (UTC)
In-Reply-To: <7vk3mcnwlj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Jun 2013 12:25:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D414F08E-CD36-11E2-8E22-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226377>

When a test wants to make sure there is no <string> in an output
file, we should just say "! grep string output"; "test_must_fail"
is there only to test Git command and catch unusual deaths we know
about (e.g. segv) as an error, not as an expected failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/README b/t/README
index e669bb3..35b3c5c 100644
--- a/t/README
+++ b/t/README
@@ -324,6 +324,9 @@ Don't:
    use 'test_must_fail git cmd'.  This will signal a failure if git
    dies in an unexpected way (e.g. segfault).
 
+   On the other hand, don't use test_must_fail for running regular
+   platform commands; just use '! cmd'.
+
  - use perl without spelling it as "$PERL_PATH". This is to help our
    friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that
