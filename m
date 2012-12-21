From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 3/7] tests: paint skipped tests in blue
Date: Thu, 20 Dec 2012 19:12:34 -0800
Message-ID: <1356059558-23479-4-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2u-0000D7-02
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2LUDMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2LUDMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C201A816;
	Thu, 20 Dec 2012 22:12:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=naRW7AepWm2AuKb2gA58eduahDQ=; b=GHQZi7nL
	PyMtnCmRGw2WNxPE5lGmmbGDW133J91BRqerQR0acd0V7046hoIlOcYIzKbFkZUS
	/DvfjayrVokLh1uRlyEC1c/DxXZvv+a31DQtLJ29sm6kcYXVhawo7GUOUdo3P9NL
	42GqJOUB6USBun+LYlzWI0O9m/RwDZbNz4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=SdCOmLtvW9ArVWhxA/2Imu4mvpoS1gdsei
	MP33xIqphMpvSeL/0WXoPNn93ruuUlUoM9+K97rYd2BWE4hJtlpx316Ptp4kXTqX
	hpGSEZJwNkv5BCK8gFuc8xHJmw3fqPqpY3ZP8T8KTn5cV2vkC93rpGNlymVGlwLo
	3H8KyKTGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC5BA814;
	Thu, 20 Dec 2012 22:12:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46356A813; Thu, 20 Dec 2012
 22:12:46 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 4AEFE72E-4B1C-11E2-8A49-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211947>

From: Adam Spiers <git@adamspiers.org>

Skipped tests indicate incomplete test coverage.  Whilst this is not a
test failure or other error, it's still not a complete success.

Other testsuite related software like automake, autotest and prove
seem to use blue for skipped tests, so let's follow suit.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 72aafd0..f32df80 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -182,7 +182,7 @@ then
 		error)
 			tput bold; tput setaf 1;; # bold red
 		skip)
-			tput bold; tput setaf 2;; # bold green
+			tput setaf 4;; # blue
 		warn)
 			tput setaf 3;; # brown/yellow
 		pass)
-- 
1.8.1.rc2.225.g8d36ab4
