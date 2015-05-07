From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: skip dav http-push tests under NO_EXPAT=NoThanks
Date: Thu, 07 May 2015 09:06:14 -0700
Message-ID: <xmqqzj5gqsnd.fsf_-_@gitster.dls.corp.google.com>
References: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
	<20150506173200.GA7985@peff.net>
	<xmqqvbg5tubj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 18:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOJa-0002zV-3N
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbEGQGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:06:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbbEGQGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:06:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 134F24E4C3;
	Thu,  7 May 2015 12:06:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7yLjWnilfSAqYvGCZhqsutOBCQA=; b=un6wEA
	+YgLTQtqN4pqXtcswnXka2oZ4v8r7ikIltFW43Zcz3509li1Uqe5zT+yW+CQ+ur0
	51EAH/bAegnCAL8WIJHAlpuRN7S2EbIByF21f3DDgHfglT4ZDSNiXZ4bjR6MZtnO
	6uQ5BpxHdT+3fsqFAC/Xw/lUePquQfr16SppE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xyTNnlc5kp8YDnwKPyqs7Cftms/Lenuy
	mtl84tV7u6cRvko2i5zJzHgqcmmr8rzQY6iAuZ4Mv4BPM5lrN31B80l6sUvyABy3
	mNoY+AL1zJWyZMp7pgXtEMcqHEEWndMF10BCZm/9SHA20dkBJ5VqTQiyIpL8/6w+
	ThHM3ygcatE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C3F44E4C2;
	Thu,  7 May 2015 12:06:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83BB14E4C1;
	Thu,  7 May 2015 12:06:15 -0400 (EDT)
In-Reply-To: <xmqqvbg5tubj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 May 2015 11:49:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD285D60-F4D2-11E4-B37B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268538>

When built with NO_EXPAT=NoThanks, we will not have a working http-push
over webdav.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile       | 1 +
 t/lib-httpd.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index e0caec3..b9ebbf6 100644
--- a/Makefile
+++ b/Makefile
@@ -2188,6 +2188,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
+	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 872a252..d823664 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -36,6 +36,12 @@ then
 	test_done
 fi
 
+if test -n "$NO_EXPAT" && test -n "$LIB_HTTPD_DAV"
+then
+	skip_all='skipping test, git built without expat support'
+	test_done
+fi
+
 test_tristate GIT_TEST_HTTPD
 if test "$GIT_TEST_HTTPD" = false
 then
